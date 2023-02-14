Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66798C61DA4
	for <kexec@archiver.kernel.org>; Tue, 14 Feb 2023 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BtrY8k4qjxA3K7tWqxG9khGkLK5/bb5tg3a4uxDRA1w=; b=zIZRSy1xjgIBGr
	wCDFHUv4wah1QoH8vTC9hxUqSlE7cVrY28E+2UaecfhIbPSeDqRXSk47IzQa2bK65ppUQ6jA8TNjm
	b7qLsPuf5t+ccvr1pEH2cKetgiqyLVCQEqLVL+zDX8hAdXjHDLC3z6UbpVkX1+MZGgw0Khcunbp7y
	1fcWNLiG0i18nyjgsWnmV14oj3Ey3KYdkKP7gW/QJcGz3uq2fNbCffIhfWu6ENkVRSAWcXz7K39hb
	hxuRNWFvJSjEO2/xH64XSmiH0Rn7SX6a5JhAn+jy/ytozAZQMsyPleS7VDBo5BNJW7g2RrUUWNj5r
	TeKVAofr3X+4/+7XExfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRwsT-002Ohn-EM; Tue, 14 Feb 2023 15:05:53 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRwaF-002HVA-45
	for kexec@lists.infradead.org; Tue, 14 Feb 2023 14:47:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id D9AFF22307;
	Tue, 14 Feb 2023 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1676386020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EK9CiP6A9TI1KmO+gBKuo7Y6VjfBhIiJDZ2Z+Ukkaws=;
	b=NrIWWvTt0AsCqPqzqyXPhbWtDHVu3yg7/B7gRjZo4/ZIqJcTmIk0ZmY7igSVXpVblGLw2K
	Krs05g+nLykoGD41GvOwYwaBr/Xm34illEaLt7DrkQNk2v2Mp6TA9HgcWB4EKsSShXuTph
	bwHDb1ySHIcOn6zUtOGTTTC2nEybqdE=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 36FFF2C141;
	Tue, 14 Feb 2023 14:47:00 +0000 (UTC)
Date: Tue, 14 Feb 2023 15:46:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, dyoung@redhat.com,
	d.hatayama@jp.fujitsu.com, feng.tang@intel.com,
	hidehiro.kawai.ez@hitachi.com, keescook@chromium.org,
	mikelley@microsoft.com, vgoyal@redhat.com, kernel-dev@igalia.com,
	kernel@gpiccoli.net, stable@vger.kernel.org
Subject: Re: [PATCH v4] panic: Fixes the panic_print NMI backtrace setting
Message-ID: <Y+ue4OsyrGSx5ujB@alley>
References: <20230210203510.1734835-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230210203510.1734835-1-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_064703_363698_9A7C5919 
X-CRM114-Status: GOOD (  29.53  )
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

On Fri 2023-02-10 17:35:10, Guilherme G. Piccoli wrote:
> Commit 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
> introduced a setting for the "panic_print" kernel parameter to allow
> users to request a NMI backtrace on panic. Problem is that the panic_print
> handling happens after the secondary CPUs are already disabled, hence
> this option ended-up being kind of a no-op - kernel skips the NMI trace
> in idling CPUs, which is the case of offline CPUs.

Great catch!

> Hi folks, thanks in advance for reviews/comments.
> 
> Notice that while at it, I got rid of the "crash_kexec_post_notifiers"
> local copy in panic(). This was introduced by commit b26e27ddfd2a
> ("kexec: use core_param for crash_kexec_post_notifiers boot option"),
> but it is not clear from comments or commit message why this local copy
> is required.
> 
> My understanding is that it's a mechanism to prevent some concurrency,
> in case some other CPU modify this variable while panic() is running.
> I find it very unlikely, hence I removed it - but if people consider
> this copy needed, I can respin this patch and keep it, even providing a
> comment about that, in order to be explict about its need.

Yes, I think that it makes the behavior consistent even when the
global variable manipulated in parallel.

I would personally prefer to keep the local copy. Better safe
than sorry.

> Let me know your thoughts!
> Cheers,
> 
> Guilherme
> 
> 
>  kernel/panic.c | 47 +++++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 463c9295bc28..f45ee88be8a2 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -211,9 +211,6 @@ static void panic_print_sys_info(bool console_flush)
>  		return;
>  	}
>  
> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> -		trigger_all_cpu_backtrace();
> -

Sigh, this is yet another PANIC_PRINT_ action that need special
timing. We should handle both the same way.

What about the following? The parameter @mask says what
actions are allowed at the given time.

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -72,6 +72,9 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
 #define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
 #define PANIC_PRINT_ALL_CPU_BT		0x00000040
+/* Filter out actions that need special timing. */
+#define PANIC_PRINT_COMMON_INFO_MASK	~(PANIC_PRINT_ALL_PRINTK_MSG |	 \
+					  PANIC_PRINT_ALL_CPU_BT)
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -203,30 +206,29 @@ void nmi_panic(struct pt_regs *regs, const char *msg)
 }
 EXPORT_SYMBOL(nmi_panic);
 
-static void panic_print_sys_info(bool console_flush)
+static void panic_print_sys_info(unsigned long mask)
 {
-	if (console_flush) {
-		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
-			console_flush_on_panic(CONSOLE_REPLAY_ALL);
-		return;
-	}
+	unsigned long panic_print_now = panic_print & mask;
+
+	if (panic_print_now & PANIC_PRINT_ALL_PRINTK_MSG)
+		console_flush_on_panic(CONSOLE_REPLAY_ALL);
 
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+	if (panic_print_now & PANIC_PRINT_ALL_CPU_BT)
 		trigger_all_cpu_backtrace();
 
-	if (panic_print & PANIC_PRINT_TASK_INFO)
+	if (panic_print_now & PANIC_PRINT_TASK_INFO)
 		show_state();
 
-	if (panic_print & PANIC_PRINT_MEM_INFO)
+	if (panic_print_now & PANIC_PRINT_MEM_INFO)
 		show_mem(0, NULL);
 
-	if (panic_print & PANIC_PRINT_TIMER_INFO)
+	if (panic_print_now & PANIC_PRINT_TIMER_INFO)
 		sysrq_timer_list_show();
 
-	if (panic_print & PANIC_PRINT_LOCK_INFO)
+	if (panic_print_now & PANIC_PRINT_LOCK_INFO)
 		debug_show_all_locks();
 
-	if (panic_print & PANIC_PRINT_FTRACE_INFO)
+	if (panic_print_now & PANIC_PRINT_FTRACE_INFO)
 		ftrace_dump(DUMP_ALL);
 }
 
@@ -333,9 +335,12 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (!_crash_kexec_post_notifiers) {
+	if (!_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
+	panic_print_sys_info(PANIC_PRINT_ALL_CPU_BT);
+
+	if (!_crash_kexec_post_notifiers) {
 		/*
 		 * Note smp_send_stop is the usual smp shutdown function, which
 		 * unfortunately means it may not be hardened to work in a
@@ -357,7 +362,7 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	panic_print_sys_info(false);
+	panic_print_sys_info(PANIC_PRINT_COMMON_INFO_MASK);
 
 	kmsg_dump(KMSG_DUMP_PANIC);
 
@@ -386,7 +391,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info(true);
+	panic_print_sys_info(PANIC_PRINT_ALL_PRINTK_MSG);
 
 	if (!panic_blink)
 		panic_blink = no_blink;


Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
