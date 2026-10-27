Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33671606A31E
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=faBQ7a2Y;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=W8JU/N6q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=; b=faBQ7a2YqCD8mx
	1lViqjgnk1AXKbO6uYLx2JK51EY/CTcNPvwlVKS+A5axFGjRRoElmSJCvm0pI5Aq4vO4Op1RyDUo6
	V7vL/7kMl0MIpUdlZ2jmZUToppmDqaKQtLg91dx90OHlK+x4DMpi8RJ24qRdFA54w4DPstIAkg/84
	2YQJJt7IzqMj7qNZlL45Cp06nJ3CHevkUDjyQa4noLi5AfrKQjGSqluNX/DvOcWYNUl7Z3i4Qvr4c
	LNMAN4H+grDhQWAI0KyHQC4ubEywq8hXuXHpG3SPKcCoEX/KcU2CwlsU/xbHpyHZwD9Ouf9Wzn4sN
	6fzDNnQM7ZJMj+q7MI5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLZSC-00000003lUw-1ykV;
	Tue, 27 Oct 2026 05:10:32 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLZS9-00000003lU5-04SF
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 05:10:31 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so7405094a12.1
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 22:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793077827; x=1793682627; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
        b=W8JU/N6q9FwWhZkLY1bFGP5pcHdFbTf8YdAcgv+H0S2l0GMljXuq9W0DaSnIyxv0w6
         rKZ2peY3EdXiztUCd0S1MfVIT1bP1dPYw+FRUVncKHdPtn0ZTfvMZaqtdOQzQ6TgsmSz
         XVvJSLlIIZcL7fwQDsX+u7tgQS6E27JSBakGTUWApPieSHvX2j0TxEmXXln2H3JV3kw2
         oAPTYQ/c5pD6RCzYKNHLr2mEb5ytDfycQAVvTKpV2QJ62Boq1sf7JnN94ehHkC1Il1FW
         VQ9JyD9Fdxmktwc/Wv3mEHS7p3QoLtXA6MxKRnvMikWf94OMSYvTXmjm9HhyyFDWkw2X
         QNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077827; x=1793682627;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
        b=YX5Q7jZ7/nKm5lLAFEKBRGoDN5rbJ24D2vlTEHY6MeqXHQhKK5j5jIi48mbitDJBYz
         xbBC1ihq9+wMEJqxFRvf6gaTzveoNkuyfVTciJTH/nUiKdOlmt93vuWi4va1xeGVPK1B
         82C5Zh+3JDbk8PWYYLympbOvuF/+NVN4ZrI3MeXHsjMoDAvJEep4ALLisX0Q+Fdq+2P0
         4nByfPWBJQfa79nfXxOu1Lod7ET4TliDV/lOWoKdbDRR4vTzqTc98eVW3CA6ff1XVcB+
         iOWRdUmN8oUCbM/NhOYSomPbmHHzNFnc4mosXCDrRm6H+x6SgQuLv8ZNSAf9KhA6tgo9
         CgiA==
X-Forwarded-Encrypted: i=1; AKwUvBxy64LpZOxiJ6qqqbIctGZhQ3SnD/hvYL8rYJZiCclHfiSw1YqAWVxYJmDTEYOmGrKvh4y0kw==@lists.infradead.org
X-Gm-Message-State: AFq9FYI/fO7d/1KFrZ/ND/hFJ78ISC1SG0lA/bzoDGowYWEkPQNNNBrt
	VkEwpEEaUoK2r++g5wQLet7sKrgfbdiEKPIpPBCaJXtKRngKxKqvgYrwnuUV7mrCy0g=
X-Gm-Gg: AYBFou3mTTe9s5s2rVvRKrmZ1eqyXAwh5Ok0Eb3bCR1tDUr2IGP+yCt9FtJm5L3HC9P
	aONqO3Yggq2oBQ53ZPoBZcq1p8/prP1nCse2h3Ucv76vgr1RZkW5lOmm2B3lcpgYP3HvO0TGufB
	UFVlTwB/YtvDa0J3uVHFRi9uzTSnczxuF2cU4tXddd51QEwYPheJpRK6N4W4FiUN6SdlZotjXob
	X1Vd3M+a1Al6EFSsHFjvABHBVhbvy+RUd2YmOE4Jj8fVbgWeqDVG5x2BkxnbScAOK3zbMuUDBA4
	2vFLqYmLfJ5+/w6oyjWDc+FL1wBNiZRewYWXu+8iI2dQJhSrmlEYUsCyAh8CKLWdrUf/BODHbmv
	Fv6VbuBp8+yxWNZhshl+6et3nimA54bUWZ2nQ9AEHNTVItQVcV4WxTjqO4cAe1HgYn5hd4r5oy2
	QM8MRdrOtass7/1OO4OU9zQYTY3cUCrmOqWuy04qOPdpr5ECP4Tbqdc6tjfibtUUm/pJHDbbe53
	m6YiGq6wdXP7FW76GGexokKrppj6pLEsthfYUl4vCw=
X-Received: by 2002:aa7:d642:0:b0:6af:80c4:8981 with SMTP id 4fb4d7f45d1cf-6b443001da4mr6849436a12.26.1793077826967;
        Mon, 26 Oct 2026 22:10:26 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b445984d85sm4571938a12.29.2026.10.26.22.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:10:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 25/46] mm/userfaultfd: wake waiters when registration
 modes are removed
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 22:10:24 -0700
Message-Id: <179307782442.2301705.17273288326330283268.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_221029_102790_A961AA5A 
X-CRM114-Status: GOOD (  23.91  )
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
> faults that are already queued. For example, switching an anonymous
> range from MISSING to WP leaves a missing-fault waiter asleep until
> userspace explicitly wakes it.
> 
> When a registration change removes a UFFD mode, wake waiters in the
> affected interval after updating the VMA. The VMA is write-locked at
> this point, so no new faults can queue under the old modes and woken
> threads cannot retry until mmap_write_unlock(). Waiters for retained
> modes in the same interval may also wake and refault.
> 
> The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
> with both read and unread fault events.
> 
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Two additional automated reviews independently confirmed a similar
pre-existing issue and generated the same patch (below).

Sashiko filed this as a pre-existing:
https://sashiko.dev/#/map/217050

But this seems directly related to your patch here, so it might be worth
squashing this in:

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 2122676c4220f..710e913c73bfa 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -2287,6 +2290,8 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> 		prev = vma;
> 
> 	for_each_vma_range(vmi, vma, end) {
> +		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
> +
> 		cond_resched();
> 
> 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));

Could the pre-existing no-op check also require an exact mode match?
It currently does this later in userfaultfd_register_range():

        if (vma->vm_userfaultfd_ctx.ctx == ctx &&
            vma_test_all_mask(vma, vma_flags))
                goto skip;

Registering MISSING|WP, then requesting WP alone, takes this branch.
It leaves missing tracking enabled and bypasses the new wake. A writer
started after the replacement ioctl returns still queues a missing fault.
A writer already waiting before replacement also stays asleep.

Both cases time out on the base and on the full series. Replacing the
predicate with

        (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags

makes both pass with this series. On the base that change fixes only the
fresh-fault case; the already-pending case still needs this patch's wake.
Would a separate fix for the mode comparison make sense alongside this
patch? This is not introduced by the series.

-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] mm/userfaultfd: compare exact registration modes before skipping

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 669f71d485d02..0a28130cebc99 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2299,7 +2299,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    vma_test_all_mask(vma, vma_flags))
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		/*

-- 
Gregory Price <gourry@gourry.net>

