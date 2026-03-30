module ALU_tb;
    parameter N = 32;
    reg [N-1:0] A, B;
    reg [2:0] OpCode;
    wire [N-1:0] Result;
    wire Zero;

    // ALU Modülünü bağlama
    ALU #(N) uut (.A(A), .B(B), .OpCode(OpCode), .Result(Result), .Zero(Zero));

    initial begin
        $display("ALU Testi Basliyor - Her islem icin 3 farkli veri seti...");

        // --- 1. TOPLAMA TESTLERİ (OpCode 000) --- 
        OpCode = 3'b000; A = 32'd100; B = 32'd50; #10;   // Test 1: 150 
        OpCode = 3'b000; A = 32'd1000; B = 32'd2000; #10; // Test 2: 3000
        OpCode = 3'b000; A = 32'h1; B = 32'h1; #10;       // Test 3: 2

        // --- 2. ÇIKARMA TESTLERİ (OpCode 001) --- 
        OpCode = 3'b001; A = 32'd25; B = 32'd25; #10;   // Test 1: Sonuc 0 (Zero Bayragi yanar)
        OpCode = 3'b001; A = 32'd10; B = 32'd20; #10;   // Test 2: Negatif sonuc -10 
        OpCode = 3'b001; A = 32'd100; B = 32'd40; #10;  // Test 3: 60

        // --- 3. MANTIKSAL VE (AND) TESTLERİ (OpCode 010) --- 
        OpCode = 3'b010; A = 32'hFFFF0000; B = 32'hF0F0F0F0; #10; // Test 1 
        OpCode = 3'b010; A = 32'hAAAAAAAA; B = 32'h55555555; #10; // Test 2: Hepsi 0 olur
        OpCode = 3'b010; A = 32'hFFFFFFFF; B = 32'h12345678; #10; // Test 3: Sayinin kendisi cikar

        // --- 4. MANTIKSAL XOR TESTLERİ (OpCode 011) --- 
        OpCode = 3'b011; A = 32'hFFFFFFFF; B = 32'hFFFFFFFF; #10; // Test 1: Ayni ise 0 cikar
        OpCode = 3'b011; A = 32'h0; B = 32'hFFFFFFFF; #10;        // Test 2: Farkli ise 1 cikar
        OpCode = 3'b011; A = 32'h12345678; B = 32'h87654321; #10; // Test 3: Rastgele bitler

        $display("Tum testler tamamlandi.");
        $finish;
    end
endmodule