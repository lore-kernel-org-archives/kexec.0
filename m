Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B5CA0EFA
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 05:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VcfWxvd2gMUp9MiHd8sOWfFMV/Om7sFRA8QIIlclSZk=; b=mlGE6FMhqlKxvKbpDic8v1Qsl9
	fFkzmmhkPHc1Rs91rBmqHAY8OLFQo3owvIK5l2zK5a43GDCgrWPhcwveOg8Vj5JUlc7Ok3legKjUe
	YdylW3cnadGOCTMs4pe76hcL1PMp3E4tOmxmJK+CHRzFt/CfMS0qsFvW234N+9vlJNMF8bN5bx6x3
	74eAeU9ZhYb3OpiGH31kH3vjQ0WiypYUPf+XlU4vnKYpj9ZZMJhlc8qX0b+K5JnZeS1e80Zt8efWg
	lzu0F1zpFfMepIfM0hlBNTKuzlkLW7+BTAE2RKvy1NCmLBZsOBVzM7j8CWGsOZjre9mMkCz0M7Z7c
	rT2nG7dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobde-0000000CRh9-48ZF;
	Wed, 20 Aug 2025 05:45:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobVM-0000000CQOE-28zK
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 05:37:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcfWxvd2gMUp9MiHd8sOWfFMV/Om7sFRA8QIIlclSZk=;
	b=fUg9ctApc64s2nxiwfucdKJuk6pgPk3UbRNwFU4tW9Qjk3m4HP2es/bnrYFYBeeBQzQbQH
	vdDRs7VUShYwHTc7HrtlwA7N9u1UN6LGMHxJD0adlsoTkoNXbxjUysQlkQziOqRcoEYkuz
	MApidT7zAxevguOmMt78U1loiI5FP0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-kDHKpYH-PcCG6_xA3bDyRQ-1; Wed,
 20 Aug 2025 01:36:50 -0400
X-MC-Unique: kDHKpYH-PcCG6_xA3bDyRQ-1
X-Mimecast-MFC-AGG-ID: kDHKpYH-PcCG6_xA3bDyRQ_1755668205
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26AEB1800346;
	Wed, 20 Aug 2025 05:36:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B28D119560B0;
	Wed, 20 Aug 2025 05:36:34 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
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
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 10/12] arch/xtensa: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:57 +0800
Message-ID: <20250820053459.164825-11-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_223700_618115_9E69F2D2 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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
usage.

Here call jump_label_init() early in setup_arch() so that later
kasan_init() can enable static key kasan_flag_enabled. Put
jump_label_init() beofre parse_early_param() as other architectures
do.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/setup.c  | 1 +
 arch/xtensa/mm/kasan_init.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index f72e280363be..aabeb23f41fa 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -352,6 +352,7 @@ void __init setup_arch(char **cmdline_p)
 	mem_reserve(__pa(_SecondaryResetVector_text_start),
 		    __pa(_SecondaryResetVector_text_end));
 #endif
+	jump_label_init();
 	parse_early_param();
 	bootmem_init();
 	kasan_init();
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173a..4a7b77f47225 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -70,6 +70,9 @@ void __init kasan_init(void)
 {
 	int i;
 
+	if (kasan_arg_disabled)
+		return;
+
 	BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_START -
 		     (KASAN_START_VADDR >> KASAN_SHADOW_SCALE_SHIFT));
 	BUILD_BUG_ON(VMALLOC_START < KASAN_START_VADDR);
@@ -92,6 +95,9 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
-- 
2.41.0


