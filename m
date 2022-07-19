Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F8EC433EF
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oBKbDiePUsM9f8TZQavs8cia/ZRFIA8koP9HlBWlFv0=; b=2CnCtZNaDfPbqD
	Nh2KuAI8pjYn4SIBzlkDkgCP2nLT74SdDReqNnS8LZYrWdt5gHp75xbj5vDX7QyD28JaiObUpDWBo
	EUlNz59pmp1R0M66+PTWYleW3fa2YdHP/bny5IZsdqYmjPYprlJ/OKNMBcOzcUjeHd8WF6Ev7h8Ef
	IPnG2bA07Ulr0JULI33QtOyLJvVZErulqvOU812+1Q4t3s0oCn83GLvsr/gBeufXKlhc6KFvqVHCF
	ubPSvpPr/mKVRMX0XV3QFECsVE9REF5j7bjGPGtZwuVV4FBN51CBEyapq28ZDS718LXuT4zQ0aqzQ
	8iNg9gD9GB13K67mAY6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nU-000sPv-8a; Wed, 20 Jul 2022 06:03:00 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtKz-00CBl6-0Q
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 19:56:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=G/r0iuXd0nlX286PGQstcOmzqdsizrciXg6SQCj+hrI=; b=RhwLi+Y/TVllg5RvRTvJG+xird
	h7Zn4/C51lw/FCc3+EweBxYFpawiiKUBDePiNsdb3Is4X2If+LfubcJv/or+mkbRd+DXDJMYXzcOc
	o+UzOf1szX5Gn3Z5brW0RQk4mkvxUtw/Ws/rYMDUvfvL85OtHy0/O4GZWH+sfPEKA3GsiyymScwh4
	40kyB/OE7DWejlgw2JGA6mO41KvaElDT9fKoSbNTP1ZgQz0+9mbbbwf73Bn2sXGllG7Pke7n4K4Os
	0BSaV1h0OvA5JuTbGQQ7eYDvYBqjF0A/rfJSQ5FWJNIpPmvbwRSEXw0p7aTaHHFw8lDfYQ6EfzrhH
	Ugj9r4xQ==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtKr-006fZI-Di; Tue, 19 Jul 2022 21:56:50 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Date: Tue, 19 Jul 2022 16:53:21 -0300
Message-Id: <20220719195325.402745-9-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719195325.402745-1-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125657_068894_0EB9DE08 
X-CRM114-Status: GOOD (  15.18  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, Sergei Shtylyov <sergei.shtylyov@gmail.com>, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently the tracing dump_on_oops feature is implemented
through separate notifiers, one for die/oops and the other
for panic - given they have the same functionality, let's
unify them.

Also improve the function comment and change the priority of
the notifier to make it execute earlier, avoiding showing useless
trace data (like the callback names for the other notifiers);
finally, we also removed an unnecessary header inclusion.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2:
- Different approach; instead of using IDs to distinguish die and
panic events, rely on address comparison like other notifiers do
and as per Petr's suggestion;

- Removed ACK from Steven since the code changed.

 kernel/trace/trace.c | 55 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8dd54627075..2a436b645c70 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -19,7 +19,6 @@
 #include <linux/kallsyms.h>
 #include <linux/security.h>
 #include <linux/seq_file.h>
-#include <linux/notifier.h>
 #include <linux/irqflags.h>
 #include <linux/debugfs.h>
 #include <linux/tracefs.h>
@@ -9777,40 +9776,40 @@ static __init int tracer_init_tracefs(void)
 
 fs_initcall(tracer_init_tracefs);
 
-static int trace_panic_handler(struct notifier_block *this,
-			       unsigned long event, void *unused)
-{
-	if (ftrace_dump_on_oops)
-		ftrace_dump(ftrace_dump_on_oops);
-	return NOTIFY_OK;
-}
+static int trace_die_panic_handler(struct notifier_block *self,
+				unsigned long ev, void *unused);
 
 static struct notifier_block trace_panic_notifier = {
-	.notifier_call  = trace_panic_handler,
-	.next           = NULL,
-	.priority       = 150   /* priority: INT_MAX >= x >= 0 */
+	.notifier_call = trace_die_panic_handler,
+	.priority = INT_MAX - 1,
 };
 
-static int trace_die_handler(struct notifier_block *self,
-			     unsigned long val,
-			     void *data)
-{
-	switch (val) {
-	case DIE_OOPS:
-		if (ftrace_dump_on_oops)
-			ftrace_dump(ftrace_dump_on_oops);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
 static struct notifier_block trace_die_notifier = {
-	.notifier_call = trace_die_handler,
-	.priority = 200
+	.notifier_call = trace_die_panic_handler,
+	.priority = INT_MAX - 1,
 };
 
+/*
+ * The idea is to execute the following die/panic callback early, in order
+ * to avoid showing irrelevant information in the trace (like other panic
+ * notifier functions); we are the 2nd to run, after hung_task/rcu_stall
+ * warnings get disabled (to prevent potential log flooding).
+ */
+static int trace_die_panic_handler(struct notifier_block *self,
+				unsigned long ev, void *unused)
+{
+	if (!ftrace_dump_on_oops)
+		goto out;
+
+	if (self == &trace_die_notifier && ev != DIE_OOPS)
+		goto out;
+
+	ftrace_dump(ftrace_dump_on_oops);
+
+out:
+	return NOTIFY_DONE;
+}
+
 /*
  * printk is set to max of 1024, we really don't need it that big.
  * Nothing should be printing 1000 characters anyway.
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
