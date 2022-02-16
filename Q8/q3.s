.pos 0x1000
code:           
                # v0 = s.x[i]
                ld $s, r0                     # r0 = address of s
                ld $i, r1                     # r1 = address of i
                ld 0x0(r1), r2                # r2 = value of i
                ld (r0, r2, 4), r3            # r3 = s.x[i]
                ld $v0, r4                    # r4 = address of v0
                st r3, 0x0(r4)                # v0 = s.x[i]

                # v1 = s.y[i]                
                ld 0x8(r0), r5                # r5 = s.y[0]
                ld (r5, r2, 4), r5            # r5 = s.y[i]
                ld $v1, r6                    # r6 = address of v1
                st r5, 0x0(r6)                # v1 = s.y[i]

                # v2 = s.z->x[i] 
                ld $s, r0                     # r0 = address of s
                ld 0xc(r0), r5                # r5 = s.z
                ld (r5, r2, 4), r6            # r6 = s.z->x[i]
                ld $v2, r7                    # r7 = address of v2
                st r6, 0x0(r7)                # v2 = s.z->x[i]

                # v3 = s.z->z->y[i];
                ld 0x10(r5), r6               # r6 = s.z->z
                ld 0x8(r6), r5                # r5 = s.z->z->y[0]
                ld (r5, r2, 4), r5            # r5 = s.z->z->y[i]
                ld $v3, r6                    # r6 = address of v3 
                st r5, 0x0(r6)                # v3 = s.z->z->y[i]

                halt                          # halt


.pos 0x2000
static:
i:              .long 0x00000001              # i = 1
v0:             .long 0x00000000              # v0 = 0
v1:             .long 0x00000001              # v1 = 1
v2:             .long 0x00000002              # v2 = 2
v3:             .long 0x00000003              # v3 = 3
s:              .long 0x00000005              # x[0] = 5
                .long 0x00000007              # x[1] = 7
                .long s_y                     # s.y
                .long s_z                     # s.z

.pos 0x3000
heap:           
s_y:            .long 0x00000002              # s.y[0] = 2
                .long 0x00000004              # s.y[1] = 4
s_z:            .long 0x00000006              # s.z->x[0] = 6
                .long 0x00000008              # s.z->x[1] = 8
                .long 0x00000003              # s.z->y[0] = 3
                .long 0x00000005              # s.z->y[1] = 5
                .long s_z_z                   # s.z->z
s_z_z:          .long 0x00000007              # s.z->z->x[0] = 7
                .long 0x00000009              # s.z->z->x[1] = 9
                .long s_z_z_y                 # s.z->z->y
                .long 0x00000002              # s.z->z->z
s_z_z_y:        .long 0x00000004              # s.z->z->y[0] = 4
                .long 0x0000000f              # s.z->z->y[1] = 15
