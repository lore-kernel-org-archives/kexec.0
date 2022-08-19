Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71B6C32796
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hb0feO3zDaO0dkoV2p/9rCdY9D9CtzrYJ3ZyMSOVWH8=; b=IYOT3wdJjtS/Yr
	LvSOMO628ihWI8wVgK3ceYHAy30l3aP8r4yvbOIDa6t4byWLrVJGbGuKvJwvTgMA8NDOihpSHunog
	gcoXoIVX110hDpDCuDRG6+IlLJNOhCUiSBpioyXiNWc0vSjJAk/n7XWMAVqjLltXPqJJGOYvYpGp2
	LDS19MFGQgQL+3tsJFWwHOIklSPJC0F5HQrqFlxXmvtCv9Nankr9dqhWf1oqW7Hv/Fc5FeTgEPEYh
	pzNxVAoWw51yavJVhu0b/8WHsZCNbOm1aMB7CVnD+sYm/PI3rfWHNBflIt0v4xX+WhhD6J9vEPbo+
	cFO/l4+/adVXcCQsQuwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq5X-00D68w-IJ; Wed, 24 Aug 2022 13:06:31 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPARt-00CrdJ-LE
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 22:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JM9Drna9qCkuXYcgitMbKoCXFed7NeXSxXsah2tjvgg=; b=p6K24F8rtU3d2Ldfz0e5oJ9YuZ
	+KS6jNUq85CuFdFWjmJeia7WQ3YSDoUhro8F0PDVzyBBqiRkw6w91u7Zss9p2XNWqe0CRCv3WXtNO
	D/13l+mEenSy7LUNO882WVlwkbVHvEs9j9aU0jFdJYIUXJeoKHmpMZmuASj4VbQ+yV4eAhfdzt3XA
	rQX+NTVhKPJEz3Uu1BbUVYPCLApghZIKc0252OOOT/VdJhFXJXobcNY1VuDF5AHGkEY6+9gZFx7vM
	+LzLXSMwkxnG//aM2mgzIowrUrI3X7MRE3ah9WkBAGGMBStW7TJdj3Rl1E6THySNikKx/1E8Wi4dn
	J2J1lH+A==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPARm-00CbEo-54; Sat, 20 Aug 2022 00:26:36 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 10/11] drivers/hv/vmbus, video/hyperv_fb: Untangle and refactor Hyper-V panic notifiers
Date: Fri, 19 Aug 2022 19:17:30 -0300
Message-Id: <20220819221731.480795-11-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819221731.480795-1-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_152642_204464_C98A0DFC 
X-CRM114-Status: GOOD (  27.42  )
X-Mailman-Approved-At: Wed, 24 Aug 2022 06:05:59 -0700
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>, will@kernel.org, Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, Dexuan Cui <decui@microsoft.com>, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, Andrea Parri <parri.andrea@gmail.com>, alejandro.j.jimenez@oracle.com, Tianyu Lan <Tianyu.Lan@microsoft.com>, keescook@chromium.org, john.ogness@linutronix.de, Haiyang Zhang <haiyangz@microsoft.com>, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently Hyper-V guests are among the most relevant users of the panic
infrastructure, like panic notifiers, kmsg dumpers, etc. The reasons rely
both in cleaning-up procedures (closing hypervisor <-> guest connection,
disabling some paravirtualized timer) as well as to data collection
(sending panic information to the hypervisor) and framebuffer management.

The thing is: some notifiers are related to others, ordering matters, some
functionalities are duplicated and there are lots of conditionals behind
sending panic information to the hypervisor. As part of an effort to
clean-up the panic notifiers mechanism and better document things, we
hereby address some of the issues/complexities of Hyper-V panic handling
through the following changes:

(a) We have die and panic notifiers on vmbus_drv.c and both have goals of
sending panic information to the hypervisor, though the panic notifier is
also responsible for a cleaning-up procedure.

This commit clears the code by splitting the panic notifier in two, one
for closing the vmbus connection whereas the other is only for sending
panic info to hypervisor. With that, it was possible to merge the die and
panic notifiers in a single/well-documented function, and clear some
conditional complexities on sending such information to the hypervisor.

(b) There is a Hyper-V framebuffer panic notifier, which relies in doing
a vmbus operation that demands a valid connection. So, we must order this
notifier with the panic notifier from vmbus_drv.c, to guarantee that the
framebuffer code executes before the vmbus connection is unloaded.

Also, this commit removes a useless header.

Although there is code rework and re-ordering, we expect that this change
has no functional regressions but instead optimize the path and increase
panic reliability on Hyper-V. This was tested on Hyper-V with success.

Cc: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Fabio A M Martins <fabiomirmar@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V3:
- Added Michael's review tag - thanks!

V2:
- Unfortunately we cannot rely in the crash shutdown (custom) handler
to perform the vmbus unload - arm64 architecture doesn't have this
"feature" [0]. So, in V2 we kept the notifier behavior and always
unload the vmbus connection, no matter what - thanks Michael for
pointing that;

- Removed the Fixes tags as per Michael suggestion;

- As per Petr suggestion, we abandoned the idea of distinguish among
notifiers using an id - so, in V2 we rely in the old and good address
comparison for that. Thanks Petr for the enriching discussion!

[0] https://lore.kernel.org/lkml/427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com/


 drivers/hv/vmbus_drv.c          | 109 +++++++++++++++++++-------------
 drivers/video/fbdev/hyperv_fb.c |   8 +++
 2 files changed, 74 insertions(+), 43 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 23c680d1a0f5..0a77e2bb0b70 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -25,7 +25,6 @@
 #include <linux/sched/task_stack.h>
 
 #include <linux/delay.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
 #include <linux/screen_info.h>
@@ -69,53 +68,74 @@ static int hyperv_report_reg(void)
 	return !sysctl_record_panic_msg || !hv_panic_page;
 }
 
-static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
+/*
+ * The panic notifier below is responsible solely for unloading the
+ * vmbus connection, which is necessary in a panic event.
+ *
+ * Notice an intrincate relation of this notifier with Hyper-V
+ * framebuffer panic notifier exists - we need vmbus connection alive
+ * there in order to succeed, so we need to order both with each other
+ * [see hvfb_on_panic()] - this is done using notifiers' priorities.
+ */
+static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned long val,
 			      void *args)
+{
+	vmbus_initiate_unload(true);
+	return NOTIFY_DONE;
+}
+static struct notifier_block hyperv_panic_vmbus_unload_block = {
+	.notifier_call	= hv_panic_vmbus_unload,
+	.priority	= INT_MIN + 1, /* almost the latest one to execute */
+};
+
+static int hv_die_panic_notify_crash(struct notifier_block *self,
+				     unsigned long val, void *args);
+
+static struct notifier_block hyperv_die_report_block = {
+	.notifier_call = hv_die_panic_notify_crash,
+};
+static struct notifier_block hyperv_panic_report_block = {
+	.notifier_call = hv_die_panic_notify_crash,
+};
+
+/*
+ * The following callback works both as die and panic notifier; its
+ * goal is to provide panic information to the hypervisor unless the
+ * kmsg dumper is used [see hv_kmsg_dump()], which provides more
+ * information but isn't always available.
+ *
+ * Notice that both the panic/die report notifiers are registered only
+ * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE set.
+ */
+static int hv_die_panic_notify_crash(struct notifier_block *self,
+				     unsigned long val, void *args)
 {
 	struct pt_regs *regs;
+	bool is_die;
 
-	vmbus_initiate_unload(true);
-
-	/*
-	 * Hyper-V should be notified only once about a panic.  If we will be
-	 * doing hv_kmsg_dump() with kmsg data later, don't do the notification
-	 * here.
-	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
-	    && hyperv_report_reg()) {
+	/* Don't notify Hyper-V unless we have a die oops event or panic. */
+	if (self == &hyperv_panic_report_block) {
+		is_die = false;
 		regs = current_pt_regs();
-		hyperv_report_panic(regs, val, false);
+	} else { /* die event */
+		if (val != DIE_OOPS)
+			return NOTIFY_DONE;
+
+		is_die = true;
+		regs = ((struct die_args *)args)->regs;
 	}
-	return NOTIFY_DONE;
-}
-
-static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
-			    void *args)
-{
-	struct die_args *die = args;
-	struct pt_regs *regs = die->regs;
-
-	/* Don't notify Hyper-V if the die event is other than oops */
-	if (val != DIE_OOPS)
-		return NOTIFY_DONE;
 
 	/*
-	 * Hyper-V should be notified only once about a panic.  If we will be
-	 * doing hv_kmsg_dump() with kmsg data later, don't do the notification
-	 * here.
+	 * Hyper-V should be notified only once about a panic/die. If we will
+	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
+	 * notification here.
 	 */
 	if (hyperv_report_reg())
-		hyperv_report_panic(regs, val, true);
+		hyperv_report_panic(regs, val, is_die);
+
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block hyperv_die_block = {
-	.notifier_call = hyperv_die_event,
-};
-static struct notifier_block hyperv_panic_block = {
-	.notifier_call = hyperv_panic_event,
-};
-
 static const char *fb_mmio_name = "fb_range";
 static struct resource *fb_mmio;
 static struct resource *hyperv_mmio;
@@ -1538,16 +1558,17 @@ static int vmbus_bus_init(void)
 		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
 			hv_kmsg_dump_register();
 
-		register_die_notifier(&hyperv_die_block);
+		register_die_notifier(&hyperv_die_report_block);
+		atomic_notifier_chain_register(&panic_notifier_list,
+						&hyperv_panic_report_block);
 	}
 
 	/*
-	 * Always register the panic notifier because we need to unload
-	 * the VMbus channel connection to prevent any VMbus
-	 * activity after the VM panics.
+	 * Always register the vmbus unload panic notifier because we
+	 * need to shut the VMbus channel connection on panic.
 	 */
 	atomic_notifier_chain_register(&panic_notifier_list,
-			       &hyperv_panic_block);
+			       &hyperv_panic_vmbus_unload_block);
 
 	vmbus_request_offers();
 
@@ -2776,15 +2797,17 @@ static void __exit vmbus_exit(void)
 
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		kmsg_dump_unregister(&hv_kmsg_dumper);
-		unregister_die_notifier(&hyperv_die_block);
+		unregister_die_notifier(&hyperv_die_report_block);
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						&hyperv_panic_report_block);
 	}
 
 	/*
-	 * The panic notifier is always registered, hence we should
+	 * The vmbus panic notifier is always registered, hence we should
 	 * also unconditionally unregister it here as well.
 	 */
 	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &hyperv_panic_block);
+					&hyperv_panic_vmbus_unload_block);
 
 	free_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index e1b65a01fb96..9234d31d4305 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1216,7 +1216,15 @@ static int hvfb_probe(struct hv_device *hdev,
 	par->fb_ready = true;
 
 	par->synchronous_fb = false;
+
+	/*
+	 * We need to be sure this panic notifier runs _before_ the
+	 * vmbus disconnect, so order it by priority. It must execute
+	 * before the function hv_panic_vmbus_unload() [drivers/hv/vmbus_drv.c],
+	 * which is almost at the end of list, with priority = INT_MIN + 1.
+	 */
 	par->hvfb_panic_nb.notifier_call = hvfb_on_panic;
+	par->hvfb_panic_nb.priority = INT_MIN + 10,
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &par->hvfb_panic_nb);
 
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
