import org.apache.arrow.memory.BufferAllocator;
import org.apache.arrow.memory.RootAllocator;
import org.apache.arrow.vector.BaseVariableWidthVector;
import org.apache.arrow.vector.ValueVector;
import org.apache.arrow.vector.VarCharVector;

import java.nio.charset.StandardCharsets;

public class PoCArrowWindows {
    public static void main(String[] args) {
        try (BufferAllocator allocator = new RootAllocator();
             BaseVariableWidthVector name = new VarCharVector("list-numbers", allocator)) {
            name.allocateNew();
            name.set(0, "One".getBytes(StandardCharsets.UTF_8));
            name.set(1, "Two".getBytes(StandardCharsets.UTF_8));
            name.setValueCount(2);
            System.out.println(name);
        }
    }
}
