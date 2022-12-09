Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFA4C4332F
	for <kexec@archiver.kernel.org>; Mon, 12 Dec 2022 12:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2QzQktT5UE0rFq+luc7QlMFQXLUACFqzc0rqYNxIlq8=; b=ieipF4DqSSdA2+
	FsQBGMmErYuQSxk1MPXQIqSCXnmX3N4UwHxZZWddQydklwI+GG8/6BNcNoBuOzJ73remhB7Jy+2Fo
	Vdzt6g42Ljfpm0NWrEUn+6VCEKBJCQp+A+XYDo/ZMXyMaDFRXy0RT1oaTW6Hg7bMdFRgEmhk6THek
	BwYRXd7iLVHkENnmqWJ77J/dIz7GGqL1FP4XX8z3un4zrAeuzUFl9QgC04d5hWufJidctP+H1GNVE
	Xsyi5uw66bhj67onGbdRewuyZ4IgqrzLIxxlBU7/UcIlPjX53hK5wroggFxOmUrrNVZeEwhxpsVsY
	ikKXyFITJjV5jNvWxKVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4htQ-00FZ9f-M0; Mon, 12 Dec 2022 12:26:48 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3fr3-009FxU-T9
	for kexec@lists.infradead.org; Fri, 09 Dec 2022 16:04:07 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 98D88337F5;
	Fri,  9 Dec 2022 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1670601838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACEb0peWm3spbIZkD6VxQeoNEBO3y0M6patrqqDV3Po=;
	b=tBtgeiW1eSS/J9B9gcfYy+/v8vbO8NRaNKUU1zejqaPXv97ZTJaZK4xuAdsEOS1Lr0tAav
	MSU8lMLDtNfRMUEoyp2Q47/FEwAYog1suVu8MBd1UU1/bwohc/fdQjbZFWyi9mGBkjtv8Y
	64ox5KSY/AS4NHDKZD/D2fgykCfzTpA=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id CF9042C142;
	Fri,  9 Dec 2022 16:03:56 +0000 (UTC)
Date: Fri, 9 Dec 2022 17:03:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
	kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
	dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
	mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com,
	jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org,
	luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com,
	paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, stern@rowland.harvard.edu,
	tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com,
	will@kernel.org, xuqiang36@huawei.com, linux-edac@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH V3 08/11] EDAC/altera: Skip the panic notifier if kdump
 is loaded
Message-ID: <Y5Ncaur0S4rEbath@alley>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-9-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220819221731.480795-9-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221209_080406_130560_D4EFB74C 
X-CRM114-Status: GOOD (  30.76  )
X-Mailman-Approved-At: Mon, 12 Dec 2022 04:26:45 -0800
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

On Fri 2022-08-19 19:17:28, Guilherme G. Piccoli wrote:
> The altera_edac panic notifier performs some data collection with
> regards errors detected; such code relies in the regmap layer to
> perform reads/writes, so the code is abstracted and there is some
> risk level to execute that, since the panic path runs in atomic
> context, with interrupts/preemption and secondary CPUs disabled.
> 
> Users want the information collected in this panic notifier though,
> so in order to balance the risk/benefit, let's skip the altera panic
> notifier if kdump is loaded. While at it, remove a useless header
> and encompass a macro inside the sole ifdef block it is used.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - added the ack tag from Dinh - thanks!
> - had a good discussion with Boris about that in V2 [0],
> hopefully we can continue and reach a consensus in this V3.
> [0] https://lore.kernel.org/lkml/46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com/
> 
> V2:
> - new patch, based on the discussion in [1].
> [1] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/
> 
> 
>  drivers/edac/altera_edac.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index e7e8e624a436..741fe5539154 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -16,7 +16,6 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/altera-sysmgr.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/notifier.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> @@ -24,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/types.h>
> +#include <linux/kexec.h>
>  #include <linux/uaccess.h>
>  
>  #include "altera_edac.h"
> @@ -2063,22 +2063,30 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
>  };
>  
>  /************** Stratix 10 EDAC Double Bit Error Handler ************/
> -#define to_a10edac(p, m) container_of(p, struct altr_arria10_edac, m)
> -
>  #ifdef CONFIG_64BIT
>  /* panic routine issues reboot on non-zero panic_timeout */
>  extern int panic_timeout;
>  
> +#define to_a10edac(p, m) container_of(p, struct altr_arria10_edac, m)
> +
>  /*
>   * The double bit error is handled through SError which is fatal. This is
>   * called as a panic notifier to printout ECC error info as part of the panic.
> + *
> + * Notice that if kdump is set, we take the risk avoidance approach and
> + * skip the notifier, given that users are expected to have access to a
> + * full vmcore.
>   */
>  static int s10_edac_dberr_handler(struct notifier_block *this,
>  				  unsigned long event, void *ptr)
>  {
> -	struct altr_arria10_edac *edac = to_a10edac(this, panic_notifier);
> +	struct altr_arria10_edac *edac;
>  	int err_addr, dberror;
>  
> +	if (kexec_crash_loaded())
> +		return NOTIFY_DONE;

I have read the discussion about v2 [1] and this looks like a bad
approach from my POV.

My understanding is that the information provided by this notifier
could not be found in the crashdump. It means that people really
want to run this before crashdump in principle.

Of course, there is the question how much safe this code is. I mean
if the panic() code path might get blocked here.

I see two possibilities.

The best solution would be if we know that this is "always" safe or if
it can be done a safe way. Then we could keep it as it is or implement
the safe way.

Alternative solution would be to create a kernel parameter that
would enable/disable this particular report when kdump is enabled.
The question would be the default. It would depend on how risky
the code is and how useful the information is.

[1] https://lore.kernel.org/r/20220719195325.402745-11-gpiccoli@igalia.com

> +	edac = to_a10edac(this, panic_notifier);
>  	regmap_read(edac->ecc_mgr_map, S10_SYSMGR_ECC_INTSTAT_DERR_OFST,
>  		    &dberror);
>  	regmap_write(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST, dberror);

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
