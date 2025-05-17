/*------------------.
| :: Description :: |
'-------------------/

    Directional Anti-Aliasing (DAA)
    
    Version 1.4.1
    Author: Barbatos Bachiko
    License: MIT

    About: Directional Anti-Aliasing (DAA) is an edge-aware spatiotemporal anti-aliasing technique 
    that smooths edges by applying directional blurring based on local gradient detection.

    History:
    (*) Feature (+) Improvement	(x) Bugfix (-) Information (!) Compatibility

    Version 1.4.1
    - Modify Constrast Threshold.
*/

// Includes
#include "ReShade.fxh"
#include "ReShadeUI.fxh"

// Start Tesseract
#ifndef USE_MARTY_LAUNCHPAD_MOTION
#define USE_MARTY_LAUNCHPAD_MOTION 0
#endif
#ifndef USE_VORT_MOTION
#define USE_VORT_MOTION 0
#endif

// version-number.fxh
#ifndef _VERSION_NUMBER_H
#define _VERSION_NUMBER_H

#define MAJOR_VERSION 1
#define MINOR_VERSION 4
#define PATCH_VERSION 1

#define BUILD_DOT_VERSION_(mav, miv, pav) #mav "." #miv "." #pav
#define BUILD_DOT_VERSION(mav, miv, pav) BUILD_DOT_VERSION_(mav, miv, pav)
#define DOT_VERSION_STR BUILD_DOT_VERSION(MAJOR_VERSION, MINOR_VERSION, PATCH_VERSION)

#define BUILD_UNDERSCORE_VERSION_(prefix, mav, miv, pav) prefix ## _ ## mav ## _ ## miv ## _ ## pav
#define BUILD_UNDERSCORE_VERSION(p, mav, miv, pav) BUILD_UNDERSCORE_VERSION_(p, mav, miv, pav)
#define APPEND_VERSION_SUFFIX(prefix) BUILD_UNDERSCORE_VERSION(prefix, MAJOR_VERSION, MINOR_VERSION, PATCH_VERSION)

#endif  //  _VERSION_NUMBER_H

uniform int APPEND_VERSION_SUFFIX(version) <
    ui_text = "Version: "
DOT_VERSION_STR;
    ui_label = " ";
    ui_type = "radio";
>;
// End Tesseract

    /*-------------------.
    | :: Settings ::    |
    '-------------------*/

uniform int View_Mode
<
    ui_category = "Anti-Aliasing";
    ui_type = "combo";
    ui_items = "DAA\0Edge Mask\0Gradient Direction\0Motion\0";
    ui_label = "View Mode";
    ui_tooltip = "Select normal or debug view output.";
> = 0;

uniform float DirectionalStrength
<
    ui_type = "slider";
    ui_label = "Strength";
    ui_min = 0.0; ui_max = 3.0; ui_step = 0.05;
    ui_category = "Anti-Aliasing";
> = 2.4;
    
uniform float PixelWidth
<
    ui_type = "slider";
    ui_label = "Pixel Width";
    ui_tooltip = "Pixel width for edge detection.";
    ui_min = 0.5; ui_max = 4.0; ui_step = 0.1;
    ui_category = "Edge Detection";
> = 1.0;

uniform float EdgeThreshold
<
    ui_type = "slider";
    ui_label = "Edge Threshold";
    ui_min = 0.0; ui_max = 4.0; ui_step = 0.01;
    ui_category = "Edge Detection";
> = 2.0;

uniform float EdgeFalloff
<
    ui_type = "slider";
    ui_label = "Edge Falloff";
    ui_tooltip = "Smooth falloff range for edge detection.";
    ui_min = 0.0; ui_max = 4.0; ui_step = 0.01;
    ui_category = "Edge Detection";
> = 2.0;

uniform bool EnableTemporalAA
<
    ui_category = "Temporal";
    ui_type = "checkbox";
    ui_label = "Temporal";
    ui_tooltip = "Enable temporal anti-aliasing.";
> = false;

uniform int TemporalMode
<
    ui_category = "Temporal";
    ui_type = "combo";
    ui_items = "Blurry\0Standard\0Quality\0";
    ui_label = "TemporalMode";
    ui_tooltip = "";
> = 2;

uniform float TemporalAAFactor
<
    ui_category = "Temporal";
    ui_type = "slider";
    ui_label = "Temporal Strength";
    ui_min = 0.0; ui_max = 1.0; ui_step = 0.01;
    ui_tooltip = "Blend factor between current DAA and history.";
> = 0.5;

uniform float SharpnessStrength
<
    ui_type = "slider";
    ui_label = "Sharpness Strength";
    ui_min = 0.0; ui_max = 2.0; ui_step = 0.01;
    ui_category = "Sharpness";
> = 0.0;

static const float ContrastThreshold = 0.0;

/*uniform float ContrastThreshold
<
    ui_type = "slider";
    ui_label = "Contrast Threshold";
    ui_min = 0.0; ui_max = 1.0; ui_step = 0.01;
    ui_category = "Sharpness";
> = 0.0;
*/

uniform uint framecount < source = "framecount"; >;

    /*---------------.
    | :: Textures :: |
    '---------------*/

#define S_PC MagFilter=POINT;MinFilter=POINT;MipFilter= POINT;AddressU=Clamp;AddressV=Clamp;AddressW=Clamp;

texture2D DAATemporal
{
    Width = BUFFER_WIDTH;
    Height = BUFFER_HEIGHT;
    Format = RGBA8;
};

texture2D DAAHistory
{
    Width = BUFFER_WIDTH;
    Height = BUFFER_HEIGHT;
    Format = RGBA8;
};

sampler2D sDAATemporal
{
    Texture = DAATemporal;
};

sampler2D sDAAHistory
{
    Texture = DAAHistory;
};

#if USE_MARTY_LAUNCHPAD_MOTION
namespace Deferred {
    texture MotionVectorsTex { Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format = RG16F; };
    sampler sMotionVectorsTex { Texture = MotionVectorsTex;  };
}
#elif USE_VORT_MOTION
    texture2D MotVectTexVort {  Width = BUFFER_WIDTH; Height = BUFFER_HEIGHT; Format = RG16F; };
    sampler2D sMotVectTexVort { Texture = MotVectTexVort; S_PC  };
#else
texture texMotionVectors
{
    Width = BUFFER_WIDTH;
    Height = BUFFER_HEIGHT;
    Format = RG16F;
};
sampler sTexMotionVectorsSampler
{
    Texture = texMotionVectors;
    S_PC
};
#endif

    /*----------------.
    | :: Functions :: |
    '----------------*/

float GetLuminance(float3 color)
{
    return dot(color, float3(0.299, 0.587, 0.114));
}

// Calculates the gradient using the Scharr operator
float2 ComputeGradient(float2 texcoord)
{
    const float2 offset = ReShade::PixelSize.xy * PixelWidth;

    float3 colorTL = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, -offset.y), 0, 0)).rgb;
    float3 colorT = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(0, -offset.y), 0, 0)).rgb;
    float3 colorTR = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, -offset.y), 0, 0)).rgb;
    float3 colorL = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, 0), 0, 0)).rgb;
    float3 colorR = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, 0), 0, 0)).rgb;
    float3 colorBL = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, offset.y), 0, 0)).rgb;
    float3 colorB = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(0, offset.y), 0, 0)).rgb;
    float3 colorBR = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, offset.y), 0, 0)).rgb;

    float lumTL = GetLuminance(colorTL);
    float lumT = GetLuminance(colorT);
    float lumTR = GetLuminance(colorTR);
    float lumL = GetLuminance(colorL);
    float lumR = GetLuminance(colorR);
    float lumBL = GetLuminance(colorBL);
    float lumB = GetLuminance(colorB);
    float lumBR = GetLuminance(colorBR);

    float gx = (-3.0 * lumTL - 10.0 * lumL - 3.0 * lumBL) + (3.0 * lumTR + 10.0 * lumR + 3.0 * lumBR);
    float gy = (-3.0 * lumTL - 10.0 * lumT - 3.0 * lumTR) + (3.0 * lumBL + 10.0 * lumB + 3.0 * lumBR);

    return float2(gx, gy);
}

float3 ApplySharpness(float2 texcoord, float3 color)
{
    const float2 offset = ReShade::PixelSize.xy * PixelWidth;

    float3 colorTL = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, -offset.y), 0, 0)).rgb;
    float3 colorTR = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, -offset.y), 0, 0)).rgb;
    float3 colorBL = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, offset.y), 0, 0)).rgb;
    float3 colorBR = tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, offset.y), 0, 0)).rgb;

    float3 averageColor = (colorTL + colorTR + colorBL + colorBR) * 0.25;
    float contrast = length(color - averageColor);

    if (contrast > ContrastThreshold)
    {
        float3 sharpenedColor = color + (color - averageColor) * SharpnessStrength;
        return lerp(color, sharpenedColor, smoothstep(ContrastThreshold, ContrastThreshold + 0.1, contrast));
    }
    return color;
}

float4 DirectionalAA(float2 texcoord)
{
    float4 originalColor = tex2Dlod(ReShade::BackBuffer, float4(texcoord, 0, 0));
    float2 gradient = ComputeGradient(texcoord);
    float edgeStrength = length(gradient);
    float weight = smoothstep(EdgeThreshold, EdgeThreshold + EdgeFalloff, edgeStrength);

    // View Modes
    if (View_Mode == 1)
        return float4(weight.xxx, 1.0); // Edge Mask
    else if (View_Mode == 2)
    {
        float2 normGrad = (edgeStrength > 0.0) ? normalize(gradient) : float2(0.0, 0.0);
        float3 debugDir = float3(normGrad.x * 0.5 + 0.5, normGrad.y * 0.5 + 0.5, 0.0);
        return float4(debugDir, 1.0); // Gradient Direction
    }

    if (weight > 0.01)
    {
        float2 blurDir = normalize(float2(-gradient.y, gradient.x));
        float2 blurOffset = blurDir * ReShade::PixelSize.xy * PixelWidth * DirectionalStrength;

        float4 color1 = tex2Dlod(ReShade::BackBuffer, float4(texcoord + blurOffset * 0.5, 0, 0));
        float4 color2 = tex2Dlod(ReShade::BackBuffer, float4(texcoord - blurOffset * 0.5, 0, 0));
        float4 color3 = tex2Dlod(ReShade::BackBuffer, float4(texcoord + blurOffset, 0, 0));
        float4 color4 = tex2Dlod(ReShade::BackBuffer, float4(texcoord - blurOffset, 0, 0));
        
        float4 smoothedColor = (color1 + color2) * 0.4 + (color3 + color4) * 0.1;
        float4 finalColor = lerp(originalColor, smoothedColor, weight);

        // Apply sharpness
        finalColor.rgb = ApplySharpness(texcoord, finalColor.rgb);
        return finalColor;
    }

    originalColor.rgb = ApplySharpness(texcoord, originalColor.rgb);
    return originalColor;
}

// work ;)
float2 GetMotionVector(float2 texcoord)
{
#if USE_MARTY_LAUNCHPAD_MOTION
    return tex2Dlod(Deferred::sMotionVectorsTex, float4(texcoord, 0, 0)).xy;
#elif USE_VORT_MOTION
    return tex2Dlod(sMotVectTexVort, float4(texcoord, 0, 0)).xy;
#else
    return tex2Dlod(sTexMotionVectorsSampler, float4(texcoord, 0, 0)).xy;
#endif
}

float3 HSVtoRGB(float3 c)
{
    float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
}

 // Convert RGB to YCoCg
float3 RGBToYCoCg(float3 rgb)
{
    float Y = dot(rgb, float3(0.25, 0.5, 0.25));
    float Co = dot(rgb, float3(0.5, 0.0, -0.5));
    float Cg = dot(rgb, float3(-0.25, 0.5, -0.25));
    return float3(Y, Co, Cg);
}

// Convert YCoCg back to RGB
float3 YCoCgToRGB(float3 ycocg)
{
    float Y = ycocg.x;
    float Co = ycocg.y;
    float Cg = ycocg.z;
    return float3(Y + Co - Cg, Y + Cg, Y - Co - Cg);
}

//Temporal DAA
float4 PS_TemporalDAA(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
    float2 motion = GetMotionVector(texcoord);
    
    if (View_Mode == 3)
    {
        float magnitude = length(motion);
        float angle = atan2(motion.y, motion.x);
        float hue = (angle + 3.14159265) / (2.0 * 3.14159265);
        float saturation = 1.0;
        float magnitudeScale = 5.0;
        float value = saturate(magnitude * magnitudeScale);
        float3 rgb = HSVtoRGB(float3(hue, saturation, value));
        return float4(rgb, 1.0);
    }
    
    float4 current = DirectionalAA(texcoord);
    
    if (TemporalMode == 0) // Method A - Basic neighborhood averaging = Blurry
    {
        float2 reprojectedTexcoord = texcoord + motion;
        
        // Define offsets for directions
        float2 offsetUp = float2(0.0, -ReShade::PixelSize.y);
        float2 offsetDown = float2(0.0, ReShade::PixelSize.y);
        float2 offsetLeft = float2(-ReShade::PixelSize.x, 0.0);
        float2 offsetRight = float2(ReShade::PixelSize.x, 0.0);
        
        // Samples the history
        float4 historyCenter = tex2Dlod(sDAAHistory, float4(reprojectedTexcoord, 0, 0));
        float4 historyUp = tex2Dlod(sDAAHistory, float4(reprojectedTexcoord + offsetUp, 0, 0));
        float4 historyDown = tex2Dlod(sDAAHistory, float4(reprojectedTexcoord + offsetDown, 0, 0));
        float4 historyLeft = tex2Dlod(sDAAHistory, float4(reprojectedTexcoord + offsetLeft, 0, 0));
        float4 historyRight = tex2Dlod(sDAAHistory, float4(reprojectedTexcoord + offsetRight, 0, 0));
        
        float4 historyAvg = (historyCenter + historyUp + historyDown + historyLeft + historyRight) / 5.0;
        
        float factor = EnableTemporalAA ? TemporalAAFactor : 0.0;
        return lerp(current, historyAvg, factor);
    }
    else if (TemporalMode == 1) // Method B - Simple YCoCg blending = Lite
    {
        float3 currentYCoCg = RGBToYCoCg(current.rgb);
        float2 reprojectedTexcoord = texcoord + motion;
        float4 history = tex2Dlod(sDAAHistory, float4(reprojectedTexcoord, 0, 0));
        float3 historyYCoCg = RGBToYCoCg(history.rgb);
        
        float factor = EnableTemporalAA ? TemporalAAFactor : 0.0;
        float3 blendedYCoCg = lerp(currentYCoCg, historyYCoCg, factor);
        float3 finalRGB = YCoCgToRGB(blendedYCoCg);
        
        return float4(finalRGB, current.a);
    }
    else // Method C - Neighborhood clamping = Quality
    {
        float3 currentYCoCg = RGBToYCoCg(current.rgb);
        float2 reprojectedTexcoord = texcoord + motion;
        
        // Sample current neighborhood for clamping
        float2 offset = ReShade::PixelSize.xy;
        float3 c00 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, -offset.y), 0, 0)).rgb);
        float3 c10 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(0, -offset.y), 0, 0)).rgb);
        float3 c20 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, -offset.y), 0, 0)).rgb);
        float3 c01 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, 0), 0, 0)).rgb);
        float3 c21 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, 0), 0, 0)).rgb);
        float3 c02 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(-offset.x, offset.y), 0, 0)).rgb);
        float3 c12 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(0, offset.y), 0, 0)).rgb);
        float3 c22 = RGBToYCoCg(tex2Dlod(ReShade::BackBuffer, float4(texcoord + float2(offset.x, offset.y), 0, 0)).rgb);
        
        // Calculate AABB for neighborhood clamping
        float3 minColor = min(min(min(c00, c10), min(c20, c01)), min(min(c21, c02), min(c12, c22)));
        float3 maxColor = max(max(max(c00, c10), max(c20, c01)), max(max(c21, c02), max(c12, c22)));
        float3 clampSize = maxColor - minColor;
        minColor -= clampSize * 0.5;
        maxColor += clampSize * 0.5;
        
        float3 historyYCoCg = RGBToYCoCg(tex2Dlod(sDAAHistory, float4(reprojectedTexcoord, 0, 0)).rgb);
        historyYCoCg = clamp(historyYCoCg, minColor, maxColor);
        
        float motionLength = length(motion) * 100.0;
        float blendFactor = EnableTemporalAA ? clamp(TemporalAAFactor * (1.0 - motionLength), 0.0, TemporalAAFactor) : 0.0;
        
        float3 resultYCoCg = lerp(currentYCoCg, historyYCoCg, blendFactor);
        
        // Convert back to RGB
        float3 resultRGB = YCoCgToRGB(resultYCoCg);
        
        return float4(resultRGB, current.a);
    }
}

// History pass
float4 PS_SaveHistoryDAA(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
    float4 temporalResult = tex2Dlod(sDAATemporal, float4(texcoord, 0, 0));
    return temporalResult;
}

// Composite pass
float4 PS_CompositeDAA(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
    return tex2Dlod(sDAATemporal, float4(texcoord, 0, 0));
}
 
    /*-------------------.
    | :: Techniques ::   |
    '-------------------*/

technique DAA
<
    ui_tooltip = "Directional Anti-Aliasing. Enable Quark_Motion or any Motion Vectors for Temporal Anti-Aliasing";
>
{
    pass Temporal
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_TemporalDAA;
        RenderTarget = DAATemporal;
    }
    pass SaveHistory
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_SaveHistoryDAA;
        RenderTarget = DAAHistory;
    }
    pass Composite
    {
        VertexShader = PostProcessVS;
        PixelShader = PS_CompositeDAA;
    }
}
