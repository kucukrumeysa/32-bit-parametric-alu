// N parametresi sayesinde bu ALU'yu tek rakamla 32, 64 veya 128 bit yapabiliriz.
module ALU #(parameter N = 32) ( 
    input [N-1:0] A, B,          // İşlem görecek iki ana sayı (Girişler)
    input [2:0] OpCode,          // Hangi işlemin yapılacağını seçen komut kodu . 3 bit oluyor ama biz 4 tanesini kullanıyoruz.
    output reg [N-1:0] Result,   // Yapılan işlemin sonucu burada görünür
    output Zero                  // Eğer sonuç 0 ise bu lamba (bayrak) yanar
);

    // Sürekli kontrol et: Eğer sonuç (Result) 0 ise Zero çıkışını 1 yap.
    assign Zero = (Result == 0);

    // always @(*) : Girişlerden herhangi biri değiştiği anda hesaplamayı tekrar yap.
    always @(*) begin
        case(OpCode)
            3'b000: Result = A + B;     // Kod 000 ise: A ile B'yi topla
            3'b001: Result = A - B;     // Kod 001 ise: A'dan B'yi çıkar
            3'b010: Result = A & B;     // Kod 010 ise: Bit düzeyinde VE (AND) yap
            3'b011: Result = A ^ B;     // Kod 011 ise: Bit düzeyinde XOR yap
            default: Result = 0;        // Yanlış bir kod girilirse sonucu 0'da tut
        endcase
    end

endmodule