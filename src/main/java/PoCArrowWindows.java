import org.apache.arrow.memory.BufferAllocator;
import org.apache.arrow.memory.RootAllocator;
import org.apache.arrow.vector.BaseVariableWidthVector;
import org.apache.arrow.vector.ValueVector;
import org.apache.arrow.vector.VarCharVector;

import java.io.File;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

public class PoCArrowWindows {
    public static void main(String[] args) {
        try (BufferAllocator allocator = new RootAllocator();
             BaseVariableWidthVector name = new VarCharVector("list-numbers", allocator)) {
            name.allocateNew();
            name.set(0, "One".getBytes(StandardCharsets.UTF_8));
            name.set(1, "Two".getBytes(StandardCharsets.UTF_8));
            name.setValueCount(2);
            System.out.println(name);

//            System.out.println(Calendar.getInstance());
//            System.out.println(Calendar.getInstance(TimeZone.getTimeZone(
//                    ZoneId.of("America/Bogota"))));
//            System.out.println(Calendar.getInstance(TimeZone.getTimeZone("UTC"), Locale.ROOT));
//
//
//            URL ddad = PoCArrowWindows.class.getResource("/");
//            System.out.println(ddad.getPath());
//            Path demos = Paths.get(ddad.getPath(), "demos");
//            System.out.println(demos);

            String out = PoCArrowWindows.class.getResource("/").getPath();
            System.out.println(out);
            File newFile = new File(out, "holis");
            System.out.println(newFile.getAbsolutePath());
        }
    }
}
