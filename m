Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwip6-0097J3-S4
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 10:44:50 +0000
Date: Mon, 13 Dec 2021 11:44:30 +0100
From: Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH 1/1] s390: handle R_390_PLT32DBL reloc entries in
 machine_apply_elf_rel()
Message-ID: <20211213114430.77f28a67@rhtmp>
In-Reply-To: <20211208125355.256391-1-egorenar@linux.ibm.com>
References: <20211208125355.256391-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: ltao@redhat.com, hca@linux.ibm.com, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>

Hi Alexander,

@Alexander: Thanks for taking care of this.

On Wed,  8 Dec 2021 13:53:55 +0100
Alexander Egorenkov <egorenar@linux.ibm.com> wrote:

> Starting with gcc 11.3, the C compiler will generate PLT-relative function
> calls even if they are local and do not require it. Later on during linking,
> the linker will replace all PLT-relative calls to local functions with
> PC-relative ones. Unfortunately, the purgatory code of kexec/kdump is
> not being linked as a regular executable or shared library would have been,
> and therefore, all PLT-relative addresses remain in the generated purgatory
> object code unresolved. This leads to the situation where the purgatory
> code is being executed during kdump with all PLT-relative addresses
> unresolved. And this results in endless loops within the purgatory code.

Tiny nit. The last two sentences describe the situation in the kernel.
Luckily the kexec-tools do proper error checking and die with

	"Unknown rela relocation: 0x14 0x73c0901c"

when they encounter an unknown relocation type.

Anyway, the code is correct

Reviewed-by: Philipp Rudo <prudo@redhat.com>

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
> * https://lore.kernel.org/linux-s390/20211208105801.188140-1-egorenar@linux.ibm.com/T/#u
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Reported-by: Tao Liu <ltao@redhat.com>
> Suggested-by: Philipp Rudo <prudo@redhat.com>
> ---
>  kexec/arch/s390/kexec-elf-rel-s390.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/s390/kexec-elf-rel-s390.c b/kexec/arch/s390/kexec-elf-rel-s390.c
> index a5e1b7345578..91ba86a9991d 100644
> --- a/kexec/arch/s390/kexec-elf-rel-s390.c
> +++ b/kexec/arch/s390/kexec-elf-rel-s390.c
> @@ -56,6 +56,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
>  	case R_390_PC16:	/* PC relative 16 bit.  */
>  	case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
>  	case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
> +	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
>  	case R_390_PC32:	/* PC relative 32 bit.  */
>  	case R_390_PC64:	/* PC relative 64 bit.	*/
>  		val -= address;
> @@ -63,7 +64,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
>  			*(unsigned short *) loc = val;
>  		else if (r_type == R_390_PC16DBL)
>  			*(unsigned short *) loc = val >> 1;
> -		else if (r_type == R_390_PC32DBL)
> +		else if (r_type == R_390_PC32DBL || r_type == R_390_PLT32DBL)
>  			*(unsigned int *) loc = val >> 1;
>  		else if (r_type == R_390_PC32)
>  			*(unsigned int *) loc = val;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
