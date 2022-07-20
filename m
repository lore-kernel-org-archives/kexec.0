Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01729C43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wz+yjtblDeXEnT2c08tqew3GghOqk+n/vuoQteysTeg=; b=tR3LicjqmIhbsG
	k4B7dfKERgYIApLsXqRhDib8QqlEa1JVRGfFb6bMkl4Zsd37+BJOevLNPgpyCeukie9WB8YdSDlSn
	Vr85dpO8WivHjYJ070YDClcTQTg5nn7WJtkXwzIlwVmSH+V10PE7bu7z07M+nwNk+tLE4Mq3/Wf6/
	BOJMjOF2XJ6fGlYTxeqPtot9lH/Bqu7ZmpUqzoKL51wuSfMTaKQCwkH7A3f/CeBJ1bus/0nNP5bah
	FcYe8VNhpzvgzK7/40lB66mHjysfiNRwxFbl2SNqa1+jfDKaS9wUi90txHtv0BZ+RDQQd2yae/4hz
	fJvb6wbzuV/heEqD+zBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2oX-000tTA-Jf; Wed, 20 Jul 2022 06:04:05 +0000
Received: from ewsoutbound.kpnmail.nl ([195.121.94.167])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDyk2-00G5ZZ-46
	for kexec@lists.infradead.org; Wed, 20 Jul 2022 01:43:14 +0000
X-KPN-MessageId: 48b152f4-07cd-11ed-92d5-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 48b152f4-07cd-11ed-92d5-005056abbe64;
	Wed, 20 Jul 2022 03:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=rJFJglb4/UlXPUAHi1JzAHBD/M9s09bPsFmPwi9LOVE=;
	b=K+cK7q+3qNmRzBhVqnrb6dcvzHwTNPb0eIHNfYy+/w9+5NhJGbV4DGkcBa1KUI0oE0OnCKtb5VKsW
	 LBKidygns/An+tmmTcJlAhuoay2aJjeeiCNVbTnTJzIAWDDdO8D1ZIK0F2S6YnaJRALGwkDW5hyNiw
	 FVnqretpsqOtryhtSVt95SRQwlK+f4XfUyyZwt9HFoV8bZ0RziblHCGN29eCMfURmr8ud2muyNUPpY
	 zzTh3AZb/rYAvinh6li1lZLbR/g/ewjqq/uMdSHwFDqXM4EHdlWg1OqUy84NWH+GUIfHEXnjlsdDM6
	 3lIuKGlcofXTuBTPowWEM6pmbH5ny1w==
X-KPN-MID: 33|X/FwXldpKQeT69J14RQrO3wWCDlNHTXiDFH+z4/5b410baHBlVm0Lo5m+k0owV3
 TzWwt78voBp9KvHnL1iswi5re4OiCxH/fUHIxGdjKB4U=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kw9TlpbAUpy2EFas4/riRupArFIg6BG1fOWsU6N4exHkaFUlNJ5+lQgOtSkXTgm
 dJHzaYn3cIm9roNAMOgcphw==
X-Originating-IP: 86.86.234.244
Received: from wim.jer (86-86-234-244.fixed.kpn.net [86.86.234.244])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4a3e2c51-07cd-11ed-b8b0-005056ab7447;
	Wed, 20 Jul 2022 03:43:02 +0200 (CEST)
Date: Wed, 20 Jul 2022 03:43:00 +0200
From: Jeroen Roovers <jer@xs4all.nl>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
 vkuznets@redhat.com, will@kernel.org, linux-parisc@vger.kernel.org, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v2 07/13] parisc: Replace regular spinlock with
 spin_trylock on panic path
Message-ID: <20220720034300.6d2905b8@wim.jer>
In-Reply-To: <20220719195325.402745-8-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
	<20220719195325.402745-8-gpiccoli@igalia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_184311_344455_4D997525 
X-CRM114-Status: GOOD (  28.99  )
X-Mailman-Approved-At: Tue, 19 Jul 2022 23:02:40 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

     Hi Guilherme,

On Tue, 19 Jul 2022 16:53:20 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> The panic notifiers' callbacks execute in an atomic context, with
> interrupts/preemption disabled, and all CPUs not running the panic
> function are off, so it's very dangerous to wait on a regular
> spinlock, there's a risk of deadlock.
> 
> Refactor the panic notifier of parisc/power driver to make use
> of spin_trylock - for that, we've added a second version of the
> soft-power function. Also, some comments were reorganized and
> trailing white spaces, useless header inclusion and blank lines
> were removed.
> 
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - Added Helge's ACK - thanks!
> 
>  arch/parisc/include/asm/pdc.h |  1 +
>  arch/parisc/kernel/firmware.c | 27 +++++++++++++++++++++++----
>  drivers/parisc/power.c        | 17 ++++++++++-------
>  3 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/pdc.h
> b/arch/parisc/include/asm/pdc.h index b643092d4b98..7a106008e258
> 100644 --- a/arch/parisc/include/asm/pdc.h
> +++ b/arch/parisc/include/asm/pdc.h
> @@ -83,6 +83,7 @@ int pdc_do_firm_test_reset(unsigned long
> ftc_bitmap); int pdc_do_reset(void);
>  int pdc_soft_power_info(unsigned long *power_reg);
>  int pdc_soft_power_button(int sw_control);
> +int pdc_soft_power_button_panic(int sw_control);
>  void pdc_io_reset(void);
>  void pdc_io_reset_devices(void);
>  int pdc_iodc_getc(void);
> diff --git a/arch/parisc/kernel/firmware.c
> b/arch/parisc/kernel/firmware.c index 6a7e315bcc2e..0e2f70b592f4
> 100644 --- a/arch/parisc/kernel/firmware.c
> +++ b/arch/parisc/kernel/firmware.c
> @@ -1232,15 +1232,18 @@ int __init pdc_soft_power_info(unsigned long
> *power_reg) }
>  
>  /*
> - * pdc_soft_power_button - Control the soft power button behaviour
> - * @sw_control: 0 for hardware control, 1 for software control 
> + * pdc_soft_power_button{_panic} - Control the soft power button
> behaviour
> + * @sw_control: 0 for hardware control, 1 for software control
>   *
>   *
>   * This PDC function places the soft power button under software or
>   * hardware control.
> - * Under software control the OS may control to when to allow to
> shut 
> - * down the system. Under hardware control pressing the power button 
> + * Under software control the OS may control to when to allow to shut
> + * down the system. Under hardware control pressing the power button
>   * powers off the system immediately.
> + *
> + * The _panic version relies in spin_trylock to prevent deadlock
> + * on panic path.

in => on

>   */
>  int pdc_soft_power_button(int sw_control)
>  {
> @@ -1254,6 +1257,22 @@ int pdc_soft_power_button(int sw_control)
>  	return retval;
>  }
>  
> +int pdc_soft_power_button_panic(int sw_control)
> +{
> +	int retval;
> +	unsigned long flags;
> +
> +	if (!spin_trylock_irqsave(&pdc_lock, flags)) {
> +		pr_emerg("Couldn't enable soft power button\n");
> +		return -EBUSY; /* ignored by the panic notifier */
> +	}
> +
> +	retval = mem_pdc_call(PDC_SOFT_POWER, PDC_SOFT_POWER_ENABLE,
> __pa(pdc_result), sw_control);
> +	spin_unlock_irqrestore(&pdc_lock, flags);
> +
> +	return retval;
> +}
> +
>  /*
>   * pdc_io_reset - Hack to avoid overlapping range registers of
> Bridges devices.
>   * Primarily a problem on T600 (which parisc-linux doesn't support)
> but diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
> index 456776bd8ee6..8512884de2cf 100644
> --- a/drivers/parisc/power.c
> +++ b/drivers/parisc/power.c
> @@ -37,7 +37,6 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> -#include <linux/notifier.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/reboot.h>
>  #include <linux/sched/signal.h>
> @@ -175,16 +174,21 @@ static void powerfail_interrupt(int code, void
> *x) 
>  
>  
> -/* parisc_panic_event() is called by the panic handler.
> - * As soon as a panic occurs, our tasklets above will not be
> - * executed any longer. This function then re-enables the 
> - * soft-power switch and allows the user to switch off the system
> +/*
> + * parisc_panic_event() is called by the panic handler.
> + *
> + * As soon as a panic occurs, our tasklets above will not
> + * be executed any longer. This function then re-enables
> + * the soft-power switch and allows the user to switch off
> + * the system. We rely in pdc_soft_power_button_panic()
> + * since this version spin_trylocks (instead of regular
> + * spinlock), preventing deadlocks on panic path.
>   */
>  static int parisc_panic_event(struct notifier_block *this,
>  		unsigned long event, void *ptr)
>  {
>  	/* re-enable the soft-power switch */
> -	pdc_soft_power_button(0);
> +	pdc_soft_power_button_panic(0);
>  	return NOTIFY_DONE;
>  }
>  
> @@ -193,7 +197,6 @@ static struct notifier_block parisc_panic_block =
> { .priority	= INT_MAX,
>  };
>  
> -
>  static int __init power_init(void)
>  {
>  	unsigned long ret;


Kind regards,
     jer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
