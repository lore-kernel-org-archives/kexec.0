Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70FDC47DAF
	for <kexec@archiver.kernel.org>; Fri, 19 Jan 2024 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E4rOm6duYwot2kzFU8U+hKqVcdJPQ2BujV5TkduhETI=; b=EEDjWJ+gpMgX/q
	ZhCeBgPKsE4zwaiJYhUeaAdu7jLTqXYYU3paC+iIcmzI4FEzESR3a3/pXrdqHnBnNfOCDKaRaegV+
	6TlnM55x8EMuMhVIpejpNl9jwnIvFsNcgvofFP2aaxLXuECFwNTHofJRMBc/gQyQaNPYWWGxJgAXY
	837KKALY4QFRgxFDWLx9Wr2t5n6fY2fiYDv3a1xmGjSdnSktOphRAF58sC+55o+IBqAQg9t2IPQQq
	P09ucX5wst8u7oRSTrvREsF28131O/e8MS77LBtS3drAW92Wzya7w4/D8eUSvHnAcmISPW7O/ceAl
	k14ZjdNeNven/qdrQmVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQqGn-005uZl-05;
	Fri, 19 Jan 2024 14:54:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQqGf-005uT0-1m
	for kexec@bombadil.infradead.org;
	Fri, 19 Jan 2024 14:54:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YldSOlh0hkcoW/MWmNQsk4AfGocgJu1kcEOopM/OxN4=; b=YDjxpMSfFN4WgGEOs3CvPm6B9e
	CQd/xI8ayyyB1PlJyJmMqTVdYE+iYiHx4357f8g7TAoiyW+NftjzGkBrlaCM9N3hcLATWhflWZV9q
	E9k5XorlhF2jgQWQrNT4nnTwekz+eO1DKhiqXac0i5+/q4DzWZgyVLs0Du2UDI6K++pTYPvNBs9/8
	wME1PAUm13RcGYcpPEzdi2J3DSfSnWlN8KSRtnTT+cpSY2YEli92XB8tLP0AGT4lHig7NmjZ95QuS
	SadSt63RvfxEjuY5RP8yA0yv7wbCeDQSJREv9Nq+hC1df5EAxFZU3rhNavGPK5LauqRmgBl37tZ5N
	8Om15Mpg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQqGZ-00000001cTd-0wKB
	for kexec@lists.infradead.org;
	Fri, 19 Jan 2024 14:54:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YldSOlh0hkcoW/MWmNQsk4AfGocgJu1kcEOopM/OxN4=;
	b=Oj5wna+px0uZVdp0yEd69ps8KVyTAIohVWphxOG1GAf3gEN7FQkyOnvWNfo/wNXU2L4yiw
	s0ZidbFa/NgtxAUEhHjo6AH2217u1HUj/ZrvpErG+2sfSSLdekJ2PeVd2/jtN8JzesKoZW
	z8o7bkxOURDE17x+v6fNa5SXmvX7380=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YldSOlh0hkcoW/MWmNQsk4AfGocgJu1kcEOopM/OxN4=;
	b=HBLJcisaKjyKF4wenzcSud+8EutWDK0jLqtdLYwyRvYJXD2Y2CDpeaMJgMwADMn5ypVJvA
	xjC9gGJPxtDpbn4ZJp1f8J5itW3hq26Fthprqmz27FuNabdCOAf2m4gq9BalepauQ5cGgw
	UwiNV/pzPr+EuhcTBXfw2qZZKLR4xwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-SZO2mk4PNgKXUDyiPm7Mhg-1; Fri, 19 Jan 2024 09:54:33 -0500
X-MC-Unique: SZO2mk4PNgKXUDyiPm7Mhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C41183DE48;
	Fri, 19 Jan 2024 14:54:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 189422949;
	Fri, 19 Jan 2024 14:54:23 +0000 (UTC)
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
Subject: [PATCH v2 13/14] riscv, crash: wrap crash dumping code into crash related ifdefs
Date: Fri, 19 Jan 2024 22:52:40 +0800
Message-ID: <20240119145241.769622-14-bhe@redhat.com>
In-Reply-To: <20240119145241.769622-1-bhe@redhat.com>
References: <20240119145241.769622-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_145443_521929_43F0F5C3 
X-CRM114-Status: GOOD (  12.61  )
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
items on risc-v with some adjustments.

Here wrap up crash dumping codes with CONFIG_CRASH_DUMP ifdeffery, and
use IS_ENABLED(CONFIG_CRASH_RESERVE) check to decide if compiling
in the crashkernel reservation code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/kernel/elf_kexec.c | 9 +++++++--
 arch/riscv/mm/init.c          | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 5bd1ec3341fe..54260c16f991 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -117,6 +117,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	return ret;
 }
 
+#ifdef CONFIG_CRASH_DUMP
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -189,6 +190,7 @@ static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 	cmdline_ptr[COMMAND_LINE_SIZE - 1] = '\0';
 	return cmdline_ptr;
 }
+#endif
 
 static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 			    unsigned long kernel_len, char *initrd,
@@ -196,12 +198,11 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 			    unsigned long cmdline_len)
 {
 	int ret;
+	void *fdt;
 	unsigned long old_kernel_pbase = ULONG_MAX;
 	unsigned long new_kernel_pbase = 0UL;
 	unsigned long initrd_pbase = 0UL;
-	unsigned long headers_sz;
 	unsigned long kernel_start;
-	void *fdt, *headers;
 	struct elfhdr ehdr;
 	struct kexec_buf kbuf;
 	struct kexec_elf_info elf_info;
@@ -227,8 +228,11 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	kbuf.buf_min = new_kernel_pbase + kernel_len;
 	kbuf.buf_max = ULONG_MAX;
 
+#ifdef CONFIG_CRASH_DUMP
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
+		void *headers;
+		unsigned long headers_sz;
 		ret = prepare_elf_headers(&headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
@@ -264,6 +268,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		}
 		cmdline = modified_cmdline;
 	}
+#endif
 
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 	/* Add purgatory to the image */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a65937336cdc..f580d1f6ee13 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1354,7 +1354,7 @@ static void __init arch_reserve_crashkernel(void)
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
