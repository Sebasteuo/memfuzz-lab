#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 2) return 1;
    FILE *f = fopen(argv[1], "rb");
    if (!f) { perror("fopen"); return 1; }

    uint8_t header[8];
    size_t n = fread(header, 1, 8, f);
    if (n < 8) { fclose(f); return 1; }

    /* Deliberate bug: corrupt write if not PNG magic */
    uint32_t *magic = (uint32_t *)header;
    if (magic[0] != 0x89504e47) {       /* "\x89PNG" */
        uint8_t crash[4];
        crash[8] = 0;                  /* OOB write -> segfault */
    }
    fclose(f);
    return 0;
}
