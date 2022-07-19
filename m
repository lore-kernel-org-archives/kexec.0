Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E7C43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5RYstS7LB1amotlw63eiSlgFvwsy9nYA9iph7JXXJlY=; b=l+LAj5YM16VlWA
	p1UUkW4BHNhbBQgGGuUNhRGnMDv5J5EpGrc4nms7I42MVhm0TJRX4hg022+dWDfLfuQF/VXavpO+n
	v2tjpbUw2RXlYqrQuefboycgk6RxT+MHAWcRTWkTcaFcaBS/Wd3d/vU30jiJ7xFuo0PieDBVRdW77
	x0WDUtDgtnU5tIkEOw9s19USfRABwO39gqcKOlbMOBFxl448dmYG+I9S7L10JTy/YnqhHboaPSKmj
	fimOyseoy/PnxzktL0lFLAMDppKEQyCP4pJt9vRN7BNX/Mfsvpav3HwTjKjUqyttzAs7znASIZMjE
	bIb4KAxGtdoI8YNZdVeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nk-000shV-Op; Wed, 20 Jul 2022 06:03:16 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtMJ-00CDWi-Mi
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 19:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WoDhjsWh6AEBPcpDgb9UnX2r2PUFNxOqgzwoPHKQOTE=; b=JqxeulwSMdmgxDuBt1v3zEAY45
	WqdXE6/pAG8EWcZuFCACdF7sX/7jDrBbu0PmgEYeaRFlNpW+qd1LWjeJ4piZIirK/RsFHHj/cnlcH
	GgnI4NGs02BZbdPfGzZTpCDtPDkHpkTRMaLn71GVyJaX7q3wR72VP8Rz+G1NJYUTZEF95s45npK8c
	qFVyt3sAFMbNsG+UOjiILy/FU9v9PLG6I/M8RPXoGfARmMgRG9GdO4let4KHUk1ZzNQVufT9CXM7r
	e0KUZR2/6bx3NVLPFS6mcdanQ0mGb75v8l9T67h+xoBRj+xVVtzNRn+g+tG6KGK5Aw2aHmWl8++AC
	zCZy942Q==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtME-006fhg-H8; Tue, 19 Jul 2022 21:58:15 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 13/13] panic: Fixes the panic_print NMI backtrace setting
Date: Tue, 19 Jul 2022 16:53:26 -0300
Message-Id: <20220719195325.402745-14-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719195325.402745-1-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125819_776692_05239100 
X-CRM114-Status: GOOD (  22.69  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
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
Cc: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---


V2:
- new patch, there was no V1 of this one.


Hi folks, thanks upfront for reviews. This is a new patch, fixing an issue
I found in my tests, so I shoved it into this fixes series.

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

Let me know your thoughts! Cheers,

Guilherme


 kernel/panic.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index a3308af28a21..7fb604e95ef9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -180,9 +180,6 @@ static void panic_print_sys_info(bool console_flush)
 		return;
 	}
 
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
-		trigger_all_cpu_backtrace();
-
 	if (panic_print & PANIC_PRINT_TASK_INFO)
 		show_state();
 
@@ -199,6 +196,30 @@ static void panic_print_sys_info(bool console_flush)
 		ftrace_dump(DUMP_ALL);
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
@@ -214,7 +235,6 @@ void panic(const char *fmt, ...)
 	long i, i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
-	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
 	if (panic_on_warn) {
 		/*
@@ -289,23 +309,10 @@ void panic(const char *fmt, ...)
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
@@ -326,7 +333,7 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (_crash_kexec_post_notifiers)
+	if (crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
 #ifdef CONFIG_VT
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
