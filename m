Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3EFCCD184
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGfWBR5gpu5BpcnPXBhslXXLKaWQISUn3yoh9fDkD14=; b=49xBm3ATwWxWtAn0HNiesKmTrv
	j3ZLpr6TgNw6t1/8zq7j++79yyMzFSUZeNjh9ea8rbhnD3qAh/VKZAR7yzUmU699gOa13OmfXW57Q
	Ii2WAtBraWYUCrlpI+ArZ6o8ZPbr6UMxMxkLPaey05uDBykaJKPIHxE+h/+MMLUacvAvCbedSjXEl
	ir//z7MrhL/aUmOalH/xRou6sC93lhJgmODHeF7HqRBQAMePt89Uq8uVStY8rt+MrXIUp59mttGPi
	UJn1/wdJjOe+ursjP6+/d0d9czbdvdSmiHbg+y2QKQ3Fbs0wFZ4FTBbUn5I3Iv6ylcLkPGVbWmyz8
	o3L9x0zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjL-0000000AjLC-1AVk;
	Sun, 19 Oct 2025 06:17:23 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjJ-0000000AjIY-0XoJ
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:22 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so3574340a91.1
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854640; x=1761459440; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGfWBR5gpu5BpcnPXBhslXXLKaWQISUn3yoh9fDkD14=;
        b=Rx/Ubk0gvDCFeOHLBfiBPJeM2p0WDlX9PaFfaAfbF2sSh2Eram8ihPHj+misJwM8fA
         jsnWVw7AD5jMnMawgANO3RVkPDyDklSEY5BYEeGHpCkE2maDTJwKuyoqXfpk2eGc+ADt
         BQJ9U6jD6oM45orl/YOEhg4o5cf7gtgOa9qN3jMhTLUeANM4tyOszg26Bn1sfHaNx6mT
         NtJ+ykZjoJxuHmCgefp7hnzDvxCO0F7bPC38kb1rghiWed5kHxZRRpcl6iH+0FlmwFX+
         1qm6Vx+RA1Opqs/T6Cv31jzdygg+FPmsTDg/CUq6KATZ7RXM/pAwatAPRpjMu32fIlN8
         kANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854640; x=1761459440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGfWBR5gpu5BpcnPXBhslXXLKaWQISUn3yoh9fDkD14=;
        b=oagpxX/akE0JSQw99+ZUxDIH6XN4Io/4HVNTW7o1J+qe7WRUHqaGO4PoLBIoQQSeSG
         8DJc1kOK998q/bi3Yh0VP1r4EHItLtw1sr9IDxMBS0lYAXODrrOb+8iv1tw1C/JxLYlX
         ZgkbGbWUbJ++YyjnB4AqanPYuH7Ujj4nsnxwTLIqQFRwdSXDGdeC1LkTXZUpHIBynkJL
         XNkGoZ4yxQkaVSeN3klyHlmFS2cwRttvDlukVyMkzB3j9XXdeSOl46+Yn7hlsRYom+S3
         WQNVz1IzhHbH2zVEz8m9E/Sw7eAmGmvDxVQwRlGpg4EzKvhuhmFgqSvCkmHJcQKdBnar
         YGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUkEUfySfoEXy1A9o7bk/XJnlwzbVzjGn+bxTZe2GeoMJ+c/U7ZPfvfT6uTKSJG2zmyDh9EHw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkkD5MFGsuD49tO44osE0+md6zR8goXZUwHwAz10K5U3pIclCC
	n3An76akqeIyv2fGkumkc8oyK0RZcHdsmZ9G/bCKBvbsG47BGjcFtQaQPOox+Q==
X-Gm-Gg: ASbGncuubZ3vDaJydfmwfrNEMqZslIULpmmWk/XOSy2p+W0EE6KJhd8iR+W2TNSpYrh
	d8xdvVDd2v1hHOTES0i1st/LMTYr/OuKuDGctSJt9Elxc5WsPbRdFhDHI8rtIYhasW/MAE9XyJL
	U5tYPTiizGWfilzwMmIc8Y2SrtplKgO0fgmJ0ASDlILifFZZ+7S3QQi5IDzRfbBR5Tbq3Lme6Uw
	sCAnuxfEGJzUlEW1NZsZsVpL5Gifd9oiJ6GutWbOJirzVFp9aU8xzGTwfXSAStI418KlcReA2PP
	av+/qAI8XKUlfbvd0oRuqX9Jp1NzjTzOThbfdC3NCUY/be0BFCOpqUl3lQYP+Xk3ATwbVuRGJSp
	QZzX4AmorXZ5KsN1YSoQqCxp0h7pc0vITI5J2F/hqQ3L050jaXjv5oXZFa+tEcz1/hrDtSOEf/E
	b0Di2S
X-Google-Smtp-Source: AGHT+IFB/9N4hWxuPbcz7xQxYSDMcrE9Ap+mI0ELEadewX8FBE7rytwKC4P01IfgOC+LAL66fL2HMg==
X-Received: by 2002:a17:90b:3512:b0:32e:7ff6:6dbd with SMTP id 98e67ed59e1d1-33bc9aa6e69mr13206379a91.0.1760854640156;
        Sat, 18 Oct 2025 23:17:20 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:19 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 14/16] multikernel: Add messaging layer for inter-kernel communication
Date: Sat, 18 Oct 2025 23:16:28 -0700
Message-Id: <20251019061631.2235405-15-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231721_219460_2A09D4C8 
X-CRM114-Status: GOOD (  25.82  )
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

Introduce a structured messaging system built on top of the existing
multikernel IPI infrastructure to enable reliable communication between
kernel instances running on different CPUs.

The messaging layer provides:

* Simple message format with type/subtype hierarchy for extensibility
* Support for I/O interrupt forwarding between kernel instances
* Resource management messages for CPU and memory hotplug operations
* Type-safe payload structures with validation
* Handler registration system for message processing
* Convenient inline functions for common operations

Message types include:
- MK_MSG_IO: I/O interrupt forwarding and load balancing
- MK_MSG_RESOURCE: CPU/memory add/remove operations
- MK_MSG_SYSTEM: System-level coordination messages
- MK_MSG_USER: User-defined message types

The implementation leverages the reliable nature of intra-machine IPIs,
maintaining simplicity and performance. Messages are limited to the
existing 256-byte IPI buffer size, with larger data transfers handled
via the existing PFN-based shared memory mechanism.

This messaging foundation enables sophisticated multikernel coordination
scenarios including dynamic resource allocation, interrupt load
balancing, and system-wide state management.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/multikernel.h    | 200 ++++++++++++++++++++++++
 kernel/multikernel/Makefile    |   2 +-
 kernel/multikernel/core.c      |   7 +
 kernel/multikernel/messaging.c | 278 +++++++++++++++++++++++++++++++++
 4 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 kernel/multikernel/messaging.c

diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
index ee96bd2332b6..3bc07361145b 100644
--- a/include/linux/multikernel.h
+++ b/include/linux/multikernel.h
@@ -80,6 +80,206 @@ void *mk_receive_map_page(struct mk_ipi_data *data);
 
 #define mk_receive_unmap_page(p) memunmap(p)
 
+/*
+ * Multikernel Messaging System
+ */
+
+/**
+ * Message type definitions - organized by category
+ */
+
+/* Top-level message categories */
+#define MK_MSG_IO           0x1000
+#define MK_MSG_RESOURCE     0x2000
+#define MK_MSG_SYSTEM       0x3000
+#define MK_MSG_USER         0x4000
+
+/* I/O interrupt forwarding subtypes */
+#define MK_IO_IRQ_FORWARD   (MK_MSG_IO + 1)
+#define MK_IO_IRQ_BALANCE   (MK_MSG_IO + 2)
+#define MK_IO_IRQ_MASK      (MK_MSG_IO + 3)
+#define MK_IO_IRQ_UNMASK    (MK_MSG_IO + 4)
+
+/* Resource management subtypes */
+#define MK_RES_CPU_ADD      (MK_MSG_RESOURCE + 1)
+#define MK_RES_CPU_REMOVE   (MK_MSG_RESOURCE + 2)
+#define MK_RES_MEM_ADD      (MK_MSG_RESOURCE + 3)
+#define MK_RES_MEM_REMOVE   (MK_MSG_RESOURCE + 4)
+#define MK_RES_QUERY        (MK_MSG_RESOURCE + 5)
+
+/* System management subtypes */
+#define MK_SYS_HEARTBEAT    (MK_MSG_SYSTEM + 1)
+#define MK_SYS_SHUTDOWN     (MK_MSG_SYSTEM + 2)
+
+/**
+ * Core message structure
+ */
+struct mk_message {
+	u32 msg_type;           /* Message type identifier */
+	u32 msg_subtype;        /* Subtype for specific operations */
+	u64 msg_id;             /* Optional message ID for correlation */
+	u32 payload_len;        /* Length of payload data */
+	u8 payload[];           /* Variable payload (up to remaining IPI buffer) */
+};
+
+/**
+ * Payload structures for specific message types
+ */
+
+/* I/O interrupt forwarding */
+struct mk_io_irq_payload {
+	u32 irq_number;         /* Hardware IRQ number */
+	u32 vector;             /* Interrupt vector */
+	u32 device_id;          /* Device identifier (optional) */
+	u32 flags;              /* Control flags (priority, etc.) */
+};
+
+/* IRQ control flags */
+#define MK_IRQ_HIGH_PRIORITY    0x01
+#define MK_IRQ_LOW_LATENCY      0x02
+#define MK_IRQ_EDGE_TRIGGERED   0x04
+#define MK_IRQ_LEVEL_TRIGGERED  0x08
+
+/* CPU resource operations */
+struct mk_cpu_resource_payload {
+	u32 cpu_id;             /* Physical CPU ID */
+	u32 numa_node;          /* NUMA node (optional) */
+	u32 flags;              /* CPU capabilities/attributes */
+};
+
+/* CPU capability flags */
+#define MK_CPU_HAS_AVX512       0x01
+#define MK_CPU_HAS_TSX          0x02
+#define MK_CPU_HYPERTHREAD      0x04
+
+/* Memory resource operations */
+struct mk_mem_resource_payload {
+	u64 start_pfn;          /* Starting page frame number */
+	u64 nr_pages;           /* Number of pages */
+	u32 numa_node;          /* NUMA node */
+	u32 mem_type;           /* Memory type (normal/DMA/etc.) */
+};
+
+/* Memory types */
+#define MK_MEM_NORMAL           0x01
+#define MK_MEM_DMA              0x02
+#define MK_MEM_DMA32            0x04
+#define MK_MEM_HIGHMEM          0x08
+
+/**
+ * Message handler callback type
+ */
+typedef void (*mk_msg_handler_t)(u32 msg_type, u32 subtype,
+				 void *payload, u32 payload_len, void *ctx);
+
+/**
+ * Message API functions
+ */
+
+/**
+ * mk_send_message - Send a message to another CPU
+ * @instance_id: Target multikernel instance ID
+ * @msg_type: Message type identifier
+ * @subtype: Message subtype
+ * @payload: Pointer to payload data (can be NULL)
+ * @payload_len: Length of payload data
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_send_message(int instance_id, u32 msg_type, u32 subtype,
+		    void *payload, u32 payload_len);
+
+/**
+ * mk_register_msg_handler - Register handler for specific message type
+ * @msg_type: Message type to handle
+ * @handler: Handler function
+ * @ctx: Context pointer passed to handler
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_register_msg_handler(u32 msg_type, mk_msg_handler_t handler, void *ctx);
+
+/**
+ * mk_unregister_msg_handler - Unregister message handler
+ * @msg_type: Message type to unregister
+ * @handler: Handler function to remove
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_unregister_msg_handler(u32 msg_type, mk_msg_handler_t handler);
+
+/**
+ * Convenience functions for common message types
+ */
+
+/* I/O interrupt forwarding */
+static inline int mk_send_irq_forward(int instance_id, u32 irq_number,
+				      u32 vector, u32 device_id, u32 flags)
+{
+	struct mk_io_irq_payload payload = {
+		.irq_number = irq_number,
+		.vector = vector,
+		.device_id = device_id,
+		.flags = flags
+	};
+	return mk_send_message(instance_id, MK_MSG_IO, MK_IO_IRQ_FORWARD,
+			       &payload, sizeof(payload));
+}
+
+/* CPU resource management */
+static inline int mk_send_cpu_add(int instance_id, u32 cpu_id,
+				  u32 numa_node, u32 flags)
+{
+	struct mk_cpu_resource_payload payload = {
+		.cpu_id = cpu_id,
+		.numa_node = numa_node,
+		.flags = flags
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_CPU_ADD,
+			       &payload, sizeof(payload));
+}
+
+static inline int mk_send_cpu_remove(int instance_id, u32 cpu_id)
+{
+	struct mk_cpu_resource_payload payload = {
+		.cpu_id = cpu_id,
+		.numa_node = 0,
+		.flags = 0
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_CPU_REMOVE,
+			       &payload, sizeof(payload));
+}
+
+/* Memory resource management */
+static inline int mk_send_mem_add(int instance_id, u64 start_pfn, u64 nr_pages,
+				  u32 numa_node, u32 mem_type)
+{
+	struct mk_mem_resource_payload payload = {
+		.start_pfn = start_pfn,
+		.nr_pages = nr_pages,
+		.numa_node = numa_node,
+		.mem_type = mem_type
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_MEM_ADD,
+			       &payload, sizeof(payload));
+}
+
+static inline int mk_send_mem_remove(int instance_id, u64 start_pfn, u64 nr_pages)
+{
+	struct mk_mem_resource_payload payload = {
+		.start_pfn = start_pfn,
+		.nr_pages = nr_pages,
+		.numa_node = 0,
+		.mem_type = 0
+	};
+	return mk_send_message(instance_id, MK_MSG_RESOURCE, MK_RES_MEM_REMOVE,
+			       &payload, sizeof(payload));
+}
+
+/* Messaging system functions */
+int __init mk_messaging_init(void);
+void mk_messaging_cleanup(void);
+
 struct resource;
 
 extern phys_addr_t multikernel_alloc(size_t size);
diff --git a/kernel/multikernel/Makefile b/kernel/multikernel/Makefile
index b539acc656c6..f133e1eaf534 100644
--- a/kernel/multikernel/Makefile
+++ b/kernel/multikernel/Makefile
@@ -3,7 +3,7 @@
 # Makefile for multikernel support
 #
 
-obj-y += core.o mem.o kernfs.o dts.o ipi.o
+obj-y += core.o mem.o kernfs.o dts.o ipi.o messaging.o
 
 # Add libfdt include path for device tree parsing
 CFLAGS_dts.o = -I $(srctree)/scripts/dtc/libfdt
diff --git a/kernel/multikernel/core.c b/kernel/multikernel/core.c
index ee7a21327ea5..37dbf0cf4be6 100644
--- a/kernel/multikernel/core.c
+++ b/kernel/multikernel/core.c
@@ -505,9 +505,16 @@ static int __init multikernel_init(void)
 {
 	int ret;
 
+	ret = mk_messaging_init();
+	if (ret < 0) {
+		pr_err("Failed to initialize multikernel messaging: %d\n", ret);
+		return ret;
+	}
+
 	ret = mk_kernfs_init();
 	if (ret < 0) {
 		pr_err("Failed to initialize multikernel sysfs interface: %d\n", ret);
+		mk_messaging_cleanup();
 		return ret;
 	}
 
diff --git a/kernel/multikernel/messaging.c b/kernel/multikernel/messaging.c
new file mode 100644
index 000000000000..be1fba8778ec
--- /dev/null
+++ b/kernel/multikernel/messaging.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Multikernel Messaging System
+ * Copyright (C) 2025 Multikernel Technologies, Inc. All rights reserved
+ *
+ * Simple messaging layer on top of multikernel IPI infrastructure
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/multikernel.h>
+
+/* Per-type message handler registry */
+struct mk_msg_type_handler {
+	u32 msg_type;
+	struct mk_ipi_handler *ipi_handler;
+	mk_msg_handler_t msg_handler;
+	void *context;
+	struct mk_msg_type_handler *next;
+};
+
+static struct mk_msg_type_handler *mk_msg_type_handlers;
+static raw_spinlock_t mk_msg_type_handlers_lock = __RAW_SPIN_LOCK_UNLOCKED(mk_msg_type_handlers_lock);
+
+/**
+ * mk_message_type_ipi_callback - IPI callback to handle incoming messages for a specific type
+ * @data: IPI data containing the message
+ * @ctx: Context containing the message handler info
+ */
+static void mk_message_type_ipi_callback(struct mk_ipi_data *data, void *ctx)
+{
+	struct mk_msg_type_handler *type_handler = (struct mk_msg_type_handler *)ctx;
+	struct mk_message *msg;
+	u32 msg_type, msg_subtype;
+	void *payload;
+	u32 payload_len;
+
+	if (!type_handler || !type_handler->msg_handler) {
+		pr_warn("Multikernel message received but no handler registered\n");
+		return;
+	}
+
+	/* Verify this matches our expected message type */
+	if (data->type != type_handler->msg_type) {
+		pr_warn("Multikernel message type mismatch: expected 0x%x, got 0x%x\n",
+			type_handler->msg_type, data->type);
+		return;
+	}
+
+	/* Ensure we have at least a message header */
+	if (data->data_size < sizeof(struct mk_message)) {
+		pr_warn("Multikernel message too small: %zu bytes\n", data->data_size);
+		return;
+	}
+
+	msg = (struct mk_message *)data->buffer;
+
+	/* Validate message structure */
+	if (msg->payload_len > (data->data_size - sizeof(struct mk_message))) {
+		pr_warn("Multikernel message payload length invalid: %u > %zu\n",
+			msg->payload_len, data->data_size - sizeof(struct mk_message));
+		return;
+	}
+
+	msg_type = msg->msg_type;
+	msg_subtype = msg->msg_subtype;
+	payload = msg->payload_len > 0 ? msg->payload : NULL;
+	payload_len = msg->payload_len;
+
+	pr_debug("Multikernel message received: type=0x%x, subtype=0x%x, len=%u from CPU %d\n",
+		 msg_type, msg_subtype, payload_len, data->sender_cpu);
+
+	/* Call the registered handler for this message type */
+	type_handler->msg_handler(msg_type, msg_subtype, payload, payload_len, type_handler->context);
+}
+
+/**
+ * mk_send_message - Send a message to another CPU
+ * @instance_id: Target multikernel instance ID
+ * @msg_type: Message type identifier
+ * @subtype: Message subtype
+ * @payload: Pointer to payload data (can be NULL)
+ * @payload_len: Length of payload data
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_send_message(int instance_id, u32 msg_type, u32 subtype,
+		    void *payload, u32 payload_len)
+{
+	struct mk_message *msg;
+	size_t total_size;
+	int ret;
+
+	/* Calculate total message size */
+	total_size = sizeof(struct mk_message) + payload_len;
+
+	/* Check if message fits in IPI buffer */
+	if (total_size > MK_MAX_DATA_SIZE) {
+		pr_err("Multikernel message too large: %zu > %d bytes\n",
+		       total_size, MK_MAX_DATA_SIZE);
+		return -EMSGSIZE;
+	}
+
+	/* Allocate temporary buffer for message */
+	msg = kzalloc(total_size, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	/* Fill in message header */
+	msg->msg_type = msg_type;
+	msg->msg_subtype = subtype;
+	msg->msg_id = 0; /* Could be enhanced with unique IDs later */
+	msg->payload_len = payload_len;
+
+	/* Copy payload if provided */
+	if (payload && payload_len > 0)
+		memcpy(msg->payload, payload, payload_len);
+
+	/* Send via IPI using the message type as IPI type */
+	ret = multikernel_send_ipi_data(instance_id, msg, total_size, msg_type);
+
+	/* Clean up temporary buffer */
+	kfree(msg);
+
+	if (ret < 0) {
+		pr_err("Failed to send multikernel message: %d\n", ret);
+		return ret;
+	}
+
+	pr_debug("Multikernel message sent: type=0x%x, subtype=0x%x, len=%u to instance %d\n",
+		 msg_type, subtype, payload_len, instance_id);
+
+	return 0;
+}
+EXPORT_SYMBOL(mk_send_message);
+
+/**
+ * mk_register_msg_handler - Register handler for specific message type
+ * @msg_type: Message type to handle
+ * @handler: Handler function
+ * @ctx: Context pointer passed to handler
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_register_msg_handler(u32 msg_type, mk_msg_handler_t handler, void *ctx)
+{
+	struct mk_msg_type_handler *type_handler;
+	unsigned long flags;
+
+	if (!handler)
+		return -EINVAL;
+
+	/* Check if handler for this type already exists */
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	for (type_handler = mk_msg_type_handlers; type_handler; type_handler = type_handler->next) {
+		if (type_handler->msg_type == msg_type) {
+			raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+			pr_warn("Handler for message type 0x%x already registered\n", msg_type);
+			return -EEXIST;
+		}
+	}
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	/* Allocate new type handler entry */
+	type_handler = kzalloc(sizeof(*type_handler), GFP_KERNEL);
+	if (!type_handler)
+		return -ENOMEM;
+
+	type_handler->msg_type = msg_type;
+	type_handler->msg_handler = handler;
+	type_handler->context = ctx;
+
+	/* Register IPI handler for this message type */
+	type_handler->ipi_handler = multikernel_register_handler(mk_message_type_ipi_callback,
+									 type_handler, msg_type);
+	if (!type_handler->ipi_handler) {
+		pr_err("Failed to register IPI handler for message type 0x%x\n", msg_type);
+		kfree(type_handler);
+		return -ENOMEM;
+	}
+
+	/* Add to type handler list */
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	type_handler->next = mk_msg_type_handlers;
+	mk_msg_type_handlers = type_handler;
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	pr_debug("Registered multikernel message handler for type 0x%x\n", msg_type);
+	return 0;
+}
+EXPORT_SYMBOL(mk_register_msg_handler);
+
+/**
+ * mk_unregister_msg_handler - Unregister message handler
+ * @msg_type: Message type to unregister
+ * @handler: Handler function to remove
+ *
+ * Returns 0 on success, negative error code on failure
+ */
+int mk_unregister_msg_handler(u32 msg_type, mk_msg_handler_t handler)
+{
+	struct mk_msg_type_handler **pp, *type_handler;
+	unsigned long flags;
+	int found = 0;
+
+	if (!handler)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	pp = &mk_msg_type_handlers;
+	while ((type_handler = *pp) != NULL) {
+		if (type_handler->msg_type == msg_type && type_handler->msg_handler == handler) {
+			*pp = type_handler->next;
+			found = 1;
+			break;
+		}
+		pp = &type_handler->next;
+	}
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	if (found) {
+		/* Unregister the IPI handler */
+		if (type_handler->ipi_handler) {
+			multikernel_unregister_handler(type_handler->ipi_handler);
+		}
+		kfree(type_handler);
+		pr_debug("Unregistered multikernel message handler for type 0x%x\n", msg_type);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(mk_unregister_msg_handler);
+
+/**
+ * mk_messaging_init - Initialize the messaging system
+ *
+ * Called during multikernel initialization to set up message handling
+ * Returns 0 on success, negative error code on failure
+ */
+int __init mk_messaging_init(void)
+{
+	/* No global IPI handler needed anymore - handlers are registered per message type */
+	pr_info("Multikernel messaging system initialized\n");
+	return 0;
+}
+
+/**
+ * mk_messaging_cleanup - Cleanup the messaging system
+ *
+ * Called during multikernel cleanup
+ */
+void mk_messaging_cleanup(void)
+{
+	struct mk_msg_type_handler *type_handler, *next;
+	unsigned long flags;
+
+	/* Clean up all registered message type handlers */
+	raw_spin_lock_irqsave(&mk_msg_type_handlers_lock, flags);
+	type_handler = mk_msg_type_handlers;
+	mk_msg_type_handlers = NULL;
+	raw_spin_unlock_irqrestore(&mk_msg_type_handlers_lock, flags);
+
+	while (type_handler) {
+		next = type_handler->next;
+
+		/* Unregister IPI handler */
+		if (type_handler->ipi_handler) {
+			multikernel_unregister_handler(type_handler->ipi_handler);
+		}
+
+		kfree(type_handler);
+		type_handler = next;
+	}
+
+	pr_info("Multikernel messaging system cleaned up\n");
+}
-- 
2.34.1


