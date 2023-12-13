Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1500C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PmNFELxlwUpXO3qL+9xOqIIRFSYJbKk2+pIJnyOdjmA=; b=cWNc9pBn3ZoE8q
	hr7Sv60w/esYIfPylDxy7k1NUNLMmcBSZu2IVypfEkCdK0ahcUGaNKSwMexwZQRigh4atDosDyFfb
	5W0HIfK+b+8XQCUqNS7kEQ/pLvLnHDSEdRTJ+0XD2eAZAmeY+DmNj6Z1BG8Y83EwjdXSBEITGmEiK
	Hb0fD7xiDjhLWnfyF0v2OBYvcGSN4vHHhKDQLwa1I1/HzHuaiqn+T2FcnpIO+BkEmB4S0VLLaHUdT
	hm58OKnAvMeWCFwm+E+p1BV6no09OumJLLn9Vb8vCPejdh+JjzHc1aG8BtlytzmncZYo1c/BSz2WM
	qGuE01lQuqs2XOJYtxmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCml-00D8E7-2K;
	Wed, 13 Dec 2023 00:07:35 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCmf-00D87o-21;
	Wed, 13 Dec 2023 00:07:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426050; x=1733962050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mc8BtMBoJccPwXhN5lfGmopEl26ZPwt65Ef0Tkxcd1Y=;
  b=guA4sv2vGCw2Y8+QzDHkP1flyshgU+cVj5MCEx+UVPGlRGwnTxEuKRB8
   K8Nxq+bEtG4tEIqLx53i5cJePDSlZQRg09Qx1fRqLLSRejxfk8KGBKYmn
   2x7psiv/bhf7tKShZ6vBl6aupyAhl48NeRFxFZ70+0KOdw/WnH6OrY9Rr
   s=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="368122532"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:07:24 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 5BC7680493;
	Wed, 13 Dec 2023 00:07:16 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:32184]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 342278a3-113e-4653-a12d-678bc8408d80; Wed, 13 Dec 2023 00:07:15 +0000 (UTC)
X-Farcaster-Flow-ID: 342278a3-113e-4653-a12d-678bc8408d80
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:15 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:11 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH 13/15] tracing: Add kho serialization of trace events
Date: Wed, 13 Dec 2023 00:04:50 +0000
Message-ID: <20231213000452.88295-14-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_160729_805969_B7E8DAE7 
X-CRM114-Status: GOOD (  18.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Events and thus their parsing handle in ftrace have dynamic IDs that get
assigned whenever the event is added to the system. If we want to parse
trace events after kexec, we need to link event IDs back to the original
trace event that existed before we kexec'ed.

There are broadly 2 paths we could take for that:

  1) Save full event description across KHO, restore after kexec,
     merge identical trace events into a single identifier.
  2) Recover the ID of post-kexec added events so they get the same
     ID after kexec that they had before kexec

This patch implements the second option. It's simpler and thus less
intrusive. However, it means we can not fully parse affected events
when the kernel removes or modifies trace events across a kho kexec.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/trace/trace.c        |  1 +
 kernel/trace/trace_output.c | 28 ++++++++++++++++++++++++++++
 kernel/trace/trace_output.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 71c249cc5b43..26edfd2a85fd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10639,6 +10639,7 @@ static int trace_kho_notifier(struct notifier_block *self,
 	err |= fdt_begin_node(fdt, "ftrace");
 	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
 	err |= trace_kho_write_trace_array(fdt, &global_trace);
+	err |= trace_kho_write_events(fdt);
 	err |= fdt_end_node(fdt);
 
 	if (!err) {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index f3677e0da795..113de40c616f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -12,6 +12,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/idr.h>
+#include <linux/kexec.h>
 
 #include "trace_output.h"
 
@@ -669,6 +670,33 @@ int trace_print_lat_context(struct trace_iterator *iter)
 	return !trace_seq_has_overflowed(s);
 }
 
+int trace_kho_write_events(void *fdt)
+{
+#ifdef CONFIG_FTRACE_KHO
+	const char compatible[] = "ftrace,events-v1";
+	const char *name = "events";
+	struct trace_event *event;
+	unsigned key;
+	int err = 0;
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+
+	for (key = 0; key < EVENT_HASHSIZE; key++) {
+		hlist_for_each_entry(event, &event_hash[key], node)
+			err |= fdt_property(fdt, event->name, &event->type,
+					    sizeof(event->type));
+	}
+
+	err |= fdt_end_node(fdt);
+
+	return err;
+#else
+	return 0;
+#endif
+}
+
+
 /**
  * ftrace_find_event - find a registered event
  * @type: the type of event to look for
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index dca40f1f1da4..36dc7963269e 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -25,6 +25,7 @@ extern enum print_line_t print_event_fields(struct trace_iterator *iter,
 extern void trace_event_read_lock(void);
 extern void trace_event_read_unlock(void);
 extern struct trace_event *ftrace_find_event(int type);
+extern int trace_kho_write_events(void *fdt);
 
 extern enum print_line_t trace_nop_print(struct trace_iterator *iter,
 					 int flags, struct trace_event *event);
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
