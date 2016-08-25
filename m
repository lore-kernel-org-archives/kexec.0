Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcog9-0001F2-6B
 for kexec@lists.infradead.org; Thu, 25 Aug 2016 07:02:23 +0000
Date: Thu, 25 Aug 2016 15:01:52 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc/fadump: parse fadump reserve memory size
 based on memory range
Message-ID: <20160825070152.GA15879@dhcp-128-65.nay.redhat.com>
References: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
 <147082352471.4631.16292252236310652183.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <147082352471.4631.16292252236310652183.stgit@hbathini.in.ibm.com>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, ebiederm@xmission.com, Michael Ellerman <mpe@ellerman.id.au>, vgoyal@redhat.com

On 08/10/16 at 03:35pm, Hari Bathini wrote:
> When fadump is enabled, by default 5% of system RAM is reserved for
> fadump kernel. While that works for most cases, it is not good enough
> for every case.
> 
> Currently, to override the default value, fadump supports specifying
> memory to reserve with fadump_reserve_mem=size, where only a fixed size
> can be specified. This patch adds support to specify memory size to
> reserve for different memory ranges as below:
> 
> 	fadump_reserve_mem=<range1>:<size1>[,<range2>:<size2>,...]

Hi, Hari

I do not understand why you need introduce the new cmdline param, what's
the difference between the "fadump reserved" memory and the memory
reserved by "crashkernel="? Can fadump just use crashkernel= to reserve
memory?

Thanks
Dave

> 
> Supporting range based input for "fadump_reserve_mem" parameter helps
> using the same commandline parameter for different system memory sizes.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
> 
> Changes from v2:
> 1. Updated changelog
> 
> 
>  arch/powerpc/kernel/fadump.c |   63 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index b3a6633..7c01b5b 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -193,6 +193,55 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
>  	return addr;
>  }
>  
> +/*
> + * This function parses command line for fadump_reserve_mem=
> + *
> + * Supports the below two syntaxes:
> + *    1. fadump_reserve_mem=size
> + *    2. fadump_reserve_mem=ramsize-range:size[,...]
> + *
> + * Sets fw_dump.reserve_bootvar with the memory size
> + * provided, 0 otherwise
> + *
> + * The function returns -EINVAL on failure, 0 otherwise.
> + */
> +static int __init parse_fadump_reserve_mem(void)
> +{
> +	char *name = "fadump_reserve_mem=";
> +	char *fadump_cmdline = NULL, *cur;
> +
> +	fw_dump.reserve_bootvar = 0;
> +
> +	/* find fadump_reserve_mem and use the last one if there are many */
> +	cur = strstr(boot_command_line, name);
> +	while (cur) {
> +		fadump_cmdline = cur;
> +		cur = strstr(cur+1, name);
> +	}
> +
> +	/* when no fadump_reserve_mem= cmdline option is provided */
> +	if (!fadump_cmdline)
> +		return 0;
> +
> +	fadump_cmdline += strlen(name);
> +
> +	/* for fadump_reserve_mem=size cmdline syntax */
> +	if (!is_colon_in_param(fadump_cmdline)) {
> +		fw_dump.reserve_bootvar = memparse(fadump_cmdline, NULL);
> +		return 0;
> +	}
> +
> +	/* for fadump_reserve_mem=ramsize-range:size[,...] cmdline syntax */
> +	cur = fadump_cmdline;
> +	fw_dump.reserve_bootvar = parse_mem_range_size("fadump_reserve_mem",
> +					&cur, memblock_phys_mem_size());
> +	if (cur == fadump_cmdline) {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
>   *
> @@ -212,12 +261,17 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>  {
>  	unsigned long size;
>  
> +	/* sets fw_dump.reserve_bootvar */
> +	parse_fadump_reserve_mem();
> +
>  	/*
>  	 * Check if the size is specified through fadump_reserve_mem= cmdline
>  	 * option. If yes, then use that.
>  	 */
>  	if (fw_dump.reserve_bootvar)
>  		return fw_dump.reserve_bootvar;
> +	else
> +		printk(KERN_INFO "fadump: calculating default boot size\n");
>  
>  	/* divide by 20 to get 5% of value */
>  	size = memblock_end_of_DRAM() / 20;
> @@ -348,15 +402,6 @@ static int __init early_fadump_param(char *p)
>  }
>  early_param("fadump", early_fadump_param);
>  
> -/* Look for fadump_reserve_mem= cmdline option */
> -static int __init early_fadump_reserve_mem(char *p)
> -{
> -	if (p)
> -		fw_dump.reserve_bootvar = memparse(p, &p);
> -	return 0;
> -}
> -early_param("fadump_reserve_mem", early_fadump_reserve_mem);
> -
>  static void register_fw_dump(struct fadump_mem_struct *fdm)
>  {
>  	int rc;
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
