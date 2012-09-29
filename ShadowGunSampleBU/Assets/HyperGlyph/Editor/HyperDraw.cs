using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

/// A utility class that provides line drawing functions for Unity editor GUIs.
public class HyperDraw
{
    public static Texture2D aaLineTex = null;
    public static Texture2D lineTex = null;

    public static void Line(Vector2 pointA, Vector2 pointB, Color color, float width, bool antiAlias)
    {
        Color savedColor = GUI.color;
        Matrix4x4 savedMatrix = GUI.matrix;

        if (!lineTex)
        {
            lineTex = new Texture2D(1, 1, TextureFormat.ARGB32, true);
            lineTex.SetPixel(0, 1, Color.white);
            lineTex.Apply();
        }
        if (!aaLineTex)
        {
            aaLineTex = new Texture2D(1, 3, TextureFormat.ARGB32, true);
            aaLineTex.SetPixel(0, 0, new Color(1, 1, 1, 0));
            aaLineTex.SetPixel(0, 1, Color.white);
            aaLineTex.SetPixel(0, 2, new Color(1, 1, 1, 0));
            aaLineTex.Apply();
        }
        if (antiAlias) width *= 3;
        float angle = Vector3.Angle(pointB - pointA, Vector2.right) * (pointA.y <= pointB.y?1:-1);
        float m = (pointB - pointA).magnitude;
        Vector3 dz = new Vector3(pointA.x,pointA.y,0);

        GUI.color = color;
        GUI.matrix = translationMatrix(dz)*GUI.matrix;
        GUIUtility.ScaleAroundPivot(new Vector2(m, width), new Vector2(-0.5f, 0));
        GUI.matrix = translationMatrix(-dz) * GUI.matrix;
        GUIUtility.RotateAroundPivot(angle, new Vector2(0,0));
        GUI.matrix = translationMatrix(dz + new Vector3(width / 2, -m / 2) * Mathf.Sin(angle * Mathf.Deg2Rad)) * GUI.matrix;
        
        if(!antiAlias)
            GUI.DrawTexture(new Rect(0,0,1,1), lineTex);
        else
            GUI.DrawTexture(new Rect(0,0,1,1), aaLineTex);

        GUI.matrix = savedMatrix;
        GUI.color = savedColor;
    }

    public static void Grid(Rect bounds, Color color, float baseline, float emphline)
    {
        int Xiterations = (int)Mathf.Round(bounds.width/25.0f);
        int Yiterations = (int)Mathf.Round(bounds.height/25.0f);

        for(int i = 1; i < Xiterations; i++)
        {
            if(i%4 == 0)
                HyperDraw.Line(new Vector2(25*i,bounds.y), new Vector2(25*i,bounds.y + bounds.height), color,emphline, true);
            else
                HyperDraw.Line(new Vector2(25*i,bounds.y), new Vector2(25*i,bounds.y + bounds.height), color, baseline, true);
        }
        for(int i = 1; i < Yiterations; i++)
        {
            if(i%4 == 0)
                HyperDraw.Line(new Vector2(bounds.x, bounds.y+(25*i)), new Vector2(bounds.width,bounds.y+(25*i)), color,emphline, true);
            else
                HyperDraw.Line(new Vector2(bounds.x,bounds.y+(25*i)), new Vector2(bounds.width,bounds.y+(25*i)), color, baseline, true);
        }
    }

    public static void Point(Vector2 point, Color color)
    {
        HyperDraw.Line(new Vector2( point.x-4,point.y), new Vector2(point.x+4,point.y), color,4.0f, true);
        HyperDraw.Line(new Vector2( point.x,point.y-4), new Vector2(point.x,point.y+4), color,4.0f, true);    
    }

    public static void Points(List<Vector2> points, Color color)
    {
        foreach(Vector2 p in points)
        {
            HyperDraw.Point(p,color);
        }    
    }

    private static void Vector(Vector2 A, Vector2 B, Color color1,Color color2 , float thickness)
    {   
        HyperDraw.Line(A,B,color1,thickness, true);
        HyperDraw.Line(new Vector2( B.x-2,B.y), new Vector2(B.x+2,B.y), color2,3.0f, true);
        HyperDraw.Line(new Vector2( B.x,B.y-2), new Vector2(B.x,B.y+2), color2,3.0f, true);

        float arrowAngle = 25 * Mathf.Deg2Rad;
        float angle = Mathf.Atan2((A.y - B.y),(A.x - B.x));
        Vector2 arrowEnd = new Vector2( 2* Mathf.Cos(angle) + B.x,2* Mathf.Sin(angle) + B.y);
        Vector2 arrowside1 = new Vector2( 8* Mathf.Cos(angle + arrowAngle) + arrowEnd.x,8* Mathf.Sin(angle + arrowAngle) + arrowEnd.y);
        Vector2 arrowside2 = new Vector2( 8* Mathf.Cos(angle - arrowAngle) + arrowEnd.x,8* Mathf.Sin(angle - arrowAngle) + arrowEnd.y);
        
        HyperDraw.Line(arrowEnd,arrowside1,color1,thickness, true);
        HyperDraw.Line(arrowEnd,arrowside2,color1,thickness, true);
    }

    public static void Box(Rect box,Color color, float thickness)
    {
        HyperDraw.Line(new Vector2(box.x,box.y), new Vector2(box.x,box.y + box.height),color,thickness, true);
        HyperDraw.Line(new Vector2(box.x,box.y + box.height), new Vector2(box.x + box.width,box.y + box.height), color,thickness, true);
        HyperDraw.Line(new Vector2(box.x + box.width,box.y + box.height), new Vector2(box.x + box.width,box.y), color,thickness, true);
        HyperDraw.Line(new Vector2(box.x + box.width,box.y), new Vector2(box.x,box.y), color,thickness, true);        
    }

    public static void Path(List<Vector2> points, Color color, float size)
    {
        for(int i = 0; i< points.Count - 1; i++)
        {
            HyperDraw.Line(points[i], points[i+1],color,size, true);
        }
    }

    public static void VectorPath(List<Vector2> points, Color color1, Color color2)
    {
        for(int i = 0; i< points.Count - 1; i++)
        {
            if(i%2 == 0)
                HyperDraw.Vector(points[i], points[i+1],color1,color2,1.2f);
            else
                HyperDraw.Vector(points[i], points[i+1],color2,color1,1.2f);
        }
    }

    public static void BezierLine(Vector2 start, Vector2 startTangent, Vector2 end, Vector2 endTangent, Color color, float width, bool antiAlias, int segments)
    {
        Vector2 lastV = cubeBezier(start, startTangent, end, endTangent, 0);
        for (int i = 1; i < segments; ++i)
        {
            Vector2 v = cubeBezier(start, startTangent, end, endTangent, i/(float)segments);

            HyperDraw.Line(lastV,v,color, width, antiAlias);
            lastV = v;
        }
    }

    private static Vector2 cubeBezier(Vector2 s, Vector2 st, Vector2 e, Vector2 et, float t){
        float rt = 1-t;
        return rt * rt * rt * s + 3 * rt * rt * t * st + 3 * rt * t * t * et + t * t * t * e;
    }

    private static Matrix4x4 translationMatrix(Vector3 v)
    {
        return Matrix4x4.TRS(v,Quaternion.identity,Vector3.one);
    }
}
