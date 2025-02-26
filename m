Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F33C021B8
	for <kexec@archiver.kernel.org>; Wed, 26 Feb 2025 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u40wel1uByZ+NuxZjQ9Eq88cyevFevGwKfBlTGuYmDo=; b=dw3KvN8861jKlWqYzIkbcEAzxC
	1VvrX2E6a75FEqvakcIasFzxEy/EzXHOfzpSBF9gCsbFXgpNid9pPdKLKuGnyttF2ZEygE4h/xlAo
	hX5l6N8euHv0GWYyyWMOGoFKiYhp8bDjIPPDdHnnwjAAknPWkTI9USZ1Szfft6jzjRhTGNis4TZHW
	deWUB+gZr+HRKb3CbaJQEdxh+uonBNrOsaWvQkgJXExnaNWiblCQ67tWGEWZKXncLWIEk4xAY8k9d
	A/9OBj3ry5scDUrJ67arfVIAx5Qd6AhsDiwqeGUE1gZiARahiDw3Gd781AQvp2UvDywM8yefrwdxk
	T21awIxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNYx-00000005F5b-4AJW;
	Wed, 26 Feb 2025 19:59:23 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNYv-00000005F2O-3LFT
	for kexec@lists.infradead.org;
	Wed, 26 Feb 2025 19:59:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD89D1F38A;
	Wed, 26 Feb 2025 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u40wel1uByZ+NuxZjQ9Eq88cyevFevGwKfBlTGuYmDo=;
	b=qPwVt1Cc1fHH2nKJ8cMSNKZCYR1By1k9TyvRld0TI3KeJGKI8VldjC1kuB9+MsU+DAQ1QR
	nFgfd/t8ZMzNPLBY1iT2Hs5MQt/Vjs3Qtob6Ng5/OP6IKavzpORqtOE9Eyt9utVe7Rnqny
	o6To2KvLf/QIST3K6K1DqIjN3HD1ZTs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u40wel1uByZ+NuxZjQ9Eq88cyevFevGwKfBlTGuYmDo=;
	b=qPwVt1Cc1fHH2nKJ8cMSNKZCYR1By1k9TyvRld0TI3KeJGKI8VldjC1kuB9+MsU+DAQ1QR
	nFgfd/t8ZMzNPLBY1iT2Hs5MQt/Vjs3Qtob6Ng5/OP6IKavzpORqtOE9Eyt9utVe7Rnqny
	o6To2KvLf/QIST3K6K1DqIjN3HD1ZTs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58CB213A53;
	Wed, 26 Feb 2025 19:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4cFaCJVyv2dPMgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 26 Feb 2025 19:59:17 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 26 Feb 2025 16:59:02 -0300
Subject: [PATCH 2/5] printk: Rename resume_console to console_resume_all
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-printk-renaming-v1-2-0b878577f2e6@suse.com>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
In-Reply-To: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Eric Biederman <ebiederm@xmission.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Todd E Brandt <todd.e.brandt@linux.intel.com>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740599947; l=5062;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=o4dSv2Q4KBStBPNP7ZCwyp3Xj3sypPx1cqkkCUPu63k=;
 b=eMPqNrB0UnFvEc27q5UbM6ptmyIqQUxeZ1y9TkP23XXXhdu3RbT7teaugAudqjEZZDtKG3DdZ
 1fnkdYMObgrBMG2Ucq75IhCtkaDgjnwlPypdFhWKFZWL7yZEQlSelfg
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_115922_002743_EDA2874B 
X-CRM114-Status: GOOD (  11.99  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The function resume_console has a misleading name,  since it resumes all
consoles, so rename it accordly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h                                   | 2 +-
 kernel/kexec_core.c                                       | 2 +-
 kernel/power/hibernate.c                                  | 8 ++++----
 kernel/power/suspend.c                                    | 6 +++---
 kernel/printk/printk.c                                    | 2 +-
 tools/power/pm-graph/config/custom-timeline-functions.cfg | 2 +-
 tools/power/pm-graph/sleepgraph.py                        | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index fa5941f4f9c5..0d48e0deb213 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -649,7 +649,7 @@ extern bool console_suspend_enabled;
 
 /* Suspend and resume console messages over PM events */
 extern void console_suspend_all(void);
-extern void resume_console(void);
+extern void console_resume_all(void);
 
 int mda_console_init(void);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8f95870030a3..6fcc46f3eb39 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1061,7 +1061,7 @@ int kernel_kexec(void)
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
-		resume_console();
+		console_resume_all();
 		thaw_processes();
  Restore_console:
 		pm_restore_console();
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a18f6016ce6c..c9f60670a261 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -437,7 +437,7 @@ int hibernation_snapshot(int platform_mode)
 	if (error || !in_suspend)
 		pm_restore_gfp_mask();
 
-	resume_console();
+	console_resume_all();
 	dpm_complete(msg);
 
  Close:
@@ -561,7 +561,7 @@ int hibernation_restore(int platform_mode)
 	}
 	dpm_resume_end(PMSG_RECOVER);
 	pm_restore_gfp_mask();
-	resume_console();
+	console_resume_all();
 	pm_restore_console();
 	return error;
 }
@@ -634,7 +634,7 @@ int hibernation_platform_enter(void)
  Resume_devices:
 	entering_platform_hibernation = false;
 	dpm_resume_end(PMSG_RESTORE);
-	resume_console();
+	console_resume_all();
 
  Close:
 	hibernation_ops->end();
@@ -920,7 +920,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 dpm_resume:
 	dpm_resume(PMSG_THAW);
 
-	resume_console();
+	console_resume_all();
 
 dpm_complete:
 	dpm_complete(PMSG_THAW);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index f296dd0a1a18..c3da3db58cdf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -521,9 +521,9 @@ int suspend_devices_and_enter(suspend_state_t state)
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
-	trace_suspend_resume(TPS("resume_console"), state, true);
-	resume_console();
-	trace_suspend_resume(TPS("resume_console"), state, false);
+	trace_suspend_resume(TPS("console_resume_all"), state, true);
+	console_resume_all();
+	trace_suspend_resume(TPS("console_resume_all"), state, false);
 
  Close:
 	platform_resume_end(state);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6cfb1e6d3613..ef259660563a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2760,7 +2760,7 @@ void console_suspend_all(void)
 	synchronize_srcu(&console_srcu);
 }
 
-void resume_console(void)
+void console_resume_all(void)
 {
 	struct console_flush_type ft;
 	struct console *con;
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
index 80ba55250163..0321b59518f3 100644
--- a/tools/power/pm-graph/config/custom-timeline-functions.cfg
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -128,7 +128,7 @@ syscore_suspend:
 arch_enable_nonboot_cpus_end:
 syscore_resume:
 acpi_pm_finish:
-resume_console:
+console_resume_all:
 acpi_pm_end:
 pm_restore_gfp_mask:
 thaw_processes:
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 114c3d0c6619..e2261f33a082 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -216,7 +216,7 @@ class SystemValues:
 		'arch_enable_nonboot_cpus_end': {},
 		'syscore_resume': {},
 		'acpi_pm_finish': {},
-		'resume_console': {},
+		'console_resume_all': {},
 		'acpi_pm_end': {},
 		'pm_restore_gfp_mask': {},
 		'thaw_processes': {},
@@ -3459,7 +3459,7 @@ def parseTraceLog(live=False):
 	tracewatch = ['irq_wakeup']
 	if sysvals.usekprobes:
 		tracewatch += ['sync_filesystems', 'freeze_processes', 'syscore_suspend',
-			'syscore_resume', 'resume_console', 'thaw_processes', 'CPU_ON',
+			'syscore_resume', 'console_resume_all', 'thaw_processes', 'CPU_ON',
 			'CPU_OFF', 'acpi_suspend']
 
 	# extract the callgraph and traceevent data

-- 
2.48.1


