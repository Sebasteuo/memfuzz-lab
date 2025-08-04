/* Tiny PNG rser – intentionally unsafe, for fuzzing demo only */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <png.h> 
int main(int argc, char **argv)
{
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <png>\n", argv[0]);
        return 1;
    }

    FILE *f = fopen(argv[1], "rb");
    if (!f) {
        perror("fopen");
        return 1;
    }

    unsigned char header[8];
//    if (fread(header, 1, 8, f) != 8) {
//        fclose(f);
//        fprintf(stderr, "File too short\n");
//        return 1;
//    }

////////    if (png_sig_cmp(header, 0, 8)) {
////////        fclose(f);
////////        fprintf(stderr, "Not a PNG file\n");
////////        return 1;
////////    }
}
