Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9CFC4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 05:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3dgCkRpOjYAQ06bk3LpnUb0p+j3BKOA9dhKxYHymWmo=; b=ksL36ZGMQy1LwN
	FbiBtqXVaZAKzQZBar4m3DplvWuCihYqX0Bh6vnuzUen1oYcER9iGbmfScLfkT8Oeuo6bztbwqx7F
	R2kYrjzLdSMF2BKefPHhuV90OWq/13XMcJHX2PWPW3OHQlhxvKkXeJhsOKs6JIdHiOu8Wd1fW+Ifv
	5TYdjA4qXX1uqi9hOQDR0v90pHAmRG3ZLfciEXkURc6WqqaXbsWFAxgIr2Ly1YXPRoR5q053b+h39
	7o+xMywTk7PpJcjPXUfUClrupiX0up8Knc4qmxxF5AZRqjXSlKNOv455thtq5jiNihcFU36kYrJex
	EFhpej2OIWG23tsvuP3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIGN-00Dh9F-2N;
	Wed, 13 Dec 2023 05:58:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIGJ-00Dh4x-2F
	for kexec@lists.infradead.org;
	Wed, 13 Dec 2023 05:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702447106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjkR0oYdbcf5oMJ79gB4p6mCedO7bWDTb3wlfW20JbQ=;
	b=MkdUg8iGo19ql9dDzSKyrhRqCYQhH4sMFaYiYvsFumtLoRPHkD/61aSXgj/F7DFQrP+pz6
	l4CFLlUTobgV2iPApJCHH4blhK2DbG3+D+E4g9tVH3hfxt4VcJVu87JXd7VM7EOp8BrAZJ
	EuyDUkk/xSYV/na8y3IL4vFiHnGrJ8M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-GiA1e1IzMRyM8FD9i7LtqA-1; Wed,
 13 Dec 2023 00:58:19 -0500
X-MC-Unique: GiA1e1IzMRyM8FD9i7LtqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 977253816B4E;
	Wed, 13 Dec 2023 05:58:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE4311C060AF;
	Wed, 13 Dec 2023 05:58:13 +0000 (UTC)
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
	conor@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 4/7] kexec_file, arm64: print out debugging message if required
Date: Wed, 13 Dec 2023 13:57:44 +0800
Message-ID: <20231213055747.61826-5-bhe@redhat.com>
In-Reply-To: <20231213055747.61826-1-bhe@redhat.com>
References: <20231213055747.61826-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_215827_805718_4D0FB323 
X-CRM114-Status: GOOD (  10.29  )
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

Then when specifying '-d' for kexec_file_load interface, loaded
locations of kernel/initrd/cmdline etc can be printed out to help
debug.

Here replace pr_debug() with the newly added kexec_dprintk() in
kexec_file loading related codes.

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
