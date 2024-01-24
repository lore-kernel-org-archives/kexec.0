Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5680C47422
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 05:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wmQkMjlVhzFso3YIDBotjbjro1ZPbMXc/P93TA+Nekw=; b=pfUY5kEloYrcg1
	52L2Chlg4iB8qfiKV1EkT+RU/ebOk/SwX7COO49brQKkDSPxkffaRVG05edZkOhTmEliuGrcFZT38
	VGwKY1Yv63TgQsGnRtvsFagPSr6u3zz23McvRj2d8akZY34cOZUWW6P0aQMKO9mTTaROtMrmJBVqV
	7IRlxLwFnuHgK086+UAUiRw75jmx8n7dmmaXTJ9VootH/RxMBoj/QHSAPlJ0XqdkV3xBrXEJqqF4E
	KE5PfRuB/+nzEX9jBx1qGdiQ4M26+SLpgzexJCEKsOO5+wsbPs1teK4FnPphfoCMoeXlgo/Svjbts
	smP7RCG5wONyu/L1q50Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVao-001XHE-1K;
	Wed, 24 Jan 2024 05:14:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVaL-001Wpo-15
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 05:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Phdml9nXkCmStja6K/ul2BV3Rap702N5eGmMqDodNlo=;
	b=RJz/sH+YGU5fwIV4GN1qjhO/vk8ZphCgadlXdZr5xFUEn/b9Wq5r9ez3nVfAp8/FdnH3Hg
	BKC7pfyjGrVvVK7MBA3KkcRTZyKQhKnZwcVBq3xo3mui9m5N4h2OQmNL/BfLswTwbUTKTH
	suM7j9xNH0u0iXlcaxpWFmDs0LvIQoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-zlaUeep3MaKZl_-kOvhPYQ-1; Wed, 24 Jan 2024 00:13:55 -0500
X-MC-Unique: zlaUeep3MaKZl_-kOvhPYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96BC0837225;
	Wed, 24 Jan 2024 05:13:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E65CE1C060AF;
	Wed, 24 Jan 2024 05:13:48 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next v3 07/14] arm64, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:47 +0800
Message-ID: <20240124051254.67105-8-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_211401_508452_FF32A3F7 
X-CRM114-Status: GOOD (  15.30  )
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

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on arm64 with some adjustments.

Here wrap up crash dumping codes with CONFIG_CRASH_DUMP ifdeffery.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/kexec.h         |  2 +-
 arch/arm64/kernel/machine_kexec.c      |  2 +-
 arch/arm64/kernel/machine_kexec_file.c | 10 ++++++++--
 arch/arm64/mm/init.c                   |  2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9ac9572a3bbe..4d9cc7a76d9c 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -80,7 +80,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	}
 }
 
-#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_HIBERNATION)
+#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_HIBERNATION)
 extern bool crash_is_nosave(unsigned long pfn);
 extern void crash_prepare_suspend(void);
 extern void crash_post_resume(void);
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index b38aae5b488d..82e2203d86a3 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -255,7 +255,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	pr_info("Starting crashdump kernel...\n");
 }
 
-#ifdef CONFIG_HIBERNATION
+#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_HIBERNATION)
 /*
  * To preserve the crash dump kernel image, the relevant memory segments
  * should be mapped again around the hibernation.
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 0e017358f4ba..af1ca875c52c 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,6 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
+#ifdef CONFIG_CRASH_DUMP
 static int prepare_elf_headers(void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
@@ -80,6 +81,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	kfree(cmem);
 	return ret;
 }
+#endif
 
 /*
  * Tries to add the initrd and DTB to the image. If it is not possible to find
@@ -93,8 +95,8 @@ int load_other_segments(struct kimage *image,
 			char *cmdline)
 {
 	struct kexec_buf kbuf;
-	void *headers, *dtb = NULL;
-	unsigned long headers_sz, initrd_load_addr = 0, dtb_len,
+	void *dtb = NULL;
+	unsigned long initrd_load_addr = 0, dtb_len,
 		      orig_segments = image->nr_segments;
 	int ret = 0;
 
@@ -102,7 +104,10 @@ int load_other_segments(struct kimage *image,
 	/* not allocate anything below the kernel */
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
+#ifdef CONFIG_CRASH_DUMP
 	/* load elf core header */
+	void *headers;
+	unsigned long headers_sz;
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = prepare_elf_headers(&headers, &headers_sz);
 		if (ret) {
@@ -130,6 +135,7 @@ int load_other_segments(struct kimage *image,
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
+#endif
 
 	/* load initrd */
 	if (initrd) {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..c1f6213e77f3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -100,7 +100,7 @@ static void __init arch_reserve_crashkernel(void)
 	bool high = false;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
