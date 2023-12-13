Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D346FC4167D
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZL/+KMGw7fQYmkx8bo4zNDoGJGJ00LyaSKWNrhiRiRE=; b=2CawS0zBZMqEJ6
	0H8L6g0K/hLavrQ1jzAhPFDrF3SmEt1EpnW+8QD2IZNI+FGo+7EBkpFQrUSosV7o45Co0Z4Mjnca9
	fVLxcLUAOCo7LTGmMS+iBRKLIlJZsr4PKwEw26Pf8Ee7etcPP+9VcOsXZsSGuXh7bLZXKIgyjtH5h
	0LCkidaZNGKHXmkA/YXErIBJyyQwQjlxQAnPTkP7/At5yuyaMzZxQxrT/eLeYRMXCG/RukzepFsKD
	FQF37hS1srSMgn3zeNMOkxfNCoRhxY/rtQDkxvty+9Oq5gVEHgP/4mcTJ7V6J4R0d9Hdhvlh+P8j1
	zc4LfkxwtzggXMXc24NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCls-00D7fz-0g;
	Wed, 13 Dec 2023 00:06:40 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDClm-00D7bi-1D;
	Wed, 13 Dec 2023 00:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702425995; x=1733961995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHxE/iueMjg5jk3J7QeMpZujdfbmXnsIes6SvH8utzQ=;
  b=X/LCBsT9TxNgfbo7kUbPdNi/YPILwe0/6w0qrNmm2NdyCfAvP+4a4Zx3
   YixVxVrk/o2gmVMNE81u/UxLmR6TY8uoVKO5j/iILuYSWUi5u6nfd/iXZ
   NTgbUH/Htht3bRRnXoW2osOWJG0wY2MtinAis0G43Gv4t1XH0wyFiU9dY
   4=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="382524268"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:06:27 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id E9CFD8179B;
	Wed, 13 Dec 2023 00:06:13 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:11247]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.147:2525] with esmtp (Farcaster)
 id 7d1c1fe5-8e35-45c9-ab5b-5b98cbcd951c; Wed, 13 Dec 2023 00:06:12 +0000 (UTC)
X-Farcaster-Flow-ID: 7d1c1fe5-8e35-45c9-ab5b-5b98cbcd951c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:12 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:08 +0000
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
Subject: [PATCH 08/15] tracing: Introduce names for ring buffers
Date: Wed, 13 Dec 2023 00:04:45 +0000
Message-ID: <20231213000452.88295-9-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_160634_478608_D87130B5 
X-CRM114-Status: GOOD (  18.14  )
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

With KHO (Kexec HandOver), we want to preserve trace buffers across
kexec. To carry over their state between kernels, the kernel needs a
common handle for them that exists on both sides. As handle we introduce
names for ring buffers. In a follow-up patch, the kernel can then use
these names to recover buffer contents for specific ring buffers.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/ring_buffer.h | 7 ++++---
 kernel/trace/ring_buffer.c  | 5 ++++-
 kernel/trace/trace.c        | 7 ++++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..f34538f97c75 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -85,17 +85,18 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
  * size is in bytes for each per CPU buffer.
  */
 struct trace_buffer *
-__ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *key);
+__ring_buffer_alloc(const char *name, unsigned long size, unsigned flags,
+		    struct lock_class_key *key);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
  * ring buffer's lock class separate.
  */
-#define ring_buffer_alloc(size, flags)			\
+#define ring_buffer_alloc(name, size, flags)			\
 ({							\
 	static struct lock_class_key __key;		\
-	__ring_buffer_alloc((size), (flags), &__key);	\
+	__ring_buffer_alloc((name), (size), (flags), &__key);	\
 })
 
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43cc47d7faaf..eaaf823ddedb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -557,6 +557,7 @@ struct trace_buffer {
 
 	struct rb_irq_work		irq_work;
 	bool				time_stamp_abs;
+	const char			*name;
 };
 
 struct ring_buffer_iter {
@@ -1801,7 +1802,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
  * when the buffer wraps. If this flag is not set, the buffer will
  * drop data when the tail hits the head.
  */
-struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
+struct trace_buffer *__ring_buffer_alloc(const char *name,
+					unsigned long size, unsigned flags,
 					struct lock_class_key *key)
 {
 	struct trace_buffer *buffer;
@@ -1823,6 +1825,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
+	buffer->name = name;
 
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..7700ca1be2a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9384,7 +9384,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 
 	buf->tr = tr;
 
-	buf->buffer = ring_buffer_alloc(size, rb_flags);
+	buf->buffer = ring_buffer_alloc(tr->name ? tr->name : "global_trace",
+					size, rb_flags);
 	if (!buf->buffer)
 		return -ENOMEM;
 
@@ -9421,7 +9422,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	ret = allocate_trace_buffer(tr, &tr->max_buffer,
+	ret = allocate_trace_buffer(NULL, &tr->max_buffer,
 				    allocate_snapshot ? size : 1);
 	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
 		free_trace_buffer(&tr->array_buffer);
@@ -10473,7 +10474,7 @@ __init static int tracer_alloc_buffers(void)
 		goto out_free_cpumask;
 	/* Used for event triggers */
 	ret = -ENOMEM;
-	temp_buffer = ring_buffer_alloc(PAGE_SIZE, RB_FL_OVERWRITE);
+	temp_buffer = ring_buffer_alloc("temp_buffer", PAGE_SIZE, RB_FL_OVERWRITE);
 	if (!temp_buffer)
 		goto out_rm_hp_state;
 
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
