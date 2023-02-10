Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EFAC636D4
	for <kexec@archiver.kernel.org>; Fri, 10 Feb 2023 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mJebU5Bs0x0D//0bIdCDIgIHczBWzEeXDfZJoRRjmdI=; b=aEexCk0f8k13j6
	DGN8JVVS52NAOMmmdcaNMxfeSxqPUWPmptRpo5o7siNLQLiuKKOQoBYtp/kYmciZxZURah+yFw9Gx
	+dfZA5hr63IDdKv7WLt+zVdnoY+O/8b4pqZYH0eJQDM+Ii+XewCB7G6WioYWwsTPakYjYKY8V3c+y
	5LUYdHGPZ+0HN2QvDJ5jxBMliU+qQXGlTILXIOlLW7GpaWNltRwmL0h0BLORl09z+HaerPsEhEHj/
	tF3tTuoekdJBSF3dew2fq+BzrdTGPIHdblYzFmWqbOKG572iusFzQcQO7GADHIcqIYnr0NV+aF1uA
	/DIk9kF6pNIOZqZ4B+Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQaVf-007X2T-2v; Fri, 10 Feb 2023 21:00:43 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQa7Y-007Qav-QK
	for kexec@lists.infradead.org; Fri, 10 Feb 2023 20:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d6OFz+pkMmvKeLrRrxwfrFR4lZ2gbax6K6PnOag8/Y0=; b=gNwpBt6ixo/c6ORlp0sXEGfu/0
	Bn9Z+herGukEmnsxWrrkPL0bFJyYXL8RQMUk5Tm+HmtDlhYFfTytu5uyjaMy7gVpnRS7eNIQyTxEE
	mfUC7LbVWlsXeGXo8VAfAGMjT57i5mqA5HcH2Hjbmiz1aLwziY1VJ4Nq6fmvfFjiAOqSLxqUJEh+A
	d8AJySAdfS24xKSjXAUdnqhz7mXxTZPfKVxIZtsHnFN3Xc4lL2EsgO9AeAkcub+mVxPtITapFjlbj
	BhE89vGQM4i0B+akm5FM5B4am4sfUqGLbBsCugSmfc2oCLNiilAXZnIrRUkA6HVjYuR9/Pzq+Mvf7
	mSfHLYZw==;
Received: from [187.10.60.16] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1pQa7D-00FNVd-9Q; Fri, 10 Feb 2023 21:35:27 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com
Subject: [PATCH v4] panic: Fixes the panic_print NMI backtrace setting
Date: Fri, 10 Feb 2023 17:35:10 -0300
Message-Id: <20230210203510.1734835-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_123548_890955_23D7F227 
X-CRM114-Status: GOOD (  21.65  )
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
Cc: feng.tang@intel.com, keescook@chromium.org, kernel@gpiccoli.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, mikelley@microsoft.com, d.hatayama@jp.fujitsu.com, kernel-dev@igalia.com, hidehiro.kawai.ez@hitachi.com, dyoung@redhat.com, vgoyal@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Commit 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
introduced a setting for the "panic_print" kernel parameter to allow
users to request a NMI backtrace on panic. Problem is that the panic_print
handling happens after the secondary CPUs are already disabled, hence
this option ended-up being kind of a no-op - kernel skips the NMI trace
in idling CPUs, which is the case of offline CPUs.

Fix it by checking the NMI backtrace bit in the panic_print prior to
the CPU disabling function.

Fixes: 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
Cc: stable@vger.kernel.org
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V4:
- Sent as standalone patch, rebased against v6.2-rc7.

V2 / V3:
- New patch, there was no V1 of this one.
Link for V3: https://lore.kernel.org/lkml/20220819221731.480795-12-gpiccoli@igalia.com/


Hi folks, thanks in advance for reviews/comments.

Notice that while at it, I got rid of the "crash_kexec_post_notifiers"
local copy in panic(). This was introduced by commit b26e27ddfd2a
("kexec: use core_param for crash_kexec_post_notifiers boot option"),
but it is not clear from comments or commit message why this local copy
is required.

My understanding is that it's a mechanism to prevent some concurrency,
in case some other CPU modify this variable while panic() is running.
I find it very unlikely, hence I removed it - but if people consider
this copy needed, I can respin this patch and keep it, even providing a
comment about that, in order to be explict about its need.

Let me know your thoughts!
Cheers,

Guilherme


 kernel/panic.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 463c9295bc28..f45ee88be8a2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -211,9 +211,6 @@ static void panic_print_sys_info(bool console_flush)
 		return;
 	}
 
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
-		trigger_all_cpu_backtrace();
-
 	if (panic_print & PANIC_PRINT_TASK_INFO)
 		show_state();
 
@@ -243,6 +240,30 @@ void check_panic_on_warn(const char *origin)
 		      origin, limit);
 }
 
+/*
+ * Helper that triggers the NMI backtrace (if set in panic_print)
+ * and then performs the secondary CPUs shutdown - we cannot have
+ * the NMI backtrace after the CPUs are off!
+ */
+static void panic_other_cpus_shutdown(void)
+{
+	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+		trigger_all_cpu_backtrace();
+
+	/*
+	 * Note that smp_send_stop() is the usual SMP shutdown function,
+	 * which unfortunately may not be hardened to work in a panic
+	 * situation. If we want to do crash dump after notifier calls
+	 * and kmsg_dump, we will need architecture dependent extra
+	 * bits in addition to stopping other CPUs, hence we rely on
+	 * crash_smp_send_stop() for that.
+	 */
+	if (!crash_kexec_post_notifiers)
+		smp_send_stop();
+	else
+		crash_smp_send_stop();
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -258,7 +279,6 @@ void panic(const char *fmt, ...)
 	long i, i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
-	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
 	if (panic_on_warn) {
 		/*
@@ -333,23 +353,10 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (!_crash_kexec_post_notifiers) {
+	if (!crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-		/*
-		 * Note smp_send_stop is the usual smp shutdown function, which
-		 * unfortunately means it may not be hardened to work in a
-		 * panic situation.
-		 */
-		smp_send_stop();
-	} else {
-		/*
-		 * If we want to do crash dump after notifier calls and
-		 * kmsg_dump, we will need architecture dependent extra
-		 * works in addition to stopping other CPUs.
-		 */
-		crash_smp_send_stop();
-	}
+	panic_other_cpus_shutdown();
 
 	/*
 	 * Run any panic handlers, including those that might need to
@@ -370,7 +377,7 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (_crash_kexec_post_notifiers)
+	if (crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
 	console_unblank();
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
