From: Philipp Rudo <prudo@redhat.com>
Date: Thu, 20 Jan 2022 19:09:06 +0100
Subject: [PATCHv4 3/4] arm64: read VA_BITS from kcore for 52-bits VA kernel
In-Reply-To: <20220118074812.27702-4-piliu@redhat.com>
References: <20220118074812.27702-1-piliu@redhat.com>
 <20220118074812.27702-4-piliu@redhat.com>
Message-ID: <20220120190906.2ec85ec9@rhtmp>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Pingfan,

On Tue, 18 Jan 2022 15:48:11 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> phys_to_virt() calculates virtual address. As a important factor,
> page_offset is excepted to be accurate.
> 
> Since arm64 kernel exposes va_bits through vmcore, using it.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: kexec at lists.infradead.org

looks good

Reviewed-by: Philipp Rudo <prudo@redhat.com>

> ---
>  kexec/arch/arm64/kexec-arm64.c | 34 ++++++++++++++++++++++++++++++----
>  util_lib/elf_info.c            |  5 +++++
>  util_lib/include/elf_info.h    |  1 +
>  3 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 33cc258..793799b 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -54,7 +54,7 @@
>  static bool try_read_phys_offset_from_kcore = false;
>  
>  /* Machine specific details. */
> -static int va_bits;
> +static int va_bits = -1;
>  static unsigned long page_offset;
>  
>  /* Global varables the core kexec routines expect. */
> @@ -876,7 +876,18 @@ static inline void set_phys_offset(int64_t v, char *set_method)
>  
>  static int get_va_bits(void)
>  {
> -	unsigned long long stext_sym_addr = get_kernel_sym("_stext");
> +	unsigned long long stext_sym_addr;
> +
> +	/*
> +	 * if already got from kcore
> +	 */
> +	if (va_bits != -1)
> +		goto out;
> +
> +
> +	/* For kernel older than v4.19 */
> +	fprintf(stderr, "Warning, can't get the VA_BITS from kcore\n");
> +	stext_sym_addr = get_kernel_sym("_stext");
>  
>  	if (stext_sym_addr == 0) {
>  		fprintf(stderr, "Can't get the symbol of _stext.\n");
> @@ -900,6 +911,7 @@ static int get_va_bits(void)
>  		return -1;
>  	}
>  
> +out:
>  	dbgprintf("va_bits : %d\n", va_bits);
>  
>  	return 0;
> @@ -917,14 +929,27 @@ int get_page_offset(unsigned long *page_offset)
>  	if (ret < 0)
>  		return ret;
>  
> -	*page_offset = UINT64_MAX << (va_bits - 1);
> +	if (va_bits < 52)
> +		*page_offset = UINT64_MAX << (va_bits - 1);
> +	else
> +		*page_offset = UINT64_MAX << va_bits;
> +
>  	dbgprintf("page_offset : %lx\n", *page_offset);
>  
>  	return 0;
>  }
>  
> +static void arm64_scan_vmcoreinfo(char *pos)
> +{
> +	const char *str;
> +
> +	str = "NUMBER(VA_BITS)=";
> +	if (memcmp(str, pos, strlen(str)) == 0)
> +		va_bits = strtoul(pos + strlen(str), NULL, 10);
> +}
> +
>  /**
> - * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET
> + * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET (and va_bits)
>   * from VMCOREINFO note inside 'kcore'.
>   */
>  
> @@ -937,6 +962,7 @@ static int get_phys_offset_from_vmcoreinfo_pt_note(long *phys_offset)
>  		return EFAILED;
>  	}
>  
> +	arch_scan_vmcoreinfo = arm64_scan_vmcoreinfo;
>  	ret = read_phys_offset_elf_kcore(fd, phys_offset);
>  
>  	close(fd);
> diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
> index 5574c7f..d252eff 100644
> --- a/util_lib/elf_info.c
> +++ b/util_lib/elf_info.c
> @@ -310,6 +310,8 @@ int get_pt_load(int idx,
>  
>  #define NOT_FOUND_LONG_VALUE		(-1)
>  
> +void (*arch_scan_vmcoreinfo)(char *pos);
> +
>  void scan_vmcoreinfo(char *start, size_t size)
>  {
>  	char *last = start + size - 1;
> @@ -551,6 +553,9 @@ void scan_vmcoreinfo(char *start, size_t size)
>  			}
>  		}
>  
> +		if (arch_scan_vmcoreinfo != NULL)
> +			(*arch_scan_vmcoreinfo)(pos);
> +
>  		if (last_line)
>  			break;
>  	}
> diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
> index f550d86..fdf4c3d 100644
> --- a/util_lib/include/elf_info.h
> +++ b/util_lib/include/elf_info.h
> @@ -31,5 +31,6 @@ int get_pt_load(int idx,
>  int read_phys_offset_elf_kcore(int fd, long *phys_off);
>  int read_elf(int fd);
>  void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
> +extern void (*arch_scan_vmcoreinfo)(char *pos);
>  
>  #endif /* ELF_INFO_H */


