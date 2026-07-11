Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536FEC43458
	for <kexec@archiver.kernel.org>; Sat, 11 Jul 2026 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=68s0RYnGpn0IUjFXbD1EK6m8KysWyV+WA560sE1DG4s=; b=fSI5G+xkHjEzXB
	0NPbjzWlPuUqrvywCUELvR/9aM7m6hbPBt8Yw6fSAB5tFyHzzAXOcyOkpMZLS8Z3GoGcZNkM0EbQ3
	87CnRbLjoIUfRs3RAo1vB8bGRgZlgkdv8u4DKbpkDIpxXO+pXGMrUeBgPfNCkGwZLBkbuoGKQVeqR
	Q9gjlNIZyr4Hd2+o1yuipJn6HdLYJuXacu+qn1NChr8fYKKIxxrTy41pMRmXVKrkLeIyQhOW81xPs
	Yz/U1bh/uGWTdTcJT1Vexal/gyqthe/H6xIk3X3MTQ3prFnJmAm3I4wSe1w9bsL3aXJZHxFO0a1h9
	lD4EGkH9FhhcagJ4pGHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUk-0000000631i-0SaU;
	Sat, 11 Jul 2026 00:23:02 +0000
Received: from confino.investici.org ([2a11:7980:1::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUg-00000006319-2MiJ
	for kexec@lists.infradead.org;
	Sat, 11 Jul 2026 00:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783729373;
	bh=68s0RYnGpn0IUjFXbD1EK6m8KysWyV+WA560sE1DG4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMA3n1tZzGcqmx/qHaOfqw1qHiTSR1xarwZHJtAunkTXOx1IHC/1Kq3J/XkpXQpTS
	 /e4yoy/riwS0j8UU6ntIjzCXS39TuqbhEi3d1Tx3NmBFadj1Rb+w2kB+PcVoMWhqDe
	 A1VUzaDWdpUCSRbqPQL/cscSzvFNNv8FV7v/wshE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gxqCx6Jlpz114G;
	Sat, 11 Jul 2026 00:22:53 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gxqCx0VSjz113X;
	Sat, 11 Jul 2026 00:22:53 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [RFC PATCH 1/4] panic: add a pre kdump notifier list
Date: Sat, 11 Jul 2026 00:22:50 +0000
Message-ID: <20260711002253.1115-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711002253.1115-1-include@grrlz.net>
References: <20260711002253.1115-1-include@grrlz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_172259_051787_93513BC3 
X-CRM114-Status: GOOD (  26.50  )
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
Cc: pmladek@suse.com, include@grrlz.net, baoquan.he@linux.dev, arnd@arndb.de, corbet@lwn.net, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When a crash kernel is loaded, panic() jumps to it before the panic
notifiers run. A hypervisor or firmware therefore never learns that
the guest panicked: the Hyper-V host never receives the crash
registers, a Google gsmi firmware log entry is dropped, a pvpanic
device never signals the host, and an AMD SEV-SNP guest skips the
firmware and IOMMU shutdown. Fleet alerting, availability tracking,
and crash logging all miss the event.

The only escape hatch today is crash_kexec_post_notifiers, but it runs
the entire legacy notifier list before the kdump. That list carries
slow callbacks, IPMI being the obvious one because it talks to a BMC,
so enabling it delays every crash dump on the machine. Hyper-V forces
it on anyway and penalizes every kdump for the sake of one upcall;
this series also removes the forcing that SEV-SNP added for the same
reason, giving SNP hosts the normal early crash kexec back.

Add a small dedicated list that always runs before crash kexec. The
list head stays private and registration goes through a function,
because the callbacks on this list have a strict contract and an API
is how you enforce one. The list lives in its own file, not in panic.c,
so the contract can carry a MAINTAINERS entry and the existing panic
code does not have to move.

Priorities order the list like any atomic notifier chain. The header
documents that they are reserved for callbacks that must run last, for
example because they may not return or because they tear down a
transport that other callbacks still need.

The notify path walks the chain by hand and names each callback on the
console before invoking it. Running anything before the crash kexec is
a reliability trade, if an upcall hangs or faults and costs us the
crash dump, the console identifies the culprit instead of leaving a
machine that silently never rebooted into the kdump kernel. Callback
return values are deliberately ignored, and a nested panic resumes the
walk after the callback that was running instead of refaulting on it.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 include/linux/panic_notifier.h | 18 ++++++++++
 kernel/Makefile                |  2 +-
 kernel/panic_notifiers.c       | 65 ++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 kernel/panic_notifiers.c

diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7..1e99de3a8a6a 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -7,6 +7,24 @@
 
 extern struct atomic_notifier_head panic_notifier_list;
 
+/*
+ * The pre kdump list runs on every panic, before a potential crash
+ * kexec, so a hypervisor or firmware learns of the panic even when a
+ * crash kernel is loaded. A callback:
+ *
+ *  - must not take locks, allocate memory or sleep
+ *  - must not assume other CPUs have been stopped
+ *  - must tolerate being entered again if the panic path panics
+ *
+ * One that cannot belongs on the legacy panic_notifier_list instead.
+ * Reserve low priorities for callbacks that must run last, for
+ * example because they do not return. Return values are ignored: the
+ * whole list always runs.
+ */
+int panic_notifier_register_pre_kdump(struct notifier_block *nb);
+int panic_notifier_unregister_pre_kdump(struct notifier_block *nb);
+void panic_pre_kdump_notify(const char *buf);
+
 extern bool crash_kexec_post_notifiers;
 
 #endif	/* _LINUX_PANIC_NOTIFIERS_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..7add98a5acc2 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y     = fork.o exec_domain.o exec_state.o panic.o \
+obj-y     = fork.o exec_domain.o exec_state.o panic.o panic_notifiers.o \
 	    cpu.o exit.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o user.o \
 	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
diff --git a/kernel/panic_notifiers.c b/kernel/panic_notifiers.c
new file mode 100644
index 000000000000..31f15f84662e
--- /dev/null
+++ b/kernel/panic_notifiers.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* The pre kdump panic notifier list. See include/linux/panic_notifier.h. */
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/notifier.h>
+#include <linux/panic_notifier.h>
+#include <linux/printk.h>
+#include <linux/rcupdate.h>
+
+static ATOMIC_NOTIFIER_HEAD(panic_pre_kdump_list);
+
+/* The callback must satisfy the contract in include/linux/panic_notifier.h. */
+int panic_notifier_register_pre_kdump(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&panic_pre_kdump_list, nb);
+}
+EXPORT_SYMBOL_GPL(panic_notifier_register_pre_kdump);
+
+/* Synchronizes RCU and may block; must not be called from the panic path. */
+int panic_notifier_unregister_pre_kdump(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&panic_pre_kdump_list, nb);
+}
+EXPORT_SYMBOL_GPL(panic_notifier_unregister_pre_kdump);
+
+/*
+ * Called from panic() only, right before a potential crash kexec. Callbacks
+ * are named on the console first and their return values ignored.
+ */
+void panic_pre_kdump_notify(const char *buf)
+{
+	static struct notifier_block *cursor;
+	struct notifier_block *nb, *resume_after;
+
+	/* No locking: panic_cpu serializes; a nested panic just runs again. */
+	resume_after = cursor;
+
+	rcu_read_lock();
+	for (nb = rcu_dereference(panic_pre_kdump_list.head); nb;
+	     nb = rcu_dereference(nb->next)) {
+		/*
+		 * On a nested panic, skip past the callback that was
+		 * running when it hit: that one is the likely culprit.
+		 */
+		if (resume_after) {
+			if (nb == resume_after)
+				resume_after = NULL;
+			continue;
+		}
+
+#ifdef CONFIG_DEBUG_NOTIFIERS
+		if (unlikely(!func_ptr_is_kernel_text(nb->notifier_call))) {
+			WARN(1, "Invalid pre kdump notifier!");
+			continue;
+		}
+#endif
+		cursor = nb;
+		pr_emerg("pre kdump notifier: calling %ps\n",
+			 nb->notifier_call);
+		/* The zero action mirrors the legacy panic_notifier_list. */
+		nb->notifier_call(nb, 0, (void *)buf);
+	}
+	rcu_read_unlock();
+	cursor = NULL;
+}
-- 
2.53.0


