Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8410606A32D
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HKXWrRMo;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=I5xf3YsI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=q7hpYPW2PDPHqr5gZrpVZZFF5P/GoD1vd7ans2dWrLc=; b=HKXWrRMoenNhXu
	K/zUQowKRjMvMHb3t4MvH9aRlcJve1jlyRMPg9/cJjfPzZZde46CTabOZW9Ab/Zn5ltm7B90NOTJo
	PbAsoR0Uivso9c7ezGzPN7ZpXVpMVDsp/gAgJdsqGVJfVS6TJ5RzyvAiPWoIIDZpYNHqL7GXw9qOI
	CL0kLirL3xLU9FXis1ZtEkrrxEEYwroQRdoYHnFY7ZN1ICbbXurbrKtd/idK50IUtM6A1ZkKc3m0f
	t3+Q3xImbvjWHcOqxFXCNcjyO4o8GBbOI0+V8saIrfa0rytW05jCstfYa66xUyAKbQfB6I6ql1qNb
	GLdf3dsBgPK1wLiuu0hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMA6m-00000007uzx-3L4r;
	Wed, 28 Oct 2026 20:18:52 +0000
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMA6j-00000007uzW-3vGM
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 20:18:51 +0000
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so479810137.2
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793218727; x=1793823527; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q7hpYPW2PDPHqr5gZrpVZZFF5P/GoD1vd7ans2dWrLc=;
        b=I5xf3YsIeCasB9ivtqweDf/S+u2TQ+wRxHtgluTe7jYmWleedJMfkqwxc2krUuVd0c
         Qa9fhfWBuZtN7+qB5JDj4r6zrEnEVHtx2EC1/T0rxIZAeGgJbbBvkuyiIRflH0Kc1obY
         ss3LHeaS2Rf8NnEQDb/BMuGe4V2gtes6qzZkbcPOxC4Sxz1tCgd+ANbObDLjU6FavVyn
         +dHt3El832EMEVzBG8mCVaj9Ni1r3RTh89y6RWriovbZgdgKj0CPxlWhaQugVv1f7isE
         OF9+xs6CO7e2mxupD1oPLlLfBMOmGslrRZhOKRsYldp+Ip+qKeo+19XNzTHTtL7VESfc
         kn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218727; x=1793823527;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7hpYPW2PDPHqr5gZrpVZZFF5P/GoD1vd7ans2dWrLc=;
        b=MXwAU4N5j4nUtGBzZ9TMFObeQF/oOF7YYmyk7VoDzFNRL9eQhQ57G1RV7mLem/rebq
         I5FDEMhDoYZgrpYzyHCNLw+NlG7VWxYvsi30KKGtP+Hpvrx9mLqt6qKrbLZr980DvyeA
         xnU0OxrrxpTZtX9dAdSjGpkiACJDsAW1jFbbJnrYtgclGpkWo+reYwWUk8oDYH/ysBsH
         P0caFthSI/R4ppLNQz8Gy0xFkWfaTMjtx3bH2+Q6omqAdK5szCwKAXU87p6VhFUXAC4x
         QpR3wNNHSAwvlwBoRVsPkd1irmLVSryg/9+j5eomqAOeo6A8mIcI6KjVdrzd9BwWtsm+
         K6VA==
X-Forwarded-Encrypted: i=1; AKwUvBxHihNwjYVwVUa4H2XZRsuvr6bfjgsmD80fAMFsKeCeny9UcenMnWNNmIg68kBr421CWB1alA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLY1prr84b66nrrg8OKwmuBYxu2Mhyt+TqkrpLtDFxAJjt/Aple
	hvs6UL8ZfN+ZYqrn+xd2ng4EcrN9FyiZasC+C3aJc175s1X8yO3mO/WO16zrtyROIFM=
X-Gm-Gg: AYBFou01PHKWx+lfIwH6pHQxoG+E5hLOh9b+muA4TtA7OKBoqLwbCAoRAEP8ntf0/Xf
	8bW2wmGaGfUD4USz9gzsHa9uM5mRFDAvNXLVpkS8zSpzyLcB+MKRGkoSO4C5Gv9vhggOenIzdjC
	+Xyh9yWZ08Y4dDF2d2umcAc97e+ebbMVCDq7XO8g49xPHRNAcBsBMpLmYqGoDzvWspa8Fr2y/eg
	qIuVAXFZV5m+kz5cVeVlzaY3D6dmgBa+lmUK+F22nck74BQRQ1itX/xZpxZjnWBsv4BuijsSi31
	cSUvHsr5wl2GcU9186L5NYEOMpLVHfWwaN/j93/SRUh7AP+Qn1tmdzVJwt8rmxBbLV12mMagbuB
	OIvXE41V6RC915o6V/hxv5BCUQVzNomJx1nMVS7s5yiYKZYvIQmBM89U0LePfsPHjbW1E+7SbF0
	pWfh63YDr2IpjQA8pcJtLAdNtzt7AK9dYy352p8I/T8KgSEiVzHaIOjHNQDXvlLFAzJmAlyIp/3
	kaTGmW4+ViKaIqQgD1+arz1XIFBwsHj5o6YwRFk2e5bceo0h1xoH9MS62VnrowjNCeeCnUx96K6
	j4IRts2fbvPQ5WML4fQMNZj16gY4Nkuz96R8f+fbQ0B4YSZj0G89PFB4pec/e75EKcc6KlknGKW
	O9A8TdfkOzJcjE6qI/JAxDDeP1wCTrOP+uu0Kx2cu5o7k
X-Received: by 2002:a05:6102:6883:b0:7cc:b246:31e2 with SMTP id ada2fe7eead31-7d03a58a4c5mr1448909137.22.1793218727248;
        Wed, 28 Oct 2026 13:18:47 -0700 (PDT)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259c3067sm7101668241.5.2026.10.28.13.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:18:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] mm/memfd_luo: don't use memfd_pin_folios()
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Kairui Song <kasong@tencent.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
In-Reply-To: <20261027173031.763213-2-pratyush@kernel.org>
References: <20261027173031.763213-1-pratyush@kernel.org>
 <20261027173031.763213-2-pratyush@kernel.org>
Date: Wed, 28 Oct 2026 16:18:41 -0400
Message-Id: <179321872100.1775665.6881420026761127422.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13277;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=wicyGmtM0HCZ8QFWa3JfkdOVd2T5bFr0dbXF/CQ4anY=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq4lilEi9frGRO5LeLMn3xnLvx74vo2VYRlAhWv
 2lO0XB3J86JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauJYpQAKCRC7dyhM23N6
 3o9WD/9QVhSIT40DNaS/9SP9NBaqI9qHd6RMGrBfO9LFzkKpTW+78VqzSPmBNIRHiDGD/94bAOM
 aA/cbfh/RmoupiUT9dxefAJ8LrYoyrnrPoe80DmghPXwGIWrrkRxSRiqnbEWsqrH4oS8vh46+ky
 L7eXHcYSUAmENhNPR0u6NiET1Zv97OY7+WS5JJn2JqwSM6T4quOhD+xyUSdX/kY9Q4T8iXe0i2z
 KQWPVoeOEMyk0E8awX8UGrDIGf/3cDQHR4aGY4DoJ8iciGK1v+fzLgwwxwRqx5/MX0486Z9TqbD
 2imlHFeXQetEi/r6CNvGVY9cwsNHgtrTIZjgZNQicnbb7sWdrShCNLRwv2J0Q8QP/3dE6guq+5s
 TirE/FuHrvbnqRfS5MP1wdHEoAodg5lk0idEFyC2SOjAZ5c5Pucm98o2Ojbx7XaTHYbU8rzkJ5B
 0rFyz0rEVEArgpA1D0BwzVLofF+CY36TqFh/WS+pwKGGN4ggIyfmVzcA9ohaOm+o9d3hq+lcW/w
 qyeyOLnoCeRt3fP3wxOW5w9F9kp+xomgFv9YNBhv01PBRIa4GCavZFqqPSawS7kj3awsH6ytdPR
 Nj8/lj3REaXGZRjfi3hi0afq7twpAI+EO5MPzGib715NyBoXBi3EDIRW1yyLj963885CxbCpT2P
 QLqAEQ+QU+uCXqQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_131850_092050_F40D7D72 
X-CRM114-Status: GOOD (  55.21  )
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> memfd_luo takes a snapshot of the folios in the file's mapping. To make
> sure the snapshot does not go out of sync, it pins the folios in the
> file via memfd_pin_folios(). The pinning also migrates the folios out of
> MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
> region.
> 
> memfd_pin_folios() does not lock the folios. So it can race with
> shmem_writeout(). A folio returned by memfd_pin_folios() might already
> be in swap cache. This happens to work but is fragile. memfd_luo looks
> at folio flags and index on a folio that isn't in the memfd's page
> cache.
> 
> In addition, memfd_pin_folios() needs the caller to allocate an array of
> folios. memfd_luo does not really need that since it will vmalloc
> folios_ser and store the information there anyway. The folios array is
> unnecessary overhead.
> 
> Finally, memfd_pin_folios() fills in holes in the memfd. This makes
> preserving sparse memfds very expensive in both compute and memory.
> While this patch doesn't yet stop filling in the holes, it sets up the
> infrastructure to make it simpler.

+1, this is problematic and should be resolved. In some setups, VMMs 
leave holes for PCI/IO space; with the current approach, single memfd 
preservation does not work for such use cases.

> Fix all this by walking the page cache directly using shmem_get_folio()
> with SGP_CACHE. This returns a locked folio with an elevated refcount.
> memfd_luo holds that reference until the memfd is unpreserved. This
> blocks compaction, migration, etc.
> 
> There is still a need to migrate folios out of MIGRATE_MOVABLE page
> blocks. This is because those might be CMA or KHO scratch. memfd_luo
> will hold a longterm reference to the folios so it will block migration
> in that pageblock. Introduce memfd_luo_migrate_folio() to do this.
> 
> Also factor out folio unpreservation logic into memfd_luo_put_folios()
> and use it from memfd_luo_unpreserve_folios() and from error paths in
> memfd_luo_preserve_folios().
> 
> Since shmem_get_folio() always returns uptodate folios, drop the folio
> zeroing logic.
> 
> This change also improves preservation performance, shown in the table
> below.
> 
> |------------------+----------+------------+-------|
> | memfd            | baseline | this patch | delta |
> |------------------+----------+------------+-------|
> | 4K pages, 32 GiB | 748 ms   | 600 ms     |  -20% |
> | THP, 4 GiB       | 0.59 ms  | 0.59 ms    |    0% |
> | THP, 16 GiB      | 2.99 ms  | 2.61 ms    |  -13% |
> | THP, 32 GiB      | 4.83 ms  | 5.21 ms    |   +8% |
> | sparse, 32 GiB   | 8695 ms  | 7269 ms    |  -16% |
> |------------------+----------+------------+-------|

For THP 16 GiB / 32 GiB, the -13% / +8% swings look like high run-to-run 
variance. However, maybe not: is it because vmalloc_array() is 
overallocating memory for folios_ser?

Also, could you clarify what "sparse, 32 GiB" means in this benchmark? 
Was the memfd completely unfaulted before preserve (so preserve faults 
in all 4K pages), or partially populated?

> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Link: https://patch.msgid.link/20261027173031.763213-2-pratyush@kernel.org
>
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 59de210bee5f..fe182d505789 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -77,26 +77,126 @@
>  #include <linux/kexec_handover.h>
>  #include <linux/kho/abi/memfd.h>
>  #include <linux/liveupdate.h>
> +#include <linux/migrate.h>
> +#include <linux/sched/mm.h>
> +#include <linux/sched/signal.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/swap.h>
>  #include <linux/vmalloc.h>
>  #include <linux/memfd.h>
>  #include <uapi/linux/memfd.h>
>  
>  #include "internal.h"
>  
> +static void memfd_luo_put_folios(const struct memfd_luo_folio_ser *folios_ser,
> +				 u64 nr_folios)
> +{
> +	u64 i;
> +
> +	for (i = 0; i < nr_folios; i++) {
> +		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
> +		struct folio *folio;
> +
> +		if (!pfolio->pfn)
> +			continue;
> +
> +		folio = pfn_folio(pfolio->pfn);
> +
> +		kho_unpreserve_folio(folio);
> +		folio_put(folio);
> +	}
> +}
> +
> +/* How many times to retry isolating a folio someone else has isolated. */
> +#define MEMFD_LUO_MIGRATE_RETRIES	3
> +
> +/*
> + * Move a folio out of ZONE_MOVABLE or CMA, so it can be held until the next
> + * kernel. Called with a reference on the unlocked folio, which is always
> + * dropped. The caller must look up the folio again afterwards.
> + *
> + * Returns 0 on success, -EBUSY if the folio could not be isolated (e.g.
> + * because someone else has it isolated right now), or -ENOMEM if migration
> + * failed.
> + */
> +static int memfd_luo_migrate_folio(struct folio *folio)
> +{
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		/* Not movable, so the target is neither in ZONE_MOVABLE nor CMA. */
> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
> +		.reason = MR_LONGTERM_PIN,
> +	};
> +	LIST_HEAD(source);
> +	bool isolated;
> +
> +	/* Flush per-CPU LRU batches holding the folio so isolation works. */
> +	lru_cache_drain_for_folio(folio, 1, NULL);
> +	isolated = isolate_folio_to_list(folio, &source);
> +	/* Isolation holds its own reference. */
> +	folio_put(folio);
> +	if (!isolated)
> +		return -EBUSY;
> +
> +	if (migrate_pages(&source, alloc_migration_target, NULL,
> +			  (unsigned long)&mtc, MIGRATE_SYNC, MR_LONGTERM_PIN,
> +			  NULL)) {
> +		putback_movable_pages(&source);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int memfd_luo_preserve_folio(struct folio *folio,
> +				    struct memfd_luo_folio_ser *pfolio)
> +{
> +	int err;
> +
> +	err = kho_preserve_folio(folio);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * A dirty folio is one which has been written to. A clean folio
> +	 * is its opposite. Since a clean folio does not carry user
> +	 * data, it can be freed by page reclaim under memory pressure.
> +	 *
> +	 * Saving the dirty flag at prepare() time doesn't work since it
> +	 * can change later. Saving it at freeze() also won't work
> +	 * because the dirty bit is normally synced at unmap and there
> +	 * might still be a mapping of the file at freeze().
> +	 *
> +	 * To see why this is a problem, say a folio is clean at
> +	 * preserve, but gets dirtied later. The pfolio flags will mark
> +	 * it as clean. After retrieve, the next kernel might try to
> +	 * reclaim this folio under memory pressure, losing user data.
> +	 *
> +	 * Unconditionally mark it dirty to avoid this problem. This
> +	 * comes at the cost of making clean folios un-reclaimable after
> +	 * live update.
> +	 */
> +	folio_mark_dirty(folio);
> +
> +	pfolio->pfn = folio_pfn(folio);
> +	pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
> +	pfolio->index = folio->index;
> +
> +	return 0;
> +}
> +
>  static int memfd_luo_preserve_folios(struct file *file,
>  				     struct kho_vmalloc *kho_vmalloc,
>  				     struct memfd_luo_folio_ser **out_folios_ser,
>  				     u64 *nr_foliosp)
>  {
> +	struct memfd_luo_folio_ser *folios_ser, *shrunk;
>  	struct inode *inode = file_inode(file);
> -	struct memfd_luo_folio_ser *folios_ser;
> -	unsigned int max_folios;
> -	long i, size, nr_pinned;
> -	struct folio **folios;
> -	int err = -EINVAL;
> -	pgoff_t offset;
> -	u64 nr_folios;
> +	u64 nr_folios = 0, max_folios;
> +	int err, busy_retries = 0;
> +	unsigned int pin_flags;
> +	pgoff_t index = 0, end;
> +	loff_t size;
>  
>  	size = i_size_read(inode);
>  	/*
> @@ -113,99 +213,77 @@ static int memfd_luo_preserve_folios(struct file *file,
>  	 * Guess the number of folios based on inode size. Real number might end
>  	 * up being smaller if there are higher order folios.
>  	 */
> -	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
> -	folios = kvmalloc_objs(*folios, max_folios);
> -	if (!folios)
> +	end = DIV_ROUND_UP_ULL(size, PAGE_SIZE);
> +	max_folios = end;
> +	folios_ser = vmalloc_array(max_folios, sizeof(*folios_ser));
> +	if (!folios_ser)
>  		return -ENOMEM;

I bet in practice memfds almost always contain folios of the same size, 
so why not estimate the folios_ser size based on the first folio's 
order, and only if that ends up being too small, vrealloc() to match the 
maximum possible remaining size?

It would be a different change though.

>  
>  	/*
> -	 * Pin the folios so they don't move around behind our back. This also
> -	 * ensures none of the folios are in CMA -- which ensures they don't
> -	 * fall in KHO scratch memory. It also moves swapped out folios back to
> -	 * memory.
> +	 * The folios are held until the next kernel, so keep newly allocated
> +	 * ones out of ZONE_MOVABLE and CMA -- which also ensures they don't
> +	 * fall in KHO bootmem. Existing ones are migrated below.
>  	 *
> -	 * A side effect of doing this is that it allocates a folio for all
> -	 * indices in the file. This might waste memory on sparse memfds. If
> -	 * that is really a problem in the future, we can have a
> -	 * memfd_pin_folios() variant that does not allocate a page on empty
> -	 * slots.
> +	 * A side effect of this is that it allocates a folio for all indices in
> +	 * the file. This might waste memory on sparse memfds. If that is really
> +	 * a problem in the future, this loop can be taught to skip empty slots.

Yeah, as I said earlier, it really should skip empty slots, again a 
different change, not related to this patch, but since you are making 
this change, I am commenting on it.

>  	 */
> -	nr_pinned = memfd_pin_folios(file, 0, size - 1, folios, max_folios,
> -				     &offset);
> -	if (nr_pinned < 0) {
> -		err = nr_pinned;
> -		pr_err("failed to pin folios: %d\n", err);
> -		goto err_free_folios;
> -	}
> -	nr_folios = nr_pinned;
> +	pin_flags = memalloc_pin_save();
> +	while (index < end) {
> +		struct folio *folio;
>  
> -	folios_ser = vcalloc(nr_folios, sizeof(*folios_ser));
> -	if (!folios_ser) {
> -		err = -ENOMEM;
> -		goto err_unpin;
> -	}
> +		cond_resched();
>  
> -	for (i = 0; i < nr_folios; i++) {
> -		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
> -		struct folio *folio = folios[i];
> +		if (fatal_signal_pending(current)) {
> +			err = -EINTR;
> +			goto err_restore;
> +		}
>  
> -		err = kho_preserve_folio(folio);
> +		if (WARN_ON_ONCE(nr_folios >= max_folios)) {
> +			err = -EINVAL;
> +			goto err_restore;
> +		}
> +
> +		err = shmem_get_folio(inode, index, 0, &folio, SGP_CACHE);
>  		if (err)
> -			goto err_unpreserve;
> -
> -		folio_lock(folio);
> -
> -		/*
> -		 * A dirty folio is one which has been written to. A clean folio
> -		 * is its opposite. Since a clean folio does not carry user
> -		 * data, it can be freed by page reclaim under memory pressure.
> -		 *
> -		 * Saving the dirty flag at prepare() time doesn't work since it
> -		 * can change later. Saving it at freeze() also won't work
> -		 * because the dirty bit is normally synced at unmap and there
> -		 * might still be a mapping of the file at freeze().
> -		 *
> -		 * To see why this is a problem, say a folio is clean at
> -		 * preserve, but gets dirtied later. The pfolio flags will mark
> -		 * it as clean. After retrieve, the next kernel might try to
> -		 * reclaim this folio under memory pressure, losing user data.
> -		 *
> -		 * Unconditionally mark it dirty to avoid this problem. This
> -		 * comes at the cost of making clean folios un-reclaimable after
> -		 * live update.
> -		 */
> -		folio_mark_dirty(folio);
> -
> -		/*
> -		 * If the folio is not uptodate, it was fallocated but never
> -		 * used. Saving this flag at prepare() doesn't work since it
> -		 * might change later when someone uses the folio.
> -		 *
> -		 * Since we have taken the performance penalty of allocating,
> -		 * zeroing, and pinning all the folios in the holes, take a bit
> -		 * more and zero all non-uptodate folios too.
> -		 *
> -		 * NOTE: For someone looking to improve preserve performance,
> -		 * this is a good place to look.
> -		 */
> -		if (!folio_test_uptodate(folio)) {
> -			folio_zero_range(folio, 0, folio_size(folio));
> -			flush_dcache_folio(folio);
> -			folio_mark_uptodate(folio);
> +			goto err_restore;
> +
> +		if (unlikely(!folio_is_longterm_pinnable(folio))) {
> +			folio_unlock(folio);
> +			err = memfd_luo_migrate_folio(folio);
> +			/* Someone else might have it isolated, retry a bit. */
> +			if (err == -EBUSY && ++busy_retries < MEMFD_LUO_MIGRATE_RETRIES)
> +				continue;
> +			if (err)
> +				goto err_restore;
> +			continue;
>  		}

Nit:

I would suggest adding another helper, memfd_luo_get_folio(inode, index, 
&folio), that wraps:

- shmem_get_folio()
- The !folio_is_longterm_pinnable() migration retry loop logic

I think this would make the final code a bit more manageable.

Other than that the patch looks alright, feel free to add
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Once the nit is addressed.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

