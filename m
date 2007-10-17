Return-path: <kexec-bounces@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IhyjE-0004iL-AF
	for kexec@lists.infradead.org; Wed, 17 Oct 2007 03:33:52 +0100
Date: Wed, 17 Oct 2007 11:33:07 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/3] [kexec-tools] Pass vmcoreinfo's address and size
Message-ID: <20071017023305.GC6709@verge.net.au>
References: <20070822210838oomichi@mail.jp.nec.com>
	<20070822211339oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070822211339oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Aug 22, 2007 at 09:13:39PM +0900, Ken'ichi Ohmichi wrote:
> 
> [2/3] [kexec-tools] Pass vmcoreinfo's address and size
> The patch is for kexec-tools-testing-20070330.
> (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
> kexec command gets the address and size of the vmcoreinfo data from
> /sys/kernel/vmcoreinfo, and passes them to the second kernel through
> ELF header of /proc/vmcore. When the second kernel is booting, the
> kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
> segment into /proc/vmcore.

Sorry for the long delay, I completely missed this patch.

The kexec-tools change seems ok to me. What is the status of
the kernel portion of the change? Do you still want the
kexec-tools portion applied?

> 
> Thanks
> Ken'ichi Ohmichi
> 
> ---
> Signed-off-by: Dan Aloni <da-x@monatomic.org>
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> 
> ---
> diff -rpuN backup/kexec-tools-testing-20070330/kexec/crashdump-elf.c kexec-tools/kexec/crashdump-elf.c
> --- backup/kexec-tools-testing-20070330/kexec/crashdump-elf.c	2007-03-30 13:34:36.000000000 +0900
> +++ kexec-tools/kexec/crashdump-elf.c	2007-08-03 14:45:47.000000000 +0900
> @@ -36,6 +36,8 @@ int FUNC(struct kexec_info *info,
>  	char *bufp;
>  	long int nr_cpus = 0;
>  	uint64_t notes_addr, notes_len;
> +	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
> +	int has_vmcoreinfo = 0;
>  	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
>  
>  	if (xen_present())
> @@ -47,7 +49,11 @@ int FUNC(struct kexec_info *info,
>  		return -1;
>  	}
>  
> -	sz = sizeof(EHDR) + nr_cpus * sizeof(PHDR) + ranges * sizeof(PHDR);
> +	if (get_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len) == 0) {
> +		has_vmcoreinfo = 1;
> +	}
> +
> +	sz = sizeof(EHDR) + (nr_cpus + has_vmcoreinfo) * sizeof(PHDR) + ranges * sizeof(PHDR);
>  
>  	/*
>  	 * Certain architectures such as x86_64 and ia64 require a separate
> @@ -148,6 +154,21 @@ int FUNC(struct kexec_info *info,
>  		dfprintf_phdr(stdout, "Elf header", phdr);
>  	}
>  
> +	if (has_vmcoreinfo) {
> +		phdr = (PHDR *) bufp;
> +		bufp += sizeof(PHDR);
> +		phdr->p_type	= PT_NOTE;
> +		phdr->p_flags	= 0;
> +		phdr->p_offset  = phdr->p_paddr = vmcoreinfo_addr;
> +		phdr->p_vaddr   = 0;
> +		phdr->p_filesz	= phdr->p_memsz	= vmcoreinfo_len;
> +		/* Do we need any alignment of segments? */
> +		phdr->p_align	= 0;
> +
> +		(elf->e_phnum)++;
> +		dfprintf_phdr(stdout, "vmcoreinfo header", phdr);
> +	}
> +
>  	/* Setup an PT_LOAD type program header for the region where
>  	 * Kernel is mapped if info->kern_size is non-zero.
>  	 */
> diff -rpuN backup/kexec-tools-testing-20070330/kexec/crashdump.c kexec-tools/kexec/crashdump.c
> --- backup/kexec-tools-testing-20070330/kexec/crashdump.c	2007-03-30 13:34:36.000000000 +0900
> +++ kexec-tools/kexec/crashdump.c	2007-08-03 14:45:05.000000000 +0900
> @@ -108,3 +108,35 @@ int get_crash_notes_per_cpu(int cpu, uin
>  
>  	return 0;
>  }
> +
> +/* Returns the physical address of start of crash notes buffer for a kernel. */
> +int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
> +{
> +	char kdump_info[PATH_MAX];
> +	char line[MAX_LINE];
> +	int count;
> +	FILE *fp;
> +	unsigned long long temp, temp2;
> +
> +	*addr = 0;
> +	*len = 0;
> +
> +	sprintf(kdump_info, "/sys/kernel/vmcoreinfo");
> +	fp = fopen(kdump_info, "r");
> +	if (!fp) {
> +		die("Could not open \"%s\": %s\n", kdump_info,
> +		    strerror(errno));
> +		return -1;
> +	}
> +
> +	if (!fgets(line, sizeof(line), fp))
> +		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
> +	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
> +	if (count != 2)
> +		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
> +
> +	*addr = (uint64_t) temp;
> +	*len = (uint64_t) temp2;
> +
> +	return 0;
> +}
> diff -rpuN backup/kexec-tools-testing-20070330/kexec/crashdump.h kexec-tools/kexec/crashdump.h
> --- backup/kexec-tools-testing-20070330/kexec/crashdump.h	2007-03-30 13:34:36.000000000 +0900
> +++ kexec-tools/kexec/crashdump.h	2007-08-03 14:45:05.000000000 +0900
> @@ -2,6 +2,7 @@
>  #define CRASHDUMP_H
>  
>  extern int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len);
> +extern int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len);
>  
>  /* Need to find a better way to determine per cpu notes section size. */
>  #define MAX_NOTE_BYTES		1024
> _
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
