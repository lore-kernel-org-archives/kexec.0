Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B67EC47258
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ycXRKCAS5bevUee8Wet7ya9jG4DNDR0nQ0/nAIQqIUY=; b=pUm8mIeE6FhN/S
	X5KReiWTRk2nAI5zsgHDXQpshImTat/UtsJp2cs434NQLnMVWxHW6SFKMMy/4V6S6+vn91gt+AQrP
	kZW+OImau78Orv+xSxa0vMLAr+IJ8TUaNz3GF9p9wpSbOWiFKBX8bMBcZWVHq9FuE4rWt/cAyQ9ex
	1DsrYAYZ6cYjQxQQNG6TqxS5xnQZ5XsoGghAkpUhwJhGoA5aBFE02E8XBByuYkQ9j1LhcTI09oe8C
	TN8J+NNV/P+1p51l+v4bGnzTw7E3Gtmu9ev3QhvekylAAtaGO/3csNciltvwJdEbjMcFqHdHzdVkC
	Gp+6TH5SxCk1FrbfKjQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7EL-00HIRt-2f;
	Wed, 17 Jan 2024 14:49:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7EA-00HILd-13;
	Wed, 17 Jan 2024 14:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=V9z9IM4flUSgP0z2cJrShPiLgbianVVfqfmMvTzhOC8=; b=qGT2CfVDcRyRBTCglGfa33/wIG
	eU/PjAhzsv38TC8i2amcxP2irvx7XC+pLz8XHwdP1oYaMA6N8QCk3MIJboto/tRaB8dQyXP3GMSIu
	CuelThzAMw55F6pIZRoarM4jPhC1u6aZA6qgCDd6gJS7Hw5F26bDdLN0Jbx8bck5Vi59PmJ9WWKy0
	DIC1jiHGOSVy+57NGVyoUKvDP3z6cOevpJAdceQMqQzblFMHURNDvMQwoUBubcMvdpzQEN1idAebb
	KFe1iRIQK19Fr8vq1FNJhUQPn5JEu5gnvW7lIRJcrSm1dHUab7I1eH7+5NEnyxt5bxjEwO502ng8E
	NXz4Ylww==;
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQ7E5-00000000VDP-3xQg;
	Wed, 17 Jan 2024 14:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502950; x=1737038950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9z9IM4flUSgP0z2cJrShPiLgbianVVfqfmMvTzhOC8=;
  b=Fk3Fg3POmoMBg590sWBzjL6TXGrXjs9d3rPaxXQiRnPXho/ly8L7x84Q
   ZssHmWbD1r/3PzZWEx75mkpomLvfvWC0LfwMexEY1ZJzvfgQwdwqpih3H
   ui5Lk7qgjtUIATpxf1FnA7XRwpM6JzTzlnqvxpPoH+MeDQg8ptQ3JpZ/7
   U=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="374981813"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:49:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 18794804F6;
	Wed, 17 Jan 2024 14:49:00 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:46192]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.164:2525] with esmtp (Farcaster)
 id c6bac9f3-2890-4c55-abf3-0050bf6f217f; Wed, 17 Jan 2024 14:48:59 +0000 (UTC)
X-Farcaster-Flow-ID: c6bac9f3-2890-4c55-abf3-0050bf6f217f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:59 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:55 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 11/17] tracing: Introduce kho serialization
Date: Wed, 17 Jan 2024 14:46:58 +0000
Message-ID: <20240117144704.602-12-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_144911_327226_962A1CF8 
X-CRM114-Status: GOOD (  16.47  )
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

We want to be able to transfer ftrace state from one kernel to the next.
To start off with, let's establish all the boiler plate to get a write
hook when KHO wants to serialize and fill out basic data.

Follow-up patches will fill in serialization of ring buffers and events.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Remove ifdefs
---
 kernel/trace/trace.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a0defe156b57..9a0d96975c9c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -32,6 +32,7 @@
 #include <linux/percpu.h>
 #include <linux/splice.h>
 #include <linux/kdebug.h>
+#include <linux/kexec.h>
 #include <linux/string.h>
 #include <linux/mount.h>
 #include <linux/rwsem.h>
@@ -866,6 +867,8 @@ static struct tracer		*trace_types __read_mostly;
  */
 DEFINE_MUTEX(trace_types_lock);
 
+static bool trace_in_kho;
+
 /*
  * serialize the access of the ring buffer
  *
@@ -10574,12 +10577,56 @@ void __init early_trace_init(void)
 	init_events();
 }
 
+static int trace_kho_notifier(struct notifier_block *self,
+			      unsigned long cmd,
+			      void *v)
+{
+	const char compatible[] = "ftrace-v1";
+	void *fdt = v;
+	int err = 0;
+
+	switch (cmd) {
+	case KEXEC_KHO_ABORT:
+		if (trace_in_kho)
+			mutex_unlock(&trace_types_lock);
+		trace_in_kho = false;
+		return NOTIFY_DONE;
+	case KEXEC_KHO_DUMP:
+		/* Handled below */
+		break;
+	default:
+		return NOTIFY_BAD;
+	}
+
+	if (unlikely(tracing_disabled))
+		return NOTIFY_DONE;
+
+	err |= fdt_begin_node(fdt, "ftrace");
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_end_node(fdt);
+
+	if (!err) {
+		/* Hold all future allocations */
+		mutex_lock(&trace_types_lock);
+		trace_in_kho = true;
+	}
+
+	return err ? NOTIFY_BAD : NOTIFY_DONE;
+}
+
+static struct notifier_block trace_kho_nb = {
+	.notifier_call = trace_kho_notifier,
+};
+
 void __init trace_init(void)
 {
 	trace_event_init();
 
 	if (boot_instance_index)
 		enable_instances();
+
+	if (IS_ENABLED(CONFIG_FTRACE_KHO))
+		register_kho_notifier(&trace_kho_nb);
 }
 
 __init static void clear_boot_tracer(void)
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
