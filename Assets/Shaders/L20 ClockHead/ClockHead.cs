using UnityEngine;

public class ClockHead : MonoBehaviour
{
    public Material clockMat;

    private bool valid;
    private int hourAnglePropID;
    private int minAnglePropID;
    private int secAnglePropID;

    void Start()
    {
        if (clockMat == null) return;

        hourAnglePropID = Shader.PropertyToID("_HourHandAngle");
        minAnglePropID = Shader.PropertyToID("_MinHandAngle");
        secAnglePropID = Shader.PropertyToID("_SecHandAngle");

        valid = clockMat.HasProperty(hourAnglePropID) && clockMat.HasProperty(minAnglePropID) && clockMat.HasProperty(secAnglePropID);
    }

    void Update()
    {
        if (!valid) return;
        
        int second = System.DateTime.Now.Second;
        float secAngle = second / 60.0f * 360.0f;
        clockMat.SetFloat(secAnglePropID, secAngle); // Better to use id for high performance

        int minute = System.DateTime.Now.Minute;
        float minAngle = minute / 60.0f * 360.0f;
        clockMat.SetFloat(minAnglePropID, minAngle);

        int hour = System.DateTime.Now.Hour;
        float hourAngle = (hour % 12) / 12.0f * 360.0f + minAngle / 360.0f * 30.0f;
        clockMat.SetFloat(hourAnglePropID, hourAngle);
    }
}
