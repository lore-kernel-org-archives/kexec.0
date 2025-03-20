Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090DDC35FFF
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MyKsFNp8HnVmgjRlr9CxzqXpTdvZkVjeQqS6GTtSoj0=; b=D8WjYVw+2+pnNR2qlKyydd6iSI
	gpHdS+s7HT9PPWMbb1YCXJro8QrgHZG1M9GX4tqfTUX2iE0jJ8Rib/dWvNpl6bWDVj/NuN37Mnrvv
	CLH+lr9AqH15KW8S8yXLrx1OseyPYIaIYO6LZOS/7zZJ5Ji4hbEHvye/lbezkNy8cSRoFvXd5sN2Y
	AueTjHWWL8XFBpi8GaACXTboN0X6DsiD9x29/BRe+QCdxDcjs4UNRvbDgZXdra6oa5hm5ORDV0wOz
	vUxRl2yI8jY2sum1kvJ3+2gsMaryLQPyMvnYwyq7HsBlwZNb/9XVvGFBDSy5AiDRJ8oTs1E7bTsmk
	cNMLd7NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRu-0000000CTvX-0OLo;
	Thu, 20 Mar 2025 15:04:46 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58d-0000000AkIA-1A3B
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:04 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so437029a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435762; x=1743040562; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyKsFNp8HnVmgjRlr9CxzqXpTdvZkVjeQqS6GTtSoj0=;
        b=UZw5ecLpbX1mRQDnVO+zxDFglR34oO918q7k846S3EaOzCKbCUxrlRoSRxRq5EuZgU
         RpBrfhVo2kAYcrjbvfsNbyxLtp46PdVMgk8DTB7UZkYyJDezwLo++LTNvEVnmVoJy1XT
         35wMJEq7vZXeOFCk3FDFWSFdGfzNsQrKpqic9TyQ1ZNtz0bgpQ5piCcJXOoBUYvtiMPy
         BpJlZhoB43adbPCxDkKm1a3xhmUOjFgVN1fJyrs4YJMlT3el4sJScUsjAAiAHQnLa4uf
         sOhmzTVuvrc9KjXxqat0A0NRrqEetZwSzWGYunt9xQ1SShlDa3fcL2Ur+Guhc0Gj598i
         454A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435762; x=1743040562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyKsFNp8HnVmgjRlr9CxzqXpTdvZkVjeQqS6GTtSoj0=;
        b=ZuTvcHpA2yP6XXCG5rSNjq/JFSF26xwfs8m33/6e/X04xCJHgTeMjsDIX4k09/Hiyc
         mOeobTDPK8v26/K9bP+r5ExjEsN3UUDIsQHvG0e08EmA9r5crziMxvKCuK8hLCtNejj2
         DeQH8IE+aRYjOvFoQzu9db3mbGqiKd+O8g7HWJsjS/Bd/ZgoujHCQ+lLgVCL8NHdsIfD
         874aUd2vjQDhQZjenzbJ9fFvOgCDtK7nzItjxjNpEuja1t9VQXrIxmeToUbECfIinzQD
         UrXO5GkBjk/d1c3oe+tREX2o1y7zf7Rn4nlFlYyd41IwxvFAhXnyto3UTzc4hXGlxVCr
         3cGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9gMzH2kFnpSHSeForwqsUKq5WVk9hPf/V1L5BbsgY8ezRwMRYab/JYw53lbOQtTjyLHh3fA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxxqttYoRnmsVoilv+jCYw1MXr6HDmasHNfXDiYUrIjmXcRt9Ve
	8/yeq+vUYRSBL3R497eZgGc6nFoKuC67MYRMaK4RWevdcQbWksqLEuX286K38t538FNeGQw7ymr
	k1Stytu7guuI+asswSg==
X-Google-Smtp-Source: AGHT+IH4fNuT0QWlfSI42heq+dLpm/GFEXTXaL6bQRWMvudZOwxIJGtvzZFRNXPgaqxisIVnXeLUFEDTHfoI9HMH
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2ee:4a90:3d06])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fc5:b0:2f6:d266:f462 with SMTP id 98e67ed59e1d1-301be20750dmr7815826a91.35.1742435761976;
 Wed, 19 Mar 2025 18:56:01 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:36 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-2-changyuanl@google.com>
Subject: [PATCH v5 01/16] kexec: define functions to map and unmap segments
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
	linux-mm@kvack.org, x86@kernel.org, steven chen <chenste@linux.microsoft.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_185603_319482_F1C85872 
X-CRM114-Status: GOOD (  18.54  )
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

From: steven chen <chenste@linux.microsoft.com>

Currently, the mechanism to map and unmap segments to the kimage
structure is not available to the subsystems outside of kexec.  This
functionality is needed when IMA is allocating the memory segments
during kexec 'load' operation.  Implement functions to map and unmap
segments to kimage.

Implement kimage_map_segment() to enable mapping of IMA buffer source
pages to the kimage structure post kexec 'load'.  This function,
accepting a kimage pointer, an address, and a size, will gather the
source pages within the specified address range, create an array of page
pointers, and map these to a contiguous virtual address range.  The
function returns the start of this range if successful, or NULL if
unsuccessful.

Implement kimage_unmap_segment() for unmapping segments
using vunmap().

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/kexec.h |  5 ++++
 kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..fad04f3bcf1d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -467,6 +467,8 @@ extern bool kexec_file_dbg_print;
 #define kexec_dprintk(fmt, arg...) \
         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
+void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
+void kimage_unmap_segment(void *buffer);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -474,6 +476,9 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
+{ return NULL; }
+static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0bdc1686154..640d252306ea 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+void *kimage_map_segment(struct kimage *image,
+			 unsigned long addr, unsigned long size)
+{
+	unsigned long eaddr = addr + size;
+	unsigned long src_page_addr, dest_page_addr;
+	unsigned int npages;
+	struct page **src_pages;
+	int i;
+	kimage_entry_t *ptr, entry;
+	void *vaddr = NULL;
+
+	/*
+	 * Collect the source pages and map them in a contiguous VA range.
+	 */
+	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
+	src_pages = kvmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
+	if (!src_pages) {
+		pr_err("Could not allocate source pages array for destination %lx.\n", addr);
+		return NULL;
+	}
+
+	i = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION) {
+			dest_page_addr = entry & PAGE_MASK;
+		} else if (entry & IND_SOURCE) {
+			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
+				src_page_addr = entry & PAGE_MASK;
+				src_pages[i++] =
+					virt_to_page(__va(src_page_addr));
+				if (i == npages)
+					break;
+				dest_page_addr += PAGE_SIZE;
+			}
+		}
+	}
+
+	/* Sanity check. */
+	WARN_ON(i < npages);
+
+	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
+	kvfree(src_pages);
+
+	if (!vaddr)
+		pr_err("Could not map segment source pages for destination %lx.\n", addr);
+
+	return vaddr;
+}
+
+void kimage_unmap_segment(void *segment_buffer)
+{
+	vunmap(segment_buffer);
+}
+
 struct kexec_load_limit {
 	/* Mutex protects the limit count. */
 	struct mutex mutex;
-- 
2.48.1.711.g2feabab25a-goog


