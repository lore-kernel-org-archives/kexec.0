Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C9BD116F1
	for <kexec@archiver.kernel.org>; Fri, 28 Nov 2025 03:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IKXZUrmhKSnLBrasgIFsU0j1OV2RdKEZHqiMi8x1qZQ=; b=mpg1XL6ulMORuNaV+Z7zHNSLAM
	SQHoUlJYIU3dgq6j+HbVR8NW+SgFDfFKxBdbg0gejAxr9kTCzIhNlilaWtypGj/JpBg0DeAh49xuE
	PpYNV+CTcLqBN2DgkjvfjhrIlMnHN8UsGdQrCBc7cL8CrYqcbuElULNAKfnCxnS7pP6O1gC/xJZ13
	0yX15qDa3GI/AJbnJtbSm9aOW+JlrO3a7PJ0TIut52q4rdNi5usRsd8jk+mhYQq16cuoOGRWhqXry
	yEK5TwP4nlZp0mYMdfb0Vuz70IAtayPDkvsZXjPJhNxNYeL8dLdMcHNan0IBSc3PYmX0ttkAi70dz
	tDFqEaHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpGR-0000000HXB8-2Etv;
	Fri, 28 Nov 2025 03:35:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpGO-0000000HX9K-1ROu
	for kexec@lists.infradead.org;
	Fri, 28 Nov 2025 03:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764300915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKXZUrmhKSnLBrasgIFsU0j1OV2RdKEZHqiMi8x1qZQ=;
	b=VqQLxoZjE1jXNhrUtq2A+0hGiEFi33m1M8AmWRS91Q4rWzG1jExaFzztt21rLLax5YLAM3
	jWFX1prwXwX1/R+yZyR8rpxejJ6opn7nsvY1dC9rmWgqgjqEzM+YBKDEOU+DP6qOfgm3EH
	O+93x1ABZrCF2ktL+gL+U+2/rNtR584=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-_d3nj9KnOtCZzyg-FTOf-A-1; Thu,
 27 Nov 2025 22:35:10 -0500
X-MC-Unique: _d3nj9KnOtCZzyg-FTOf-A-1
X-Mimecast-MFC-AGG-ID: _d3nj9KnOtCZzyg-FTOf-A_1764300908
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E284195608F;
	Fri, 28 Nov 2025 03:35:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6219519560B6;
	Fri, 28 Nov 2025 03:35:00 +0000 (UTC)
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
	elver@google.com,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	linux-um@lists.infradead.org
Subject: [PATCH v4 11/12] arch/um: don't initialize kasan if it's disabled
Date: Fri, 28 Nov 2025 11:33:19 +0800
Message-ID: <20251128033320.1349620-12-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-1-bhe@redhat.com>
References: <20251128033320.1349620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_193517_311294_55A27E13 
X-CRM114-Status: UNSURE (   8.96  )
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

And also do the kasan_arg_disabled chekcing before kasan_flag_enabled
enabling to make sure kernel parameter kasan=on|off has been parsed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/kernel/mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 39c4a7e21c6f..08cd012a6bb8 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -62,8 +62,11 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+#ifdef CONFIG_KASAN
 	/* Safe to call after jump_label_init(). Enables KASAN. */
-	kasan_init_generic();
+	if (!kasan_arg_disabled)
+		kasan_init_generic();
+#endif
 
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
-- 
2.41.0


