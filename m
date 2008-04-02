Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jh6wY-0001op-L5
	for kexec@lists.infradead.org; Wed, 02 Apr 2008 17:40:15 +0000
Date: Wed, 2 Apr 2008 13:39:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Add the symbol "phys_base" to vmcoreinfo
Message-ID: <20080402173908.GL668@redhat.com>
References: <47F0C449.9000204@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47F0C449.9000204@mxs.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Dave Anderson <anderson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>, "IKEDA,
	Munehiro" <m-ikeda@ds.jp.nec.com>

On Mon, Mar 31, 2008 at 08:00:25PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi Andrew,
> 
> This patch fixes the problem that makedumpfile sometimes fails
> on x86_64 machine. I hope that this patch will be merged to both
> linux-2.6.25 and linux-2.6.24.5.
> 
> This patch adds the symbol "phys_base" to a vmcoreinfo data.
> The vmcoreinfo data has the minimum debugging information only
> for dump filtering. makedumpfile (dump filtering command) gets
> it to distinguish unnecessary pages, and makedumpfile creates
> a small dumpfile.
> 
> On x86_64 kernel which compiled with CONFIG_PHYSICAL_START=0x0
> and CONFIG_RELOCATABLE=y, makedumpfile fails like the following:
> 
>  # makedumpfile -d31 /proc/vmcore dumpfile
>  The kernel version is not supported.
>  The created dumpfile may be incomplete.
>  _exclude_free_page: Can't get next online node.
> 
>  makedumpfile Failed.
>  #
> 
> The cause is the lack of the symbol "phys_base" in a vmcoreinfo
> data. If the symbol "phys_base" does not exist, makedumpfile
> considers an x86_64 kernel as non relocatable. As the result,
> makedumpfile misunderstands the physical address where the kernel
> is loaded, and it cannot translate a kernel virtual address to
> physical address correctly. To fix this proble, the attached
> patch which adds the symbol "phys_base" to a vmcoreinfo data.
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> ---
> diff -rpuN linux-2.6.25-rc7.orig/arch/x86/kernel/machine_kexec_64.c linux-2.6.25-rc7/arch/x86/kernel/machine_kexec_64.c
> --- linux-2.6.25-rc7.orig/arch/x86/kernel/machine_kexec_64.c	2008-03-26 14:55:29.000000000 +0900
> +++ linux-2.6.25-rc7/arch/x86/kernel/machine_kexec_64.c	2008-03-26 14:52:52.000000000 +0900
> @@ -233,6 +233,7 @@ NORET_TYPE void machine_kexec(struct kim
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> +	VMCOREINFO_SYMBOL(phys_base);
>  	VMCOREINFO_SYMBOL(init_level4_pgt);

CCing to LKML.

Looks good to me. Given a vmcore file, one needs to know about
the shift between compile address and run time address of kernel
to be able to do filtering. This shift (phys_base) will vary
based on kernel config options and based on where boot loader
has loaded a kernel.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
