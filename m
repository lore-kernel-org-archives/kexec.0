Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBA3C46CD8
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bNSXh1IbMarO3QelYGLKCQY5YiBrsoHIEcZeeERyd8U=; b=Vk0FhR81Uaaujz
	JZQ9fZFgrAg+eAHlKXjiE9iYyeth8P4kNll+iV3xBADdVnYkwjdDjDxeZ9Q6hQq839xppkUHyuI2p
	0kk7H2XJAwACg2v9lx5+qW5M36wt7l8keSnFEyQYmCQsZW55HEVKHZC+SL5lBQsnXrK+hoVSQ00IQ
	CU7748oMSUq77DyJzZacXr4oAUZvgnuLB68EIn/fTOLkKGyNTIOXENSsk3KKn4CgbEMyNtfjU6Ayq
	BsbTV1Q4PbWNP9RaYvMewTXSUO75Kjw33NeVXn+67JnfoCOakMr7y6E1M+uz0Zv3Cb2+9OtVfli0P
	YIKqMKilKbyfQTPIOHQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlaC-006lTl-2S;
	Fri, 22 Dec 2023 19:53:20 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGla4-006lLw-0a;
	Fri, 22 Dec 2023 19:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703274792; x=1734810792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmWS8dZ9jK84BAKLfSbbK2PJywlEcHQnIlXSuHEMw/A=;
  b=ZA+2na76H4K98Wh849AfON1CAQAh2x0CQtlavv44fhS9nIZer6Wqe4cZ
   s2Bpsf2ndfz0jbNbEIbuh+33M605ESB/TeJQ4ScjkBGl28a4lOIYn44rB
   or2l48WRLATk8QofGfC7G4kEKScMJjh4z4XlgC93ghEYwhNOK/URDqi+G
   w=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="53453679"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:53:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 55927804E1;
	Fri, 22 Dec 2023 19:53:02 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:14717]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.30:2525] with esmtp (Farcaster)
 id a9f26b86-9fc7-4cad-9223-cfbee1a06d30; Fri, 22 Dec 2023 19:53:01 +0000 (UTC)
X-Farcaster-Flow-ID: a9f26b86-9fc7-4cad-9223-cfbee1a06d30
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:53:00 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:52:56 +0000
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
Subject: [PATCH v2 13/17] tracing: Recover trace buffers from kexec handover
Date: Fri, 22 Dec 2023 19:51:40 +0000
Message-ID: <20231222195144.24532-8-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222195144.24532-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_115312_314144_E09E4A45 
X-CRM114-Status: GOOD (  30.84  )
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

When kexec handover is in place, we now know the location of all
previous buffers for ftrace rings. With this patch applied, ftrace
reassembles any new trace buffer that carries the same name as a
previous one with the same data pages that the previous buffer had.

That way, a buffer that we had in place before kexec becomes readable
after kexec again as soon as it gets initialized with the same name.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Move from names to fdt offsets. That way, trace.c can find the trace
    array offset and then the ring buffer code only needs to read out
    its per-CPU data. That way it can stay oblivient to its name.
  - Make kho_get_fdt() const
  - Remove ifdefs
---
 include/linux/ring_buffer.h |  15 ++--
 kernel/trace/ring_buffer.c  | 171 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.c        |  32 ++++++-
 3 files changed, 206 insertions(+), 12 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 1c5eb33f0cb5..f6d6ce441890 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -84,20 +84,23 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
 /*
  * size is in bytes for each per CPU buffer.
  */
-struct trace_buffer *
-__ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *key);
+struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
+					 struct lock_class_key *key,
+					 int tr_off);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
  * ring buffer's lock class separate.
  */
-#define ring_buffer_alloc(size, flags)			\
-({							\
-	static struct lock_class_key __key;		\
-	__ring_buffer_alloc((size), (flags), &__key);	\
+#define ring_buffer_alloc_kho(size, flags, tr_off)		\
+({								\
+	static struct lock_class_key __key;			\
+	__ring_buffer_alloc((size), (flags), &__key, tr_off);	\
 })
 
+#define ring_buffer_alloc(size, flags) ring_buffer_alloc_kho(size, flags, 0)
+
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 971af7ee35da..4c62a66068a7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -558,6 +558,7 @@ struct trace_buffer {
 
 	struct rb_irq_work		irq_work;
 	bool				time_stamp_abs;
+	int				tr_off;
 };
 
 struct ring_buffer_iter {
@@ -574,6 +575,15 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+struct rb_kho_cpu {
+	const struct kho_mem *mem;
+	uint32_t nr_mems;
+};
+
+static int rb_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
+				     struct rb_kho_cpu *kho);
+static int rb_kho_read_cpu(int tr_off, int cpu, struct rb_kho_cpu *kho);
+
 #ifdef RB_TIME_32
 
 /*
@@ -1762,12 +1772,15 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
  * drop data when the tail hits the head.
  */
 struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
-					struct lock_class_key *key)
+					 struct lock_class_key *key,
+					 int tr_off)
 {
+	int cpu = raw_smp_processor_id();
+	struct rb_kho_cpu kho = {};
 	struct trace_buffer *buffer;
+	bool use_kho = false;
 	long nr_pages;
 	int bsize;
-	int cpu;
 	int ret;
 
 	/* keep it in its own cache line */
@@ -1780,9 +1793,16 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 		goto fail_free_buffer;
 
 	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
+	if (!rb_kho_read_cpu(tr_off, cpu, &kho) && kho.nr_mems > 4) {
+		nr_pages = kho.nr_mems / 2;
+		use_kho = true;
+		pr_debug("Using kho on CPU [%03d]", cpu);
+	}
+
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
+	buffer->tr_off = tr_off;
 
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
@@ -1799,12 +1819,14 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	if (!buffer->buffers)
 		goto fail_free_cpumask;
 
-	cpu = raw_smp_processor_id();
 	cpumask_set_cpu(cpu, buffer->cpumask);
 	buffer->buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 	if (!buffer->buffers[cpu])
 		goto fail_free_buffers;
 
+	if (use_kho && rb_kho_replace_buffers(buffer->buffers[cpu], &kho))
+		pr_warn("Could not revive all previous trace data");
+
 	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 	if (ret < 0)
 		goto fail_free_buffers;
@@ -5818,7 +5840,9 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page);
  */
 int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 {
+	struct rb_kho_cpu kho = {};
 	struct trace_buffer *buffer;
+	bool use_kho = false;
 	long nr_pages_same;
 	int cpu_i;
 	unsigned long nr_pages;
@@ -5842,6 +5866,12 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	/* allocate minimum pages, user can later expand it */
 	if (!nr_pages_same)
 		nr_pages = 2;
+
+	if (!rb_kho_read_cpu(buffer->tr_off, cpu, &kho) && kho.nr_mems > 4) {
+		nr_pages = kho.nr_mems / 2;
+		use_kho = true;
+	}
+
 	buffer->buffers[cpu] =
 		rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 	if (!buffer->buffers[cpu]) {
@@ -5849,13 +5879,143 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 		     cpu);
 		return -ENOMEM;
 	}
+
+	if (use_kho && rb_kho_replace_buffers(buffer->buffers[cpu], &kho))
+		pr_warn("Could not revive all previous trace data");
+
 	smp_wmb();
 	cpumask_set_cpu(cpu, buffer->cpumask);
 	return 0;
 }
 
-#ifdef CONFIG_FTRACE_KHO
-static int rb_kho_write_cpu(void *fdt, struct trace_buffer *buffer, int cpu)
+static int rb_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
+				     struct rb_kho_cpu *kho)
+{
+	bool first_loop = true;
+	struct list_head *tmp;
+	int err = 0;
+	int i = 0;
+
+	if (!IS_ENABLED(CONFIG_FTRACE_KHO))
+		return -EINVAL;
+
+	if (kho->nr_mems != cpu_buffer->nr_pages * 2)
+		return -EINVAL;
+
+	for (tmp = rb_list_head(cpu_buffer->pages);
+	     tmp != rb_list_head(cpu_buffer->pages) || first_loop;
+	     tmp = rb_list_head(tmp->next), first_loop = false) {
+		struct buffer_page *bpage = (struct buffer_page *)tmp;
+		const struct kho_mem *mem_bpage = &kho->mem[i++];
+		const struct kho_mem *mem_page = &kho->mem[i++];
+		const uint64_t rb_page_head = 1;
+		struct buffer_page *old_bpage;
+		void *old_page;
+
+		old_bpage = __va(mem_bpage->addr);
+		if (!bpage)
+			goto out;
+
+		if ((ulong)old_bpage->list.next & rb_page_head) {
+			struct list_head *new_lhead;
+			struct buffer_page *new_head;
+
+			new_lhead = rb_list_head(bpage->list.next);
+			new_head = (struct buffer_page *)new_lhead;
+
+			/* Assume the buffer is completely full */
+			cpu_buffer->tail_page = bpage;
+			cpu_buffer->commit_page = bpage;
+			/* Set the head pointers to what they were before */
+			cpu_buffer->head_page->list.prev->next = (struct list_head *)
+				((ulong)cpu_buffer->head_page->list.prev->next & ~rb_page_head);
+			cpu_buffer->head_page = new_head;
+			bpage->list.next = (struct list_head *)((ulong)new_lhead | rb_page_head);
+		}
+
+		if (rb_page_entries(old_bpage) || rb_page_write(old_bpage)) {
+			/*
+			 * We want to recycle the pre-kho page, it contains
+			 * trace data. To do so, we unreserve it and swap the
+			 * current data page with the pre-kho one
+			 */
+			old_page = kho_claim_mem(mem_page);
+
+			/* Recycle the old page, it contains data */
+			free_page((ulong)bpage->page);
+			bpage->page = old_page;
+
+			bpage->write = old_bpage->write;
+			bpage->entries = old_bpage->entries;
+			bpage->real_end = old_bpage->real_end;
+
+			local_inc(&cpu_buffer->pages_touched);
+		} else {
+			kho_return_mem(mem_page);
+		}
+
+		kho_return_mem(mem_bpage);
+	}
+
+out:
+	return err;
+}
+
+static int rb_kho_read_cpu(int tr_off, int cpu, struct rb_kho_cpu *kho)
+{
+	const void *fdt = kho_get_fdt();
+	int mem_len;
+	int err = 0;
+	char *path;
+	int off;
+
+	if (!IS_ENABLED(CONFIG_FTRACE_KHO))
+		return -EINVAL;
+
+	if (!tr_off || !fdt || !kho)
+		return -EINVAL;
+
+	path = kasprintf(GFP_KERNEL, "cpu%x", cpu);
+	if (!path)
+		return -ENOMEM;
+
+	pr_debug("Trying to revive trace cpu '%s'", path);
+
+	off = fdt_subnode_offset(fdt, tr_off, path);
+	if (off < 0) {
+		pr_debug("Could not find '%s' in DT", path);
+		err = -ENOENT;
+		goto out;
+	}
+
+	err = fdt_node_check_compatible(fdt, off, "ftrace,cpu-v1");
+	if (err) {
+		pr_warn("Node '%s' has invalid compatible", path);
+		err = -EINVAL;
+		goto out;
+	}
+
+	kho->mem = fdt_getprop(fdt, off, "mem", &mem_len);
+	if (!kho->mem) {
+		pr_warn("Node '%s' has invalid mem property", path);
+		err = -EINVAL;
+		goto out;
+	}
+
+	kho->nr_mems = mem_len / sizeof(*kho->mem);
+
+	/* Should follow "bpage 0, page 0, bpage 1, page 1, ..." pattern */
+	if ((kho->nr_mems & 1)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+out:
+	kfree(path);
+	return err;
+}
+
+static int __maybe_unused rb_kho_write_cpu(void *fdt, struct trace_buffer *buffer, int cpu)
 {
 	int i = 0;
 	int err = 0;
@@ -5915,6 +6075,7 @@ static int rb_kho_write_cpu(void *fdt, struct trace_buffer *buffer, int cpu)
 	return err;
 }
 
+#ifdef CONFIG_FTRACE_KHO
 int ring_buffer_kho_write(void *fdt, struct trace_buffer *buffer)
 {
 	int err, i;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2ccea4c1965b..94e30dfacfd1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9348,16 +9348,46 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+static int trace_kho_off_tr(struct trace_array *tr)
+{
+	const char *name = tr->name ? tr->name : "global_trace";
+	const void *fdt = kho_get_fdt();
+	char *path;
+	int off;
+
+	if (!IS_ENABLED(CONFIG_FTRACE_KHO))
+		return 0;
+
+	if (!fdt)
+		return 0;
+
+	path = kasprintf(GFP_KERNEL, "/ftrace/%s", name);
+	if (!path)
+		return -ENOMEM;
+
+	pr_debug("Trying to revive trace buffer '%s'", path);
+
+	off = fdt_path_offset(fdt, path);
+	if (off < 0) {
+		pr_debug("Could not find '%s' in DT", path);
+		off = 0;
+	}
+
+	kfree(path);
+	return off;
+}
+
 static int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
 {
+	int tr_off = trace_kho_off_tr(tr);
 	enum ring_buffer_flags rb_flags;
 
 	rb_flags = tr->trace_flags & TRACE_ITER_OVERWRITE ? RB_FL_OVERWRITE : 0;
 
 	buf->tr = tr;
 
-	buf->buffer = ring_buffer_alloc(size, rb_flags);
+	buf->buffer = ring_buffer_alloc_kho(size, rb_flags, tr_off);
 	if (!buf->buffer)
 		return -ENOMEM;
 
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
