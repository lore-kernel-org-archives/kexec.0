Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cS0OW-0002cC-Kj
 for kexec@lists.infradead.org; Fri, 13 Jan 2017 11:51:46 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0DBnbYS049232
 for <kexec@lists.infradead.org>; Fri, 13 Jan 2017 06:51:24 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27xqejp757-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 13 Jan 2017 06:51:23 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 13 Jan 2017 21:51:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 64DC92CE8046
 for <kexec@lists.infradead.org>; Fri, 13 Jan 2017 22:51:19 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0DBpJUw56295652
 for <kexec@lists.infradead.org>; Fri, 13 Jan 2017 22:51:19 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0DBpI6V028805
 for <kexec@lists.infradead.org>; Fri, 13 Jan 2017 22:51:19 +1100
Subject: Re: [PATCH v4 4/5] powerpc/fadump: reuse crashkernel parameter for
 fadump memory reservation
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363754236.11570.1527409032997316662.stgit@hbathini.in.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 13 Jan 2017 17:21:13 +0530
MIME-Version: 1.0
In-Reply-To: <148363754236.11570.1527409032997316662.stgit@hbathini.in.ibm.com>
Message-Id: <ca056a82-65c0-c2e0-bc30-8dc8644452de@linux.vnet.ibm.com>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com

On 01/05/2017 11:02 PM, Hari Bathini wrote:
> fadump supports specifying memory to reserve for fadump's crash kernel
> with fadump_reserve_mem kernel parameter. This parameter currently
> supports passing a fixed memory size, like fadump_reserve_mem=<size>
> only. This patch aims to add support for other syntaxes like range-based
> memory size <range1>:<size1>[,<range2>:<size2>,<range3>:<size3>,...]
> which allows using the same parameter to boot the kernel with different
> system RAM sizes.
> 
> As crashkernel parameter already supports the above mentioned syntaxes,
> this patch deprecates fadump_reserve_mem parameter and reuses crashkernel
> parameter instead, to specify memory for fadump's crash kernel memory
> reservation as well. If any offset is provided in crashkernel parameter,
> it will be ignored in case of fadump, as fadump reserves memory at end
> of RAM.
> 
> Advantages using crashkernel parameter instead of fadump_reserve_mem
> parameter are one less kernel parameter overall, code reuse and support
> for multiple syntaxes to specify memory.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/fadump.c |   23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index db0b339..de7d39a 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -210,14 +210,20 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
>   */
>  static inline unsigned long fadump_calculate_reserve_size(void)
>  {
> -	unsigned long size;
> +	int ret;
> +	unsigned long long base, size;
> 
>  	/*
> -	 * Check if the size is specified through fadump_reserve_mem= cmdline
> -	 * option. If yes, then use that.
> +	 * Check if the size is specified through crashkernel= cmdline
> +	 * option. If yes, then use that but ignore base as fadump
> +	 * reserves memory at end of RAM.
>  	 */
> -	if (fw_dump.reserve_bootvar)
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +				&size, &base);
> +	if (ret == 0 && size > 0) {
> +		fw_dump.reserve_bootvar = (unsigned long)size;
>  		return fw_dump.reserve_bootvar;
> +	}
> 
>  	/* divide by 20 to get 5% of value */
>  	size = memblock_end_of_DRAM() / 20;
> @@ -353,15 +359,6 @@ static int __init early_fadump_param(char *p)
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
