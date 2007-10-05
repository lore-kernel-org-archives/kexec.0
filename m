Return-path: <kexec-bounces@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Idg7H-0002Dw-DK
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 06:52:56 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l955ndA8013045
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 01:49:39 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l955ndQd475844
	for <kexec@lists.infradead.org>; Thu, 4 Oct 2007 23:49:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l955nctn020960
	for <kexec@lists.infradead.org>; Thu, 4 Oct 2007 23:49:39 -0600
Date: Fri, 5 Oct 2007 11:19:52 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 2/2] implement new notifier function to panic_notifier_list
Message-ID: <20071005054952.GC4893@in.ibm.com>
References: <4704D0CA.4080001@ah.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4704D0CA.4080001@ah.jp.nec.com>
Reply-To: vgoyal@in.ibm.com
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Oct 04, 2007 at 08:38:50PM +0900, Takenori Nagano wrote:
> This patch implements new notifier function to panic_notifier_list. We can
> change the list of order by debugfs.
> 
> Thanks,
> 
> ---
> 
> Signed-off-by: Takenori Nagano <t-nagano@ah.jp.nec.com>
> 
> ---
> diff -uprN linux-2.6.23-rc9.orig/arch/alpha/kernel/setup.c
> linux-2.6.23-rc9/arch/alpha/kernel/setup.c
> --- linux-2.6.23-rc9.orig/arch/alpha/kernel/setup.c	2007-10-02
> 12:24:52.000000000 +0900
> +++ linux-2.6.23-rc9/arch/alpha/kernel/setup.c	2007-10-04 09:49:34.440000000 +0900
> @@ -45,14 +45,22 @@
>  #include <asm/io.h>
>  #include <linux/log2.h>
> 
> -extern struct atomic_notifier_head panic_notifier_list;
> +extern struct tunable_notifier_head panic_notifier_list;
>  static int alpha_panic_event(struct notifier_block *, unsigned long, void *);
> -static struct notifier_block alpha_panic_block = {
> +static struct notifier_block alpha_panic_block_base = {
>  	alpha_panic_event,
>          NULL,
>          INT_MAX /* try to do it first */
>  };
> 
> +static struct tunable_notifier_block alpha_panic_block = {
> +	&alpha_panic_block_base,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL
> +};
> +
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
>  #include <asm/system.h>
> @@ -522,8 +530,8 @@ setup_arch(char **cmdline_p)
>  	}
> 
>  	/* Register a call for panic conditions. */
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -			&alpha_panic_block);
> +	tunable_notifier_chain_register(&panic_notifier_list,
> +			&alpha_panic_block, "alpha_panic", NULL);
> 

I think it might be good idea to somehow create provisions for another a
help string. This help string will inform admin that what a registered
user does? Ideally this should be visible in /sys/kernel/debug/<user module>/description file.

This kind of description can help admin to decide the priority among various
registered users withoug having to look at the source code.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
