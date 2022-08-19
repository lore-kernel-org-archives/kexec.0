Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C213BC00140
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sLXZd0ifpfvnV8XoiEsT20Bw1511wMKLIYuf+P73D2U=; b=Cc/5FKjOtPxRLX
	Zp0YLjNMDAFwVrmWBp5d/Cu6FrxKTfIDROooOLpN6S3XEyCAVHWjS0EbEZr72lDKoBEzFHyKvRI1y
	IYnXiQ0S9oPO3LcJur21/C1ciXiHOQJCm5mJh/uLhPRbu1Y6afz4nhb62AtU2NeUcp/zwnlHjMLGH
	JsTsyyquxA9hpPhaYOErsz8HMQ8mn+4uizzjM4tVl5Ri7KY3tKh8MfwJ4xjQ2kC4b+aBIZEBif2e/
	lyecUjHEBU+xg3pIBJNcf7KNJqQ3862Zj7xldy3ST1btTdg6vj5zRBGrPzQm99tctw9hioSi9T1YD
	QMpp5z550BjcE20+acDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq5M-00D610-4C; Wed, 24 Aug 2022 13:06:20 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPAOo-00CpiS-Ji
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 22:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d2an8K4S3oBRBmk7SIJDz4Oai1o8VvWFhnH8gpD08U0=; b=X2+kGd13kauJptBzv6orQ1U7yS
	4aVfkn5eFTKuYn33XLrObdbdfBscRW7PnPpTi00KjX722oTJFFbDGBByOFk/diOtlqyJUfXp1qqtk
	wdAyoKW3PdYKCTsCYnvnraOEqwCd466jDzHdiLOwLKF9ZjNoUljXl9a8OK3JS3DA64x+It+MtEgjo
	9j46jITNnxNXwQM8p6iXaD+6u+VxqJqBPZbsVtVKQDuWHrqQ2/urSChnRWiPaMvc2L+ukkn4Fmyax
	j1lFef3s95ENI6oiTnHSrbeqhX4dTAauX2TwiB5awED4vpx4s2jm8I3rnXNRpHJaRpI5R0QmdmdLU
	O+2sMEDw==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPAOh-00Cb6O-5U; Sat, 20 Aug 2022 00:23:25 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 07/11] notifiers: Add tracepoints to the notifiers infrastructure
Date: Fri, 19 Aug 2022 19:17:27 -0300
Message-Id: <20220819221731.480795-8-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819221731.480795-1-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_152330_690056_78167D19 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, Valentin Schneider <valentin.schneider@arm.com>, vgoyal@redhat.com, Xiaoming Ni <nixiaoming@huawei.com>, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, Cong Wang <xiyou.wangcong@gmail.com>, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, Arjan van de Ven <arjan@linux.intel.com>, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently there is no way to show the callback names for registered,
unregistered or executed notifiers. This is very useful for debug
purposes, hence add this functionality here in the form of notifiers'
tracepoints, one per operation.

Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V3:
- Yet another major change - thanks to Arjan's great suggestion,
refactored the code to make use of tracepoints instead of guarding
the output with a Kconfig debug setting.

V2:
- Major improvement thanks to the great idea from Xiaoming - changed
all the ksym wheel reinvention to printk %ps modifier;

- Instead of ifdefs, using IS_ENABLED() - thanks Steven.

- Removed an unlikely() hint on debug path.


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
index 0d5bd62c480e..2f2783f59a31 100644
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
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
