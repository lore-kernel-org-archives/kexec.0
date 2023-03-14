Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1C7C6FD1F
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZX7GdMdFXXL+N01q/0ZgB3YqbEmMdP7S0zlXcCRl9qU=; b=OAg2k6uLur5uJK
	JCMXz7LaRtCKE0ROzDgPQG9E2jN7019TQnmtVEfh39ftKH4unr/2LKaczq64omnczZR57qbZzKwnT
	CSxhDSvtWItt66x2G9AK5XdHEeHrvQyheEaNJCI1fjDv/YUFS7Nfda5gQiCcCDjwG4EhGwd4D1Q82
	OjiSv264xZ2LLEhfoutKqdGkXbTTUm1oluCCk3yje60YERmEzOIqeRgCxz5xZjw1y8AjYPTeuYsQo
	sXjlfQ36UvAYjiYdHV5lk5qgeaiL0qXghfHqfbpUKoYPy0XFvnnDjqTST5Ade/+RyqIbeCqnLEW56
	+OdEpFN+EARfVnImlSfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcAqg-00BQI5-0s;
	Tue, 14 Mar 2023 20:02:18 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcAqc-00BQCl-0s
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 20:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ScOePP8ptx3kVOMCN2OZHRA7zZmcuNjXDuuoTzcaq4c=; b=FdBBFcXcRU38XoS5fijRs2ca65
	Mn6Lg/PH2Atsa8AHOAn21foytDah9QOpYH8syw5IMdJ/ICmzNtcGdAU/bFfAWe3GQVXe3D3LHy/tL
	8enjFOB7dRGuTzox/V0wQaDLsMZmbnUmubhM6JmPw20xV/0Uvg/zFiFznQq9pO5grQR0VZsiMWMom
	qh9dSxGnYoZaH9OocuAPyN2UvYQikX49pe6ohsbIKoon5SxklO9nL6K0AIbMYYeI0J35mbxTZvngG
	mpOfTFmsvwxHiDvvwprbC4i3XDLXtcZRHBbR/PfRVFzjrFWPRByw5/YnSgErveWtjaE5itzd1K2WW
	Qo0fERMg==;
Received: from [152.254.169.34] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1pcAq4-00AOIk-KD; Tue, 14 Mar 2023 21:01:41 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] notifiers: Add tracepoints to the notifiers infrastructure
Date: Tue, 14 Mar 2023 17:00:58 -0300
Message-Id: <20230314200058.1326909-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_130214_632839_CDCF78D0 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: pmladek@suse.com, kernel@gpiccoli.net, kernel-dev@igalia.com, bhe@redhat.com, Xiaoming Ni <nixiaoming@huawei.com>, bigeasy@linutronix.de, rafael.j.wysocki@intel.com, kexec@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Michael Kelley <mikelley@microsoft.com>, dmitry.osipenko@collabora.com, xiyou.wangcong@gmail.com, Arjan van de Ven <arjan@linux.intel.com>, valentin.schneider@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently there is no way to show the callback names for registered,
unregistered or executed notifiers. This is very useful for debug
purposes, hence add this functionality here in the form of notifiers'
tracepoints, one per operation.

Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V4:
- Rebased and tested on top of v6.3-rc2.
- Sending as standalone patch, not part of any series.

V3:
- Yet another major change - thanks to Arjan's great suggestion,
refactored the code to make use of tracepoints instead of guarding
the output under a Kconfig debug setting.

V2:
- Major improvement thanks to the great idea from Xiaoming - changed
all the ksym wheel reinvention to printk %ps modifier;

- Instead of ifdefs, using IS_ENABLED() - thanks Steven.

- Removed an unlikely() hint on debug path.

V3: https://lore.kernel.org/lkml/20220819221731.480795-8-gpiccoli@igalia.com/
V2: https://lore.kernel.org/lkml/20220719195325.402745-10-gpiccoli@igalia.com/

Thanks in advance for reviews!
Cheers,

Guilherme


 include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
 kernel/notifier.c                |  6 +++
 2 files changed, 75 insertions(+)
 create mode 100644 include/trace/events/notifiers.h

diff --git a/include/trace/events/notifiers.h b/include/trace/events/notifiers.h
new file mode 100644
index 000000000000..e8f30631aef5
--- /dev/null
+++ b/include/trace/events/notifiers.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM notifiers
+
+#if !defined(_TRACE_NOTIFIERS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NOTIFIERS_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(notifiers_info,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb),
+
+	TP_STRUCT__entry(
+		__field(void *, cb)
+	),
+
+	TP_fast_assign(
+		__entry->cb = cb;
+	),
+
+	TP_printk("%ps", __entry->cb)
+);
+
+/*
+ * notifiers_register - called upon notifier callback registration
+ *
+ * @cb:		callback pointer
+ *
+ */
+DEFINE_EVENT(notifiers_info, notifiers_register,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb)
+);
+
+/*
+ * notifiers_unregister - called upon notifier callback unregistration
+ *
+ * @cb:		callback pointer
+ *
+ */
+DEFINE_EVENT(notifiers_info, notifiers_unregister,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb)
+);
+
+/*
+ * notifiers_run - called upon notifier callback execution
+ *
+ * @cb:		callback pointer
+ *
+ */
+DEFINE_EVENT(notifiers_info, notifiers_run,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb)
+);
+
+#endif /* _TRACE_NOTIFIERS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/notifier.c b/kernel/notifier.c
index d353e4b5402d..f57e54ddbb5f 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -7,6 +7,9 @@
 #include <linux/vmalloc.h>
 #include <linux/reboot.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/notifiers.h>
+
 /*
  *	Notifier list for kernel code which wants to be called
  *	at shutdown. This is used to stop any idling DMA operations
@@ -37,6 +40,7 @@ static int notifier_chain_register(struct notifier_block **nl,
 	}
 	n->next = *nl;
 	rcu_assign_pointer(*nl, n);
+	trace_notifiers_register((void*)n->notifier_call);
 	return 0;
 }
 
@@ -46,6 +50,7 @@ static int notifier_chain_unregister(struct notifier_block **nl,
 	while ((*nl) != NULL) {
 		if ((*nl) == n) {
 			rcu_assign_pointer(*nl, n->next);
+			trace_notifiers_unregister((void*)n->notifier_call);
 			return 0;
 		}
 		nl = &((*nl)->next);
@@ -84,6 +89,7 @@ static int notifier_call_chain(struct notifier_block **nl,
 			continue;
 		}
 #endif
+		trace_notifiers_run((void*)nb->notifier_call);
 		ret = nb->notifier_call(nb, val, v);
 
 		if (nr_calls)
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
