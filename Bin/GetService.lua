return function() 
    local env = getfenv() 
    for _, service in ipairs(
        { "CoreGui", "Players", "UserInputService", "TweenService", "HttpService", "MarketplaceService", "RunService", "TeleportService", "StarterGui", "GuiService", "Lighting", "ContextActionService", "ReplicatedStorage", "GroupService", "PathfindingService", "SoundService", "Teams", "StarterPlayer", "InsertService", "Chat", "ProximityPromptService", "ContentProvider", "Stats", "MaterialService", "AvatarEditorService", "TextService", "TextChatService", "CaptureService", "VoiceChatService" 
    }) do 
        env[service] = game:GetService(service) 
    end 
end

--[[ -- What I made today in Java bbg ;) lerp vectors
class Main {
    public static void main(String[] args) {
        Vector2 firstVector = new Vector2(10, 10);
        Vector2 secondVector = new Vector2(100, 100);
        System.out.println(firstVector);
        firstVector.lerpVectorToVector(secondVector, 1000, 5);
    }
}

class Vector2 {
    private double x;
    private double y;

    public Vector2(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public void lerpVectorToVector(Vector2 target, int steps, int tolernace) {
        for (int i = 0; i <= steps; i++) {
            double step = (double) i / steps;
            double newX = this.x + (target.x - this.x) * step;
            double newY = this.y + (target.y - this.y) * step;
            System.out.println(
                String.format("Vector2(%s, %s)", MathModule.round(newX, tolernace), MathModule.round(newY, tolernace))
            );
        }
    }
    
    public String toString()
    {
        return String.format("Vector2(%s, %s)", this.x, this.y);
    }
}

class MathModule
{
    public static double round(double num, int place)
    {
        double mult = Math.pow(10, place);
        return (int) Math.floor(num * mult + 0.5) / mult;
    }
}
]]