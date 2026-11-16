Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E9606A88A
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VvLxIsJH;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Om4Zhlf/;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kG+SvUCI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ov7f0jCh2x7/B/l+YrluktAKi2O0zfS/6BcSjEJkDWQ=; b=VvLxIsJH7Rq9EH
	g8lqoob9fIP6fXS8lTceuBF9c1o5NQg0O7KtQQIQC4lGe6AcdCvoQkXcGcj/AZyyOikGXjZ3M9EgR
	7SHUg4z3EjG5amHuKBXR1AIs3JLm35ELYZsjq/S3bg4WOCGQt8OMBpYahXFJxNdoJQs8uJaGbVWiJ
	NHIYwwmYYP9imeaVt/2JlEDdZDKkPg2cGjvA9uzSO97Km30RKN2QSJlpAsRVfe4z9HcJVW9eaqOgh
	TQpWCvYboeM+J2zxgzvAfnMaIBW613hotv0DsnuVWELl6jZfx+oGIX3B5Nzd0ADZWpNwZ1G2w6n5T
	fokYvQCad7SMI4CyZWCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5nA-000000046yR-0YRt;
	Mon, 16 Nov 2026 23:07:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5n3-000000046sN-0VUA
	for kexec@bombadil.infradead.org;
	Mon, 16 Nov 2026 23:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Ov7f0jCh2x7/B/l+YrluktAKi2O0zfS/6BcSjEJkDWQ=; b=Om4Zhlf/jbzsyaQ8ecnNutf2Kl
	kclR09QMBF48cocTXUc5xt5HA3cU/XHP7Bp+oWXRQWSeGfSP5Qa/LSYo5DaHDfqQhg4Ol7iKlawg4
	4AQf1vygspKYAq6jVqrx9MruAvnXOsg1b/ZZmcK+0TSU+5U79++/Ea/esgw7rPTwtfyN6qEt4qHIq
	L1L+t1r/gMeMC4r0k7oaeAwUXh5mhGUvF1PPH17J5rty6Uf+oXW5207L7Cy6F01dxHcueyQjx/1jS
	QXJlhuEnx1EPWq5qDK5xZTlC8A2i4vag794OYh4UtKsWmp44ZzSOKI6fsVr/TGQuy2Ml9nfsWUNtB
	I0FA7YbA==;
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5n0-0000000EOzu-1rSG
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:07:07 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3b09cc7ed1aso489101a91.2
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870424; x=1795475224; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ov7f0jCh2x7/B/l+YrluktAKi2O0zfS/6BcSjEJkDWQ=;
        b=kG+SvUCIshXk0Hm9Y16yKPPmiU7s32jdZpFUy7mbUpSDRnmpeNLbf9HsNo8+W5UhKp
         k4aiLd3esa2Qu5nlv5pPORJoj6/JVF5DS1srwDj71hoY5KJLESCUbWhKLMudf6lLVhv/
         GvH+ITNZOj31PBT01o+c5rgYMtYJxRKAFSvIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870424; x=1795475224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ov7f0jCh2x7/B/l+YrluktAKi2O0zfS/6BcSjEJkDWQ=;
        b=CAQ84Ltwge3XHscIaFogW+IQMWjVnwN/5ijrikvDyUZmLPxtot7/LIKwHaNwSIlFFF
         OtVuYJ86vEIFuvgIcDtMc36CzD8Kn+j5VWB+dsjL5GiLTag89VudG/uZGo0C0h8oQfVc
         /NsR2yFdJg9V4c5P9B+uDov/6YrTgsm2ZbXtGaliJMWKvogM7yecnYJKl4ztD8+ZFtoe
         HIhv0S0ZVWmN8RsrhH5RlEZCNPiqoF7P6twQ0mRZBpDkaSTukpIzpICYsqiNny5AVCA8
         TfmdcvH74zhmT80vuK+5uf2MAAhyS5nMxkGWH9/GpCO9qTviQwF6ju8/Y+S0A3mVEBtl
         QL/w==
X-Forwarded-Encrypted: i=1; AL+hErEPmQux/qWpFmvWx3vKCFPp6OC+JLXYv44unm+Nx7UZv0xUPKQCmcXKv+S8hGEDFDGS4hirhg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8YDjUfa5QitomwPBuyGpTjijsi9BPj4xd0vnU3p2DMJelyrhPw
	Yr2XimiP0WtCObVK/eqr2O9UrYQfsQsj2cNaKljMh2aNrnkAC0IvIl4UDV40jDyV4w==
X-Gm-Gg: AZFdTZdvEJf6nR+jSHuWyLatwp7WlWrZyTDOHU+E+fB6iFT1CuOYtoleoDAHe0QsFR+
	H4IKFUYx/ULSAL2c7gILCKMwLI0iCQaUcQUnZZrsQy8F2Iikvrz9Kybfi31miuub+WIjs57EPnd
	iJBlqqU3mEucr03AeCXn6OhYwLZQNKjoPlNep7MuulY/COSMac7W6CsnCSR04UdaGI2OesjfsM+
	hzCO1SXNo4m/DrGFInyLW2G+wYIsEJqvK/PSvXrde1+KHPFQPgNBlfmbNCVg0wVFZ37MQ75IEvr
	CSomgTDRr5CFWhRCbqujUxr91AdK77EOCyizLDEfCLKMCQz8wjBVGygOjvtuZd9RKzIRysVvHbR
	5HObhrQ+96CPZPR2o2txnIsEk9/UFOOOV6GOLS8FwIcrVunoK0frDtNlAjW2ou+CK+JLo4AhFoF
	nmXcH5lxtrGqpVN7O6VXIuGWw+ct4HDfvogWlWTIF34Y+aUhdUwk/gmTZ8SZTWPrEI5vMcaSkmA
	TcPRgwqmEFQQ+7V4rStW0ff3U9pL95pMSuxS1h3c9FcvOdqR+1z7ICTwhWzTijFvnpztoknCU8H
	mvy0Ud/VHejLFf2afS+h1EZYI2fRW+8UG7JMnKkEMpJIN2LMHoSbwMerq9U6YOztKeSoJVUhSxT
	/gK4EUQgqw6xrSeGL
X-Received: by 2002:a17:90b:5906:b0:3b0:d0be:f02c with SMTP id 98e67ed59e1d1-3b1b0b4ffffmr17720470a91.6.1794870423621;
        Mon, 16 Nov 2026 15:07:03 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cddc13275cfsm5035019a12.0.2026.11.16.15.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:07:03 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/7] mm/kasan/kunit: add page_alloc_highuser_kasan test
Date: Mon, 16 Nov 2026 15:06:27 -0800
Message-ID: <20261116230627.3537051-8-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261116230627.3537051-1-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_230706_507277_02DC3E68 
X-CRM114-Status: GOOD (  14.92  )
X-Spam-Score: -0.2 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a KUnit test (page_alloc_highuser_kasan) to verify that, unlike
GFP_HIGHUSER, page allocations using GFP_HIGHUSER_KASAN under
CONFIG_KASAN_HW_TAGS:
1. Get a KASAN tag in page_kasan_tag() across all sub-pages of a
   high-order allocation, and the same tag in the pointer returned by
   page_address(), and
2. Are poisoned on free, so that a use-after-free through the stale
   pointer is reported.

The test fails if __GFP_SKIP_KASAN is added to GFP_HIGHUSER_KASAN.

Tested on arm64 with CONFIG_KASAN_HW_TAGS under QEMU (virt,mte=on) with
kasan.mode=sync, async and asymm.

Assisted-by: LLM
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/kasan/kasan_test_c.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 72342137bb18..285b82793bdd 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -423,6 +423,33 @@ static void page_alloc_skip_kasan(struct kunit *test)
 	page_alloc_skip_kasan_helper(test, GFP_HIGHUSER_MOVABLE);
 }
 
+static void page_alloc_highuser_kasan(struct kunit *test)
+{
+	struct page *pages;
+	size_t order = 2;
+	char *ptr;
+	size_t i;
+
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_HW_TAGS);
+
+	pages = alloc_pages(GFP_HIGHUSER_KASAN, order);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+	ptr = page_address(pages);
+
+	/* Unlike GFP_HIGHUSER, these pages must get a KASAN tag. */
+	for (i = 0; i < (1UL << order); i++) {
+		KUNIT_EXPECT_GE(test, page_kasan_tag(pages + i),
+				(u8)KASAN_TAG_MIN);
+		KUNIT_EXPECT_LT(test, page_kasan_tag(pages + i),
+				(u8)KASAN_TAG_KERNEL);
+	}
+	KUNIT_EXPECT_EQ(test, (u8)get_tag(ptr), page_kasan_tag(pages));
+
+	/* They are poisoned on free, so a use-after-free is reported. */
+	__free_pages(pages, order);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, READ_ONCE(*ptr));
+}
+
 static void krealloc_more_oob_helper(struct kunit *test,
 					size_t size1, size_t size2)
 {
@@ -2413,6 +2440,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(page_alloc_oob_right),
 	KUNIT_CASE(page_alloc_uaf),
 	KUNIT_CASE(page_alloc_skip_kasan),
+	KUNIT_CASE(page_alloc_highuser_kasan),
 	KUNIT_CASE(krealloc_more_oob),
 	KUNIT_CASE(krealloc_less_oob),
 	KUNIT_CASE(krealloc_large_more_oob),
-- 
2.56.0.611.g1030f0b940-goog


