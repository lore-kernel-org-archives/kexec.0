Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QPfY4-0005bH-Uh
	for kexec@lists.infradead.org; Thu, 26 May 2011 18:44:46 +0000
Date: Thu, 26 May 2011 14:43:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC Patch 4/6] PANIC_MCE: Introduce a new panic flag for fatal
	MCE, capture related information
Message-ID: <20110526184350.GE29496@redhat.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171521.GD17988@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526171521.GD17988@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, May 26, 2011 at 10:45:21PM +0530, K.Prasad wrote:

[..]
> Index: linux-2.6.slim_kdump/arch/x86/kernel/cpu/mcheck/mce.c
> ===================================================================
> --- linux-2.6.slim_kdump.orig/arch/x86/kernel/cpu/mcheck/mce.c
> +++ linux-2.6.slim_kdump/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -258,8 +258,7 @@ static void wait_for_panic(void)
>  	local_irq_enable();
>  	while (timeout-- > 0)
>  		udelay(1);
> -	xpanic(PANIC_NO_KEXEC|PANIC_NO_BACKTRACE, 0,
> -		"Panicing machine check CPU died");
> +	xpanic(PANIC_MCE, 0, NULL, 0, "Panicing machine check CPU died");
>  }
>  
>  static void mce_panic(char *msg, struct mce *final, char *exp)
> @@ -315,8 +314,8 @@ static void mce_panic(char *msg, struct
>  	if (exp)
>  		pr_emerg(HW_ERR "Machine check: %s\n", exp);
>  	if (!fake_panic) {
> -		xpanic(PANIC_NO_KEXEC|PANIC_NO_BACKTRACE, mce_panic_timeout,
> -			msg);
> +		xpanic(PANIC_MCE, mce_panic_timeout, final,
> +			sizeof(struct mce), msg);
>  	} else
>  		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
>  }

In previous patches you introduce PANIC_NO_KEXEC and PANIC_NO_BACKTRACE. 
Now in this patch you got rid of those. Are there any other users left
of PANIC_NO_BACKTRACE and PANIC_NO_EXEC? If not, then why to introduce
these to begin with.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
