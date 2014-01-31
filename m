Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W94Fp-0004cN-H0
 for kexec@lists.infradead.org; Fri, 31 Jan 2014 02:54:54 +0000
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 12:54:27 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C24FC2BB0054
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 13:54:24 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0V2ZBi159900152
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 13:35:11 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0V2sNr3011878
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 13:54:24 +1100
Message-ID: <52EB105D.2060907@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 08:24:21 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/ppc64 Enable early kernel's OPAL calls
References: <20140124141614.6404.37733.stgit@nimbus>
In-Reply-To: <20140124141614.6404.37733.stgit@nimbus>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, horms@verge.net.au, kexec@lists.infradead.org

On 01/24/2014 07:46 PM, Laurent Dufour wrote:
> When the kernel is built with CONFIG_PPC_EARLY_DEBUG_OPAL set, it is
> expecting to get r8 and r9 filled respectively with OPAL base address and
> OPAL entry address (arc/power/head_64.S).
> 
> On the new powernv platform, having these 2 registers set allows the kernel
> to perform OPAL calls before it parse the device tree.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

> ---
>  kexec/arch/ppc64/kexec-elf-ppc64.c     |   43 ++++++++++++++++++++++++++++++++
>  purgatory/arch/ppc64/purgatory-ppc64.c |    2 +
>  purgatory/arch/ppc64/v2wrap.S          |    4 +++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
> index 7d49d8a..ce10367 100644
> --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
> @@ -71,6 +71,26 @@ void arch_reuse_initrd(void)
>  	reuse_initrd = 1;
>  }
> 
> +static int read_prop(char *name, void *value, size_t len)
> +{
> +	int fd;
> +	size_t rlen;
> +
> +	fd = open(name, O_RDONLY);
> +	if (fd == -1)
> +		return -1;
> +
> +	rlen = read(fd, value, len);
> +	if (rlen < 0)
> +		fprintf(stderr, "Warning : Can't read %s : %s",
> +			name, strerror(errno));
> +	else if (rlen != len)
> +		fprintf(stderr, "Warning : short read from %s", name);
> +
> +	close(fd);
> +	return 0;
> +}
> +
>  int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  			struct kexec_info *info)
>  {
> @@ -90,6 +110,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  	int i;
>  	int result, opt;
>  	uint64_t my_kernel, my_dt_offset;
> +	uint64_t my_opal_base = 0, my_opal_entry = 0;
>  	unsigned int my_panic_kernel;
>  	uint64_t my_stack, my_backup_start;
>  	uint64_t toc_addr;
> @@ -246,6 +267,20 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  	*rsvmap_ptr = cpu_to_be64((uint64_t)be32_to_cpu(bb_ptr->totalsize));
>  #endif
> 
> +	if (read_prop("/proc/device-tree/ibm,opal/opal-base-address",
> +		      &my_opal_base, sizeof(my_opal_base)) == 0) {
> +		my_opal_base = be64_to_cpu(my_opal_base);
> +		elf_rel_set_symbol(&info->rhdr, "opal_base",
> +				   &my_opal_base, sizeof(my_opal_base));
> +	}
> +
> +	if (read_prop("/proc/device-tree/ibm,opal/opal-entry-address",
> +		      &my_opal_entry, sizeof(my_opal_entry)) == 0) {
> +		my_opal_entry = be64_to_cpu(my_opal_entry);
> +		elf_rel_set_symbol(&info->rhdr, "opal_entry",
> +				   &my_opal_entry, sizeof(my_opal_entry));
> +	}
> +
>  	/* Set kernel */
>  	elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
> 
> @@ -306,7 +341,13 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  	toc_addr = 0;
>  	my_run_at_load = 0;
>  	my_debug = 0;
> +	my_opal_base = 0;
> +	my_opal_entry = 0;
> 
> +	elf_rel_get_symbol(&info->rhdr, "opal_base", &my_opal_base,
> +			   sizeof(my_opal_base));
> +	elf_rel_get_symbol(&info->rhdr, "opal_entry", &my_opal_entry,
> +			   sizeof(my_opal_entry));
>  	elf_rel_get_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
>  	elf_rel_get_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
>  				sizeof(my_dt_offset));
> @@ -333,6 +374,8 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  	dbgprintf("toc_addr is %llx\n", (unsigned long long)toc_addr);
>  	dbgprintf("purgatory size is %zu\n", purgatory_size);
>  	dbgprintf("debug is %d\n", my_debug);
> +	dbgprintf("opal_base is %llx\n", (unsigned long long) my_opal_base);
> +	dbgprintf("opal_entry is %llx\n", (unsigned long long) my_opal_entry);
> 
>  	for (i = 0; i < info->nr_segments; i++)
>  		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
> diff --git a/purgatory/arch/ppc64/purgatory-ppc64.c b/purgatory/arch/ppc64/purgatory-ppc64.c
> index 0b6d326..7248ac8 100644
> --- a/purgatory/arch/ppc64/purgatory-ppc64.c
> +++ b/purgatory/arch/ppc64/purgatory-ppc64.c
> @@ -29,6 +29,8 @@ unsigned long dt_offset = 0;
>  unsigned long my_toc = 0;
>  unsigned long kernel = 0;
>  unsigned int debug = 0;
> +unsigned long opal_base = 0;
> +unsigned long opal_entry = 0;
> 
>  void setup_arch(void)
>  {
> diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
> index 2761c14..6fc62e3 100644
> --- a/purgatory/arch/ppc64/v2wrap.S
> +++ b/purgatory/arch/ppc64/v2wrap.S
> @@ -95,6 +95,10 @@ master:
>  	blt     80f
>  	stw     17,28(3)        # save my cpu number as boot_cpu_phys
>  80:
> +	LOADADDR(6,opal_base)	# For OPAL early debug
> +	ld      8,0(6)          # load the OPAL base address in r8
> +	LOADADDR(6,opal_entry)	# For OPAL early debug
> +	ld      9,0(6)          # load the OPAL entry address in r9
>  	LOADADDR(6,kernel)
>  	ld      4,0(6)          # load the kernel address
>  	LOADADDR(6,run_at_load) # the load flag
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
