Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A709C41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KwkNYMiLQ1ue5GuhM761qXQbO/ykQh71RCeSTWC2/7Q=; b=vg+1UFvJOmuQml
	JOTKUyk9Gfbl41B2wxp6GWvtzlysDzqP2ClhbV0ooCySi9HIkLgOzWUzjy++PdyDJ7VDS5hdPDuYx
	qLN9WZRruWItFiR2ebt2SZAmeHDE5K4uRV++a2F2n2AI4g2psvpLfDJxm3a4zG0i5OYks4R+CHrkn
	kTjbYnPII8kcLDx8tnqVTFaUj4JtJDjmKiDjZSmcSoacPiT/RhOaN/q+4GbN1Um6rRRbGPt9jOGGg
	kW2tuXocyueoL5WCvjRpfTocnZAKUXemjYAl0XHZbBr2XjTiYG8C1dLajneROTXOVVsNYze4Oqs8G
	P6Yqyq0ivXvqEo3GbGXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlLU-006ixA-1R;
	Fri, 22 Dec 2023 19:38:08 +0000
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlLP-006isN-2j;
	Fri, 22 Dec 2023 19:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273884; x=1734809884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwhP9TX+qhNuxIBvRPP4G1COkpJHtM0yxRM6jOIEYyk=;
  b=Ov2om9X46gGrX3w9PqWqvmcOr7cO5BK9ZKKKdCfR7HJOgMSHzjBv6ZDx
   7Rup92KFw51O1ffCjsve0JiBN5Ps1jl8WE3JEcNJHDTwJUNZwtF45vp0Y
   F9XUSss3VZMtfATeMe763FXNkUsOHOH8F/vV2wypDCCno/CHbtiRUAUKg
   w=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="262157740"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:38:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id BDB358B25B;
	Fri, 22 Dec 2023 19:37:58 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:5256]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.144:2525] with esmtp (Farcaster)
 id ce48a30f-05bb-48a3-9e16-f52e7034e6f9; Fri, 22 Dec 2023 19:37:58 +0000 (UTC)
X-Farcaster-Flow-ID: ce48a30f-05bb-48a3-9e16-f52e7034e6f9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:58 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:37:54 +0000
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
Subject: [PATCH v2 10/17] tracing: Initialize fields before registering
Date: Fri, 22 Dec 2023 19:36:00 +0000
Message-ID: <20231222193607.15474-11-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222193607.15474-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_113803_938334_5B718BF7 
X-CRM114-Status: GOOD (  20.33  )
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
index 846e02c0fb59..4db41218ccf7 100644
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
index 9365ce407426..b9837e987525 100644
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
