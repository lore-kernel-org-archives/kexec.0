Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42332606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bGEjJHi+;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ijaSVVgs;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ljFKBqmi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=b3WMjSBwi5PFDvIaCpQd7Axi/XWPxIYqZlMheE6sk7Q=; b=bGEjJHi+tvPmbL
	2KcoIrJ6lCmA60NjlawYxy3kbcQTtEHCVGTV6bN611EH55opY6VFtgAw9nKafKyTV+HDwxOoWPff/
	slGTymrGulYULWSVPSlCG/cQ+EIygizIdwqyISW1UCbiN3GAdHBNy91x628nneN0b9QqQbxcSmhiK
	rhX0djykAt2BDfK6yuT5W2RROVAsLKIYpm/zVCpkd6RHCgXkoHqlf1/fOwt9kLpDzHXm7wka9teli
	adgg5URF4HG7LHE27Dzuunfbg8N6WS4FvX0MKjfteJ+fdDAoJ+rc1hENROcfKkkuMS/4UoAGBLr8p
	bVTpTVYTtPMDbMrhsb/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPsv-00000002cvZ-3kg8;
	Mon, 23 Nov 2026 08:58:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPsk-00000002cnz-2hGH;
	Mon, 23 Nov 2026 08:58:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=b3WMjSBwi5PFDvIaCpQd7Axi/XWPxIYqZlMheE6sk7Q=; b=ijaSVVgsGXpZ4m0Ac/guhXk5fm
	GZ1h4W3ZrYYyVNpdmu9jNC7IHGxX10ciIjjo7KCJqYQG8kX8+/hcv92cf0G0TZE+YM2Gctt+MxsXO
	fsX16nnQLBX0zUyiYY49w57KtJfPJLiHv24Oav3th/NSOu92Frvmi/m94bbyVFeYre3r2SWdOdZEg
	gigr4pe7IApHRDefU/lWLexOebEZMkSEQmUB+63M6ERfo3sseCfgvTyhlxQ6Ci8Iows1im2ucNcNq
	82rj8UCOJhcBHZPbm6CQPxpRgD7snMIir6IRBLMmVv1LUjvbQQHDPzYiNyh57PueuUHDdTPri1StY
	k9httjcw==;
Received: from foss.arm.com ([217.140.110.172])
	by desiato.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPsf-00000002t6C-3ZlJ;
	Mon, 23 Nov 2026 08:58:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC6F1476;
	Mon, 23 Nov 2026 00:58:28 -0800 (PST)
Received: from [10.57.91.245] (unknown [10.57.91.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF623F882;
	Mon, 23 Nov 2026 00:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795424311; bh=IyuQOHegOm7o8+idks5YbotHgA2kGInEw/MsLFSwZbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ljFKBqmieG86A9o17mg2OKClKeqYmywjsi88qro4DKa+Bzf6DMkYNr9cZvknPpkUp
	 MK+dIkOffcqanqO2jC1axlvaTs8nppW4q108uU909LcHYNdp1I6oK5movdwY5TJcih
	 uXIzdw84Y8RliXz46ZJI31Ytyxy9qn1kOEfkLx1Q=
Message-ID: <7a3ffc6a-866d-472b-91d6-886ca8095008@arm.com>
Date: Mon, 23 Nov 2026 08:58:20 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/kasan/kunit: add page_alloc_skip_kasan test
To: Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver
 <elver@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Dev Jain <dev.jain@arm.com>, Ian Rickards <ian.rickards@arm.com>,
 Jann Horn <jannh@google.com>, Jeff Vander Stoep <jeffv@google.com>,
 Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <peter@pcc.me.uk>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Tomasz Figa <tfiga@chromium.org>, Will Deacon <will@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Allison Henderson
 <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, kexec@lists.infradead.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20261123033111.2349160-1-jeffxu@chromium.org>
 <20261123033111.2349160-3-jeffxu@chromium.org>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261123033111.2349160-3-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_085835_834061_CE46F8DA 
X-CRM114-Status: GOOD (  22.63  )
X-Spam-Score: -2.5 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/11/2026 03:31, Jeff Xu wrote:
> Add a KUnit test (page_alloc_skip_kasan) to verify that page allocations
> using __GFP_SKIP_KASAN (GFP_KERNEL | __GFP_SKIP_KASAN, GFP_HIGHUSER, and
> GFP_HIGHUSER_MOVABLE) under CONFIG_KASAN_HW_TAGS:
> 
> 1. Reset page_kasan_tag() to KASAN_TAG_KERNEL (0xff) across all sub-pages
>    of a high-order allocation, and
> 2. Return a match-all (0xff) linear-map pointer from page_address() that
>    does not trigger a KASAN fault even when the underlying physical
>    granules carry a mismatched tag (such as KASAN_TAG_INVALID or
>    restored userspace PROT_MTE tags).
> 
> Tested on arm64 with CONFIG_KASAN_HW_TAGS under QEMU (virt,mte=on) with
> kasan.mode=sync, async and asymm.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/kasan/kasan_test_c.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index f34163e19bd6..72342137bb18 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -380,6 +380,49 @@ static void page_alloc_uaf(struct kunit *test)
>  	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[0]);
>  }
>  
> +static void page_alloc_skip_kasan_helper(struct kunit *test, gfp_t gfp)
> +{
> +	struct page *pages;
> +	size_t order = 2;
> +	char *ptr;
> +	size_t i;
> +
> +	pages = alloc_pages(gfp, order);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
> +
> +	for (i = 0; i < (1UL << order); i++) {
> +		/*
> +		 * __GFP_SKIP_KASAN allocations must carry the match-all tag
> +		 * in page->flags, and so in page_address(), not a random tag.
> +		 */
> +		KUNIT_EXPECT_EQ(test, page_kasan_tag(pages + i),
> +				(u8)KASAN_TAG_KERNEL);
> +
> +		ptr = page_address(pages + i);
> +		KUNIT_EXPECT_EQ(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +
> +		/*
> +		 * The memory tags of such pages are arbitrary: stale poison,
> +		 * or tags set by userspace through PROT_MTE. Accesses via
> +		 * page_address() must not fault regardless.
> +		 */
> +		kasan_poison(ptr, PAGE_SIZE, KASAN_TAG_INVALID, false);
> +		KUNIT_EXPECT_KASAN_RESULT(test, WRITE_ONCE(*ptr, 0),
> +					  "WRITE_ONCE(*ptr, 0)", false);
> +	}
> +
> +	__free_pages(pages, order);
> +}
> +
> +static void page_alloc_skip_kasan(struct kunit *test)
> +{
> +	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_HW_TAGS);
> +
> +	page_alloc_skip_kasan_helper(test, GFP_KERNEL | __GFP_SKIP_KASAN);
> +	page_alloc_skip_kasan_helper(test, GFP_HIGHUSER);
> +	page_alloc_skip_kasan_helper(test, GFP_HIGHUSER_MOVABLE);
> +}
> +
>  static void krealloc_more_oob_helper(struct kunit *test,
>  					size_t size1, size_t size2)
>  {
> @@ -2369,6 +2412,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kmalloc_large_invalid_free),
>  	KUNIT_CASE(page_alloc_oob_right),
>  	KUNIT_CASE(page_alloc_uaf),
> +	KUNIT_CASE(page_alloc_skip_kasan),
>  	KUNIT_CASE(krealloc_more_oob),
>  	KUNIT_CASE(krealloc_less_oob),
>  	KUNIT_CASE(krealloc_large_more_oob),


