Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8673C47258
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xkzb50OV7XMF6v6MK1ECCbuMWURXb3/xAmCCJLXtvoo=; b=iyVOCcHbF6dAtH
	vB1xFZndiWsgTvmYW40ND1VpdDit5CSqreFwudHzlFSfZehYnVhJdtLTOxyEVnADLftlf/RQrbhol
	JjzGAmLcdkiBU50h2agyaUFAMFWK1oJFlPSGTZEduSGbVdUqZptVYtUgs5mDQHOtHEV6feqifG9Sz
	j3rYUEBN+hqSlRQsldlTGObYy9x7ncPB0okw4mZb8y/lCo7YocbYvjKJCPEcErN1O39H/ii7W2gRs
	uzNCK1GDlRh/ss48JCVDsYdneKbA3AGzzwuIyFC9WDD3AvQB3cdOqNmQYdm2KKUkC+dMMlAaonzMQ
	qntZKoHqQcOYCUGggcTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7En-00HIqO-05;
	Wed, 17 Jan 2024 14:49:53 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7EZ-00HIcg-0p;
	Wed, 17 Jan 2024 14:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502980; x=1737038980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0hyYTkhSxvX6+T1x6RjDPfV1ywV5C7Siqc3ZcSpla8=;
  b=FP5/QFXbYdX/GtmJd2PcD3pJflnmoS+Rq4mlOi83YQjAj3CdT+bTNMbk
   edmNb7hCULNyiWFLoYhp8GV9vKsrElr6YvnUCIMbA4dAg/sNw0k91/J2Y
   EILfIVGaWHunxJyyXLLBPZeqGmg6CLCY5Z5xTf7DqRmc7U0wrCxVq/E20
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="322019440"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:49:29 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com (Postfix) with ESMTPS id 6A2AF160007;
	Wed, 17 Jan 2024 14:49:25 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:54156]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.181:2525] with esmtp (Farcaster)
 id 512a89a9-fd01-4e5a-876b-90d048f33ffd; Wed, 17 Jan 2024 14:49:25 +0000 (UTC)
X-Farcaster-Flow-ID: 512a89a9-fd01-4e5a-876b-90d048f33ffd
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:24 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:49:21 +0000
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
Subject: [PATCH v3 12/17] tracing: Add kho serialization of trace buffers
Date: Wed, 17 Jan 2024 14:46:59 +0000
Message-ID: <20240117144704.602-13-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_064939_378076_80CBF3FB 
X-CRM114-Status: GOOD (  25.21  )
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

When we do a kexec handover, we want to preserve previous ftrace data
into the new kernel. At the point when we write out the handover data,
ftrace may still be running and recording new events and we want to
capture all of those too.

To allow the new kernel to revive all trace data up to reboot, we store
all locations of trace buffers as well as their linked list metadata. We
can then later reuse the linked list to reconstruct the head pointer.

This patch implements the write-out logic for trace buffers.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Leave the node generation code that needs to know the name in
    trace.c so that ring buffers can stay anonymous

v2 -> v3:

  - s/"global_trace"/"global-trace"/
  - s/"trace_flags"/"trace-flags"/
---
 include/linux/ring_buffer.h |  2 +
 kernel/trace/ring_buffer.c  | 76 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        | 16 ++++++++
 3 files changed, 94 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..1c5eb33f0cb5 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -211,4 +211,6 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_kho_write(void *fdt, struct trace_buffer *buffer);
+
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9286f88fcd32..33b41013cda9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/kexec.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/hash.h>
@@ -5859,6 +5860,81 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+#ifdef CONFIG_FTRACE_KHO
+static int rb_kho_write_cpu(void *fdt, struct trace_buffer *buffer, int cpu)
+{
+	int i = 0;
+	int err = 0;
+	struct list_head *tmp;
+	const char compatible[] = "ftrace,cpu-v1";
+	char name[] = "cpuffffffff";
+	int nr_pages;
+	struct ring_buffer_per_cpu *cpu_buffer;
+	bool first_loop = true;
+	struct kho_mem *mem;
+	uint64_t mem_len;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return 0;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	nr_pages = cpu_buffer->nr_pages;
+	mem_len = sizeof(*mem) * nr_pages * 2;
+	mem = vmalloc(mem_len);
+
+	snprintf(name, sizeof(name), "cpu%x", cpu);
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "cpu", &cpu, sizeof(cpu));
+
+	for (tmp = rb_list_head(cpu_buffer->pages);
+	     tmp != rb_list_head(cpu_buffer->pages) || first_loop;
+	     tmp = rb_list_head(tmp->next), first_loop = false) {
+		struct buffer_page *bpage = (struct buffer_page *)tmp;
+
+		/* Ring is larger than it should be? */
+		if (i >= (nr_pages * 2)) {
+			pr_err("ftrace ring has more pages than nr_pages (%d / %d)", i, nr_pages);
+			err = -EINVAL;
+			break;
+		}
+
+		/* First describe the bpage */
+		mem[i++] = (struct kho_mem) {
+			.addr = __pa(bpage),
+			.len = sizeof(*bpage)
+		};
+
+		/* Then the data page */
+		mem[i++] = (struct kho_mem) {
+			.addr = __pa(bpage->page),
+			.len = PAGE_SIZE
+		};
+	}
+
+	err |= fdt_property(fdt, "mem", mem, mem_len);
+	err |= fdt_end_node(fdt);
+
+	vfree(mem);
+	return err;
+}
+
+int ring_buffer_kho_write(void *fdt, struct trace_buffer *buffer)
+{
+	int err, i;
+
+	for (i = 0; i < buffer->cpus; i++) {
+		err = rb_kho_write_cpu(fdt, buffer, i);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_RING_BUFFER_STARTUP_TEST
 /*
  * This is a basic integrity check of the ring buffer.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9a0d96975c9c..9505a929a726 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10577,6 +10577,21 @@ void __init early_trace_init(void)
 	init_events();
 }
 
+static int trace_kho_write_trace_array(void *fdt, struct trace_array *tr)
+{
+	const char *name = tr->name ? tr->name : "global-trace";
+	const char compatible[] = "ftrace,array-v1";
+	int err = 0;
+
+	err |= fdt_begin_node(fdt, name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "trace-flags", &tr->trace_flags, sizeof(tr->trace_flags));
+	err |= ring_buffer_kho_write(fdt, tr->array_buffer.buffer);
+	err |= fdt_end_node(fdt);
+
+	return err;
+}
+
 static int trace_kho_notifier(struct notifier_block *self,
 			      unsigned long cmd,
 			      void *v)
@@ -10603,6 +10618,7 @@ static int trace_kho_notifier(struct notifier_block *self,
 
 	err |= fdt_begin_node(fdt, "ftrace");
 	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= trace_kho_write_trace_array(fdt, &global_trace);
 	err |= fdt_end_node(fdt);
 
 	if (!err) {
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
