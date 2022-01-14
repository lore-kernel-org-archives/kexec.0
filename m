From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Jan 2022 15:55:30 +0100
Subject: [PATCHv2 1/1] s390: handle R_390_PLT32DBL reloc entries in
 machine_apply_elf_rel()
In-Reply-To: <20211215174853.7520-2-hca@linux.ibm.com>
References: <20211215174853.7520-1-hca@linux.ibm.com>
 <20211215174853.7520-2-hca@linux.ibm.com>
Message-ID: <20220114145530.GF16732@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Dec 15, 2021 at 06:48:53PM +0100, Heiko Carstens wrote:
> From: Alexander Egorenkov <egorenar@linux.ibm.com>
> 
> Starting with gcc 11.3, the C compiler will generate PLT-relative function
> calls even if they are local and do not require it. Later on during linking,
> the linker will replace all PLT-relative calls to local functions with
> PC-relative ones. Unfortunately, the purgatory code of kexec/kdump is
> not being linked as a regular executable or shared library would have been,
> and therefore, all PLT-relative addresses remain in the generated purgatory
> object code unresolved. This in turn lets kexec-tools fail with
> "Unknown rela relocation: 0x14 0x73c0901c" for such relocation types.
> 
> Furthermore, the clang C compiler has always behaved like described above
> and this commit should fix the purgatory code built with the latter.
> 
> Because the purgatory code is no regular executable or shared library,
> contains only calls to local functions and has no PLT, all R_390_PLT32DBL
> relocation entries can be resolved just like a R_390_PC32DBL one.
> 
> * https://refspecs.linuxfoundation.org/ELF/zSeries/lzsabi0_zSeries/x1633.html#AEN1699
> 
> Relocation entries of purgatory code generated with gcc 11.3
> ------------------------------------------------------------
> 
> $ readelf -r purgatory/purgatory.o
> 
> Relocation section '.rela.text' at offset 0x6e8 contains 27 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 00000000000c  000300000013 R_390_PC32DBL     0000000000000000 .data + 2
> 00000000001a  001000000014 R_390_PLT32DBL    0000000000000000 sha256_starts + 2
> 000000000030  001100000014 R_390_PLT32DBL    0000000000000000 sha256_update + 2
> 000000000046  001200000014 R_390_PLT32DBL    0000000000000000 sha256_finish + 2
> 000000000050  000300000013 R_390_PC32DBL     0000000000000000 .data + 102
> 00000000005a  001300000014 R_390_PLT32DBL    0000000000000000 memcmp + 2
> ...
> 000000000118  001600000014 R_390_PLT32DBL    0000000000000000 setup_arch + 2
> 00000000011e  000300000013 R_390_PC32DBL     0000000000000000 .data + 2
> 00000000012c  000f00000014 R_390_PLT32DBL    0000000000000000 verify_sha256_digest + 2
> 000000000142  001700000014 R_390_PLT32DBL    0000000000000000
> post_verification[...] + 2
> 
> Relocation entries of purgatory code generated with gcc 11.2
> ------------------------------------------------------------
> 
> $ readelf -r purgatory/purgatory.o
> 
> Relocation section '.rela.text' at offset 0x6e8 contains 27 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 00000000000e  000300000013 R_390_PC32DBL     0000000000000000 .data + 2
> 00000000001c  001000000013 R_390_PC32DBL     0000000000000000 sha256_starts + 2
> 000000000036  001100000013 R_390_PC32DBL     0000000000000000 sha256_update + 2
> 000000000048  001200000013 R_390_PC32DBL     0000000000000000 sha256_finish + 2
> 000000000052  000300000013 R_390_PC32DBL     0000000000000000 .data + 102
> 00000000005c  001300000013 R_390_PC32DBL     0000000000000000 memcmp + 2
> ...
> 00000000011a  001600000013 R_390_PC32DBL     0000000000000000 setup_arch + 2
> 000000000120  000300000013 R_390_PC32DBL     0000000000000000 .data + 122
> 000000000130  000f00000013 R_390_PC32DBL     0000000000000000 verify_sha256_digest + 2
> 000000000146  001700000013 R_390_PC32DBL     0000000000000000 post_verification[...] + 2
> 
> Corresponding s390 kernel discussion:
> * https://lore.kernel.org/linux-s390/20211208105801.188140-1-egorenar at linux.ibm.com/T/#u
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Reported-by: Tao Liu <ltao@redhat.com>
> Suggested-by: Philipp Rudo <prudo@redhat.com>
> Reviewed-by: Philipp Rudo <prudo@redhat.com>
> [hca at linux.ibm.com: changed commit message as requested by Philipp Rudo]
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  kexec/arch/s390/kexec-elf-rel-s390.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Sorry for the delay, applied.

