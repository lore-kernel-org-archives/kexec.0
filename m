Return-path: <kexec-bounces@lists.infradead.org>
Received: from rgminet01.oracle.com ([148.87.113.118])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IdTNi-0005vk-1A
	for kexec@lists.infradead.org; Thu, 04 Oct 2007 17:17:02 +0100
Date: Thu, 4 Oct 2007 09:07:11 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/2] implement new notifier function to panic_notifier_list
Message-Id: <20071004090711.456b6338.randy.dunlap@oracle.com>
In-Reply-To: <4704D0CA.4080001@ah.jp.nec.com>
References: <4704D0CA.4080001@ah.jp.nec.com>
Mime-Version: 1.0
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
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 04 Oct 2007 20:38:50 +0900 Takenori Nagano wrote:

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

...

> diff -uprN linux-2.6.23-rc9.orig/kernel/softlockup.c
> linux-2.6.23-rc9/kernel/softlockup.c
> --- linux-2.6.23-rc9.orig/kernel/softlockup.c	2007-10-02 12:24:52.000000000 +0900
> +++ linux-2.6.23-rc9/kernel/softlockup.c	2007-10-04 09:46:25.784000000 +0900
> @@ -31,10 +31,18 @@ softlock_panic(struct notifier_block *th
>  	return NOTIFY_DONE;
>  }
> 
> -static struct notifier_block panic_block = {
> +static struct notifier_block panic_block_base = {
>  	.notifier_call = softlock_panic,
>  };
> 
> +static struct tunable_notifier_block panic_block = {
> +	.nb		= &panic_block_base,
> +	.head		= NULL,
> +	.dir		= NULL,
> +	.pri_dentry	= NULL,
> +	.desc_dentry	= NULL
> +};
> +
>  /*
>   * Returns seconds, approximately.  We don't need nanosecond
>   * resolution, and we don't need to waste time with a big divide when
> @@ -193,5 +201,6 @@ __init void spawn_softlockup_task(void)
>  	cpu_callback(&cpu_nfb, CPU_ONLINE, cpu);
>  	register_cpu_notifier(&cpu_nfb);
> 
> -	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> +	tunable_notifier_chain_register(&panic_notifier_list, &panic_block,
> +						"softlookup", NULL);
>  }

                                                "softlockup"

---
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
