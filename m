Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF39606A333
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YOjlcOsv;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Oh2kYb3Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7noARN/sft+NtmJTHmUDUAvU1Dihrn7FLenu365oKlA=; b=YOjlcOsvuuGq34
	P3jVZjxu9FWKFjZtJSj93pEgWamq/SR2/FOEgZCXmW+y1D9IsBkjuk0L59Xp6u0MALM/JKQtcJkDP
	L3HB/oDJFtNFYlhbcbHi67o9ACIUahcd9Ak9vGDPQZkqcG+V/wc//O85AiAVxFlU0RbjeUKtSy9GF
	D/GaIWV8pZqYEAhsWjZwmDlAjT76XLS5Fzc78lCbVbBFuT6f2YRLl48qJKYoPIEQhCmrrqDBlmv20
	4qRqIVorYM3BUPpX/3UG79sAH9Db7YqCrr00LBXKZEEjK8wdHmkTxkr4TxNTuacifujE7lxv9XMLp
	CdcOLUlFqeKO0oMjp0Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5n9-000000046y3-3zVN;
	Mon, 16 Nov 2026 23:07:15 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5mv-000000046kz-3hLO
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:07:05 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so728161a91.0
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870421; x=1795475221; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7noARN/sft+NtmJTHmUDUAvU1Dihrn7FLenu365oKlA=;
        b=Oh2kYb3Q0CDNYToRJtgMSgGziMIRn8bga23IUIEQQPqnpZU9OETq2dmv7BOO2BMIC1
         Vxodz5JtESIQrAV4p3wqpiAv7WHAePpyFcMHH7Mz7aqFuOhl+XdyNjRd3dLFxDzSV7ND
         79F/k1e5EfaurVDWwDlaSqyEZLSjvkWlEHiYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870421; x=1795475221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7noARN/sft+NtmJTHmUDUAvU1Dihrn7FLenu365oKlA=;
        b=NsHLM0r6Zy02xN7JVxMPZdtHPJ/VkxXqQpAqm4I8vm7MpKeFLc0kzEs+9wx5eEX3EI
         5TExGoqE0Zrfwn8xPFVgawwrXt0Ohbpb9J9DbN7GfhEGtW+L6iHbMllLZSW8H1xrTAtR
         o6btxeu1U/AyhtT4Lba7pZ5Ns9muSe8fw0O/DBwthlVZFi49LuqZloc202Uu+ndEmJVq
         6+HVNPJssOyxz2rjkxjkLFH3EPB0TeRsoodC9CglFDv/m78CmwcwEwwQxwjv4Vs5C3yt
         AWYTGeR8/JniK4obKPBzoRNHqbV1orZTLzA5psoxXQYSd3OmlYDZVAugwDb9nAEWMcn7
         KkYg==
X-Forwarded-Encrypted: i=1; AL+hErFdT7ryl1S3bS9+veY0XXspt38CGHjvpkhf+iigFC+MCHEPkXAdiz1hxzyp4H+4ZtsqQPyPtw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9iPH9UWbdic+bi5ap7tvx0msg/7aJKhhEMDlgd7AbetpA07Ogc
	jy14UsIvv8cMzo+KhNZ2VpHg6/lInsfeu67brkRJSqcdQaqG9F+ee91YqjjsEOfpgQ==
X-Gm-Gg: AZFdTZfQ1nveaemvrHmsEELmgdqJPlyTKajb6sKpwJOBblEzt/2+ZU7bAGIr64tqEUF
	eMhLuI3KvEAiWfErED9tc+8mHfRrWfEDw8KmwAvMrzpIcSj6yaw86YsOMZdJSFhYxEfTyZMx69L
	9VlWijGZk+7V79C3qYBziiK1Clw0dG4vkWKPJLmtxmJ2A7wlK3+mXm6Cve50dS4DCWv4fOmSXNK
	ZTxTD7d5W65y3981/k4f98DYtLjAELSRiVvRSO0VBcdemXqLwmNRKHGjc6GXU/ouAdGk8LENAzw
	PwH/nAeOA3x3Arsnmi+ZuNIjTAX3h71wRxwflyzbR7iweUsCQ99ShRMF4urn/acoYKfr4Mv0rHC
	pTUs0AUDQA374tQjtzKWVVvDanqoJP6FeS32PJOPWcaa8wnOqUtHpO2jTyoeNqbdcKtzOPVFjB4
	e3dghX1IsrmXbXb+fQZUXNCAMI6XBumfLIJKuzyQHqe1ZX7UeQAPrMsjxazBfuJhp/66jhmZ2Nu
	RaKm/t4VTQMUaU3TI8YLtSq/TlnQsW/oC8quNhRjgiD1ljylGWDu1rXMmMuswhtY/TShoPyzTsN
	EnK4VdyKBe34ORwkaQe4O0zdUNoFScEYlZOwlk1Bn7JQb0bYaqKBI6Xpe6/JkLrPSEfaefE=
X-Received: by 2002:a17:90a:c88f:b0:3b0:9a3e:bf8b with SMTP id 98e67ed59e1d1-3b1b0b5d63amr16850510a91.6.1794870420893;
        Mon, 16 Nov 2026 15:07:00 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cddc1873531sm4674755a12.10.2026.11.16.15.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:07:00 -0800 (PST)
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
Subject: [PATCH v1 6/7] mm/kasan/kunit: add page_alloc_skip_kasan test
Date: Mon, 16 Nov 2026 15:06:26 -0800
Message-ID: <20261116230627.3537051-7-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261116230627.3537051-1-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_150701_964037_68535F06 
X-CRM114-Status: GOOD (  14.83  )
X-Spam-Score: -2.1 (--)
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

Add a KUnit test (page_alloc_skip_kasan) to verify that page allocations
using __GFP_SKIP_KASAN (GFP_KERNEL | __GFP_SKIP_KASAN, GFP_HIGHUSER, and
GFP_HIGHUSER_MOVABLE) under CONFIG_KASAN_HW_TAGS:
1. Reset page_kasan_tag() to KASAN_TAG_KERNEL (0xff) across all sub-pages
   of a high-order allocation, and
2. Return a match-all (0xff) linear-map pointer from page_address() that
   does not trigger a KASAN fault even when the underlying physical
   granules carry a mismatched tag (such as KASAN_TAG_INVALID or
   restored userspace PROT_MTE tags).

Assisted-by: LLM
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/kasan/kasan_test_c.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index f34163e19bd6..72342137bb18 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -380,6 +380,49 @@ static void page_alloc_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[0]);
 }
 
+static void page_alloc_skip_kasan_helper(struct kunit *test, gfp_t gfp)
+{
+	struct page *pages;
+	size_t order = 2;
+	char *ptr;
+	size_t i;
+
+	pages = alloc_pages(gfp, order);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+
+	for (i = 0; i < (1UL << order); i++) {
+		/*
+		 * __GFP_SKIP_KASAN allocations must carry the match-all tag
+		 * in page->flags, and so in page_address(), not a random tag.
+		 */
+		KUNIT_EXPECT_EQ(test, page_kasan_tag(pages + i),
+				(u8)KASAN_TAG_KERNEL);
+
+		ptr = page_address(pages + i);
+		KUNIT_EXPECT_EQ(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+
+		/*
+		 * The memory tags of such pages are arbitrary: stale poison,
+		 * or tags set by userspace through PROT_MTE. Accesses via
+		 * page_address() must not fault regardless.
+		 */
+		kasan_poison(ptr, PAGE_SIZE, KASAN_TAG_INVALID, false);
+		KUNIT_EXPECT_KASAN_RESULT(test, WRITE_ONCE(*ptr, 0),
+					  "WRITE_ONCE(*ptr, 0)", false);
+	}
+
+	__free_pages(pages, order);
+}
+
+static void page_alloc_skip_kasan(struct kunit *test)
+{
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_HW_TAGS);
+
+	page_alloc_skip_kasan_helper(test, GFP_KERNEL | __GFP_SKIP_KASAN);
+	page_alloc_skip_kasan_helper(test, GFP_HIGHUSER);
+	page_alloc_skip_kasan_helper(test, GFP_HIGHUSER_MOVABLE);
+}
+
 static void krealloc_more_oob_helper(struct kunit *test,
 					size_t size1, size_t size2)
 {
@@ -2369,6 +2412,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_large_invalid_free),
 	KUNIT_CASE(page_alloc_oob_right),
 	KUNIT_CASE(page_alloc_uaf),
+	KUNIT_CASE(page_alloc_skip_kasan),
 	KUNIT_CASE(krealloc_more_oob),
 	KUNIT_CASE(krealloc_less_oob),
 	KUNIT_CASE(krealloc_large_more_oob),
-- 
2.56.0.611.g1030f0b940-goog


