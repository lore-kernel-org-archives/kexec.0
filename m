Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1BDCCD1A7
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CHtfDmtNu58qaeT00d02kMdjaM8J6l+T+7ap5Uqy+yE=; b=q8RGvtEkXRF+xwXiDi9cN1Oj03
	61bCM7px2przBC9NVeYoM9rLaasBgIeAB4zuiUTqeC1mr5SXPIrLMMb3v9AbgiEo9KZCqtiufuikB
	WIZck27CNuDaU+S3czqsZ3AE5LOIivz+nsDV8QWD1h3MoGMYa1lRgAwvZcnzFz7yEVn6ItZk1MOTD
	Y3rYAKedZLhJa4L+fyjtTzDUXBLSZcqWIMgDNbIvF2G5U0rWptYOlMZoOEiGqR31o9O+kdXkS+l9j
	LXmliIhcmUtJMBZTc28nk7Txhfi+JcZ0bpVVYpUUI9epQgGpf9DS/qNeQbbrWZz6yl+bibVOimqVd
	Heqa2UAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjN-0000000AjNp-3PG1;
	Sun, 19 Oct 2025 06:17:25 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMjK-0000000AjKK-41eN
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:24 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7a1603a098eso2091175b3a.1
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854642; x=1761459442; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHtfDmtNu58qaeT00d02kMdjaM8J6l+T+7ap5Uqy+yE=;
        b=BFPgciKOafl8/Fd2FnCQGOIC/JwXyaLi3hd4dyc6Tt3BnNQLw7NQVXzxVDXsyNL7Sf
         wK+fum7GOqQWvrzvITaXW/xt73c44X/+A0fmny8f08Q62pk8+nBv0eJNN/jtx4Vk698z
         E6WAWz8vo7mNUs9M78AEm9/Qa3FdAsG9SRcKERXWvfyKZ2KOeIMZ0eA2U2VRhP4GfOgN
         IkkIJPoAz72zvT6uf6kp6Pqt+7M4QN2MKNdEQd3UaDAl1/LouKmqL90TfH1Z6ow2pAc+
         lxltFEbcALkcMVB0BQxbAYUDYx8YPexOOOxZIvmnuiBYMvvhjwVPxFrkTMsrTqKp2NIY
         8kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854642; x=1761459442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHtfDmtNu58qaeT00d02kMdjaM8J6l+T+7ap5Uqy+yE=;
        b=quDPyp+X/IZBq5PCs8CkTy7i4wVgv1g/cAzkmM5MPnSmGUnTecS+9oS7KG4hTKbvGO
         K3JtGEmT4Xvgn30Z5P7orICxo29/6qNvvd9rNft8TWpbA4cjWo3ETH+5oQTOh9P8dncc
         Rzy2Y4Z+TWq/JaxzYSMHUSI6gRNUf579rPoSS+QWVFRhUAFXNZd4hxhSw9sILWCqIhFz
         mxY8ncWz0bc/iG+KGv0aA3ZoK7YFFE8wPAEYSJBkglMk6NRIUibfNagSkowzhY2wHtfK
         1jq7FZViYhk5b38Oydd96bKyhfON8rgjasg6TJO2PORFhuO5xN6Wef+WJuYisB3nwVZr
         Sshg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Q0NXQphMQgdqZO7A7c+f/o8PAyHfRF+ZDcr77OfLHv4xxY7HJN6b1en/+LafKFQAkhh8lw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBPDEdKrP0VzHbyKzZjfuyvN+zB805yuqsw+HVb55GhxDS2vOO
	QuNqMzxzoSZJ47e93/C1paXr+MSiH6ADomeO4VX3KsOdbMO6Cfh3Y9Fl
X-Gm-Gg: ASbGncsbFbZfmxwMrbDCwZvUJ+kRnk5lIeFPpkR5cJuf/0jZHXZw/Nb4S6O8x047BwK
	Tns/+G0Q6nKqBpSDBlQQ87Lxr5o7bHsQCt9Sa1flgjjJOGry8wCWi09yo5Y7ss5ASSxBsh9DVcq
	JBh3PeEmWB6mci/2FlC/fQVqMCuaU+NlU0wtrbgs0qpJW4nVYPyyB/2z8oYlTLeyfnCkyfz1cga
	dsOybk7KS/4Trm5b5sF5HbuhgrtnkwWn7FHAs672PW4h1+Ek3cukhR2jMdz5n+GbtwNH998KsQf
	9iGkYlIUq2BXeB9DykKgVVM+89iTFjH0E9B2M+l+4SVAlvCQx+GRp29jPfpmA8pUPScWE3lr47s
	9Lpm7GZfU2PH22L3X5TxDfqoOsLBjkTBmbfs2U0LQR7dOdy79YeckXFZVojhS7UohEQXXJQMzIM
	mmT4rdxis5GvyBWm6972TxxhnoOA==
X-Google-Smtp-Source: AGHT+IF+l7vrEZFb1JvgrlXqJojLzFTrJb7A2HoVWh6qL7YExVTjo54P1fLRx45jmPuBVut01m7GGw==
X-Received: by 2002:a05:6a20:3945:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-334a8629db6mr11280818637.44.1760854642239;
        Sat, 18 Oct 2025 23:17:22 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:21 -0700 (PDT)
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
Subject: [RFC Patch v2 15/16] kexec: Integrate multikernel support with kexec_file_load()
Date: Sat, 18 Oct 2025 23:16:29 -0700
Message-Id: <20251019061631.2235405-16-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231723_048410_2D959411 
X-CRM114-Status: GOOD (  30.35  )
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

This commit introduces:

* Multikernel flag support in kexec_file_load by adding KEXEC_MULTIKERNEL
  to KEXEC_FILE_FLAGS, enabling user-space to specify multikernel
  operations through the file-based kexec interface with proper flag
  validation and ID extraction.

* Instance-based memory allocation for multikernel images through
  kexec_alloc_multikernel() that allocates kernel segments from
  instance-specific memory pools rather than system memory, ensuring
  compliance with device tree resource specifications.

* Multikernel control page allocation via kimage_alloc_multikernel_control_pages()
  that provides page-aligned control structures from instance pools
  with proper alignment validation and conflict detection against
  existing segments.

* Enhanced kimage_file_alloc_init() with multikernel instance association
  that extracts multikernel IDs from kexec flags, validates instance
  availability, establishes bidirectional cross-references, and updates
  instance states to LOADING during the load process.

* Integrated memory hole location in kexec_locate_mem_hole() that
  prioritizes multikernel instance pool allocation over system memory
  allocation, ensuring multikernel segments respect reserved memory
  boundaries and resource isolation.

The integration maintains compatibility with existing kexec_file_load()
use cases, such as crash kernel, while extending it for multikernel case.
Standard kexec operations continue to use system memory allocation, while
multikernel operations automatically use instance-specific pools when
the KEXEC_MULTIKERNEL flag is specified.

This enables user-space tools to load multikernel images using the
more secure and flexible kexec_file_load interface rather than the
legacy kexec_load syscall, providing better integration with modern
security frameworks and signed kernel verification.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/kexec.h |   3 +-
 kernel/kexec_core.c   |  61 ++++++++++++++++++++++
 kernel/kexec_file.c   | 116 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5e9e9ad1dfeb..b907b7a92fd2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -477,7 +477,8 @@ bool kexec_load_permitted(int kexec_image_type);
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
-				 KEXEC_FILE_NO_CMA | KEXEC_FILE_FORCE_DTB)
+				 KEXEC_FILE_NO_CMA | KEXEC_FILE_FORCE_DTB | \
+				 KEXEC_MULTIKERNEL)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7db755e64dd6..61ad01acd034 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -476,6 +476,64 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 }
 #endif
 
+static struct page *kimage_alloc_multikernel_control_pages(struct kimage *image,
+							   unsigned int order)
+{
+	/* Control pages for multikernel must be allocated from the instance's
+	 * memory pool to ensure they stay within the reserved memory regions
+	 * specified in the device tree configuration.
+	 *
+	 * We use mk_kimage_alloc() to get memory from the instance pool,
+	 * then convert it to page structures.
+	 */
+	void *virt_addr;
+	phys_addr_t phys_addr;
+	struct page *pages;
+	unsigned long size;
+	unsigned int count;
+
+	if (!image->mk_instance) {
+		pr_err("Multikernel image has no associated instance\n");
+		return NULL;
+	}
+
+	count = 1 << order;
+	size = count << PAGE_SHIFT;
+
+	/* Allocate from the multikernel instance pool (page aligned) */
+	virt_addr = mk_kimage_alloc(image, size, PAGE_SIZE);
+	if (!virt_addr) {
+		pr_debug("Failed to allocate %lu bytes for multikernel control pages\n", size);
+		return NULL;
+	}
+
+	/* Convert virtual address to physical */
+	phys_addr = virt_to_phys(virt_addr);
+
+	/* Check alignment requirements - control pages need page alignment */
+	if (!IS_ALIGNED(phys_addr, PAGE_SIZE)) {
+		pr_err("Multikernel control page allocation not page-aligned: phys=0x%llx\n",
+		       (unsigned long long)phys_addr);
+		mk_kimage_free(image, virt_addr, size);
+		return NULL;
+	}
+
+	/* Get the page structure */
+	pages = virt_to_page(virt_addr);
+
+	/* Check for conflicts with existing segments */
+	if (kimage_is_destination_range(image, phys_addr, phys_addr + size - 1)) {
+		pr_debug("Multikernel control pages conflict with existing segments: 0x%llx+0x%lx\n",
+			 (unsigned long long)phys_addr, size);
+		mk_kimage_free(image, virt_addr, size);
+		return NULL;
+	}
+
+	pr_debug("Allocated multikernel control pages: order=%u, phys=0x%llx, virt=%px\n",
+		 order, (unsigned long long)phys_addr, virt_addr);
+
+	return pages;
+}
 
 struct page *kimage_alloc_control_pages(struct kimage *image,
 					 unsigned int order)
@@ -491,6 +549,9 @@ struct page *kimage_alloc_control_pages(struct kimage *image,
 		pages = kimage_alloc_crash_control_pages(image, order);
 		break;
 #endif
+	case KEXEC_TYPE_MULTIKERNEL:
+		pages = kimage_alloc_multikernel_control_pages(image, order);
+		break;
 	}
 
 	return pages;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2d9d5626c8da..f9979c1d9f9e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/dma-map-ops.h>
+#include <linux/multikernel.h>
 #include "kexec_internal.h"
 
 #ifdef CONFIG_KEXEC_SIG
@@ -309,6 +310,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	int ret;
 	struct kimage *image;
 	bool kexec_on_panic = flags & KEXEC_FILE_ON_CRASH;
+	bool multikernel_load = flags & KEXEC_MULTIKERNEL;
 
 	image = do_kimage_alloc_init();
 	if (!image)
@@ -322,8 +324,50 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 		/* Enable special crash kernel control page alloc policy. */
 		image->control_page = crashk_res.start;
 		image->type = KEXEC_TYPE_CRASH;
-	}
+	} else
 #endif
+	if (multikernel_load) {
+		struct mk_instance *instance;
+		int mk_id = KEXEC_GET_MK_ID(flags);
+
+		/* Set multikernel image type for proper memory allocation */
+		image->type = KEXEC_TYPE_MULTIKERNEL;
+
+		pr_info("kexec_file_load: multikernel load - flags=0x%lx, extracted mk_id=%d\n",
+			flags, mk_id);
+
+		if (mk_id <= 0) {
+			pr_err("Invalid multikernel ID %d in flags\n", mk_id);
+			ret = -EINVAL;
+			goto out_free_image;
+		}
+
+		/* Find the existing mk_instance */
+		instance = mk_instance_find(mk_id);
+		if (!instance) {
+			pr_err("No multikernel instance found with ID %d\n", mk_id);
+			ret = -ENOENT;
+			goto out_free_image;
+		}
+
+		/* Check if instance is already associated with a kimage */
+		if (instance->kimage) {
+			pr_err("Multikernel instance %d already has an associated kimage\n", mk_id);
+			mk_instance_put(instance);
+			ret = -EBUSY;
+			goto out_free_image;
+		}
+
+		/* Establish cross-references */
+		image->mk_instance = instance; /* Transfer reference from find */
+		image->mk_id = mk_id;
+		instance->kimage = image;
+
+		/* Update instance state */
+		mk_instance_set_state(instance, MK_STATE_LOADING);
+
+		pr_info("Associated kimage with multikernel instance %d\n", mk_id);
+	}
 
 	ret = kimage_file_prepare_segments(image, kernel_fd, initrd_fd,
 					   cmdline_ptr, cmdline_len, flags);
@@ -731,6 +775,61 @@ static int kexec_alloc_contig(struct kexec_buf *kbuf)
 	return 0;
 }
 
+static int kexec_alloc_multikernel(struct kexec_buf *kbuf)
+{
+	void *virt_addr;
+	phys_addr_t phys_addr;
+
+	pr_info("kexec_alloc_multikernel: called for segment size=0x%lx, buf_min=0x%lx, buf_max=0x%lx, align=0x%lx\n",
+		kbuf->memsz, kbuf->buf_min, kbuf->buf_max, kbuf->buf_align);
+
+	/* Check if this is a multikernel image with an associated instance */
+	if (!kbuf->image->mk_instance || kbuf->image->type != KEXEC_TYPE_MULTIKERNEL) {
+		pr_info("kexec_alloc_multikernel: not a multikernel image (mk_instance=%p, type=%d)\n",
+			kbuf->image->mk_instance, kbuf->image->type);
+		return -EPERM;
+	}
+
+	/* Allocate from the multikernel instance pool using the proper API */
+	virt_addr = mk_kimage_alloc(kbuf->image, kbuf->memsz, kbuf->buf_align);
+	if (!virt_addr) {
+		pr_info("Failed to allocate %lu bytes from multikernel instance pool (align=0x%lx)\n",
+			kbuf->memsz, kbuf->buf_align);
+		return -ENOMEM;
+	}
+
+	/* Convert virtual address to physical */
+	phys_addr = virt_to_phys(virt_addr);
+
+	if (!IS_ALIGNED(phys_addr, kbuf->buf_align)) {
+		pr_info("Multikernel allocation not aligned: phys=0x%llx, required=0x%lx\n",
+			 (unsigned long long)phys_addr, kbuf->buf_align);
+		mk_kimage_free(kbuf->image, virt_addr, kbuf->memsz);
+		return -ENOMEM;
+	}
+
+	if (phys_addr < kbuf->buf_min || (phys_addr + kbuf->memsz - 1) > kbuf->buf_max) {
+		pr_info("Multikernel allocation out of bounds: phys=0x%llx, min=0x%lx, max=0x%lx\n",
+			 (unsigned long long)phys_addr, kbuf->buf_min, kbuf->buf_max);
+		mk_kimage_free(kbuf->image, virt_addr, kbuf->memsz);
+		return -ENOMEM;
+	}
+
+	if (kimage_is_destination_range(kbuf->image, phys_addr, phys_addr + kbuf->memsz - 1)) {
+		pr_info("Multikernel allocation conflicts with existing segments: 0x%llx+0x%lx\n",
+			 (unsigned long long)phys_addr, kbuf->memsz);
+		mk_kimage_free(kbuf->image, virt_addr, kbuf->memsz);
+		return -EBUSY;
+	}
+
+	kbuf->mem = phys_addr;
+
+	pr_info("Allocated %lu bytes from multikernel pool at 0x%llx (virt=%px)\n",
+		 kbuf->memsz, (unsigned long long)phys_addr, virt_addr);
+
+	return 0;
+}
+
 /**
  * kexec_locate_mem_hole - find free memory for the purgatory or the next kernel
  * @kbuf:	Parameters for the memory search.
@@ -743,8 +842,21 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
 	int ret;
 
+	pr_info("kexec_locate_mem_hole: called for segment size=0x%lx, mem=0x%lx, image_type=%d\n",
+		kbuf->memsz, kbuf->mem, kbuf->image->type);
+
 	/* Arch knows where to place */
-	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN) {
+		pr_info("kexec_locate_mem_hole: memory already specified (0x%lx), skipping allocation\n", kbuf->mem);
+		return 0;
+	}
+
+	/*
+	 * If this is a multikernel image, try to allocate from the instance's
+	 * memory pool first. This ensures multikernel segments use pre-reserved
+	 * memory from the device tree configuration and respects the pool management.
+	 */
+	if (!kexec_alloc_multikernel(kbuf))
 		return 0;
 
 	/*
-- 
2.34.1


