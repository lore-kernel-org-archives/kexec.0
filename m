Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BABBC47DAF
	for <kexec@archiver.kernel.org>; Fri, 19 Jan 2024 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BbgbcZWqlDDmQE0N3juQZ67PYXAMAD/iLL/jCAz9Wu4=; b=Srh5aOKxENTlbT
	Wvk7q+NQ0fZXzaV3lTbJeeEIVWEJfXsQBFVje8bGzz/FHOSdhFLy3tL/T10b0fzNlvIa7oX4+YeWs
	7GaT6Cpl58G+tNQRYh8A6oQRoDpum01kYzS8Gt+jTUMiRVp/JH2QRS3/Qpv3WftmoP3svMVFPTwER
	9Y5ehlE082LQxNzGjU9DV/eFNSaMF3xMxOZIHwkXS69Z1bCi8cK/3aQRi6qR9V25zRkahJRwUTP98
	Gn7SHg7nod+TiazGEGwRf0kd1+5HP35Nn+bQXkUgLrHoaTcbLUim9wEIHzUX87pYE3n0eisI2r7ia
	Fnr2Cj95HugSvC4Qu1RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQqGY-005uME-09;
	Fri, 19 Jan 2024 14:54:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQqGK-005uBc-37
	for kexec@lists.infradead.org;
	Fri, 19 Jan 2024 14:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNOeu1HbpskBZbW25MWU6cZYUz3N/w+rWXoFdZjNr5M=;
	b=VsAuQglsbaetpoSH/asBihypGS1D0Lw/1Hfixu7SvUzNEBtDpzbPGLJg3/3S5MYotmstRH
	Ov1A/bLDAig87eBKm7ho4iqKSsXAsqGLWpX4IyciMAXAqhuyvxjT0mMd2rH6CrkcHyAQZt
	uz+uZctH4RMPgdteFvaBwiTwnA7sRKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-VfYFFUBHNdin9KkcEv-clA-1; Fri, 19 Jan 2024 09:54:24 -0500
X-MC-Unique: VfYFFUBHNdin9KkcEv-clA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1734E106D107;
	Fri, 19 Jan 2024 14:54:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB5F351D5;
	Fri, 19 Jan 2024 14:54:16 +0000 (UTC)
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
Subject: [PATCH v2 12/14] mips, crash: wrap crash dumping code into crash related ifdefs
Date: Fri, 19 Jan 2024 22:52:39 +0800
Message-ID: <20240119145241.769622-13-bhe@redhat.com>
In-Reply-To: <20240119145241.769622-1-bhe@redhat.com>
References: <20240119145241.769622-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_065429_114902_A8E806F3 
X-CRM114-Status: GOOD (  10.38  )
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
items on mips with some adjustments.

Here use IS_ENABLED(CONFIG_CRASH_RESERVE) check to decide if compiling
in the crashkernel reservation code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/mips/kernel/setup.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9c30de151597..12a1a4ffb602 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -442,8 +442,6 @@ static void __init mips_reserve_vmcore(void)
 #endif
 }
 
-#ifdef CONFIG_KEXEC
-
 /* 64M alignment for crash kernel regions */
 #define CRASH_ALIGN	SZ_64M
 #define CRASH_ADDR_MAX	SZ_512M
@@ -454,6 +452,9 @@ static void __init mips_parse_crashkernel(void)
 	unsigned long long crash_size, crash_base;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
@@ -489,6 +490,9 @@ static void __init request_crashkernel(struct resource *res)
 {
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	if (crashk_res.start == crashk_res.end)
 		return;
 
@@ -498,15 +502,6 @@ static void __init request_crashkernel(struct resource *res)
 			(unsigned long)(resource_size(&crashk_res) >> 20),
 			(unsigned long)(crashk_res.start  >> 20));
 }
-#else /* !defined(CONFIG_KEXEC)		*/
-static void __init mips_parse_crashkernel(void)
-{
-}
-
-static void __init request_crashkernel(struct resource *res)
-{
-}
-#endif /* !defined(CONFIG_KEXEC)  */
 
 static void __init check_kernel_sections_mem(void)
 {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
