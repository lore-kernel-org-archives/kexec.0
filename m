Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB48C47DA2
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pm/K4yfIHaiSSjJcPvHLcbMTHV0H5WTbVWRxg8FtRBM=; b=sK8TkOwtf/9GtP
	uG/WILDlIHoF5eqEUeS7wolpzt8ndMLb3A6htlrhV/uJieBmCNvbB6YttylqGWFQO0ML/LMe15Oel
	2b+wEEASEPKD+4M9GyXsv9JS4qhOiqGVQJk+feciXr/Q+ME13+z5MEsmGUhmOgmbafPCgZ4/FNwV4
	ckoA+hUR8WswU2NIhB3EU7gDVSXMSNg6jsEzi5q6VQfQtmCWYfG709a2B1ht1k3My6exkZ4Mi9Fzw
	zgbQZGA22v+tiGKPu4Jg9IQC0K5VBgl9dhEWOL6ZMrEwEr5xoNp5eJSa3QtNvE4xpF1g514JMOrKf
	Xu8My/rHFwjPklQMuPWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7E9-00HILc-2i;
	Wed, 17 Jan 2024 14:49:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7E8-00HIJR-1l;
	Wed, 17 Jan 2024 14:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9pczdVAxGtp8vop5MUdkuCtVFQ4MsLa5wqYfeungQ1E=; b=WC3t8QwsLShz1E6O7oDftAE4om
	frF7zPucplOMgti5kMO5CcWozmRUVuhBm+9UFWFAtYMZ/wOaURan63AODHgEi9bDPPTMYXfLwYvdP
	VaGgkyrlD1gJ1m51vN+NSRx8+6mcm3nPk3i8SrBsMvAuc4SmJAm0xToqvKCMRtOBWhZqJlKfYWkwR
	WDAtZXrPIf2Nk1dlvivS3vnuIa+4Mav9gplALe+cPUZMa18L2IgckS5JwNcLNcpsDTFyF2/EZH7Q6
	1pTL3kjhZMqgaq65FaqN00QVWxWF6kHivmFxObJGg+/oWAkHV9fOWFWPkBWTruumxSoJnDX6WHmX7
	QO5Lu2HQ==;
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQ7E2-00000000VC7-0XQB;
	Wed, 17 Jan 2024 14:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502946; x=1737038946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pczdVAxGtp8vop5MUdkuCtVFQ4MsLa5wqYfeungQ1E=;
  b=qe37UbFCPGwtDaQyT9B0N+Nk/bxAADE9rT7hkfAWcHGqVxw29OEMSx4x
   QGBzStWZtSSL3o2otKcpY/JK1r+Uo00wEkUX5FWF9RA1yevMV4pLCeyfg
   tA0nBFS703mSZYeJ7Us6CiaSKGil8Ln+ATcLh1VH7EqpcLZhTlLXzFgOK
   U=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="58930320"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:49:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id D8D0D8A8A0;
	Wed, 17 Jan 2024 14:48:55 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:63007]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.164:2525] with esmtp (Farcaster)
 id 5adc92f8-d4ed-40f7-9a1d-c28ae39974fc; Wed, 17 Jan 2024 14:48:55 +0000 (UTC)
X-Farcaster-Flow-ID: 5adc92f8-d4ed-40f7-9a1d-c28ae39974fc
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:55 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:48:51 +0000
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
Subject: [PATCH v3 10/17] tracing: Initialize fields before registering
Date: Wed, 17 Jan 2024 14:46:57 +0000
Message-ID: <20240117144704.602-11-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_144906_527850_C6AB619E 
X-CRM114-Status: GOOD (  20.81  )
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

With KHO, we need to know all event fields before we allocate an event
type for a trace event so that we can recover it based on a previous
execution context.

Before this patch, fields were only initialized after we allocated a
type id. After this patch, we try to allocate it early as well.

This patch leaves the old late initialization logic in place. The field
init code already validates whether there are any fields present, which
means it's legal to call it multiple times. This way we're sure we don't
miss any call sites.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/trace_events.h      |  1 +
 kernel/trace/trace_events.c       | 14 +++++++++-----
 kernel/trace/trace_events_synth.c | 14 +++++++++-----
 kernel/trace/trace_events_user.c  |  4 ++++
 kernel/trace/trace_probe.c        |  4 ++++
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..8fe8970b48e3 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -842,6 +842,7 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
+extern int trace_event_define_fields(struct trace_event_call *call);
 
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f29e815ca5b2..fbf8be1d2806 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -462,6 +462,11 @@ static void test_event_printk(struct trace_event_call *call)
 int trace_event_raw_init(struct trace_event_call *call)
 {
 	int id;
+	int ret;
+
+	ret = trace_event_define_fields(call);
+	if (ret)
+		return ret;
 
 	id = register_trace_event(&call->event);
 	if (!id)
@@ -2402,8 +2407,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	return NULL;
 }
 
-static int
-event_define_fields(struct trace_event_call *call)
+int trace_event_define_fields(struct trace_event_call *call)
 {
 	struct list_head *head;
 	int ret = 0;
@@ -2592,7 +2596,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 
 	file->ei = ei;
 
-	ret = event_define_fields(call);
+	ret = trace_event_define_fields(call);
 	if (ret < 0) {
 		pr_warn("Could not initialize trace point events/%s\n", name);
 		return ret;
@@ -2978,7 +2982,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 	if (eventdir_initialized)
 		return event_create_dir(tr->event_dir, file);
 	else
-		return event_define_fields(call);
+		return trace_event_define_fields(call);
 }
 
 static void trace_early_triggers(struct trace_event_file *file, const char *name)
@@ -3015,7 +3019,7 @@ __trace_early_add_new_event(struct trace_event_call *call,
 	if (!file)
 		return -ENOMEM;
 
-	ret = event_define_fields(call);
+	ret = trace_event_define_fields(call);
 	if (ret)
 		return ret;
 
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e7af286af4f1..debfe852b0d8 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -880,17 +880,21 @@ static int register_synth_event(struct synth_event *event)
 	INIT_LIST_HEAD(&call->class->fields);
 	call->event.funcs = &synth_event_funcs;
 	call->class->fields_array = synth_event_fields_array;
+	call->flags = TRACE_EVENT_FL_TRACEPOINT;
+	call->class->reg = trace_event_reg;
+	call->class->probe = trace_event_raw_event_synth;
+	call->data = event;
+	call->tp = event->tp;
+
+	ret = trace_event_define_fields(call);
+	if (ret)
+		goto out;
 
 	ret = register_trace_event(&call->event);
 	if (!ret) {
 		ret = -ENODEV;
 		goto out;
 	}
-	call->flags = TRACE_EVENT_FL_TRACEPOINT;
-	call->class->reg = trace_event_reg;
-	call->class->probe = trace_event_raw_event_synth;
-	call->data = event;
-	call->tp = event->tp;
 
 	ret = trace_add_event_call(call);
 	if (ret) {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e76f5e1efdf2..7b7e13260932 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1900,6 +1900,10 @@ static int user_event_trace_register(struct user_event *user)
 {
 	int ret;
 
+	ret = trace_event_define_fields(&user->call);
+	if (ret)
+		return ret;
+
 	ret = register_trace_event(&user->call.event);
 
 	if (!ret)
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..da73a02246d8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1835,6 +1835,10 @@ int trace_probe_register_event_call(struct trace_probe *tp)
 				  trace_probe_name(tp)))
 		return -EEXIST;
 
+	ret = trace_event_define_fields(call);
+	if (ret)
+		return ret;
+
 	ret = register_trace_event(&call->event);
 	if (!ret)
 		return -ENODEV;
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
