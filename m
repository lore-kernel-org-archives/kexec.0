Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D6EC46CD8
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fFFYvgw5GdaEqUz0GS/WOvC4TncVo7Ua2B9CpBH75ZA=; b=mKkO9naCO/KGHG
	n7HkiIGrO/viGfNzw5lE5gxgz7YzsRZ3H5Rzfqi8YhxcnaChqGPNNw+Z4PNX1FaoLThktWnvCXCtX
	9+tOAdMsy6GfQh9YZXZFOo4a0ykDKGhEdX08vsw4nMnoqce+QIBi4rhhBm2OKa/+vH5AT0kiaxwe3
	ZTVucYJ69RVhLeeRQSBb016gXRK/cyo1tushAd1jjdiYHXIsWEPOmsPUHPGvbylpPprKNp3t+jEJk
	oa+JPafPUhIbb0yQPgQNyviouAzPwS5zAH/lfs+ds/3F627TDVfkJrHwF+vw6WB8WJvv3LQXqggF3
	3jlI0omx4S6vaBGd/C8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlZe-006l3x-1A;
	Fri, 22 Dec 2023 19:52:46 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlZY-006kyT-04;
	Fri, 22 Dec 2023 19:52:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703274760; x=1734810760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmhUZjf5F0irRMFPH4YUunFpNZODTBv7SKMl/vOJmCU=;
  b=DZRtWwrHDbeJZ7Kiu3qm0w1oqMzmDwUgILe68nCq3rnvP8iIAmvFKR7g
   EeCqvMM14rOzGHaBMcpBn4nfvfAGp7++DRi8C78/ATDQ6gamcz7BDsceo
   J8yb88i+4wsUT07oREBsaqzbz7bGNmKVBS0BRC7/94nIRfgXzSlHZ8aD2
   I=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="602627243"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:52:39 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id E5434498C1;
	Fri, 22 Dec 2023 19:52:31 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:18611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.30:2525] with esmtp (Farcaster)
 id 881e61d8-d7c5-43dd-85b6-cb73d6682b26; Fri, 22 Dec 2023 19:52:30 +0000 (UTC)
X-Farcaster-Flow-ID: 881e61d8-d7c5-43dd-85b6-cb73d6682b26
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:52:30 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:52:26 +0000
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
Subject: [PATCH v2 11/17] tracing: Introduce kho serialization
Date: Fri, 22 Dec 2023 19:51:38 +0000
Message-ID: <20231222195144.24532-6-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222195144.24532-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_115240_197882_36AB0304 
X-CRM114-Status: GOOD (  15.89  )
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
index 199df497db07..6ec31879b4eb 100644
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
@@ -10560,12 +10563,56 @@ void __init early_trace_init(void)
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
