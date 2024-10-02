Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7E7CF6D3D
	for <kexec@archiver.kernel.org>; Wed,  2 Oct 2024 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7C29n5QVdDrgi3zJqBGVUweZKyKrIRhKfE8A0dUuoOI=; b=dLbDms8UfqIuJe
	lfsvY3YqtJCYwNg8vgfWc4LJxrLxT6/qP/NxlXH59YoyMDo2r4wgokVi+zQcyD0VTwdj3r4aAXEqT
	BaX9cc7xQ/aDizoRi/BcbIiiz9iuzLu5CB2hfeQ9cyVlgN/NHkL/i2y6qrO5qbpg232SYH/As/sch
	5zoxOSgMkUOWi2EREDeFFEJsT1XTwhHMg18IIeNh1CacZ/0TX0Rf0WObiRK5l/+PFFB54EGPrM15F
	SPYusf1cnuIzAyW7qTLUQiPf925yyaEuyVdonBpQSjU0AeDgLyj8O8XU1oxT/pLDS4On4SpcND2Dd
	4xnvJMObSvmxZgMoRqQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1ud-00000006rhK-3GLh;
	Wed, 02 Oct 2024 16:09:15 +0000
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1uY-00000006rZZ-0TuJ
	for kexec@lists.infradead.org;
	Wed, 02 Oct 2024 16:09:13 +0000
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9F16460949;
	Wed,  2 Oct 2024 19:09:08 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-ueku0Pjg;
	Wed, 02 Oct 2024 19:09:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885347;
	bh=r6KOHiXGwu9wJr+jMWOsPrgnVfkjQk3UoBVxWjKVRQc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=F5+i2ZBr2Uq7UPOSwZbgC7ZA0tYzgqL47KGhDszAsbQa6F6J/7vbR7Ko3bOmn6riv
	 8JQEDe8b3xruR/nSABrpSw17jrHYUuNZVIz8HuRdoAPk5CYiB7gV3oWoy60iWQ6ke4
	 u3C0/g9G/pAFLeQBOSS9YnP/FYBQuMXxxe4R9D2w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 7/7] trace: migrate trace buffers across kexec
Date: Wed,  2 Oct 2024 18:07:22 +0200
Message-ID: <20241002160722.20025-8-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002160722.20025-1-arbn@yandex-team.com>
References: <20241002160722.20025-1-arbn@yandex-team.com>
MIME-Version: 1.0
X-Yandex-Filter: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_090910_591131_0E9C7F88 
X-CRM114-Status: GOOD (  21.55  )
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

This is a demonstration of kstate capabilities to migrate across
kexec something more complex rather than simple structure like
in the lib/test_kstate.c module.

Here we migrate tracing_on/current_trace and content of the
trace buffers to the new kernel

The 'global_trace_state' describes 'tracing_on' and 'current_trace'
states. The 'trace_buffer' kstate field in 'global_trace_state'
points to 'kstate_trace_buffer' describing the state of ring buffers.

The code in kstate_rb_[save/restore]() saves and restore list of buffer
pages. It turned out to be somewhat hacky and ugly, partially because
kstate currently can't migrate slab data. So because of that we have
to save/restore positions of commit_page/reader_page/etc in the list
of pages. We could probably teach kstate to migrate slab pages, preserving
contents at the same address, which would make easier to migrate lists
like the ring buffer list in the trace, as we would need to save/restore
only pointer.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h     |   4 +
 kernel/trace/ring_buffer.c | 189 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c       |  81 ++++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 2ddbe41a1f171..ae807a75a02f8 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -32,6 +32,10 @@ enum kstate_ids {
 	KSTATE_PAGE_ID,
 	KSTATE_RSVD_MEM_ID,
 	KSTATE_TEST_ID,
+	KSTATE_TRACE_ID,
+	KSTATE_TRACE_BUFFER_ID,
+	KSTATE_TRACE_RING_BUFFER_ID,
+	KSTATE_TRACE_BUFFER_PAGE_ID,
 	KSTATE_LAST_ID = -1,
 };
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 77dc0b25140e6..9a8692d7d960c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
+#include <linux/kstate.h>
 #include <linux/kthread.h>	/* for self test */
 #include <linux/module.h>
 #include <linux/percpu.h>
@@ -1467,6 +1468,194 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 }
 
+#ifdef CONFIG_KSTATE
+static int kstate_bpage_save(void *mig_stream, void *obj, const struct kstate_field *field)
+{
+	struct buffer_page *bpage = obj;
+
+	kstate_register_page(virt_to_page(bpage->page), bpage->order);
+	return 0;
+
+}
+struct kstate_description kstate_buffer_page = {
+	.name = "buffer_page",
+	.id = KSTATE_TRACE_BUFFER_PAGE_ID,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_SIMPLE(write, struct buffer_page),
+		KSTATE_SIMPLE(read, struct buffer_page),
+		KSTATE_SIMPLE(entries, struct buffer_page),
+		KSTATE_SIMPLE(real_end, struct buffer_page),
+		KSTATE_SIMPLE(order, struct buffer_page),
+		KSTATE_SIMPLE(page, struct buffer_page),
+		{
+			.name = "buffer_page",
+			.flags = KS_CUSTOM,
+			.save = kstate_bpage_save,
+			.size = (sizeof(struct buffer_page)),
+		},
+		KSTATE_END_OF_LIST(),
+	},
+};
+
+static void restore_pages_positions(void **mig_stream,
+				struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct list_head *tmp;
+	struct list_head *head = rb_list_head(cpu_buffer->pages);
+	unsigned long commit_page_nr, reader_page_nr,
+		head_page_nr, tail_page_nr;
+	int i = 0;
+
+	commit_page_nr = kstate_get_ulong(mig_stream);
+	reader_page_nr = kstate_get_ulong(mig_stream);
+	head_page_nr = kstate_get_ulong(mig_stream);
+	tail_page_nr = kstate_get_ulong(mig_stream);
+
+	for (tmp = head;;) {
+		struct buffer_page *page = (struct buffer_page *)tmp;
+
+		if (commit_page_nr == i)
+			cpu_buffer->commit_page = page;
+		if (reader_page_nr == i)
+			cpu_buffer->reader_page = page;
+		if (head_page_nr == i)
+			cpu_buffer->head_page = page;
+		if (tail_page_nr == i)
+			cpu_buffer->tail_page = page;
+		i++;
+		tmp = rb_list_head(tmp->next);
+		if (tmp == head)
+			break;
+	}
+}
+
+static int kstate_rb_restore(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = obj;
+	LIST_HEAD(pages);
+	void *stream_start = mig_stream;
+	struct buffer_page *page;
+	struct list_head *tmp;
+	struct list_head *head = rb_list_head(cpu_buffer->pages);
+	int i = 0;
+
+	while (kstate_get_byte(&mig_stream)) {
+		int j = 0;
+		bool page_exists  = false;
+
+		for (tmp = rb_list_head(head->next); tmp != head;
+		     tmp = rb_list_head(tmp->next)) {
+			if (j == i) {
+				page_exists = true;
+				page = (struct buffer_page *)tmp;
+				break;
+			}
+			j++;
+		}
+		if (!page_exists) {
+			struct buffer_page *bpage;
+
+			bpage = kzalloc_node(ALIGN(sizeof(*bpage),
+					cache_line_size()), GFP_KERNEL,
+					cpu_to_node(cpu_buffer->cpu));
+			list_add(&bpage->list, &pages);
+			page = bpage;
+		}
+		mig_stream = restore_kstate((struct kstate_entry *)mig_stream,
+					i++, field->ksd, page);
+	}
+
+	restore_pages_positions(&mig_stream, cpu_buffer);
+
+	return mig_stream - stream_start;
+}
+
+static int kstate_rb_save(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = obj;
+	struct list_head *tmp;
+	struct list_head *head = rb_list_head(cpu_buffer->pages);
+	void *stream_start = mig_stream;
+	unsigned long commit_page_nr, reader_page_nr,
+		head_page_nr, tail_page_nr;
+	int i = 0;
+
+
+	for (tmp = head;;) {
+		struct buffer_page *page = (struct buffer_page *)tmp;
+
+		mig_stream = kstate_save_byte(mig_stream, 1);
+		mig_stream = save_kstate(mig_stream, i, field->ksd, page);
+
+		if (cpu_buffer->commit_page == page)
+			commit_page_nr = i;
+		if (cpu_buffer->reader_page == page)
+			reader_page_nr = i;
+		if (cpu_buffer->head_page == page)
+			head_page_nr = i;
+		if (cpu_buffer->tail_page == page)
+			tail_page_nr = i;
+		i++;
+		tmp = rb_list_head(tmp->next);
+		if (tmp == head)
+			break;
+	}
+
+	mig_stream = kstate_save_byte(mig_stream, 0);
+
+	/* save pages positions */
+	mig_stream = kstate_save_ulong(mig_stream, commit_page_nr);
+	mig_stream = kstate_save_ulong(mig_stream, reader_page_nr);
+	mig_stream = kstate_save_ulong(mig_stream, head_page_nr);
+	mig_stream = kstate_save_ulong(mig_stream, tail_page_nr);
+
+	return mig_stream - stream_start;
+}
+
+struct kstate_description kstate_ring_buffer_per_cpu = {
+	.name = "ring_buffer_per_cpu",
+	.id = KSTATE_TRACE_RING_BUFFER_ID,
+	.state_list = LIST_HEAD_INIT(kstate_ring_buffer_per_cpu.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_SIMPLE(entries, struct ring_buffer_per_cpu),
+		KSTATE_SIMPLE(entries_bytes, struct ring_buffer_per_cpu),
+		{
+			.name = "buffer_pages",
+			.flags = KS_CUSTOM,
+			.size = (sizeof(struct ring_buffer_per_cpu)),
+			.ksd = &kstate_buffer_page,
+			.save = kstate_rb_save,
+			.restore = kstate_rb_restore,
+		},
+		KSTATE_END_OF_LIST(),
+	},
+};
+
+static int nr_ring_buffers(void)
+{
+	return nr_cpu_ids;
+}
+
+struct kstate_description kstate_trace_buffer = {
+	.name = "trace_buffer",
+	.id = KSTATE_TRACE_BUFFER_ID,
+	.state_list = LIST_HEAD_INIT(kstate_trace_buffer.state_list),
+	.fields = (const struct kstate_field[]) {
+		{
+			.name = "ring_buffers",
+			.flags = KS_STRUCT|KS_POINTER|KS_ARRAY_OF_POINTER,
+			.size = (sizeof(struct ring_buffer_per_cpu *)),
+			.offset = offsetof(struct trace_buffer, buffers),
+			.count = nr_ring_buffers,
+			.ksd = &kstate_ring_buffer_per_cpu,
+		},
+		KSTATE_END_OF_LIST(),
+	}
+};
+#endif
+
 static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 			  struct buffer_page *bpage)
 {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc4714..bb07d716beab4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -18,6 +18,7 @@
 #include <linux/writeback.h>
 #include <linux/kallsyms.h>
 #include <linux/security.h>
+#include <linux/kstate.h>
 #include <linux/seq_file.h>
 #include <linux/irqflags.h>
 #include <linux/debugfs.h>
@@ -10621,6 +10622,84 @@ __init static void enable_instances(void)
 	}
 }
 
+#ifdef CONFIG_KSTATE
+static int cur_trace_save(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct trace_array *tr = obj;
+
+	return strscpy(mig_stream, tr->current_trace->name, 100) + 1;
+}
+
+static int cur_trace_restore(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct trace_array *tr = obj;
+
+	tracing_set_tracer(tr, mig_stream);
+	return strlen(mig_stream) + 1;
+}
+
+static int tracing_on_save(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct trace_array *tr = obj;
+
+	*(u8 *)mig_stream = (u8)tracer_tracing_is_on(tr);
+	return sizeof(u8);
+
+}
+
+static int tracing_on_restore(void *mig_stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct trace_array *tr = obj;
+	u8 on = *(u8 *)mig_stream;
+
+	if (on)
+		tracer_tracing_on(tr);
+	else
+		tracer_tracing_off(tr);
+
+	return sizeof(on);
+}
+
+extern struct kstate_description kstate_trace_buffer;
+
+struct kstate_description global_trace_state = {
+	.name = "trace_state",
+	.id = KSTATE_TRACE_ID,
+	.version_id = 1,
+	.state_list = LIST_HEAD_INIT(global_trace_state.state_list),
+	.fields = (const struct kstate_field[]) {
+		{
+			.name = "tracing_on",
+			.flags = KS_CUSTOM,
+			.version_id = 0,
+			.size = sizeof(struct trace_array),
+			.save = tracing_on_save,
+			.restore = tracing_on_restore,
+		},
+		{
+			.name = "current_trace",
+			.flags = KS_CUSTOM,
+			.version_id = 0,
+			.size = sizeof(struct trace_array),
+			.save = cur_trace_save,
+			.restore = cur_trace_restore,
+
+		},
+		{
+			.name = "trace_buffer",
+			.flags = KS_STRUCT|KS_POINTER,
+			.offset = offsetof(struct trace_array, array_buffer.buffer),
+			.ksd = &kstate_trace_buffer,
+		},
+		KSTATE_END_OF_LIST()
+	},
+};
+#endif
+
 __init static int tracer_alloc_buffers(void)
 {
 	int ring_buf_size;
@@ -10848,6 +10927,8 @@ __init static int late_trace_init(void)
 
 	tracing_set_default_clock();
 	clear_boot_tracer();
+	kstate_register(&global_trace_state, &global_trace);
+
 	return 0;
 }
 
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
