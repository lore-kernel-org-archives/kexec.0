Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C52DC4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s7LvrI/o5xFBHLzE23OiExHyw7/LMSIwO8LF77rFbuw=; b=ktgOOlh/JHu8q1
	PSIFZRVFL6EO4S/WQLJITBaeWrz2qMwOFwgykIBroDhFsiS+0BU5gpfiizYNX9FX51I3nH/dKejmT
	MAw+ETTgNb5t6b4IMlPtiruF4feuPaLQzR9q9BmBAGDL0NahuS2GTmPlmrv7kNrk9LQ5qz1NpnhCo
	xQVyOa01N2/v+1LHmjZkKzRwgpkXM9WbfWp/RQ9GdHtRgQRllrfOYAiLDW5QtIWHQTI7M7VDuQXP3
	JUHCC6kN8wWAmMo0YvkuNXwjyx8+urrXBcxJIxK8Feat+DZpKqSj52x2/lEFfGkbq7pwtrFQfi6mo
	Fv/WisSsZTadMgVkJ0aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCmo-00D8GS-0n;
	Wed, 13 Dec 2023 00:07:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCml-00D8Cv-18;
	Wed, 13 Dec 2023 00:07:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ijxY/skruFfgxp/KO2yhFBX0a87YYNVgJHNp25q/K2g=; b=VrOL6ZmPoyKk9Yz+aO/RtK2Lqx
	qbDww18lNY6mje0QMaX/i3N9u8ekPcUiWABL5EBEYCVBpjpEQdDfl20gtZQWAGnqmmf8mcu3xwYLy
	oiuOdn/MT34+7nJfnk18iOU56nBzqEtvJhSB0VRsqEFI+U8NL4irBFLcTInw6Gm3FoxzJEonmmI+e
	eThJjRqEsfM8gsSvkPbbfHVE0WSRTKJZWIArQRw1NP4KnBnx4NvUGF2/RhE4qE+Ixu1VoKZ3XFea0
	Vz32sIfPg6Vgdgz4yCuB7kddEyVBk9pTARPrFXnXmMZ0b40q/zq4ICbjtQBiesjDCrptba/ynR2RU
	CDDdSesw==;
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCmg-008sOk-3D;
	Wed, 13 Dec 2023 00:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426051; x=1733962051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ijxY/skruFfgxp/KO2yhFBX0a87YYNVgJHNp25q/K2g=;
  b=Vd8MHtcdaudKrb3RrBAHReqYpyUIwQIB4O6c9StD8QprE/Rvm/ivyBlQ
   dJC7gY1dinV1Y8B16b2MfPyGSpSkHDaPsRY9ITqmxjO4ghGqx7GH7KscC
   OtDNMKXCE+rFwYXqc0R6s+28ytDdZc9Yq32+pVXLSmPn2w+v/loJKdFJU
   c=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="50248355"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:07:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 96E81A0B0F;
	Wed, 13 Dec 2023 00:07:20 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:13591]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id d7626d9c-b144-446f-b11a-bed8a3932442; Wed, 13 Dec 2023 00:07:19 +0000 (UTC)
X-Farcaster-Flow-ID: d7626d9c-b144-446f-b11a-bed8a3932442
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:19 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:15 +0000
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
Subject: [PATCH 14/15] tracing: Recover trace events from kexec handover
Date: Wed, 13 Dec 2023 00:04:51 +0000
Message-ID: <20231213000452.88295-15-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_000731_982176_367E245D 
X-CRM114-Status: GOOD (  17.97  )
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

This patch implements all logic necessary to match a new trace event
that we add against preserved trace events from kho. If we find a match,
we give the new trace event the old event's identifier. That way, trace
read-outs are able to make sense of buffer contents again because the
parsing code for events looks at the same identifiers.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/trace/trace_output.c | 65 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 113de40c616f..d2e2a6346322 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -749,6 +749,67 @@ void trace_event_read_unlock(void)
 	up_read(&trace_event_sem);
 }
 
+/**
+ * trace_kho_fill_event_type - restore event type info from KHO
+ * @event: the event type to enumerate
+ *
+ * Event types are semi-dynamically generated. To ensure that
+ * their identifiers match before and after kexec with KHO,
+ * let's match up unique name identifiers and fill in the
+ * respective ID information if we booted with KHO.
+ */
+static bool trace_kho_fill_event_type(struct trace_event *event)
+{
+#ifdef CONFIG_FTRACE_KHO
+	const char *path = "/ftrace/events";
+	void *fdt = kho_get_fdt();
+	int err, len, off, id;
+	const void *p;
+
+	if (!fdt)
+		return false;
+
+	if (WARN_ON(!event->name))
+		return false;
+
+	pr_debug("Trying to revive event '%s'", event->name);
+
+	off = fdt_path_offset(fdt, path);
+	if (off < 0) {
+		pr_debug("Could not find '%s' in DT", path);
+		return false;
+	}
+
+	err = fdt_node_check_compatible(fdt, off, "ftrace,events-v1");
+	if (err) {
+		pr_warn("Node '%s' has invalid compatible", path);
+		return false;
+	}
+
+	p = fdt_getprop(fdt, off, event->name, &len);
+	if (!p) {
+		pr_warn("Event '%s' not found", event->name);
+		return false;
+	}
+
+	if (len != sizeof(event->type)) {
+		pr_warn("Event '%s' has invalid length", event->name);
+		return false;
+	}
+
+	id = *(const u32 *)p;
+
+	/* Mark ID as in use */
+	if (ida_alloc_range(&trace_event_ida, id, id, GFP_KERNEL) != id)
+		return false;
+
+	event->type = id;
+	return true;
+#endif
+
+	return false;
+}
+
 /**
  * register_trace_event - register output for an event type
  * @event: the event type to register
@@ -777,7 +838,9 @@ int register_trace_event(struct trace_event *event)
 	if (WARN_ON(!event->funcs))
 		goto out;
 
-	if (!event->type) {
+	if (trace_kho_fill_event_type(event)) {
+		pr_debug("Recovered '%s' as id=%d", event->name, event->type);
+	} else if (!event->type) {
 		event->type = alloc_trace_event_type();
 		if (!event->type)
 			goto out;
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
