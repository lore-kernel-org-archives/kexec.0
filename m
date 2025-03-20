Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83118C36008
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+uiHbtbR2+LTCG9tPghyUo9+PEq69RRB7eOXIX8kmmQ=; b=YZvCv55o7FTjL7kD5O8Cw8wPFn
	fWi3ejIvz8l3IPt2JSsfKLZsJ4OoUKlWkKg49GD9t71kETH3HuU15foX/MxQN3RAxsPtVfwQmatah
	pEUQ6AP3bpMA4NT8h3ntR5AmT2Iun2SRy/a0w2w6Pr1xo2CTnIJsiXzDg6GU3B2qkBrRzNnSiqktq
	OZ/q4z3sKWw3bPLr4AoLhp25HasHKce4z34ZbtoDdg3QgILZrj5d38e//E/8JCXmw8eDShHqsjD/e
	1w4Kx5dQJxzJjE7TRD33j9uhl77g2DVVuXANUphZtOnSuvLmWsl2OUydohGqHSCbt6O3gSlGsl+2X
	LfW77viQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS7-0000000CUGN-0r7U;
	Thu, 20 Mar 2025 15:04:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv594-0000000Akpu-0rKZ
	for kexec@bombadil.infradead.org;
	Thu, 20 Mar 2025 01:56:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+uiHbtbR2+LTCG9tPghyUo9+PEq69RRB7eOXIX8kmmQ=; b=MmLIAyAMMArYv65dUBzyozMJaU
	e20J+1wqafhCVXZ4GqlA27xHeNZnqDcRRbVoAKoW+fVic1MDV35ZzbdD7P3Tm0W3SICjx9rfVPVro
	2L+9vTTzMSLSA1XpISq4ZZZyV0DcxNydb5sp6eEBmkw9N9mIRV4+zDewzW0nm5L2qwZaHRM0AQvFF
	2ESZp+H2JcSpRQqYHWe0Tj9L16CenIZZnG/okGo+VLjNnxl3Cz/3xZjGZieTX7ju4NuzsGdqbpbeH
	p/Q16YlOEYbJmVOKBpdAEp6Z0F3WIN9V8zXKZ4QzF4lQu42IeBL6e+HlI5fxplXpECtmRoX0Pk3Kw
	DNNQkwTw==;
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv590-000000043fy-2n1h
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:29 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2ff62f96b10so2210662a91.0
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435784; x=1743040584; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uiHbtbR2+LTCG9tPghyUo9+PEq69RRB7eOXIX8kmmQ=;
        b=e3k0Lo60PpHn6fXyv87r9sknedIJLblwUeYNTZlcRNoYG3vdMS4Dk5/jnA2XlsPftS
         nPQuYA8WQEcxdpzIgJCgIxJYV0goxlNwVZ9cBovx+zo5l0bpYmCcmdTl8WrEw3Djt5aa
         YYXI5mCQ2B7WqM2b4Bg1ogyE1ltv8yM0Bblp/gCwitzYp7U/pFGAptq6DCyFdsclz0B0
         tzfHGjKhpavcXoX0tuMuwiBU+0IK5RBEKrvtcXuYVNvCaxslFfctpeP5+2DI7zWCClG1
         c75pvvy1P4zGdUfcMtS5Umq7++32GsiQGW/FJBuJWwqpti2H3DRUaHEjIZsnFpvVf4BE
         iAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435784; x=1743040584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uiHbtbR2+LTCG9tPghyUo9+PEq69RRB7eOXIX8kmmQ=;
        b=A6V8eGgnjdA2/nh095chq5WS4WFCbBxUB9HbyIfe/237UqhKgvLiRl0UEOjcGIg4n1
         NWqHbUL66Sa/UbpCeXqpS+dth49ATAEWMHQkeZbIm7N1fdNZq9+5mcaw8YF2ww6wlOUW
         QDliWubBi8buWIqvUrxgDGjttw/3gck5Xw8q56Q8B3KsU1Jnxe/jbVJ+fRWJ2rrNhRss
         3Q/+RCi1f07BPSekGgDXkuYy8pWwI9b2/gCV+YAHaY+yuzavQ/RWub8xS5gRDNnovG9n
         i6n3AQcaJiWlpI0n47LGTTKhL2ZDwlU7YvcM2XWrWmGVcF39V97wSH7dbx5Y2xI9EzqV
         EPig==
X-Forwarded-Encrypted: i=1; AJvYcCXu1wQkrHOZqAiix44Y65q6LEfmh0Ijvo0w84M4AtBfaB2IcrCBaiftTRYCKFQu4ixF8jiy2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzAS956JNPTAckIZk9Ucpjvn039idql4pJpxnB8AKELC6+tVoW6
	fhc54jv0I3B6zEMwiXU40YSASzLskiolMwqMqzd05uFpB1kzft4ard1PzDSCmLM/p1FqYV1hfT+
	oFmxvP+NnTsSyVa0Z2g==
X-Google-Smtp-Source: AGHT+IGco0TbFvrpWaz7RU09LVDLIbrwQOB0hzzeh7i66UCW7yrWSDQtXXKFJgzbGrQWcK/LzqGUCqggvCd+K/bd
X-Received: from pgvr15.prod.google.com ([2002:a65:60cf:0:b0:ad8:bdc2:8a33])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:69c:b0:1f5:8bf4:fde0 with SMTP id adf61e73a8af0-1fd0904c18cmr2493103637.9.1742435784427;
 Wed, 19 Mar 2025 18:56:24 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:50 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-16-changyuanl@google.com>
Subject: [PATCH v5 15/16] memblock: add KHO support for reserve_mem
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_015627_239057_4F772A4F 
X-CRM114-Status: GOOD (  19.87  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

From: Alexander Graf <graf@amazon.com>

Linux has recently gained support for "reserve_mem": A mechanism to
allocate a region of memory early enough in boot that we can cross our
fingers and hope it stays at the same location during most boots, so we
can store for example ftrace buffers into it.

Thanks to KASLR, we can never be really sure that "reserve_mem"
allocations are static across kexec. Let's teach it KHO awareness so
that it serializes its reservations on kexec exit and deserializes them
again on boot, preserving the exact same mapping across kexec.

This is an example user for KHO in the KHO patch set to ensure we have
at least one (not very controversial) user in the tree before extending
KHO's use to more subsystems.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 mm/memblock.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index d28abf3def1c..dd698c55b87e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -17,6 +17,10 @@
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#include <linux/kexec_handover.h>
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 #include <asm/sections.h>
 #include <linux/io.h>
 
@@ -2431,6 +2435,176 @@ int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *
 }
 EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#define MEMBLOCK_KHO_NODE "memblock"
+#define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
+#define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
+
+static struct kho_node memblock_kho_node = KHO_NODE_INIT;
+
+static void reserve_mem_kho_reset(void)
+{
+	int i;
+	struct kho_node *node;
+
+	kho_remove_node(NULL, MEMBLOCK_KHO_NODE);
+	kho_remove_prop(&memblock_kho_node, "compatible", NULL);
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		node = kho_remove_node(&memblock_kho_node, map->name);
+		if (IS_ERR(node))
+			continue;
+
+		kho_unpreserve_phys(map->start, map->size);
+
+		kho_remove_prop(node, "compatible", NULL);
+		kho_remove_prop(node, "start", NULL);
+		kho_remove_prop(node, "size", NULL);
+
+		kfree(node);
+	}
+}
+
+static int reserve_mem_kho_finalize(void)
+{
+	int i, err = 0;
+	struct kho_node *node;
+
+	if (!reserved_mem_count)
+		return NOTIFY_DONE;
+
+	err = kho_add_node(NULL, MEMBLOCK_KHO_NODE, &memblock_kho_node);
+	if (err == 1)
+		return NOTIFY_DONE;
+
+	err |= kho_add_string_prop(&memblock_kho_node, "compatible",
+				   MEMBLOCK_KHO_NODE_COMPATIBLE);
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		node = kmalloc(sizeof(*node), GFP_KERNEL);
+		if (!node) {
+			err = -ENOMEM;
+			break;
+		}
+
+		err |= kho_preserve_phys(map->start, map->size);
+
+		kho_init_node(node);
+		err |= kho_add_string_prop(node, "compatible",
+					   RESERVE_MEM_KHO_NODE_COMPATIBLE);
+		err |= kho_add_prop(node, "start", &map->start,
+				    sizeof(map->start));
+		err |= kho_add_prop(node, "size", &map->size,
+				    sizeof(map->size));
+		err |= kho_add_node(&memblock_kho_node, map->name, node);
+
+		if (err)
+			break;
+	}
+
+	if (err) {
+		pr_err("failed to save reserve_mem to KHO: %d\n", err);
+		reserve_mem_kho_reset();
+		return NOTIFY_STOP;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int reserve_mem_kho_notifier(struct notifier_block *self,
+				    unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case KEXEC_KHO_FINALIZE:
+		return reserve_mem_kho_finalize();
+	case KEXEC_KHO_UNFREEZE:
+		return NOTIFY_DONE;
+	default:
+		return NOTIFY_BAD;
+	}
+}
+
+static struct notifier_block reserve_mem_kho_nb = {
+	.notifier_call = reserve_mem_kho_notifier,
+};
+
+static int __init reserve_mem_init(void)
+{
+	if (!kho_is_enabled())
+		return 0;
+
+	return register_kho_notifier(&reserve_mem_kho_nb);
+}
+core_initcall(reserve_mem_init);
+
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	int err, len_start, len_size;
+	struct kho_in_node node, child;
+	const phys_addr_t *p_start, *p_size;
+
+	err = kho_get_node(NULL, MEMBLOCK_KHO_NODE, &node);
+	if (err)
+		return false;
+
+	err = kho_node_check_compatible(&node, MEMBLOCK_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("Node '%s' is incompatible with %s: %d\n",
+			MEMBLOCK_KHO_NODE, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
+		return false;
+	}
+
+	err = kho_get_node(&node, name, &child);
+	if (err) {
+		pr_warn("Node '%s' has no child '%s': %d\n",
+			MEMBLOCK_KHO_NODE, name, err);
+		return false;
+	}
+	err = kho_node_check_compatible(&child, RESERVE_MEM_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("Node '%s/%s' is incompatible with %s: %d\n",
+			MEMBLOCK_KHO_NODE, name,
+			RESERVE_MEM_KHO_NODE_COMPATIBLE, err);
+		return false;
+	}
+
+	p_start = kho_get_prop(&child, "start", &len_start);
+	p_size = kho_get_prop(&child, "size", &len_size);
+	if (!p_start || len_start != sizeof(*p_start) || !p_size ||
+	    len_size != sizeof(*p_size)) {
+		return false;
+	}
+
+	if (*p_start & (align - 1)) {
+		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%lx, 0x%lx)\n",
+			name, (long)align, (long)*p_start);
+		return false;
+	}
+
+	if (*p_size != size) {
+		pr_warn("KHO reserve-mem '%s' has wrong size (0x%lx != 0x%lx)\n",
+			name, (long)*p_size, (long)size);
+		return false;
+	}
+
+	reserved_mem_add(*p_start, size, name);
+	pr_info("Revived memory reservation '%s' from KHO\n", name);
+
+	return true;
+}
+#else
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 /*
  * Parse reserve_mem=nn:align:name
  */
@@ -2486,6 +2660,11 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_find_by_name(name, &start, &tmp))
 		return -EBUSY;
 
+	/* Pick previous allocations up from KHO if available */
+	if (reserve_mem_kho_revive(name, size, align))
+		return 1;
+
+	/* TODO: Allocation must be outside of scratch region */
 	start = memblock_phys_alloc(size, align);
 	if (!start)
 		return -ENOMEM;
-- 
2.48.1.711.g2feabab25a-goog


