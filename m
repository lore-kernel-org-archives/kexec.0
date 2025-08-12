Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9795ACA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNvwjh3bkLYd7LcWTIY96phbAPIdD7DxmW/f2AxTNdM=; b=ynSBxqgWJtz79lxRzI8NoAoiSn
	zv1p26vquj+cMSXQ/y/PkO4ijZWIQ08fEh4R1mZkXPfTvZ4EeSz8vgPJ0sIionAxjSxDMLfk9SiHU
	a/gU/1iNUFiBsHhKwcf2BCmt6uySCoDa9zLHVP7v9RZYVCnkdU7OEjYD1zy/fZRX8fIvteDLxrMMc
	KVpmR9seMUuTrEQ003yqA6ZBaNpJOxAe8w+WEsO3Y1X5hd8dML9m+6iCXoFucpZfFyPgyoN95eFhM
	J8lvmYUVZ+LbtvwNP+cTk545PAFJFlX4uLHddYIn/NjVA5TcJHKWiyzjhttWQbkweoTt1i0Zy+KzR
	CyHC20FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsqF-0000000BZgV-2ahz;
	Tue, 12 Aug 2025 17:31:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloUy-0000000AqKq-3DhM
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 12:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNvwjh3bkLYd7LcWTIY96phbAPIdD7DxmW/f2AxTNdM=;
	b=Ibh64Iz5f+dG7mVrqJHUHAesBgtuX7cNFcyVg652QjFjKIdBXHhlkY2A+sDnJWmP3zkUfl
	dpG+rnQ3Dl/0CFH8JebQv72mNyLYXPU2ThaOPud3pkTwptxdmJwIJhzPoxyzW0MmWgWe/l
	p/2SSMcUnWZM8Xe2wifzHcGSOjXJx1U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-BarAkwZZPNi3t3OI2JjPPg-1; Tue,
 12 Aug 2025 08:51:17 -0400
X-MC-Unique: BarAkwZZPNi3t3OI2JjPPg-1
X-Mimecast-MFC-AGG-ID: BarAkwZZPNi3t3OI2JjPPg_1755003075
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A2E81800352;
	Tue, 12 Aug 2025 12:51:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EAE530001A1;
	Tue, 12 Aug 2025 12:51:08 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 11/12] arch/um: don't initialize kasan if it's disabled
Date: Tue, 12 Aug 2025 20:49:40 +0800
Message-ID: <20250812124941.69508-12-bhe@redhat.com>
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
References: <20250812124941.69508-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_055304_926956_CD54B2D4 
X-CRM114-Status: GOOD (  11.07  )
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

And also add code to enable kasan_flag_enabled, this is for later
usage. Since kasan_init() is called before main(), enabling
kasan_flag_enabled is done in arch_mm_preinit() which is after
jump_label_init() invocation.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/um/kernel/mem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b5..392a23d4ef96 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -26,6 +26,9 @@
 int kasan_um_is_ready;
 void kasan_init(void)
 {
+
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * kasan_map_memory will map all of the required address space and
 	 * the host machine will allocate physical memory as necessary.
@@ -58,6 +61,9 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+	/* Safe to call after jump_label_init(). Enables KASAN. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-- 
2.41.0


