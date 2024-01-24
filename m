Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4A1C47422
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 05:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IhZGrveHiK3F+eaB38I+5qFkXXGLb2elEDroUW3KU74=; b=1UO+G1GF1IeqZ7
	Sm/nwo0mNSiNVN9ftuo9ERxu8ta7eNbJeh5S8c2WeqX/461hedqslntzt8ePpjW9cLlnLInj1vN1d
	gLGB9PGaeyC2KVKr2wfuWZnn88R462h4BzKy/PkFDmXcEFSjkpFIVN5bGHaY1jSTHhgM1pSXKQ0yO
	swzl8vbRUptjJ63RkFk9szzeOPtZpmmPVuL4UtlE2Zjv5fEcl5SPAiGIavqR2Z1jXvqK+vQvl8t1z
	WEPvILqNavgdSSIvAOx2Um5VwoJTuPtRnjvEXPMRG7U4gWC65VvIfUAUjK+YLbXJj2e+AVHOBlxcb
	lgiD/7cEK+uYIyld7ldQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVbE-001Xdm-1k;
	Wed, 24 Jan 2024 05:14:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVaw-001XN8-0X
	for kexec@bombadil.infradead.org;
	Wed, 24 Jan 2024 05:14:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NaWsezpiSi0g7GnmvcBjUWnIT5KvaNjJV46jtxgyD8g=; b=WbFMJe1+gaOk1gMhhnIkHp4Lro
	Ew7CpsSKNc0YEUXRWaz17N1yOC7EFxNFYTEQHuY1aOz2IoSKJHgkeKopWhXyfXaszW1b4VrXfVxc8
	t1TQpWlI40rfzDoOaZCEgYi46u2Ls2MqnSxYcs2hzSz2P0yaRItEeDhEEvPFjQECp4wpUkgXEj9Ew
	B3hzFfbYQ65HA3w9oXnCnKp7X1NNzukOvG2UmIioIGkRVTrmCUVtDTdDBun3pKoRJyIz6yZ9ONg7Q
	UMrnXzlygT4btao9tdtfc7TQpzaj9R7bEPIBE1lyvNMkl11dA7FSQxWtLFFwRCi9/QtErr5YlfoOa
	8VX7CElQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVar-00000004FQT-1iWC
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 05:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaWsezpiSi0g7GnmvcBjUWnIT5KvaNjJV46jtxgyD8g=;
	b=C9VbRWaAT8MZhKgEwt/lj0jkQQf7Z4SvK2wyjJQIobERk1MdVuQcYzxX8Jlq3tlyAfp0JC
	ateIovzylBI5Ulqq5B47H4TekZkXLynI1dMCY7OGrmX0TlYeI3dyH2xEDlViVF79AGBmz0
	OiOAT/nc/kiExtDUFCw0worlYvtPzb0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaWsezpiSi0g7GnmvcBjUWnIT5KvaNjJV46jtxgyD8g=;
	b=C9VbRWaAT8MZhKgEwt/lj0jkQQf7Z4SvK2wyjJQIobERk1MdVuQcYzxX8Jlq3tlyAfp0JC
	ateIovzylBI5Ulqq5B47H4TekZkXLynI1dMCY7OGrmX0TlYeI3dyH2xEDlViVF79AGBmz0
	OiOAT/nc/kiExtDUFCw0worlYvtPzb0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-6MSAjmHBNja5UCvfdGGVYQ-1; Wed, 24 Jan 2024 00:14:28 -0500
X-MC-Unique: 6MSAjmHBNja5UCvfdGGVYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 561ED810BB0;
	Wed, 24 Jan 2024 05:14:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBD0D1C060AF;
	Wed, 24 Jan 2024 05:14:20 +0000 (UTC)
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
Subject: [PATCH linux-next v3 12/14] riscv, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:52 +0800
Message-ID: <20240124051254.67105-13-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_051433_598456_7F5015E8 
X-CRM114-Status: GOOD (  12.49  )
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
index 32cad6a65ccd..245919dda910 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1358,7 +1358,7 @@ static void __init arch_reserve_crashkernel(void)
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
