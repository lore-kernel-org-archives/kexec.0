Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B37C71136
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ToUwqQz3UL7tOfGhP1to15m5/LHNnBP7uU1ip6Qp53c=; b=3CuXo45qrfcPEsOzOVMPggNEmb
	wJDD9tHn2zztt0r3V9pMvc0BWe18o48Hu7wJiInwJHTf+TCEEewsxnJwtJu/0qxznIkFUtK/zY0tH
	G5WS+PnbJmMEggG7EAdf6tcCQ3ZX7lEjRFuFCRyckJDau2eOJFAul/1crCwmR+PwNvjrxf38QiZKN
	SQPSF8BLumfq5FsAmnZ2aOV9VevaswpfqZ4eTegxZPXQZ4xAh9cAxvuZve7OnZ7RGdB52YwaRIvoz
	oeT6U/FqxHnvoSZ2sSUuuz7+60vAlQtos8lbFOiR8ZRNUZHRVlHkLOIzbRsGLiVD+bJ0VP0OIPyM7
	0RvMpK4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQCCH-000000008wK-38O0;
	Fri, 13 Jun 2025 21:44:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQCCF-000000008vn-0DEJ
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 21:44:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7C5DA5C56F8;
	Fri, 13 Jun 2025 21:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA943C4CEE3;
	Fri, 13 Jun 2025 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749851061;
	bh=GJfPbPeu9q+2/ctADOJkntAal4bqSrgg30/06dFHPVs=;
	h=From:To:Cc:Subject:Date:From;
	b=c1Pb5svEJPW7BnMQIy4dzAlbioiM0wMC/G4nwO9W9mNyKXb2rT9TjkekI6YIaGTW0
	 xnEbRTHR/WOtDFM4lDyHaltqg4Te/uz7fCSz+Z5h2/vWGqzpUizBOLJoLOgy80pfcu
	 JANhKPQ+BU740VbNPauEHmGg5Prq7wenNqJgQLT8JICChYNHkR4TRuUmLp+nO8pfc9
	 JMGsSo+Zc6A9s5vPlQ34Mb07KL72uUAFFQAzmkGKNQIAzvkYJmL9FUUW+gff79y2UB
	 3cOBMjxtsB0d6LfvGMIhOEBs9ZucL2m/4hO1YJQYASiIutIrDVi/VLen6IfWDprq8S
	 hXTtGoc5Z70Cg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	bhe@redhat.com
Cc: christian.koenig@amd.com,
	linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH] PM: Restrict swap use to later in the suspend sequence
Date: Fri, 13 Jun 2025 16:43:44 -0500
Message-ID: <20250613214413.4127087-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_144423_170964_62B9A952 
X-CRM114-Status: GOOD (  15.58  )
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

From: Mario Limonciello <mario.limonciello@amd.com>

Currently swap is restricted before drivers have had a chance to do their
prepare() PM callbacks. Restricting swap this early means that if a driver
needs to evict some content from memory into sawp in it's prepare callback
it won't be able to.

On AMD dGPUs this can lead to failed suspends under memory pressure
situations as all VRAM must be evicted to system memory or swap.

Move the swap restriction to right after all devices have had a chance to
do the prepare() callback.  If there is any problem with the sequence,
restore swap in the appropriate dpm resume callbacks or error handling
paths.

Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/base/power/main.c | 5 ++++-
 include/linux/suspend.h   | 5 +++++
 kernel/kexec_core.c       | 1 +
 kernel/power/hibernate.c  | 3 ---
 kernel/power/power.h      | 5 -----
 kernel/power/suspend.c    | 3 +--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0215b20c5e2c8..4970a804afb6d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1241,6 +1241,7 @@ void dpm_complete(pm_message_t state)
  */
 void dpm_resume_end(pm_message_t state)
 {
+	pm_restore_gfp_mask();
 	dpm_resume(state);
 	dpm_complete(state);
 }
@@ -2183,8 +2184,10 @@ int dpm_suspend_start(pm_message_t state)
 	error = dpm_prepare(state);
 	if (error)
 		dpm_save_failed_step(SUSPEND_PREPARE);
-	else
+	else {
+		pm_restrict_gfp_mask();
 		error = dpm_suspend(state);
+	}
 
 	dpm_show_time(starttime, state, error, "start");
 	return error;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b1c76c8f2c822..6a3f920988720 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -446,6 +446,8 @@ extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
 extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
+void pm_restrict_gfp_mask(void);
+void pm_restore_gfp_mask(void);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -492,6 +494,9 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 static inline void pm_report_hw_sleep_time(u64 t) {};
 static inline void pm_report_max_hw_sleep(u64 t) {};
 
+static inline void pm_restrict_gfp_mask(void) {}
+static inline void pm_restore_gfp_mask(void) {}
+
 static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9c59fa480b0b6..3a9a9f240dbc9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1136,6 +1136,7 @@ int kernel_kexec(void)
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
+		pm_restore_gfp_mask();
 		console_resume_all();
 		thaw_processes();
  Restore_console:
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 519fb09de5e0c..9216e3b91d3b3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -423,7 +423,6 @@ int hibernation_snapshot(int platform_mode)
 	}
 
 	console_suspend_all();
-	pm_restrict_gfp_mask();
 
 	error = dpm_suspend(PMSG_FREEZE);
 
@@ -559,7 +558,6 @@ int hibernation_restore(int platform_mode)
 
 	pm_prepare_console();
 	console_suspend_all();
-	pm_restrict_gfp_mask();
 	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
 		error = resume_target_kernel(platform_mode);
@@ -571,7 +569,6 @@ int hibernation_restore(int platform_mode)
 		BUG_ON(!error);
 	}
 	dpm_resume_end(PMSG_RECOVER);
-	pm_restore_gfp_mask();
 	console_resume_all();
 	pm_restore_console();
 	return error;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index cb1d715620020..7ccd709af93f5 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -239,11 +239,6 @@ static inline void suspend_test_finish(const char *label) {}
 /* kernel/power/main.c */
 extern int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down);
 extern int pm_notifier_call_chain(unsigned long val);
-void pm_restrict_gfp_mask(void);
-void pm_restore_gfp_mask(void);
-#else
-static inline void pm_restrict_gfp_mask(void) {}
-static inline void pm_restore_gfp_mask(void) {}
 #endif
 
 #ifdef CONFIG_HIGHMEM
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 76b141b9aac01..bb608b68fb301 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -540,6 +540,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	return error;
 
  Recover_platform:
+	pm_restore_gfp_mask();
 	platform_recover(state);
 	goto Resume_devices;
 }
@@ -606,9 +607,7 @@ static int enter_state(suspend_state_t state)
 
 	trace_suspend_resume(TPS("suspend_enter"), state, false);
 	pm_pr_dbg("Suspending system (%s)\n", mem_sleep_labels[state]);
-	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
-	pm_restore_gfp_mask();
 
  Finish:
 	events_check_enabled = false;
-- 
2.43.0


