Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pup9z-0006AJ-L8
	for kexec@lists.infradead.org; Wed, 02 Mar 2011 16:44:24 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p22GiMWm001314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 2 Mar 2011 11:44:22 -0500
Date: Wed, 2 Mar 2011 11:44:21 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch] get the backup area dynamically
Message-ID: <20110302164421.GB16583@redhat.com>
References: <1299082243-25716-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1299082243-25716-1-git-send-email-amwang@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Amerigo Wang <amwang@redhat.com>
Cc: kexec@lists.infradead.org

On Thu, Mar 03, 2011 at 12:10:43AM +0800, Amerigo Wang wrote:
> Currently we hard-coded the first 640K area as backup area,
> however, this is not correct on some system which has reserved
> memory area in the first 640K:
> 
> BIOS-e820: 0000000000010000 - 0000000000097000 (usable)
> BIOS-e820: 0000000000097000 - 00000000000a0000 (reserved)
> 
> on such system we still mark all the first 640K as usable
> in capture kernel, this will cause kernel panic.

We recently had an issue where the BIOS area which was marked as reserved
in first kernel, and second kernel tried to use it and led to panic. The
believe is that kernel shouldn't have used that area as it is BIOS
reserved.

So we need to move away from hardcoded first 640K and instead try to
determine that area dynamically. In more generic form, which should
have the capability to have multiple backup areas or multiple ranges
in single backup area. But I think as a first step, having single
backup area is fine. 

If we run into issues where BIOS split first 640K into multiple small
"usable" pieces, then we shall have to go for more generic form.

So this approach sounds reasonable to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> 
> The solution, pointed by Vivek, is that we can get the backup
> area dynamically by reading /proc/iomem.
> 
> The reporter has tested this patch and it fixes the problem.
> 
> Signed-off-by: WANG Cong <amwang@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> 
> ---
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 40f989a..ef4a6f6 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -200,15 +200,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  		return -1;
>  	}
>  
> -	/* First entry is for first 640K region. Different bios report first
> -	 * 640K in different manner hence hardcoding it */
> -	if (!(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
> -		crash_memory_range[0].start = 0x00000000;
> -		crash_memory_range[0].end = 0x0009ffff;
> -		crash_memory_range[0].type = RANGE_RAM;
> -		memory_ranges++;
> -	}
> -
>  	while(fgets(line, sizeof(line), fp) != 0) {
>  		char *str;
>  		int type, consumed, count;
> @@ -254,10 +245,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  			continue;
>  		}
>  
> -		/* First 640K already registered */
> -		if (end <= 0x0009ffff)
> -			continue;
> -
>  		crash_memory_range[memory_ranges].start = start;
>  		crash_memory_range[memory_ranges].end = end;
>  		crash_memory_range[memory_ranges].type = type;
> @@ -678,6 +665,49 @@ static int cmdline_add_memmap_acpi(char *cmdline, unsigned long start,
>  	return 0;
>  }
>  
> +static void get_backup_area(unsigned long *start, unsigned long *end)
> +{
> +	const char *iomem = proc_iomem();
> +	char line[MAX_LINE];
> +	FILE *fp;
> +
> +	fp = fopen(iomem, "r");
> +	if (!fp) {
> +		fprintf(stderr, "Cannot open %s: %s\n",
> +			iomem, strerror(errno));
> +		return;
> +	}
> +
> +	while(fgets(line, sizeof(line), fp) != 0) {
> +		char *str;
> +		int count, consumed;
> +		unsigned long mstart, mend;
> +
> +		count = sscanf(line, "%lx-%lx : %n",
> +			&mstart, &mend, &consumed);
> +		if (count != 2)
> +			continue;
> +		str = line + consumed;
> +#ifdef DEBUG
> +		printf("%016lx-%016lx : %s",
> +			mstart, mend, str);
> +#endif
> +		/* Hopefully there is only one RAM region in the first 640K */
> +		if (memcmp(str, "System RAM\n", 11) == 0 && mend <= 0xa0000 ) {
> +#ifdef DEBUG
> +			printf("%s: %016lx-%016lx : %s", __func__, mstart, mend, str);
> +#endif
> +			*start = mstart;
> +			*end = mend;
> +			fclose(fp);
> +			return;
> +		}
> +	}
> +	*start = BACKUP_SRC_START;
> +	*end = BACKUP_SRC_END;
> +	fclose(fp);
> +}
> +
>  /* Loads additional segments in case of a panic kernel is being loaded.
>   * One segment for backup region, another segment for storing elf headers
>   * for crash memory image.
> @@ -695,8 +725,10 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  
>  	/* Constant parts of the elf_info */
>  	elf_info.data             = ELFDATA2LSB;
> -	elf_info.backup_src_start = BACKUP_SRC_START;
> -	elf_info.backup_src_end   = BACKUP_SRC_END;
> +	get_backup_area(&elf_info.backup_src_start, &elf_info.backup_src_end);
> +	info->backup_src_start = elf_info.backup_src_start;
> +	info->backup_src_size = elf_info.backup_src_end
> +				- elf_info.backup_src_start + 1;
>  
>          /* Get the elf architecture of the running kernel */
>  	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64) {
> @@ -739,13 +771,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  	sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
>  	memmap_p = xmalloc(sz);
>  	memset(memmap_p, 0, sz);
> -	add_memmap(memmap_p, BACKUP_SRC_START, BACKUP_SRC_SIZE);
> +	add_memmap(memmap_p, elf_info.backup_src_start,
> +		   elf_info.backup_src_end - elf_info.backup_src_start + 1);
>  	sz = crash_reserved_mem.end - crash_reserved_mem.start +1;
>  	add_memmap(memmap_p, crash_reserved_mem.start, sz);
>  
>  	/* Create a backup region segment to store backup data*/
>  	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
> -		sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
> +		sz = (elf_info.backup_src_end - elf_info.backup_src_start + align)
> +		     & ~(align - 1);
>  		tmp = xmalloc(sz);
>  		memset(tmp, 0, sz);
>  		info->backup_start = add_buffer(info, tmp, sz, sz, align,
> diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
> index c34fd92..6c42c32 100644
> --- a/kexec/arch/x86_64/kexec-x86_64.c
> +++ b/kexec/arch/x86_64/kexec-x86_64.c
> @@ -157,6 +157,10 @@ void arch_update_purgatory(struct kexec_info *info)
>  		&arch_options.console_vga, sizeof(arch_options.console_vga));
>  	elf_rel_set_symbol(&info->rhdr, "console_serial",
>  		&arch_options.console_serial, sizeof(arch_options.console_serial));
> +	elf_rel_set_symbol(&info->rhdr, "backup_src_start",
> +		&info->backup_src_start, sizeof(info->backup_src_start));
> +	elf_rel_set_symbol(&info->rhdr, "backup_src_size",
> +		&info->backup_src_size, sizeof(info->backup_src_size));
>  
>  	if (info->kexec_flags & KEXEC_ON_CRASH) {
>  		panic_kernel = 1;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 9a70224..9b59890 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -122,6 +122,8 @@ struct kexec_info {
>  	struct mem_ehdr rhdr;
>  	unsigned long backup_start;
>  	unsigned long kexec_flags;
> +	unsigned long backup_src_start;
> +	unsigned long backup_src_size;
>  };
>  
>  struct arch_map_entry {
> diff --git a/purgatory/arch/i386/crashdump_backup.c b/purgatory/arch/i386/crashdump_backup.c
> index c619446..365eb5d 100644
> --- a/purgatory/arch/i386/crashdump_backup.c
> +++ b/purgatory/arch/i386/crashdump_backup.c
> @@ -20,13 +20,15 @@
>  
>  #include <stdint.h>
>  #include <string.h>
> -#include "../../../kexec/arch/i386/crashdump-x86.h"
>  
>  /* Backup region start gets set after /proc/iomem has been parsed. */
>  /* We reuse the same code for x86_64 also so changing backup_start to
>     unsigned long */
>  unsigned long  backup_start = 0;
>  
> +unsigned long backup_src_start = 0;
> +unsigned long backup_src_size = 0;
> +
>  /* Backup first 640K of memory to backup region as reserved by kexec.
>   * Assuming first 640K has to be present on i386 machines and no address
>   * validity checks have to be performed. */
> @@ -34,11 +36,16 @@ unsigned long  backup_start = 0;
>  void crashdump_backup_memory(void)
>  {
>  	void *dest, *src;
> +	size_t size;
> +
> +	src = (void *) backup_src_start;
> +	size = (size_t) backup_src_size;
>  
> -	src = (void *) BACKUP_SRC_START;
> +	if (!size)
> +		return;
>  
>  	if (backup_start) {
>  		dest = (void *)(backup_start);
> -		memcpy(dest, src, BACKUP_SRC_SIZE);
> +		memcpy(dest, src, size);
>  	}
>  }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
