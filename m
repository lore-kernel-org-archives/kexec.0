Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743AFD116F1
	for <kexec@archiver.kernel.org>; Fri, 28 Nov 2025 03:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zYq5Xg8QPu70UaOO3h6mVKhUd8xeQ64UlU5KTsxCNk=; b=BCcZfqXZltPRhnbbo/+LkEuJVz
	44xqXmNyYfQeAN4L5DrEQnU+IyXqUglI2yX5m870aU9qZkBr7gGTtzimXKLDoxb5xRRZRnCF8XMv0
	OtafJ2AILJ4yBNVmfM7bYT6+Gh9XAB83RSoTXc2TSC6TOMje0+JB7gi4wAYlbAG6Ks1UGmjfW8PAw
	T4ZCRoSzfaQ4Fkdt+PO83fCnCsSjgKWdinTwSHtgx4dwRCQAFJrqCzejlsa9XsERbD0X4BMtJc3ui
	cc+xP1hcwb57LRfdmS5w4FG9+KEZQaoz0HmC3a00mdqcKNjgk1UQNYzMvtBmUwtzRr4JllyfJFNyg
	OD2t+O8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpGc-0000000HXGQ-473O;
	Fri, 28 Nov 2025 03:35:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpGY-0000000HXES-1GRu
	for kexec@lists.infradead.org;
	Fri, 28 Nov 2025 03:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764300925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zYq5Xg8QPu70UaOO3h6mVKhUd8xeQ64UlU5KTsxCNk=;
	b=dzY8eMFf0NJll/TuvwPFFg7gRNogtNHf2BEDGQX/mF7buDH9BvZYxNgLXyZ3WOirC3sQpb
	5z2OmmDr38mbM783cfjF2DAnC8L8GQ6cnu39poeBL1gcOHH9gZsZj/Y9RqNopJYxCnxHPR
	FYz9211vIaG+drGfrY6+MsFCmu+d6jA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-PSk638q6NMCqBHAkPGt0ZA-1; Thu,
 27 Nov 2025 22:35:19 -0500
X-MC-Unique: PSk638q6NMCqBHAkPGt0ZA-1
X-Mimecast-MFC-AGG-ID: PSk638q6NMCqBHAkPGt0ZA_1764300917
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E833A195606F;
	Fri, 28 Nov 2025 03:35:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A4DE19560B0;
	Fri, 28 Nov 2025 03:35:08 +0000 (UTC)
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
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 12/12] mm/kasan: make kasan=on|off take effect for all three modes
Date: Fri, 28 Nov 2025 11:33:20 +0800
Message-ID: <20251128033320.1349620-13-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-1-bhe@redhat.com>
References: <20251128033320.1349620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_193527_174575_01A1BF87 
X-CRM114-Status: UNSURE (   9.90  )
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

Now everything is ready, set kasan=off can disable kasan for all
three modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index b05ec6329fbe..b33c92cc6bd8 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,6 +4,7 @@
 
 #include <linux/static_key.h>
 
+#ifdef CONFIG_KASAN
 extern bool kasan_arg_disabled;
 
 /*
@@ -12,7 +13,6 @@ extern bool kasan_arg_disabled;
  */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
-#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
 /*
  * Runtime control for shadow memory initialization or HW_TAGS mode.
  * Uses static key for architectures that need deferred KASAN or HW_TAGS.
@@ -30,7 +30,7 @@ static inline void kasan_enable(void)
 /* For architectures that can enable KASAN early, use compile-time check. */
 static __always_inline bool kasan_enabled(void)
 {
-	return IS_ENABLED(CONFIG_KASAN);
+	return false;
 }
 
 static inline void kasan_enable(void) {}
-- 
2.41.0


