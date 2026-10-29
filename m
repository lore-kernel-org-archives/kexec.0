Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5F606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zwhJGvrO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ail9VJBd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hNCQwk1kVwwDQd6YdP9bn0F2tzwSBJGnMYrpsz+xroI=; b=zwhJGvrOQmFNzEBjZ7jNeuFJa+
	/e0ap9shOPwJgOWA/N7iiLOl7rshTUrONIvdMty7gPahGRNWrF2CyFWeDi/tfaYOCsy0Vcc7I/a8p
	N8B499uGNB1HI2f9BeSuqjbMoNPqUfOlzv0z5pcP0t/QMHuQySH1APOa2Ao1eUv5ujtEVQH/EELv8
	b8ZlFhDluvk/YBWZndU0hoclKtUeZe2lG5NKsle7haXqUkqN1sLrZfRbY2RRPOIWJAkDzH1cbxmsc
	3y64xsGW3NXyx2fU0sElF4U7pSCyR1hxbb7NxJohl6oWE8xvt8GexxdJ7p29xMKB3wgKg5CcZ3Amu
	OU76JyUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOSK-000000094W6-2Dm2;
	Thu, 29 Oct 2026 11:38:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMOSJ-000000094W0-3fqP
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 11:38:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F3C3E43440;
	Thu, 29 Oct 2026 11:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3801F01825;
	Thu, 29 Oct 2026 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793273882;
	bh=hNCQwk1kVwwDQd6YdP9bn0F2tzwSBJGnMYrpsz+xroI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ail9VJBdWbIaFY6FctxLtUgYRHgBXtvqpup5RxHjX8Kun5bgSmdWKaIGvUbl/H67D
	 EtchMfmh++7c58rAzzIcOZJlh7lU068ve+224x/vgneSfQv01jqM2Wo4b1vgV5PkQV
	 p1wGA6vLiXNJvxW4IlD096ZyNX3LzYYrCECa15A67f/Y3MyckPpiJSZQCM9WofsF1h
	 dNLVrxG6X+4vXWm3hjvcfoKWjvFUJFbtcZd9TwphSLT6L7gTvVao+jRJGI2iJ7TQ6k
	 Iqx3OJ8IZ43B5gnVKp4CY6HGbSbA7r7q2m7qWPekZSqeQFYt6ZRDde2QXdTZrHksaG
	 hRFiEsxBGnmWw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 61199198003A;
	Thu, 29 Oct 2026 07:37:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 07:37:57 -0400
X-ME-Sender: <xms:CjDjajshZPeHtuir7v6mreGhAT4TgwhDFbd67W8lqX6eL1H1h2Hveg>
    <xme:CjDjapxTdjr1qMNJTi5jiBAbPeUL8WNi-rLAE_SEgVpbUTGclmUKEQ760n5h0fqeV
    hy4NTYi59RMULuyZS8aZ2YEk4SsTRY2j-0YZqzoSiY2c-6zrTJ_WiZa>
X-ME-Received: <xmr:CjDjah4JZaAhw-Fk9PScSG2a10e8jvqhDX8C23W0UBFCIs08u9qC86Fq1ss>
X-ME-Proxy-Cause: dmFkZTEJDAstCk+7zNgejakM4nNk+p9JZpQkZ6Wp/ORPY45DYJ9sLHFzb2OSqjFNCrREyO
    88yfN6Bm2PU/BZ+n9uLJeM8IQCx6gh4dmoBjtrR/gRMQnW1vav0T4U3R0wWLGH7ILSJz0U
    jdMa6OkiVebfbkVm5JCCWeL4Bgmn1pDydwYsJOPck3Qdns4HPrCASx59vSMT+/j+yF0qvX
    G2BRvU5cIsoY70+iA26gBsYSOUUpx4hNQp6J+87EVccCZ9Ae0yLIol7hi0rblFUAevpiPd
    uHrIkD9QzQyn3BgarrdLD501N6XdbeMUSrCRkW1q1L/F8zcqlxf0OSCgggqIu+bFPdnmVK
    NcNYxpSkwWOCwZcLOuaYHRTsxYx6D85JDsOHrpKL1vEhmUAKDtUhCnUAlLFqot1DM9q/eV
    ZTIcjPJqq14fF0zy0HGkF60Z4NFN+bSz/WNKQw6f5WcVzsXmI0zvI1J66w/XqmME697OXQ
    zERHpQf1f2P1KpVc8eIXbHuzD/SOd6B+KE+lUnfFtKDQN9VNcFcye2oj8ZEx6A7qEAQffs
    IUWqlyPo0fg/2eaM6xeJ2DOITKhJqU9srQCSgILo9WyD2HhperaR62DEVqvtfMq6CL02UO
    uYQhCBNO5b6ROgC+/K/MpQZdw9fNc5YCZUTnJbGBtnaHKfxJROTOsVpYwzvA
X-ME-Proxy: <xmx:CjDjanSS7Mx8TZPiU7heer_Q9SPTwHVFNB-SMCwAJ9aut0b1vRFrUw>
    <xmx:CjDjag-PYdm5Aer_OhpqtOoZx_SwLxAY07eLDmtLNEeq-uTx5hq8eg>
    <xmx:CjDjauzsU80bWiXzCsXzA_QbCjiGNW-gGh7_khHqQIP9Mv30v0qhhg>
    <xmx:CjDjaqzuB5gcDCgx7-WAvZUa70Eg8YXQlUPcy8ONATKcSf71OQuvVg>
    <xmx:CjDjah0f_57xCcmxZRGSyxLW9vwtr4aZedU-FEl-YETeEd7d6gRBRj2j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 07:37:45 -0400 (EDT)
Date: Thu, 29 Oct 2026 11:37:44 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
Message-ID: <auMvYdTd_e9O9kDj@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
 <auIniV8YSpA4_oxg@thinkstation>
 <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:45:34PM +0100, David Hildenbrand (Arm) wrote:
> My brain hurts, does the above make sense?

Yes, I missed that the loop only goes back to start when a lookup
comes back empty below end. When the last batch reaches end, it exits
without another look. It doesn't need the split either: any punch hole
whose last page is in the page cache gets there.

That exit looks unintended to me. b9a8a4195c7d ("truncate,shmem: Handle
truncates that split large folios") turned the "if (start >= end) goto
out" early exit into the loop condition. Before it, the loop went back
to start until a lookup from start found nothing; Hugh kept that on
purpose for hole punch in 792ceaefe621 ("mm/fs: fix pessimization in
hole-punching pagecache").

Restoring it is enough, and makes the "restart to make sure all gone"
comment true again:

+       if (start >= end)
+               return;
+
        index = start;
-       while (index < end) {
+       for (;;) {

Then a replaced folio is found on the next round, and truncate needs no
special case for it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

