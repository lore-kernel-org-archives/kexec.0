Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SgVS0-0000pt-PA
 for kexec@lists.infradead.org; Mon, 18 Jun 2012 06:28:38 +0000
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Mon, 18 Jun 2012 06:17:36 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5I6KM5Y53084290
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 16:20:23 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5I6Rk85029078
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 16:27:47 +1000
Message-ID: <4FDECA4F.6030905@in.ibm.com>
Date: Mon, 18 Jun 2012 11:57:27 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] [ppc] Do not reserve cpu spin-table for crash kernel
References: <CAEsOVNeg2aogCwCy-v3ez4cC4VPF79A4PWRaO2ohDj_ypqCWmg@mail.gmail.com>
 <20120524060933.14035.42732.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20120524060933.14035.42732.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: B29882@freescale.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On 05/24/2012 11:39 AM, Suzuki K. Poulose wrote:
> As of now, the kexec reserves the spin-table for all the CPUs
> on an SMP machine. The spin-table is pointed to by the
> cpu-release-addr property in the device-tree. Reserving the
> spin-table in the crash kernel will cause a BUG(), if the table
> lies outside the memory reserved for the crashkernel.
>
> Disable reserving the spin-table regions and use maxcpus=1 to
> use only the crashing CPU to boot the crash kernel.
>
> Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>

Simon,

Any response on this one ?

I have tested this on a Currituck board (476, SMP) with a UP kernel.
Without this patch, the secondary kernel hits 'PANIC' in boot while
trying to reserve a memory(the spin table), outside the memory
range(crash reserve).


Thanks
Suzuki

> ---
>
>   kexec/arch/ppc/crashdump-powerpc.c |   19 +++++++++++++------
>   kexec/arch/ppc/fixup_dtb.c         |    4 ++++
>   2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
> index 1bef69b..4c8c75d 100644
> --- a/kexec/arch/ppc/crashdump-powerpc.c
> +++ b/kexec/arch/ppc/crashdump-powerpc.c
> @@ -262,10 +262,19 @@ static void ulltoa(unsigned long long i, char *str)
>   	}
>   }
>
> +/* Append str to cmdline */
> +static void add_cmdline(char *cmdline, char *str)
> +{
> +	int cmdlen = strlen(cmdline) + strlen(str);
> +	if (cmdlen>  (COMMAND_LINE_SIZE - 1))
> +		die("Command line overflow\n");
> +	strcat(cmdline, str);
> +}
> +
>   static int add_cmdline_param(char *cmdline, unsigned long long addr,
>   				char *cmdstr, char *byte)
>   {
> -	int cmdlen, len, align = 1024;
> +	int align = 1024;
>   	char str[COMMAND_LINE_SIZE], *ptr;
>
>   	/* Passing in =xxxK / =xxxM format. Saves space required in cmdline.*/
> @@ -284,11 +293,8 @@ static int add_cmdline_param(char *cmdline, unsigned long long addr,
>   	ptr += strlen(str);
>   	ulltoa(addr, ptr);
>   	strcat(str, byte);
> -	len = strlen(str);
> -	cmdlen = strlen(cmdline) + len;
> -	if (cmdlen>  (COMMAND_LINE_SIZE - 1))
> -		die("Command line overflow\n");
> -	strcat(cmdline, str);
> +
> +	add_cmdline(cmdline, str);
>
>   	dbgprintf("Command line after adding elfcorehdr: %s\n", cmdline);
>
> @@ -365,6 +371,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
>   	 */
>   	add_cmdline_param(mod_cmdline, elfcorehdr, " elfcorehdr=", "K");
>   	add_cmdline_param(mod_cmdline, saved_max_mem, " savemaxmem=", "M");
> +	add_cmdline(mod_cmdline, " maxcpus=1");
>   	return 0;
>   }
>
> diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
> index e9890a4..f832026 100644
> --- a/kexec/arch/ppc/fixup_dtb.c
> +++ b/kexec/arch/ppc/fixup_dtb.c
> @@ -172,6 +172,9 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf)
>   		}
>   	}
>
> +#if 0
> +	/* XXX: Do not reserve spin-table for CPUs. */
> +
>   	/* Add reserve regions for cpu-release-addr */
>   	nodeoffset = fdt_node_offset_by_prop_value(blob_buf, -1, "device_type", "cpu", 4);
>   	while (nodeoffset != -FDT_ERR_NOTFOUND) {
> @@ -201,6 +204,7 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf)
>   		nodeoffset = fdt_node_offset_by_prop_value(blob_buf, nodeoffset,
>   				"device_type", "cpu", 4);
>   	}
> +#endif
>
>   out:
>   	print_fdt_reserve_regions(blob_buf);
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
