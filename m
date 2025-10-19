Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A2FCCD184
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SIzBYAq5cauMEng/8nrVC1spI8sxNqVcm1FTDbL64Gs=; b=W48oVeVXzXNIkJmcats80zOmfd
	NX2v3BzNEPPIjyQicB4p4nsSs455mhyE1OP12jo6fMYJrhuMwnA6/1i4OcuhzHbkXFMtBhjnYXFsI
	qGDhlueRjv+XD6UZUap/dSwAk8IA9+ESW+SgoWVzDjdqk1rr85ph+Ru+wt7G9iwWIRJ366NAWdWBo
	hMF3LBNmjLd2PDr0FfFFqsKQwnbhO5cESHlLY6IwGkSaOuPtY9mKbmD6xSOEHllJdz4vYLAQvCMEv
	rTUrw9J881XqIP6Sz0Z8LSMrllzvCiNTDN4NCNFmazVrELQ7/3oWId57ZcYkKFRLxFF0mcMP4hj5F
	wg2gHAaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjG-0000000AjGn-1vYV;
	Sun, 19 Oct 2025 06:17:18 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjE-0000000AjEo-0Gqh
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:17 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7835321bc98so2925146b3a.2
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854635; x=1761459435; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIzBYAq5cauMEng/8nrVC1spI8sxNqVcm1FTDbL64Gs=;
        b=bIAzzjnaSCKa9EQF3IgYo+bVi9+4x4xGWspx4E4jTt5KqLLkhCUna1Q+aOEogFHaD7
         aK7yNsr0p2ybPU4b/+jglIr0/IfMBUH0y23VtsCr5CGTrFSk4+7CRJVTuPhHSzdeSD1C
         OK4iMm7lnlSSkU82WSWWlCQV65CuUY8gMqdx1+EUWIULqVXWsRQPepaMxIVZg5W3Gd3Q
         33d/63mNHNFPU8sapmIZsVlF52cvDcw/KcbxxbaDITDqNlPz7Iit/mRU56jthwjgHwc+
         gvBg4RM2W/9KIPjNbWpdcHtmUI34hLRIZ02wyt6wUDcJ7dZV/d4eYSoJUXHaUvAAzMiu
         TcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854635; x=1761459435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIzBYAq5cauMEng/8nrVC1spI8sxNqVcm1FTDbL64Gs=;
        b=lMBSyDEM3j3nVk3Njxhgu3UK4IByYEN8Db/iXNRrpOqfViRDdfeo049WVjqouVS1b0
         0+3D0XYraeWq3z59KfxHkswVFSvx0zdDE5U3brp9KTL8rl0XxKjTahyoSHXdZfSVWYF+
         ZPie6pHUFawAtP3fdMf+65gegUa6XJZA8+qJDCFuSmFwdDOroK0LhfIe5NZFhTlSpNIu
         U5AgzsHCFnz9qjJcrBbKTRj+fLpFXckhB9+rbN04SxXdDPwMtV88cdjGeTdGq5JUCcvD
         COTGuCD6Sfbmb8ThZ7Q/fTyxagB5P8WWtqs2cpB/7MmfCVqHnbrymNR0Lmj+hs+yjBI6
         cyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV12oICTHMeiJOQctNvMe2scI7646X8gpmIhbW4cDuX8126IbAI3fqkXWWnBRBOLZLTPsvNbQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwlDn60y3k0CpzBqDWwTKKFumvG9avN+fO0CJ8KQtVjpZ2h0taH
	hYdlacZCSHgAjUgGmyB5rvB+h4KiQt+LlSMKVyT1n49XINroE9ixKS8H
X-Gm-Gg: ASbGncvt08J5xNeJLD+YdpnRTfBhMJs+TEwAIFkHWKnEp4sX0cr6tee8xZrWVymsCGE
	Ujpj8WVzN+K5vlnxIWYwtB4ldnvx48yloUL+++PJAaE8e3b0UPnHV68jKBnoTH30ZI8M8uHes4V
	Ska8fe11bbmTMfGsBzzs79hM5MKWbVu4oy6kZasd7e2MkFTmp5xhs3/XDQ0JHtLI+Vto/fPRJbL
	oJ3o2mbqwUF9oV//o1rJDmtHgwOB6xDxLTBkYCK8nxKI2dDdhd/51O2InJ2RNiLSNP6Ryi04VyU
	uXzGITAreKl3lPQd1UtY0rFPOid5VNAo//pJ1vHo2OjR7ee40SxG87MBDYUN9q9LAuSTxfk5DsY
	kVwGYzB3CoPLza2RL7KroXTNRAlRlMiR8o28HGPL4XUL6WZB613YK9mG1m+k/a6oxDPASA+PxPh
	hahgzh
X-Google-Smtp-Source: AGHT+IHfF4hU8/QtsMDLLQvEjqsCa8w0BBb+2CNnqIZAGSLrLtnMeBv6KtywAED8Fp+17ZtBPczCAA==
X-Received: by 2002:a05:6a20:7355:b0:32d:b925:4a8 with SMTP id adf61e73a8af0-334a851519cmr11699864637.3.1760854635123;
        Sat, 18 Oct 2025 23:17:15 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:14 -0700 (PDT)
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
Subject: [RFC Patch v2 12/16] multikernel: Introduce per-instance memory allocation interface
Date: Sat, 18 Oct 2025 23:16:26 -0700
Message-Id: <20251019061631.2235405-13-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231716_120999_6EE42B04 
X-CRM114-Status: GOOD (  15.12  )
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

Add virtual memory allocation interface for multikernel instances,
providing convenient high-level functions for memory management within
instance-specific memory pools with automatic virtual address mapping.

This commit introduces:

* Instance-based memory allocation functions (mk_instance_alloc() and
  mk_instance_free()) that provide virtual memory allocation from
  instance-specific memory pools with configurable alignment support
  and automatic physical-to-virtual address mapping using memremap().

* Kimage-based memory allocation wrappers (mk_kimage_alloc() and
  mk_kimage_free()) that provide convenient access to instance memory
  pools through kimage structures, commonly used in kexec code paths
  for multikernel operations.

* Automatic memory mapping infrastructure that uses memremap() with
  MEMREMAP_WB caching policy to provide write-back cached virtual
  addresses for allocated physical memory from instance pools.

* Proper error handling and cleanup with automatic rollback of
  physical allocations when virtual mapping fails, preventing memory
  leaks in error conditions.

The allocation functions complement the existing physical memory pool
management by providing a higher-level interface suitable for kernel
code that requires virtual addresses, such as buffer management, data
structure allocation, and inter-kernel communication buffers.

This interface enables multikernel subsystems to allocate kernel images,
initramfs etc., maintaining proper resource isolation between multikernel
instances.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/multikernel.h |  6 +++
 kernel/multikernel/core.c   | 98 +++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/linux/multikernel.h b/include/linux/multikernel.h
index c65d39a66b84..79611923649e 100644
--- a/include/linux/multikernel.h
+++ b/include/linux/multikernel.h
@@ -280,6 +280,12 @@ int mk_instance_reserve_resources(struct mk_instance *instance,
  */
 void mk_instance_free_memory(struct mk_instance *instance);
 
+void *mk_instance_alloc(struct mk_instance *instance, size_t size, size_t align);
+void mk_instance_free(struct mk_instance *instance, void *virt_addr, size_t size);
+
+void *mk_kimage_alloc(struct kimage *image, size_t size, size_t align);
+void mk_kimage_free(struct kimage *image, void *virt_addr, size_t size);
+
 /**
  * String conversion helpers
  */
diff --git a/kernel/multikernel/core.c b/kernel/multikernel/core.c
index 52bf8e38206a..ee7a21327ea5 100644
--- a/kernel/multikernel/core.c
+++ b/kernel/multikernel/core.c
@@ -7,7 +7,10 @@
 #include <linux/init.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/kexec.h>
 #include <linux/multikernel.h>
+#include <asm/page.h>
 #include "internal.h"
 
 /**
@@ -403,6 +406,101 @@ int mk_instance_reserve_resources(struct mk_instance *instance,
 	return 0;
 }
 
+/**
+ * Per-instance memory pool management
+ */
+
+/**
+ * mk_instance_alloc() - Allocate memory from instance pool
+ * @instance: Instance to allocate from
+ * @size: Size to allocate
+ * @align: Alignment requirement (must be power of 2)
+ *
+ * Returns virtual address of allocated memory, or NULL on failure.
+ */
+void *mk_instance_alloc(struct mk_instance *instance, size_t size, size_t align)
+{
+	phys_addr_t phys_addr;
+	void *virt_addr;
+
+	if (!instance || !instance->instance_pool) {
+		pr_debug("mk_instance_alloc: instance %p has no pool\n", instance);
+		return NULL;
+	}
+
+	/* Allocate from instance pool with alignment */
+	phys_addr = multikernel_instance_alloc(instance->instance_pool, size, align);
+	if (!phys_addr) {
+		pr_debug("Failed to allocate %zu bytes from instance pool (align=0x%zx)\n", size, align);
+		return NULL;
+	}
+
+	/* Map to virtual address space */
+	virt_addr = memremap(phys_addr, size, MEMREMAP_WB);
+	if (!virt_addr) {
+		pr_err("Failed to map instance memory at 0x%llx\n", (unsigned long long)phys_addr);
+		multikernel_instance_free(instance->instance_pool, phys_addr, size);
+		return NULL;
+	}
+
+	return virt_addr;
+}
+
+/**
+ * mk_instance_free() - Free memory back to instance pool
+ * @instance: Instance to free to
+ * @virt_addr: Virtual address to free
+ * @size: Size to free
+ */
+void mk_instance_free(struct mk_instance *instance, void *virt_addr, size_t size)
+{
+	phys_addr_t phys_addr;
+
+	if (!instance || !instance->instance_pool || !virt_addr)
+		return;
+
+	phys_addr = virt_to_phys(virt_addr);
+	memunmap(virt_addr);
+	multikernel_instance_free(instance->instance_pool, phys_addr, size);
+}
+
+/**
+ * Kimage-based memory pool access functions
+ *
+ * These provide convenient wrappers for accessing instance memory pools
+ * through the kimage structure, commonly used in kexec code paths.
+ */
+
+/**
+ * mk_kimage_alloc() - Allocate memory from kimage's instance pool
+ * @image: kimage with associated mk_instance
+ * @size: Size to allocate
+ * @align: Alignment requirement (must be power of 2)
+ *
+ * Returns virtual address of allocated memory, or NULL on failure.
+ */
+void *mk_kimage_alloc(struct kimage *image, size_t size, size_t align)
+{
+	if (!image || !image->mk_instance)
+		return NULL;
+
+	return mk_instance_alloc(image->mk_instance, size, align);
+}
+
+/**
+ * mk_kimage_free() - Free memory back to kimage's instance pool
+ * @image: kimage with associated mk_instance
+ * @virt_addr: Virtual address to free
+ * @size: Size to free
+ */
+void mk_kimage_free(struct kimage *image, void *virt_addr, size_t size)
+{
+	if (!image || !image->mk_instance)
+		return;
+
+	mk_instance_free(image->mk_instance, virt_addr, size);
+}
+
 static int __init multikernel_init(void)
 {
 	int ret;
-- 
2.34.1


