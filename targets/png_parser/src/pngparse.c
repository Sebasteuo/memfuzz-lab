/* Tiny PNG parser – intentionally unsafe, for fuzzing demo only */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char **argv) {
    FILE *f;
    uint8_t header[8];
    if (argc != 2) { fputs("usage: pngparse <file>\n", stderr); return 1; }

    f = fopen(argv[1], "rb");
    if (!f) { perror("fopen"); return 1; }

    /* No bounds check – classic vulnerability */
    fread(header, 1, 8, f);

    /* Trigger read of uninitialised data to crash under ASAN */
    if (header[0] != 0x89 || header[1] != 'P') {
        char *boom = NULL;
        *boom = 0; /* Intentional segfault */
    }

    fclose(f);
    return 0;
}

