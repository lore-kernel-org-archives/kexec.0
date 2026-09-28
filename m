Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596B606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R6ko68r2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgJleyjF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1wgoeoJYPRfg3GcR5cNgIa+KIwSHuCasXM5odxS1hrI=; b=R6ko68r27M0NkadFnzRU8QCEKt
	P+R9dP53R7/oYAjt6E1XvjDqL5z174dXW/iqUy2JpckSD2K4i/jQr/1I71ZD1ahejYJ50VqiZPKiz
	EQnC/QI7AeV5s39Rn+MMalQ7hu9QkS9WNY3ZFZLL9luVrfGn2qvVWgQj9a7rtP/yYZnfZUrebTPuf
	jn4aVU6qaNS6xDelOyp4/2zSEWFSEA7egRM1ZuN3OfPSgv9SW76pdJwKWyCAtAyQrWcK1GM8p2unQ
	8mHRuWiRgZ7uH091DERA1ADmP4OFPaIybDBrE71Mc4UuA/C+OUnbJoAXlCv0oS1l5rDiNQUpgrQub
	91NhRpSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56O-000000099aq-2scf;
	Tue, 20 Oct 2026 08:21:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFGA-00000001BCt-0yNi;
	Mon, 28 Sep 2026 17:35:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E54D243EF7;
	Mon, 28 Sep 2026 17:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A71F00893;
	Mon, 28 Sep 2026 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616925;
	bh=1wgoeoJYPRfg3GcR5cNgIa+KIwSHuCasXM5odxS1hrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JgJleyjFQgWpfSJkA6nyiCqqkWAAQHtWpxUxiVpk/gtQMO+5K7zLj5gw60+XRVrxG
	 DOxpA1mOKjw+UpOYOeAT8dGi1rHv4aXAS/klnjPQQTsZ8M2A7aHg9r5h38IBTnycHr
	 Iq3i3uWPDRV0Ha6SOjYiot9MUb80bIaPo4t9fvVIUc5TN2bKqu+nC4zb5/1aJcNHSp
	 8yrxScOB5GeImFdiGk8r9MJ+cXNpADyVXtzcldQsWRluad0eoZommMs41pDQElhyDf
	 TXYaXwVdcTkN3AXpUXfrkwTpLtLbSwRpIfEdx6NbmMkCLCcvUN8Dc1I/37mSc4kT+z
	 YLFq0XLOxp1iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/12] mm/madvise: Add MADV_CRASH_SECRET,
 MADV_CRASH_CACHE and MADV_CRASH_RESET
To: "Serge E. Hallyn" <serge@hallyn.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Mark Rutland" <mark.rutland@arm.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Barry Song" <baohua@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "James Morris" <jmorris@namei.org>, "Jann
 Horn" <jannh@google.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Zi
 Yan" <ziy@nvidia.com>, "David Howells" <dhowells@redhat.com>, "Saravana
 Kannan" <saravanak@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Matthew
 Brost" <matthew.brost@intel.com>, =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Rob Herring" <robh@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Oscar Salvador" <osalvador@suse.de>, "Pedro
 Falcato" <pfalcato@suse.de>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@suse.com>, "Arnd Bergmann" <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "Alistair
 Popple" <apopple@nvidia.com>, "Alasdair Kergon" <agk@redhat.com>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Gregory Price" <gourry@gourry.net>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "Nico Pache" <nico.pache@linux.dev>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Peter
 Xu" <peterx@redhat.com>, "Mike Rapoport" <rppt@kernel.org>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Benjamin
 Marzinski" <bmarzins@redhat.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "David Hildenbrand" <david@kernel.org>, "Rik
 van Riel" <riel@surriel.com>, "Harry Yoo" <harry@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Baoquan
 He" <baoquan.he@linux.dev>, "Byungchul Park" <byungchul@sk.com>, "Suren
 Baghdasaryan" <surenb@google.com>, "Dave Young" <ruirui.yang@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Mike Snitzer" <snitzer@kernel.org>, "Usama
 Arif" <usama.arif@linux.dev>, "Liam R. Howlett" <liam@infradead.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-integrity@vger.kernel.org, conor+dt@kernel.org, keyrings@vger.kernel.org, devicetree@vger.kernel.org, "Eric
 Biggers" <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dm-devel@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-10-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-10-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:35:21 +0000
Message-Id: <20260928173522.064A71F00893@smtp.kernel.org>
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:10 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: MADV_CRASH_SECRET skips migration entries leaving secrets unpr=
otected
--

commit bd54b0316a2281079a7116bef1937bfde7198adf
Author: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

mm/madvise: Add MADV_CRASH_SECRET, MADV_CRASH_CACHE and MADV_CRASH_RESET

This commit introduces new madvise flags allowing userspace to mark pages
containing secrets or unimportant cache data. These marks are registered in=
 a
bitmap for the kdump kernel to process during a crash dump.

> diff --git a/mm/madvise.c b/mm/madvise.c
> index 00b1be655a8b5..37f08334e95a8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
[ ... ]
> @@ -1173,6 +1175,98 @@ static long madvise_populate(struct madvise_behavi=
or *madv_behavior)
[ ... ]
> +static int crash_mark_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long end, struct mm_walk *walk)
> +{
> +	pte_t *start_pte, *pte;
> +	spinlock_t *ptl;
> +
> +	if (fatal_signal_pending(current))
> +		return -EINTR;
> +
> +	ptl =3D pmd_trans_huge_lock(pmd, walk->vma);
> +	if (ptl) {
> +		pmd_t pmdval =3D *pmd;
> +
> +		if (pmd_present(pmdval))
> +			madvise_crash_mark_pfns(walk,
> +				pmd_pfn(pmdval) + ((addr & ~PMD_MASK) >> PAGE_SHIFT),
> +				(end - addr) >> PAGE_SHIFT);
> +		spin_unlock(ptl);
> +		return 0;
> +	}

[Severity: High]
Does this code leave secrets unprotected if a migration is occurring
concurrently?

If a PMD is temporarily unmapped during a migration (such as background
compaction or NUMA balancing), pmd_present evaluates to false. This
code skips the PMD without marking it and returns 0, leaving the entire
2MB range unprotected in the crash memaction bitmap. Once the migration
completes, the restored page remains permanently unmarked and will be
dumped.

> +
> +	start_pte =3D pte =3D pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!start_pte)
> +		return 0;
> +
> +	for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> +		pte_t ptent =3D ptep_get(pte);
> +
> +		if (pte_present(ptent))
> +			madvise_crash_mark_pfns(walk, pte_pfn(ptent), 1);
> +	}

[Severity: High]
Similarly, does this loop silently skip non-present PTEs like migration
and device-exclusive swap entries?

When userspace calls madvise with MADV_CRASH_SECRET, it expects the
memory range to be marked. Checking only pte_present skips resident
physical pages that are temporarily unmapped for migration. Since the
rmap hooks only see the flags as folios arrive, these skipped entries
never get added to the bitmap, potentially leaking sensitive data in a
crash dump.

> +
> +	pte_unmap_unlock(start_pte, ptl);
> +	cond_resched();
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D10

