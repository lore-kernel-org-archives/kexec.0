Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E60C64ED6
	for <kexec@archiver.kernel.org>; Sun, 26 Feb 2023 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MuE+jsDIdHhHWYCij1xMqTb5ih9DqrBeQAcZsitgZVU=; b=rxhzi0bd/40IiD
	1Tqg4zvr9efXs1qYynfJjEy55GQNAWOTYVUUDbMBgdZPgICeMYZpBRY3Lw2KgLeOd654yGN4+eU4m
	QhX9FQ9TcPecq8oMJbvO3kUyMmvyM+9j/kT3wn6/Tmp/uYZAE+9GHxKWamriivqLPGaLWp++6uSqS
	qElPeOQwDr1VQKKEOLLsTa/izF/p3kb7LDuN7noA/Pja6MXfAr8DWSAkn3SdAuumOEoErkFyQ3g4y
	/suQfmNc7ON9A9b5k82hizh+X7xwfaLYbiG42wlwidlnXkxpPVD8F+d2Mih3YG2P0vqfxxcEyJZRb
	WH4V6m6YVgohL/5axhwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWJal-007YB1-EJ; Sun, 26 Feb 2023 16:09:39 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWJaf-007Y9f-RZ
	for kexec@lists.infradead.org; Sun, 26 Feb 2023 16:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=J9cSEBaREI6poXfJEyM7t/caJaahD9F9/WQ3FfRuqPk=; b=U9URBDJeaaZWcFcuoSlxLwLjlm
	JSJms62xEFsoiBRLjtJjX1jkYCD1tNLMBVy2xYt4uSr/MvV9xYXJ1eXSOFxtWPpzmQ2oXkr5N95MK
	qSr6V2ibjhc691pBmB3YRUEhr0trN4WEiYT5Y8rwgigtCXTdOqi3rdtuPVBaP72G8vE1Cwx0CqPDl
	jg42HnVBVlQ06ap1tzVjaxs7kWxoTS4FEjt5Zq5kfGyloTnWZugyWtjyFiiSGC78iEWwG5Fn2PwPB
	vFFe96h9n4F5e1Zm/Xn8/qAE1Pnf1qUKX/wnbSLNFb9FcQ7u1gGeJ4bConKT7zKbSfok1NiKJu1Ak
	lnd2QZnw==;
Received: from [152.254.196.162] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1pWJa8-00FwZV-A3; Sun, 26 Feb 2023 17:09:01 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com
Subject: [PATCH v5] panic: Fixes the panic_print NMI backtrace setting
Date: Sun, 26 Feb 2023 13:08:38 -0300
Message-Id: <20230226160838.414257-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_080933_916285_8C0042F4 
X-CRM114-Status: GOOD (  17.97  )
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

V5:
- Kept the local version of "crash_kexec_post_notifiers", since
this is standalone fix that should be backported to stable. Hence,
it's not a good idea to mess with it in this patch (thanks Andrew!).

V4:
- Sent as standalone patch, rebased against v6.2-rc7.
- Link: https://lore.kernel.org/lkml/20230210203510.1734835-1-gpiccoli@igalia.com/


 kernel/panic.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 463c9295bc28..e026191a0a07 100644
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
+static void panic_other_cpus_shutdown(bool crash_kexec)
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
+	if (!crash_kexec)
+		smp_send_stop();
+	else
+		crash_smp_send_stop();
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -333,23 +354,10 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (!_crash_kexec_post_notifiers) {
+	if (!_crash_kexec_post_notifiers)
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
+	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
 
 	/*
 	 * Run any panic handlers, including those that might need to
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
