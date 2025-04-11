Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F828C36010
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 05:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQ4ycF7gsLT06FnekoMeMnv8oicyD3TdT/CesWgek8A=; b=UnBjBaldNo8G8/hLmT2DUXuaHy
	9Wx5frAsK3ZiGvwbjNF9MNhte+Q+JTrNQvz2pJX9K2B0fzE6jyS8mZyNFk5517tYE/osJeiySjP1Y
	lqZeFMiqji9XXFDQELhyP1gFMCuH0eHRXOt2tk/+uyBHC9Hfr/nMzzAqk2ITXkT+5Skw4qXeAppKd
	UBK047+8cQWl4aem99Egxo+wZPfdUGkFzM+3/+0ovC4XqJoYllsc94Wy1cgM98LpW6TJHwLCt8DqX
	xswj6NmbVDytuBUh5u6bkKj7Na45DPw5HHBbEw6YPv1vpWl+wQRctBLQNDXuYsXUCEC8kjw56a6i8
	fr7D+3xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37Gd-0000000CbqE-29Up;
	Fri, 11 Apr 2025 05:49:31 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3760-0000000CYUq-1yEb
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 05:38:34 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-af96cdd7f5bso1142883a12.1
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 22:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349911; x=1744954711; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ4ycF7gsLT06FnekoMeMnv8oicyD3TdT/CesWgek8A=;
        b=VNAqYjndcx/J6VxyZlGgR4rBtWC0ohiK2NtQmsAci9n1mg2GDF7b8ydg4mIyz94Hla
         pDoPrA+vKCvcXh5CAk4O7VWie9rdwwwk+wEaomIgt2lMKHTn2HmhBYLup9ONPTYDSCIf
         vOTuz0ifehPxNMavge1qXwEI1P5AOvmeoTSEy/nyiWxw3M5+cfjKODtq44zYbIzK+UCT
         S69ywvVoxKoB4ollpkSXFr++HL3Flgu4zMEq5+82YSX+XhGAAzlL/ypfEMzGaVFt4vOS
         eUyhsd73yt1CUni2JT1NVL0myhLk5UDqNj47HrspcjU7BhKpel/OfhDOu2+C8G7cmKuv
         MJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349911; x=1744954711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ4ycF7gsLT06FnekoMeMnv8oicyD3TdT/CesWgek8A=;
        b=vcxkn/KPlzgPzV8CMLP4cza5uxSI8cX546j3djNP2OsnNXzFfcb/6oHDaQaMeMAq7J
         iNhR95FikfyJNmIBW7DiJ345i8fLczBGRItkJeLFb2w3ZnFcW7LBV0WbwDGbWhgjJoFr
         Qyk4fJaF2j/bK4vly2hV3NuUIFd0441irpQ/SO1+PRUDc00cV75mb9Ly10mz5E4VHZjm
         81Cxv88pSTR3un0nv7ACZH3OMHg9YUbs6AQnXgYjly+Z6RsDAU+8t94eXfKDNd4A3+Fe
         +hjMjoq1iehzn9Q7oSxhuQzbnqWUyTPKC/iV4mSFeT9ULAq9syAfkmYLhUoe/xljLQUS
         odfA==
X-Forwarded-Encrypted: i=1; AJvYcCUkPdlRshMlMbm/yCvpF/4RRbK4JSBXEmyEP+WJwrxLjy/XE29CqPCVHd6B4H7zYxsenoey2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6ioSqgEaSN1Ex0+QqaDmMe6EYYHpVkqxB6H34kCQZDDYq8bVr
	vdLnBTJJWvDKRIpzY+ACJhOofWlIQUwU7rB6K1PoelgLvNY63+Z2o1Vvrh5iWodY2DC++VnoJ6c
	N+l1LzO3SjvqA3nOgkQ==
X-Google-Smtp-Source: AGHT+IFmHMamHSCxGJ9jONFAPmV1A91iPoS28bApZs3vQoT8HryanIff8vx754Cryl7fBwGV08e16HC+nkdncy1g
X-Received: from plcc1.prod.google.com ([2002:a17:902:c1c1:b0:220:da6b:5d08])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f705:b0:220:e9ac:e746 with SMTP id d9443c01a7336-22bea4fdc7amr25793305ad.53.1744349911576;
 Thu, 10 Apr 2025 22:38:31 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:37:38 -0700
In-Reply-To: <20250411053745.1817356-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250411053745.1817356-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411053745.1817356-8-changyuanl@google.com>
Subject: [PATCH v6 07/14] kexec: add KHO support to kexec file loads
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_223832_540018_1B66C220 
X-CRM114-Status: GOOD (  22.38  )
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

Kexec has 2 modes: A user space driven mode and a kernel driven mode.
For the kernel driven mode, kernel code determines the physical
addresses of all target buffers that the payload gets copied into.

With KHO, we can only safely copy payloads into the "scratch area".
Teach the kexec file loader about it, so it only allocates for that
area. In addition, enlighten it with support to ask the KHO subsystem
for its respective payloads to copy into target memory. Also teach the
KHO subsystem how to fill the images for file loads.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/kexec.h   |  7 +++++
 kernel/kexec_file.c     | 13 ++++++++
 kernel/kexec_handover.c | 67 +++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_internal.h | 16 ++++++++++
 4 files changed, 103 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c8971861521a5..d3cad108b8076 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -371,6 +371,13 @@ struct kimage {
 	size_t ima_buffer_size;
 #endif
 
+#ifdef CONFIG_KEXEC_HANDOVER
+	struct {
+		struct kexec_segment *scratch;
+		phys_addr_t fdt;
+	} kho;
+#endif
+
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_sz;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fba686487e3b5..77758c5331229 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -253,6 +253,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
+	/* If KHO is active, add its images to the list */
+	ret = kho_fill_kimage(image);
+	if (ret)
+		goto out;
+
 	/* Call image load handler */
 	ldata = kexec_image_load_default(image);
 
@@ -648,6 +653,14 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
+	/*
+	 * If KHO is active, only use KHO scratch memory. All other memory
+	 * could potentially be handed over.
+	 */
+	ret = kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
+	if (ret <= 0)
+		return ret;
+
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
 	else
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index a594da2a22912..4bbc6f5ef7230 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -23,6 +23,7 @@
  * internal APIs.
  */
 #include "../mm/internal.h"
+#include "kexec_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
@@ -1184,3 +1185,69 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	if (err)
 		pr_warn("disabling KHO revival: %d\n", err);
 }
+
+/* Helper functions for kexec_file_load */
+
+int kho_fill_kimage(struct kimage *image)
+{
+	ssize_t scratch_size;
+	int err = 0;
+	struct kexec_buf scratch;
+
+	if (!kho_enable)
+		return 0;
+
+	image->kho.fdt = page_to_phys(kho_out.ser.fdt);
+
+	scratch_size = sizeof(*kho_scratch) * kho_scratch_cnt;
+	scratch = (struct kexec_buf){
+		.image = image,
+		.buffer = kho_scratch,
+		.bufsz = scratch_size,
+		.mem = KEXEC_BUF_MEM_UNKNOWN,
+		.memsz = scratch_size,
+		.buf_align = SZ_64K, /* Makes it easier to map */
+		.buf_max = ULONG_MAX,
+		.top_down = true,
+	};
+	err = kexec_add_buffer(&scratch);
+	if (err)
+		return err;
+	image->kho.scratch = &image->segment[image->nr_segments - 1];
+
+	return 0;
+}
+
+static int kho_walk_scratch(struct kexec_buf *kbuf,
+			    int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		struct resource res = {
+			.start = kho_scratch[i].addr,
+			.end = kho_scratch[i].addr + kho_scratch[i].size - 1,
+		};
+
+		/* Try to fit the kimage into our KHO scratch region */
+		ret = func(&res, kbuf);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+int kho_locate_mem_hole(struct kexec_buf *kbuf,
+			int (*func)(struct resource *, void *))
+{
+	int ret;
+
+	if (!kho_enable || kbuf->image->type == KEXEC_TYPE_CRASH)
+		return 1;
+
+	ret = kho_walk_scratch(kbuf, func);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
+}
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index d35d9792402d1..30a733a55a67b 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -39,4 +39,20 @@ extern size_t kexec_purgatory_size;
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
+
+struct kexec_buf;
+
+#ifdef CONFIG_KEXEC_HANDOVER
+int kho_locate_mem_hole(struct kexec_buf *kbuf,
+			int (*func)(struct resource *, void *));
+int kho_fill_kimage(struct kimage *image);
+#else
+static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
+				      int (*func)(struct resource *, void *))
+{
+	return 1;
+}
+
+static inline int kho_fill_kimage(struct kimage *image) { return 0; }
+#endif /* CONFIG_KEXEC_HANDOVER */
 #endif /* LINUX_KEXEC_INTERNAL_H */
-- 
2.49.0.604.gff1f9ca942-goog


