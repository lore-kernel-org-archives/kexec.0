Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gp57.nurk.org ([208.74.128.57] helo=dscp.org)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YIU8b-0007n1-Uv
 for kexec@lists.infradead.org; Tue, 03 Feb 2015 03:26:54 +0000
Date: Mon, 2 Feb 2015 19:26:29 -0800 (PST)
From: Ebben Aries <earies@dscp.org>
Subject: Unhandled rela relocation: R_X86_64_29
Message-ID: <alpine.LNX.2.11.1502021854480.10823@zinq.dscp.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

According to the defined relocation types at http://refspecs.linuxbase.org/elf/x86_64-abi-0.98.pdf, I appear to be encountering an undefined type "R_X86_64_29" when attempting to load kexec

Does anyone have any idea what this undefined type indicates?

$ zcat /proc/config.gz | grep -E "^CONFIG_KEXEC|^CONFIG_RELOCAT"
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_RELOCATABLE=y

$ KERNEL=3.18.5-20150202
$ sudo kexec -l /boot/vmlinuz-${KERNEL} --reuse-cmdline --initrd="/boot/initrd-${KERNEL}.gz" -d
kernel: 0x7fb387de4010 kernel_size: 0x39c190
MEMORY RANGES
0000000000000100-0000000000057fff (0)
0000000000058000-0000000000058fff (1)
0000000000059000-000000000009bfff (0)
000000000009c000-000000000009cfff (1)
000000000009d000-000000000009dfff (0)
000000000009e000-00000000000bffff (1)
0000000000100000-00000000cfd57fff (0)
00000000cfd58000-00000000cff59fff (1)
00000000cff5a000-00000000da44cfff (0)
00000000da44d000-00000000dcd3efff (1)
00000000dcd3f000-00000000dce7efff (3)
00000000dce7f000-00000000dcefefff (2)
00000000dceff000-00000000dcefffff (0)
00000000dcf00000-00000000df9fffff (1)
00000000f80f8000-00000000f80f8fff (1)
00000000fe101000-00000000fe112fff (1)
00000000fed1c000-00000000fed1ffff (1)
0000000100000000-000000031e5fffff (0)
sym: _GLOBAL_OFFSET_TABLE_ info: 10 other: 00 shndx: 0 value: 0 size: 0
sym: _GLOBAL_OFFSET_TABLE_ value: 4 addr: 31e5f6004
R_X86_64_29
Unhandled rela relocation: R_X86_64_29


From include/elf.h

/* AMD x86-64 relocations.  */
#define R_X86_64_NONE           0       /* No reloc */
#define R_X86_64_64             1       /* Direct 64 bit  */
#define R_X86_64_PC32           2       /* PC relative 32 bit signed */
#define R_X86_64_GOT32          3       /* 32 bit GOT entry */
#define R_X86_64_PLT32          4       /* 32 bit PLT address */
#define R_X86_64_COPY           5       /* Copy symbol at runtime */
#define R_X86_64_GLOB_DAT       6       /* Create GOT entry */
#define R_X86_64_JUMP_SLOT      7       /* Create PLT entry */
#define R_X86_64_RELATIVE       8       /* Adjust by program base */
#define R_X86_64_GOTPCREL       9       /* 32 bit signed PC relative
                                            offset to GOT */
#define R_X86_64_32             10      /* Direct 32 bit zero extended */
#define R_X86_64_32S            11      /* Direct 32 bit sign extended */
#define R_X86_64_16             12      /* Direct 16 bit zero extended */
#define R_X86_64_PC16           13      /* 16 bit sign extended pc relative */
#define R_X86_64_8              14      /* Direct 8 bit sign extended  */
#define R_X86_64_PC8            15      /* 8 bit sign extended pc relative */
#define R_X86_64_DTPMOD64       16      /* ID of module containing symbol */
#define R_X86_64_DTPOFF64       17      /* Offset in module's TLS block */
#define R_X86_64_TPOFF64        18      /* Offset in initial TLS block */
#define R_X86_64_TLSGD          19      /* 32 bit signed PC relative offset
                                            to two GOT entries for GD symbol */
#define R_X86_64_TLSLD          20      /* 32 bit signed PC relative offset
                                            to two GOT entries for LD symbol */
#define R_X86_64_DTPOFF32       21      /* Offset in TLS block */
#define R_X86_64_GOTTPOFF       22      /* 32 bit signed PC relative offset
                                            to GOT entry for IE symbol */
#define R_X86_64_TPOFF32        23      /* Offset in initial TLS block */

#define R_X86_64_NUM            24

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
