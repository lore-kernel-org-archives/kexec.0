Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2D7CA1013
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzZPK+tD8ua9mkD8VwlX20r11BOjtw6Um42qZGE0OrE=; b=F2pKGnwXX7P327lAtXS0gQA39S
	2U6Xw22MHWeqEvH6lNGrlvaQiLPBEy+lX3HAIRWJ7l7/NbYQzGBb6JzqEtqdl+f9anhnStdaZ6A1Q
	V8rFuS+leNsMwNwk0RUa1xXgqHeIgXbGpcgasRwbCC0GEA/IO9o2stKAPAVOVfKlywuWxB0ea0tGN
	DPWcVVXlsiD2uB7sznzmUlXGJR5oUWG1+EBnxA8FhcSAMxGSLVgfuQxfIiU5O0YjGPWwo69K0ozoL
	Gdd+qq/L/v/XiI0GLAjX6yy/fFK4TyblJFO00+cEpk18ATaCQ4NJKTB5r+ONwqytzcs5jkbKE2Ku5
	yPy5Gg5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5C-00000001KLz-44hk;
	Thu, 18 Sep 2025 22:26:30 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN5A-00000001KJ9-17ZN
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 22:26:29 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-77d64726e47so1043748b3a.3
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234388; x=1758839188; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzZPK+tD8ua9mkD8VwlX20r11BOjtw6Um42qZGE0OrE=;
        b=aMPwbuyHtHP7dl79swyxGFlprjnDjO59xmHH+9UZbA3XDjgnrb85xk2cs4XVeRQA3a
         yCM9GILdV4zUIDbEPbR+Y2Gm74Yam9NeE3AF77BAHfTTMunxPHcd8f9JMMas6+q9TjzR
         Vlvi+4sOPnxvX40ytfYjdThAO3xnCDte4nyW093RCOU2OUw2/Nybe4QTC5Ks0bOoq72I
         VOv+5k5Pvt/Nr4TdzahuJZ1b7uDN9dyCXF97zC93S9G3+Up5D1s1NAeTTfZB8ZKt/6mF
         fhx0hW9avZAKPT0mz6zHtNs7xxa7RRMuA081wVG181+kgghmhdScJHd+RQ8flRapRF2X
         YwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234388; x=1758839188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzZPK+tD8ua9mkD8VwlX20r11BOjtw6Um42qZGE0OrE=;
        b=ErEhu1TO/Xovw2cegRUMmeVqGrXu4aIQDl5hWlNZHo5BLLvosC2oGyVaGJ0fTz7iZK
         JxQvNHZ4TzOiOkiu7yvuxAOTEVKd0lptXImibuYhywMKwIaYMfwvA/8/cW6cJTONLf8g
         vpfGIX36Ox4J6H6NYskel5TsZljF7OZwLrgRA1fqYwK8VWQdAtraHH9l1zAm2Uiyi2Lb
         4SmvM9U2Tf/oBkVEyBdf2ohsAMm1jbiZjH2E6NOXQ1rYIp2A0ms7YpYFjCLJsMF+vaNU
         otjrsby3UUOoMJUGnTVCtNSNs9fl5oORFtkSUi9RBWntcp9IdoN0MKlqvJcTKufgq316
         jJfA==
X-Forwarded-Encrypted: i=1; AJvYcCWhHUmA6FsLG272Ra9iIUjXZNra4Aus9duB0oh4vQ9DIG/Zz/+aNl4PZqOUUSG39uBs83f6bg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3Z1L+3V6T3Yy2RDZzOF2/MOlFMo1aQ43aiYrCK5ofzwg6w5Vd
	SbxO7WmJ91tAd3bjDSTzmu1zeP4Lrejv2kq7DkNF+znGy/OqMeYN1RO7
X-Gm-Gg: ASbGncuKo3i3Ley5aYzqykrL1ksk9WIj3wP5pFB6aqlKvjYsq8DUnb5FLnc6BSfJAGf
	lY4zZXxvBHhqTJpepgQygF+8m0xgKVMayzChcnas3Q/XTnqfexMGjICk4fcCa/mTnoV9YNVyEWg
	6va4xHjgj0aI+SEPlwEMlwVDKOhP/qW+7e85XYOPzH4dBkVsqTXba21FMspu5I4D49NyzdfQsSc
	WRDQkuujwoBK+pghNMBd9ZOfvYcG+74NI1sTl/mX+LZCLRjaWqk0BjTzO+3o8NSH046e9tDkfzb
	0lRsXhZaQJUF+GtJMcc5A5jngLKW6AVrPruIwanKfv9M1JyxjncfWvAI2r0tEbsJWor0fewz7SP
	U8ftZN8iZMqyqYPxkblCszFHeLIqn1WqJTnZoYeizXdDMMiE=
X-Google-Smtp-Source: AGHT+IEcmBpKgxWK65kqL+t4N9tpvg/YpMV9lF9NLfIoi4A5w/Hpr9vbHnSl2Ql5oJ01WR0BGA3tRA==
X-Received: by 2002:a05:6a00:cc7:b0:776:1804:6fe with SMTP id d2e1a72fcca58-77e4cc3c5e1mr1115624b3a.7.1758234387508;
        Thu, 18 Sep 2025 15:26:27 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:26 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 4/7] kernel: Introduce generic multikernel IPI communication framework
Date: Thu, 18 Sep 2025 15:26:03 -0700
Message-Id: <20250918222607.186488-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_152628_342710_EC7EF801 
X-CRM114-Status: GOOD (  31.42  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Cong Wang <cwang@multikernel.io>

This patch implements a comprehensive IPI-based communication system
for multikernel environments, enabling data exchange between different
kernel instances running on separate CPUs.

Key features include:

- Generic IPI handler registration and callback mechanism allowing
  modules to register for multikernel communication events
- Shared memory infrastructure using either boot parameter-specified
  or dynamically allocated physical memory regions
- Per-CPU data buffers in shared memory for efficient IPI payload
  transfer up to 256 bytes per message
- IRQ work integration for safe callback execution in interrupt context
- PFN-based flexible shared memory APIs for page-level data sharing
- Resource tracking integration for /proc/iomem visibility

The implementation provides multikernel_send_ipi_data() for sending
typed data to target CPUs and multikernel_register_handler() for
receiving notifications. Shared memory is established during early
boot and mapped using memremap() for cache-coherent access.

This infrastructure enables heterogeneous computing scenarios where
multikernel instances can coordinate and share data while maintaining
isolation on their respective CPU cores.

Note, as a proof-of-concept, we have only implemented the x86 part.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/kernel/smp.c       |   5 +-
 include/linux/multikernel.h |  81 ++++++++++
 init/main.c                 |   2 +
 kernel/Makefile             |   2 +-
 kernel/multikernel.c        | 313 ++++++++++++++++++++++++++++++++++++
 5 files changed, 398 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/multikernel.h
 create mode 100644 kernel/multikernel.c

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 028cc423a772..3ee515e32383 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -272,10 +272,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
 }
 
-static void generic_multikernel_interrupt(void)
-{
-	pr_info("Multikernel interrupt\n");
-}
+void generic_multikernel_interrupt(void);
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_multikernel)
 {
diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
new file mode 100644
index 000000000000..12ed5e03f92e
--- /dev/null
+++ b/include/linux/multikernel.h
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ */
+#ifndef _LINUX_MULTIKERNEL_H
+#define _LINUX_MULTIKERNEL_H
+
+#include <linux/types.h>
+#include <linux/irq_work.h>
+
+/**
+ * Multikernel IPI interface
+ *
+ * This header provides declarations for the multikernel IPI interface,
+ * allowing modules to register callbacks for IPI events and pass data
+ * between CPUs.
+ */
+
+/* Maximum data size that can be transferred via IPI */
+#define MK_MAX_DATA_SIZE 256
+
+/* Data structure for passing parameters via IPI */
+struct mk_ipi_data {
+	int sender_cpu;          /* Which CPU sent this IPI */
+	unsigned int type;      /* User-defined type identifier */
+	size_t data_size;        /* Size of the data */
+	char buffer[MK_MAX_DATA_SIZE]; /* Actual data buffer */
+};
+
+/* Function pointer type for IPI callbacks */
+typedef void (*mk_ipi_callback_t)(struct mk_ipi_data *data, void *ctx);
+
+struct mk_ipi_handler {
+	mk_ipi_callback_t callback;
+	void *context;
+	struct mk_ipi_handler *next;
+	struct mk_ipi_data *saved_data;
+	struct irq_work work;
+};
+
+/**
+ * multikernel_register_handler - Register a callback for multikernel IPI
+ * @callback: Function to call when IPI is received
+ * @ctx: Context pointer passed to the callback
+ *
+ * Returns pointer to handler on success, NULL on failure
+ */
+struct mk_ipi_handler *multikernel_register_handler(mk_ipi_callback_t callback, void *ctx);
+
+/**
+ * multikernel_unregister_handler - Unregister a multikernel IPI callback
+ * @handler: Handler pointer returned from multikernel_register_handler
+ */
+void multikernel_unregister_handler(struct mk_ipi_handler *handler);
+
+/**
+ * multikernel_send_ipi_data - Send data to another CPU via IPI
+ * @cpu: Target CPU
+ * @data: Pointer to data to send
+ * @data_size: Size of data
+ * @type: User-defined type identifier
+ *
+ * This function copies the data to per-CPU storage and sends an IPI
+ * to the target CPU.
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int multikernel_send_ipi_data(int cpu, void *data, size_t data_size, unsigned long type);
+
+void generic_multikernel_interrupt(void);
+
+int __init multikernel_init(void);
+
+/* Flexible shared memory APIs (PFN-based) */
+int mk_send_pfn(int target_cpu, unsigned long pfn);
+int mk_receive_pfn(struct mk_ipi_data *data, unsigned long *out_pfn);
+void *mk_receive_map_page(struct mk_ipi_data *data);
+
+#define mk_receive_unmap_page(p) memunmap(p)
+
+#endif /* _LINUX_MULTIKERNEL_H */
diff --git a/init/main.c b/init/main.c
index 5753e9539ae6..46a199bcb389 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,7 @@
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
+#include <linux/multikernel.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -955,6 +956,7 @@ void start_kernel(void)
 	vfs_caches_init_early();
 	sort_main_extable();
 	trap_init();
+	multikernel_init();
 	mm_core_init();
 	maple_tree_init();
 	poking_init();
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235..e5216610a4e7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
+	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o multikernel.o
 
 obj-$(CONFIG_MULTIUSER) += groups.o
 obj-$(CONFIG_VHOST_TASK) += vhost_task.o
diff --git a/kernel/multikernel.c b/kernel/multikernel.c
new file mode 100644
index 000000000000..74e2f84b7914
--- /dev/null
+++ b/kernel/multikernel.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+#include <linux/multikernel.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <asm/apic.h>
+#include <linux/memblock.h>
+
+/* Memory parameters for shared region */
+#define MK_IPI_DATA_SIZE  (sizeof(struct mk_ipi_data) * NR_CPUS)
+#define MK_MEM_BASE_SIZE  (sizeof(struct mk_shared_data))
+#define MK_MEM_SIZE       (MK_MEM_BASE_SIZE + PAGE_SIZE)
+
+/* Boot parameter for physical address */
+static unsigned long mk_phys_addr_param;
+
+/* Parse multikernel physical address from kernel command line */
+static int __init multikernel_phys_addr_setup(char *str)
+{
+	return kstrtoul(str, 0, &mk_phys_addr_param);
+}
+early_param("mk_shared_memory", multikernel_phys_addr_setup);
+
+/* Allocated/assigned physical address for shared memory */
+static phys_addr_t mk_phys_addr_base;
+
+/* Resource structure for tracking the memory in /proc/iomem */
+static struct resource mk_mem_res __ro_after_init = {
+	.name = "Multikernel Shared Memory",
+	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
+};
+
+/* Shared memory structures */
+struct mk_shared_data {
+	struct mk_ipi_data cpu_data[NR_CPUS];  /* Data area for each CPU */
+};
+
+/* Pointer to the shared memory area (remapped virtual address) */
+static struct mk_shared_data *mk_shared_mem;
+
+/* Callback management */
+static struct mk_ipi_handler *mk_handlers;
+static raw_spinlock_t mk_handlers_lock = __RAW_SPIN_LOCK_UNLOCKED(mk_handlers_lock);
+
+static void handler_work(struct irq_work *work)
+{
+    struct mk_ipi_handler *handler = container_of(work, struct mk_ipi_handler, work);
+    if (handler->callback)
+        handler->callback(handler->saved_data, handler->context);
+}
+
+/**
+ * multikernel_register_handler - Register a callback for multikernel IPI
+ * @callback: Function to call when IPI is received
+ * @ctx: Context pointer passed to the callback
+ *
+ * Returns pointer to handler on success, NULL on failure
+ */
+struct mk_ipi_handler *multikernel_register_handler(mk_ipi_callback_t callback, void *ctx)
+{
+	struct mk_ipi_handler *handler;
+	unsigned long flags;
+
+	if (!callback)
+		return NULL;
+
+	handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return NULL;
+
+	handler->callback = callback;
+	handler->context = ctx;
+
+	init_irq_work(&handler->work, handler_work);
+
+	raw_spin_lock_irqsave(&mk_handlers_lock, flags);
+	handler->next = mk_handlers;
+	mk_handlers = handler;
+	raw_spin_unlock_irqrestore(&mk_handlers_lock, flags);
+
+	return handler;
+}
+EXPORT_SYMBOL(multikernel_register_handler);
+
+/**
+ * multikernel_unregister_handler - Unregister a multikernel IPI callback
+ * @handler: Handler pointer returned from multikernel_register_handler
+ */
+void multikernel_unregister_handler(struct mk_ipi_handler *handler)
+{
+	struct mk_ipi_handler **pp, *p;
+	unsigned long flags;
+
+	if (!handler)
+		return;
+
+	raw_spin_lock_irqsave(&mk_handlers_lock, flags);
+	pp = &mk_handlers;
+	while ((p = *pp) != NULL) {
+		if (p == handler) {
+			*pp = p->next;
+			break;
+		}
+		pp = &p->next;
+	}
+	raw_spin_unlock_irqrestore(&mk_handlers_lock, flags);
+
+    /* Wait for pending work to complete */
+    irq_work_sync(&handler->work);
+    kfree(p);
+}
+EXPORT_SYMBOL(multikernel_unregister_handler);
+
+/**
+ * multikernel_send_ipi_data - Send data to another CPU via IPI
+ * @cpu: Target CPU
+ * @data: Pointer to data to send
+ * @data_size: Size of data
+ * @type: User-defined type identifier
+ *
+ * This function copies the data to per-CPU storage and sends an IPI
+ * to the target CPU.
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int multikernel_send_ipi_data(int cpu, void *data, size_t data_size, unsigned long type)
+{
+	struct mk_ipi_data *target;
+
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (data_size > MK_MAX_DATA_SIZE)
+		return -EINVAL;  /* Data too large for buffer */
+
+	/* Ensure shared memory is initialized */
+	if (!mk_shared_mem)
+		return -ENOMEM;
+
+	/* Get target CPU's data area from shared memory */
+	target = &mk_shared_mem->cpu_data[cpu];
+
+	/* Set header information */
+	target->data_size = data_size;
+	target->sender_cpu = smp_processor_id();
+	target->type = type;
+
+	/* Copy the actual data into the buffer */
+	if (data && data_size > 0)
+		memcpy(target->buffer, data, data_size);
+
+	/* Send IPI to target CPU */
+	__apic_send_IPI(cpu, MULTIKERNEL_VECTOR);
+
+	return 0;
+}
+EXPORT_SYMBOL(multikernel_send_ipi_data);
+
+/**
+ * multikernel_interrupt_handler - Handle the multikernel IPI
+ *
+ * This function is called when a multikernel IPI is received.
+ * It invokes all registered callbacks with the per-CPU data.
+ */
+static void multikernel_interrupt_handler(void)
+{
+	struct mk_ipi_data *data;
+	struct mk_ipi_handler *handler;
+	int current_cpu = smp_processor_id();
+
+	/* Ensure shared memory is initialized */
+	if (!mk_shared_mem) {
+		pr_err("Multikernel IPI received but shared memory not initialized\n");
+		return;
+	}
+
+	/* Get this CPU's data area from shared memory */
+	data = &mk_shared_mem->cpu_data[current_cpu];
+
+	pr_debug("Multikernel IPI received on CPU %d from CPU %d, type=%u\n",
+		 current_cpu, data->sender_cpu, data->type);
+
+    raw_spin_lock(&mk_handlers_lock);
+    for (handler = mk_handlers; handler; handler = handler->next) {
+        handler->saved_data = data;
+        irq_work_queue(&handler->work);
+    }
+    raw_spin_unlock(&mk_handlers_lock);
+}
+
+/**
+ * Generic multikernel interrupt handler - called by the IPI vector
+ *
+ * This is the function that gets called by the IPI vector handler.
+ */
+void generic_multikernel_interrupt(void)
+{
+	multikernel_interrupt_handler();
+}
+
+/**
+ * setup_shared_memory - Initialize shared memory for inter-kernel communication
+ *
+ * Maps a fixed physical memory region for sharing IPI data between kernels
+ * Returns 0 on success, negative error code on failure
+ */
+static int __init setup_shared_memory(void)
+{
+	/* Check if a fixed physical address was provided via parameter */
+	if (mk_phys_addr_param) {
+		/* Use the provided physical address */
+		mk_phys_addr_base = (phys_addr_t)mk_phys_addr_param;
+		pr_info("Using specified physical address 0x%llx for multikernel shared memory\n",
+		       (unsigned long long)mk_phys_addr_base);
+	} else {
+		/* Dynamically allocate contiguous physical memory using memblock */
+		mk_phys_addr_base = memblock_phys_alloc(MK_MEM_SIZE, PAGE_SIZE);
+		if (!mk_phys_addr_base) {
+			pr_err("Failed to allocate physical memory for multikernel IPI data\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* Map the physical memory region to virtual address space */
+	mk_shared_mem = memremap(mk_phys_addr_base, MK_MEM_SIZE, MEMREMAP_WB);
+	if (!mk_shared_mem) {
+		pr_err("Failed to map shared memory at 0x%llx for multikernel IPI data\n",
+		       (unsigned long long)mk_phys_addr_base);
+
+		/* Only free the memory if we allocated it dynamically */
+		if (!mk_phys_addr_param)
+			memblock_phys_free(mk_phys_addr_base, MK_MEM_SIZE);
+		return -ENOMEM;
+	}
+
+	/* Initialize the memory to zero */
+	memset(mk_shared_mem, 0, sizeof(struct mk_shared_data));
+
+	pr_info("Allocated and mapped multikernel shared memory: phys=0x%llx, virt=%px, size=%lu bytes\n",
+		(unsigned long long)mk_phys_addr_base, mk_shared_mem, MK_MEM_SIZE);
+
+	return 0;
+}
+
+int __init multikernel_init(void)
+{
+	int ret;
+
+	ret = setup_shared_memory();
+	if (ret < 0)
+		return ret;
+
+	pr_info("Multikernel IPI support initialized\n");
+	return 0;
+}
+
+static int __init init_shared_memory(void)
+{
+	/* Set up resource structure for /proc/iomem visibility */
+	mk_mem_res.start = mk_phys_addr_base;
+	mk_mem_res.end = mk_phys_addr_base + MK_MEM_SIZE - 1;
+
+	/* Register the resource in the global resource tree */
+	if (insert_resource(&iomem_resource, &mk_mem_res)) {
+		pr_warn("Could not register multikernel shared memory region in resource tracking\n");
+		/* Continue anyway as this is not fatal */
+		return -1;
+	}
+
+	pr_info("Registered multikernel shared memory in resource tree: 0x%llx-0x%llx\n",
+		(unsigned long long)mk_mem_res.start, (unsigned long long)mk_mem_res.end);
+	return 0;
+}
+core_initcall(init_shared_memory);
+
+/* ---- Flexible shared memory APIs (PFN-based) ---- */
+#define MK_PFN_IPI_TYPE 0x80000001U
+
+/* Send a PFN to another kernel via mk_ipi_data */
+int mk_send_pfn(int target_cpu, unsigned long pfn)
+{
+	return multikernel_send_ipi_data(target_cpu, &pfn, sizeof(pfn), MK_PFN_IPI_TYPE);
+}
+
+/* Receive a PFN from mk_ipi_data. Caller must check type. */
+int mk_receive_pfn(struct mk_ipi_data *data, unsigned long *out_pfn)
+{
+	if (!data || !out_pfn)
+		return -EINVAL;
+	if (data->type != MK_PFN_IPI_TYPE || data->data_size != sizeof(unsigned long))
+		return -EINVAL;
+	*out_pfn = *(unsigned long *)data->buffer;
+	return 0;
+}
+
+void *mk_receive_map_page(struct mk_ipi_data *data)
+{
+	unsigned long pfn;
+	int ret;
+
+	ret = mk_receive_pfn(data, &pfn);
+	if (ret < 0)
+		return NULL;
+	return memremap(pfn << PAGE_SHIFT, PAGE_SIZE, MEMREMAP_WB);
+}
-- 
2.34.1


