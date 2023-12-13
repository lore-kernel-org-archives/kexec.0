Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E02C35274
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 01:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=34Pykxsz2tPMPAqxt3CdGB1mJkeTcgstGYpkpIlZS74=; b=kCA4i8U3Op9Hg6
	D1pcnECpCc+mb2Y0wxnZGT+jzRaK9pA+t+90vm5mgkMxrGTHA7XbxrbZ0ujpHIcE99LwXf3aqKe+M
	ABAucCLbnXqzKs2nHrkFDRUufZ9+mVKLyt4oujKBPXGEcy3EavRnfnKeDdbhsHb9zWfocQGBuNUxW
	csl5gzwY0xagvMUSCyCWfmrxxGiBy6DhJaQeQ2Mpo1zxSe/E++URzRWNQnqMOl7KwLRncIkPzveky
	mrOsZ7VUleNI0eFlceXFZj1hWdDCD8jmBiH0jvE6py45HoD61UYXdxFApy39/IWLu5aJV2mlcmacA
	YqNwOs/tznhtolN2Rf8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDDrQ-00DHiS-12;
	Wed, 13 Dec 2023 01:16:28 +0000
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCmK-00D7qs-34;
	Wed, 13 Dec 2023 00:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426029; x=1733962029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YG4rwMst//uzBl8lCmh1WsDiUmAxsOlA2EWBHH+q6Y0=;
  b=s4besE8J4FXdF0pY1V4RNQXdfPh65JA7/MCHGuYELR3JWPif5dX9CBjV
   gldkX6BnQaQBH7L+ZN/P9Eu5alkuJuCztsvpUk4ZDlyl1t/MXl9P/Wu/0
   zS71NyztJw8mFgRe0erlvUItEseAfMxNOdy7uIFl3jK6hVxfBla5Wtujf
   w=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="259290025"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:06:55 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id 69799881F9;
	Wed, 13 Dec 2023 00:06:53 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:53530]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.147:2525] with esmtp (Farcaster)
 id 28ae9c8f-1014-431a-84b5-e7284b5dddc6; Wed, 13 Dec 2023 00:06:53 +0000 (UTC)
X-Farcaster-Flow-ID: 28ae9c8f-1014-431a-84b5-e7284b5dddc6
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:42 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:38 +0000
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
Subject: [PATCH 10/15] tracing: Introduce kho serialization
Date: Wed, 13 Dec 2023 00:04:47 +0000
Message-ID: <20231213000452.88295-11-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_160709_052470_76021DA1 
X-CRM114-Status: GOOD (  16.03  )
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
 kernel/trace/trace.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7700ca1be2a5..3e7f61cf773e 100644
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
@@ -866,6 +867,10 @@ static struct tracer		*trace_types __read_mostly;
  */
 DEFINE_MUTEX(trace_types_lock);
 
+#ifdef CONFIG_FTRACE_KHO
+static bool trace_in_kho;
+#endif
+
 /*
  * serialize the access of the ring buffer
  *
@@ -10591,12 +10596,59 @@ void __init early_trace_init(void)
 	init_events();
 }
 
+#ifdef CONFIG_FTRACE_KHO
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
+#endif
+
 void __init trace_init(void)
 {
 	trace_event_init();
 
 	if (boot_instance_index)
 		enable_instances();
+
+#ifdef CONFIG_FTRACE_KHO
+	register_kho_notifier(&trace_kho_nb);
+#endif
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
