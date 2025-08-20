Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889FACA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 05:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lC7gxKLfCffY1/zE+RJo3yBumyZwu5V9Ft7avRiVVTY=; b=GmzYFVyjAMb7b4PbKf0gLO1o4o
	wu/SJ76ByqTc+KmQRx4AkqtJ10jLm0m6KtPaC1ybDxpWtSmuwIKKN8vqZSrPKxNQJ81x+QipmE59R
	ew7YjiNgTG2XQRLCUGMeghBcLSO462CnvXdiQ5FYJBPSsOzxwsiGcwPaCDDhS8jrrYjNTzM/QL5zs
	qBaAZUzMpGsG0rQQ06L9TNM0T1Z1F/p+v6oAY32nopQ4/h8BtH7BeedA4nlnTHFCS37qUQ8djfqIk
	luaSEkBoAIYyWx1C8M4lSk4jTKbouq9MsJ/nlFjmvXmCELVEcL2Z6x0jwkyeux/tnw6hh9aIu496f
	8Dm+mSew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobVr-0000000CQWm-1yFB;
	Wed, 20 Aug 2025 05:37:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobUA-0000000CQ53-2EBY
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 05:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC7gxKLfCffY1/zE+RJo3yBumyZwu5V9Ft7avRiVVTY=;
	b=XY7DJoGt1ZpL9OGDuL6E31SlPaDKPanhcZzs8S/aE5UggDLCxcw3uz//VGttBpb4AXzsl/
	lveRkH2VdxMEq8Ev7emT2Nvpidiltz6aaToBq3Ul8HjUccqZbST6VDgzwQ0hLSO+K1ldhg
	8gbl2VAW7RtzMpZ0Zvg55XiMiSjPQmg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-6LzTzuBZPxSmLJLuVYPWIw-1; Wed,
 20 Aug 2025 01:35:41 -0400
X-MC-Unique: 6LzTzuBZPxSmLJLuVYPWIw-1
X-Mimecast-MFC-AGG-ID: 6LzTzuBZPxSmLJLuVYPWIw_1755668139
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AE39195422A;
	Wed, 20 Aug 2025 05:35:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FD9E19560B0;
	Wed, 20 Aug 2025 05:35:29 +0000 (UTC)
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
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 03/12] mm/kasan/sw_tags: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:50 +0800
Message-ID: <20250820053459.164825-4-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_223546_651750_F3063873 
X-CRM114-Status: UNSURE (   8.62  )
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

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/kasan/sw_tags.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 01f19bc4a326..dd963ba4d143 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -40,11 +40,17 @@ void __init kasan_init_sw_tags(void)
 {
 	int cpu;
 
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_possible_cpu(cpu)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
 
 	kasan_init_tags();
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.41.0


