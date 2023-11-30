Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A19C4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Or2psW2B7m42mYvt9FgGBYs6HwNa91cof08s8W9B+F0=; b=LCtDfo7rNGya2R
	bnW8yxhNU28dCC1hL/qhTlPak4D4U9y6MFjvG5JOm2sMbOYDwRIq8l/9C69uzY2gzgrhOEsAYMQyF
	uPns3r8kuW+JvdD5yDBG9tVZqCD0hoJkrIjWY1ef3cqIU5PpGVBC7DdVnhNFrmvWp3hqQTy5pvbQZ
	3P5Kr+d4ac1ZCfSVzg8OyC8zkzZ5zI0a6tFeGiyEcr+JBUcLmSROc47cpMt0LXOpXK1DfXfnTy5xI
	ReC2uRNyRd/LW7peXXPyjIe4c2u57bk704lwL3qPlwl70Y0A3SZThFiq237QPgySJf9+Vjhde2iU2
	u0KnfTFhoVm7KPg3lG5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Wyo-009mMS-2k;
	Thu, 30 Nov 2023 02:40:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8WyX-009m60-2i
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 02:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701312024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4ZlhbB4eVOuDd3XAQP5yEasxof6vyePMpXV5+f1mdM=;
	b=AIuNpgWUzO2jYk/XBaolUlKbr3bOvfpG7pJFI/UOA9k0CPiuv8XWVY/+3YFTLWocRWy1x+
	XxFxcEZBHuB9VSerjKgs1TvJSrCWj1rGItM4lXboOhsQqGppGR8kBvNbdxHHgG2CXemN8N
	a4DmZMbPq2xz7PFMNJvo588UB1Bh0J4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-3nWnOtmnMPOhg84PRj1Ptg-1; Wed, 29 Nov 2023 21:40:21 -0500
X-MC-Unique: 3nWnOtmnMPOhg84PRj1Ptg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83465813845;
	Thu, 30 Nov 2023 02:40:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7EE382026D4C;
	Thu, 30 Nov 2023 02:40:16 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org,
	akpm@linux-foundation.org,
	joe@perches.com,
	nathan@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 4/7] kexec_file, arm64: print out debugging message if required
Date: Thu, 30 Nov 2023 10:39:52 +0800
Message-ID: <20231130023955.5257-5-bhe@redhat.com>
In-Reply-To: <20231130023955.5257-1-bhe@redhat.com>
References: <20231130023955.5257-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_184025_952269_68AA9007 
X-CRM114-Status: GOOD (  10.88  )
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

Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
loading related codes.

And also remove the kimage->segment[] printing because the generic code
has done the printing.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/kernel/kexec_image.c        |  6 +++---
 arch/arm64/kernel/machine_kexec.c      | 26 ++++++--------------------
 arch/arm64/kernel/machine_kexec_file.c | 12 ++++++------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 636be6715155..532d72ea42ee 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -122,9 +122,9 @@ static void *image_load(struct kimage *image,
 	kernel_segment->memsz -= text_offset;
 	image->start = kernel_segment->mem;
 
-	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-				kernel_segment->mem, kbuf.bufsz,
-				kernel_segment->memsz);
+	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kernel_segment->mem, kbuf.bufsz,
+		      kernel_segment->memsz);
 
 	return NULL;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 078910db77a4..b38aae5b488d 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -32,26 +32,12 @@
 static void _kexec_image_info(const char *func, int line,
 	const struct kimage *kimage)
 {
-	unsigned long i;
-
-	pr_debug("%s:%d:\n", func, line);
-	pr_debug("  kexec kimage info:\n");
-	pr_debug("    type:        %d\n", kimage->type);
-	pr_debug("    start:       %lx\n", kimage->start);
-	pr_debug("    head:        %lx\n", kimage->head);
-	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
-	pr_debug("    dtb_mem: %pa\n", &kimage->arch.dtb_mem);
-	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
-	pr_debug("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
-
-	for (i = 0; i < kimage->nr_segments; i++) {
-		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
-			i,
-			kimage->segment[i].mem,
-			kimage->segment[i].mem + kimage->segment[i].memsz,
-			kimage->segment[i].memsz,
-			kimage->segment[i].memsz /  PAGE_SIZE);
-	}
+	kexec_dprintk("%s:%d:\n", func, line);
+	kexec_dprintk("  kexec kimage info:\n");
+	kexec_dprintk("    type:        %d\n", kimage->type);
+	kexec_dprintk("    head:        %lx\n", kimage->head);
+	kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
+	kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
 }
 
 void machine_kexec_cleanup(struct kimage *kimage)
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a11a6e14ba89..0e017358f4ba 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -127,8 +127,8 @@ int load_other_segments(struct kimage *image,
 		image->elf_load_addr = kbuf.mem;
 		image->elf_headers_sz = headers_sz;
 
-		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
+		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load initrd */
@@ -148,8 +148,8 @@ int load_other_segments(struct kimage *image,
 			goto out_err;
 		initrd_load_addr = kbuf.mem;
 
-		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-				initrd_load_addr, kbuf.bufsz, kbuf.memsz);
+		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load dtb */
@@ -179,8 +179,8 @@ int load_other_segments(struct kimage *image,
 	image->arch.dtb = dtb;
 	image->arch.dtb_mem = kbuf.mem;
 
-	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			kbuf.mem, kbuf.bufsz, kbuf.memsz);
+	kexec_dprintk("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kbuf.mem, kbuf.bufsz, kbuf.memsz);
 
 	return 0;
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
