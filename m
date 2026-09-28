Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC93606A31C
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KyZec/e0;
	dkim=permerror header.d=jaseg.de header.i=@jaseg.de header.a=rsa-sha1 header.s=fm1 header.b=KaZlWMLm;
	dkim=permerror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha1 header.s=fm1 header.b=dcbF+wyv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53EGbVlBCmuFO/yPGaufkagD24x0y+PKNHNL/qinRMo=; b=KyZec/e0nejsCd0MBZDqtB0KJv
	9a5jsBAJG0UNJ18Q6mVkc+NXpDhehYx2zrLxMKPTVqkDRRU7CRFVKRFu7MA/4bF4DMGbdD50+xQpw
	YbvcOlqooeymRwM1fZd3yeydWUOOoWu7x3+VHqwidQda3lewcs86OUx6dBAlD0g58ILl7n2e+Fzbb
	kxa//ZPYNSOnbzhJpfYt8Y+86won2v4QHf+zbrAU6Ov60Y0UU+Dyfk5Apjd96Xq/AsbEGONIeJLwH
	1whZ+6Rcp+EGHPX6SxTtqM7TmnWhpvIBd9J2fPVeDdSSxWE+m9qKiWua6ZwPe59/eVpmdHWF0jpkW
	22TuAopw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55z-0000000994g-3NHS;
	Tue, 20 Oct 2026 08:21:19 +0000
Received: from flow-a2-smtp.messagingengine.com ([103.168.172.137])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF2g-00000001966-30o8;
	Mon, 28 Sep 2026 17:21:34 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id B330D1380021;
	Mon, 28 Sep 2026 13:21:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 13:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790616089;
	 x=1790623289; bh=53EGbVlBCmuFO/yPGaufkagD24x0y+PKNHNL/qinRMo=; b=
	KaZlWMLmtvRq2GeQrDQaqKaxYnEHoQjh5LSeMxcYhf3GCNNRPEu9cY0Ir2XBK7RJ
	JVbvETgTonrJ8uG1FJh0sfjReLo5OBOKkFNLs2YLZQ4c1QQeIMWSdm+0EmM6ySuo
	O5p3yRupqREp8EXfTd2Kp5kYmgS1GyiQDoylj+WVxJj7vNnB+vo3r3DQ5YRLBCty
	DbEMMnEUpVJyBOUa1ZkhZhTb2PyPnldDX3TMn1w/cp+FReq5aNImdY/n6ulGu3Dk
	uXPh4+ndTpVVPzsJWzdjZI6onVhqrS06M6VIQlkJ90okQJAGhOqmuvCjcQwv+hft
	4JWAeabHnuDXuHEidheMzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790616089; x=
	1790623289; bh=53EGbVlBCmuFO/yPGaufkagD24x0y+PKNHNL/qinRMo=; b=d
	cbF+wyvCLIU7MFxc0k/maGQv0JOz7etFVBshyNhAvaShG64yyzlp15DozydFDWvJ
	oWB0J/puyiRbPj8OZjia5/gmDRAjBfedW8qqXNyN+LBbHKJwMgfa3r4njouEfric
	NGeYM80TRvklD08K7HDQ3FG7HhfBNys0763UOylIljc5wnvaQ3x3DAs74RPZVxX3
	IqFb4Wbfzj/ce5rqonBT+w12nVufrZqrrTch6fwqiIGOfB25BPDQhzgllfLcHAbE
	GDsLYTZ+ACRgs4Vk5M4uv78aaEct0YGGvewt4/EU/l2AZNZjwr3i4ciUvEEI1Pve
	kgKyp+WFp3vAsMGRQAEyg==
X-ME-Sender: <xms:GaK6agME_RUqisuTZaZ8sblvuXWJKUD2UcrSysV3P_vOv8SP4L5R7Q>
    <xme:GaK6atFD7JhlkoBcU_eCVfpSYrZsTvmWmiMNZI_haZmQ75ER7JfSWTksd5BnQzszT
    eMb-nR5kYeYODRnDOU_60tQ5hpLmazJlalZrMJMpbxT9uWkbv4ciZA>
X-ME-Received: <xmr:GaK6akBVgAmZH-kz65nORHPTKkwNmr5ULsLU48UIFOxLeoeoTn8D0mQz1XMGL7QU>
X-ME-Proxy-Cause: dmFkZTFVchM+bTT1PKuZ7CN10fxXJIikNoVdUVFHA1eqyKMgAAVr8P6ONf1Qg916JwGLA/
    UIAM5uyklkVrDRDmXBCinnisDlXug/Uvz0CnXEuy4xZlY+Q3iKI5V68dUZbqn8FCfsIN95
    6KfV8L2bBYYMAysjIpjjTtDvr59SlVXR0rT3rsZ8OOWBdCzi2fs/qRsgGZhcNemn8sEAcR
    7gOuIxy/+2FBe7o4KglohLGCDym2m4zsXZ2bZO1r7mHjauIXUwmWu2ruzm3DMO6W6IP24K
    Wr2E/Zfjs4QhZp1KylseoV5Uqh0JkwjuRMQihg5e/hXKn9gV8Cjo7+1dG47k97NaaXBvC7
    wjkPY0MykASYaurO98ZHxrl0KcaeBJvFcHGkCls8dJmp8N9EgVIVZBPmju1Jaa0vGc/g26
    ElcZ1+93OK72UscCr1gvESBIDBc/k5GRgmMs4aRi/NhqRPA8qigxm7a8c5v3VBEdkBWELG
    Hl6Rl3Lo1/OLIPFbcTXUFqhvrftb5lPDDoAdzIZMIihMRVJ0BtE9OAIHN0k5JRPQYUtB50
    uEN906KhBV3w26s4nR9FTs32IRL8sBtDCGDtj9NdKWa5JOndRzoGCYTcFpYRBBavwhOH46
    wGLX+aVoqY6v4MsvVkdjVwPbLIC3TqWJI7dmZiEeUCpOJ3rjOknfBh2dkXoQ
X-ME-Proxy: <xmx:GaK6aulxxt4X4suH6T5nGB8VEVZ8YMgNoWHDGwVXSUcJ9TaynJqzww>
    <xmx:GaK6asuLAHs1Qq0aqQZTzF_SawsJGPZ16q1y5_5W7BEMkyBB17X5hQ>
    <xmx:GaK6amV5Hm_CHmZCMDi3seeCJTpRkbIp5yN-e3h9dmvlFppKG0TVlw>
    <xmx:GaK6amiXj9XCynaX0y4fkOxEbZKWYJzObo4FgQFDu0HZ-nOYgPrLgQ>
    <xmx:GaK6ats1-IsvrHI78yAph7SKA-W3bmPkQ5IoFPgfEo_-gkU3Kei-02qk>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 13:21:08 -0400 (EDT)
From: =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Date: Mon, 28 Sep 2026 19:17:58 +0200
Subject: [PATCH v3 10/12] mm/madvise: Add MADV_CRASH_SECRET,
 MADV_CRASH_CACHE and MADV_CRASH_RESET
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-crash-memaction-upstream-20260921-v3-10-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
To: Jonathan Corbet <corbet@lwn.net>,
  Shuah Khan <skhan@linuxfoundation.org>,
  Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>,
  Saravana Kannan <saravanak@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
  David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
  Brendan Jackman <brendan.jackman@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
  Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,
 Alasdair Kergon <agk@redhat.com>,  Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
  Benjamin Marzinski <bmarzins@redhat.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>,
 Mimi Zohar <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,  Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,  Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,  Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>,  Lance Yang <lance.yang@linux.dev>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
  Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
  Matthew Brost <matthew.brost@intel.com>,
  Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,
  Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
  Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kexec@lists.infradead.org, driver-core@lists.linux.dev, linux-mm@kvack.org, 
 linux-arm-kernel@lists.infradead.org, dm-devel@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_102131_619027_C5FAE825 
X-CRM114-Status: GOOD (  25.23  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:07 -0700
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These flags allow userspace to indicate memory pages to a kdump kernel
that contain sensitive secrets or unimportant cache data. This allows
the kdump kernel to e.g. wipe secrets before dumping, or to skip caches
while dumping.

The feature is similar to MADV_DONTDUMP but for the kdump kernel. In
contrast to MADV_DONTDUMP, it specifies the contents of the page, not
what should be done with it. This is to account for some flexibility
between the host userspace registering the marks, and the kdump
userspace processing them.

The flags set here are matched against a mask given through the
crash_memaction= cmdline param. Only when the param is present and the
mask matches, a VMA flag ("cm") is set. The kdump kernel later receives
a single bitmap describing all marked ranges matching the mask.

When madvise'd, marked ranges are registered in the bitmap right away.
These registrations are then kept up to date by code in rmap.
Marks are transparent to swap etc.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
Assisted-by: Claude Opus 5 <noreply@anthropic.com>
---
 include/uapi/asm-generic/mman-common.h |   4 +
 mm/madvise.c                           | 132 +++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index ef1c27fa3c57..b00caec7c130 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,10 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_CRASH_SECRET 26		/* holds secrets, tell the kdump kernel */
+#define MADV_CRASH_CACHE 27		/* holds nothing worth dumping */
+#define MADV_CRASH_RESET 28		/* undo MADV_CRASH_SECRET and MADV_CRASH_CACHE */
+
 #define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
 #define MADV_GUARD_REMOVE 103		/* unguard range */
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 00b1be655a8b..37f08334e95a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -13,6 +13,8 @@
 #include <linux/page-isolation.h>
 #include <linux/page_idle.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/crash_memaction.h>
+#include <linux/rmap.h>
 #include <linux/hugetlb.h>
 #include <linux/falloc.h>
 #include <linux/fadvise.h>
@@ -1173,6 +1175,98 @@ static long madvise_populate(struct madvise_behavior *madv_behavior)
 	return 0;
 }
 
+#ifdef CONFIG_CRASH_MEMACTION
+static void madvise_crash_mark_pfns(struct mm_walk *walk, unsigned long pfn,
+		unsigned long nr_pages)
+{
+	bool mark = *(bool *)walk->private;
+
+	/* Acting on the zero page would reach every other mapping of it. */
+	if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn) || !pfn_valid(pfn))
+		return;
+
+	if (mark)
+		crash_mark_pages(pfn_to_page(pfn), nr_pages, walk->vma);
+	else
+		crash_memaction_unmark_pfns(pfn, nr_pages);
+}
+
+static int crash_mark_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long end, struct mm_walk *walk)
+{
+	pte_t *start_pte, *pte;
+	spinlock_t *ptl;
+
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
+	ptl = pmd_trans_huge_lock(pmd, walk->vma);
+	if (ptl) {
+		pmd_t pmdval = *pmd;
+
+		if (pmd_present(pmdval))
+			madvise_crash_mark_pfns(walk,
+				pmd_pfn(pmdval) + ((addr & ~PMD_MASK) >> PAGE_SHIFT),
+				(end - addr) >> PAGE_SHIFT);
+		spin_unlock(ptl);
+		return 0;
+	}
+
+	start_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!start_pte)
+		return 0;
+
+	for (; addr < end; pte++, addr += PAGE_SIZE) {
+		pte_t ptent = ptep_get(pte);
+
+		if (pte_present(ptent))
+			madvise_crash_mark_pfns(walk, pte_pfn(ptent), 1);
+	}
+
+	pte_unmap_unlock(start_pte, ptl);
+	cond_resched();
+	return 0;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static int crash_mark_hugetlb_entry(pte_t *pte, unsigned long hmask,
+		unsigned long addr, unsigned long end, struct mm_walk *walk)
+{
+	struct hstate *h = hstate_vma(walk->vma);
+	spinlock_t *ptl;
+	pte_t entry;
+
+	ptl = huge_pte_lock(h, walk->mm, pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
+	if (pte_present(entry))
+		madvise_crash_mark_pfns(walk,
+			pte_pfn(entry) + ((addr & ~hmask) >> PAGE_SHIFT),
+			(end - addr) >> PAGE_SHIFT);
+	spin_unlock(ptl);
+
+	return 0;
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
+static const struct mm_walk_ops crash_mark_walk_ops = {
+	.pmd_entry	= crash_mark_pmd_entry,
+#ifdef CONFIG_HUGETLB_PAGE
+	.hugetlb_entry	= crash_mark_hugetlb_entry,
+#endif
+	.walk_lock	= PGWALK_WRLOCK,
+};
+
+static int madvise_crash_mark_existing(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, bool mark)
+{
+	if (!static_branch_unlikely(&crash_memaction_active))
+		return 0;
+
+	return walk_page_range_vma(vma, start, end, &crash_mark_walk_ops,
+				   &mark);
+}
+#endif /* CONFIG_CRASH_MEMACTION */
+
 /*
  * Application wants to free up the pages and associated backing store.
  * This is effectively punching a hole into the middle of a file.
@@ -1585,6 +1679,26 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	case MADV_DONTDUMP:
 		new_flags |= VM_DONTDUMP;
 		break;
+#ifdef CONFIG_CRASH_MEMACTION
+	case MADV_CRASH_SECRET:
+		if (!vma_is_anonymous(vma) && !vma_is_shmem(vma) &&
+		    !vma_is_hugetlb(vma))
+			return -EINVAL;
+		if (crash_memaction_types() & CRASH_MEMACTION_SECRET)
+			new_flags |= VM_CRASH_MARK;
+		break;
+	case MADV_CRASH_CACHE:
+		if (!vma_is_anonymous(vma) && !vma_is_shmem(vma) &&
+		    !vma_is_hugetlb(vma))
+			return -EINVAL;
+		if (crash_memaction_types() & CRASH_MEMACTION_CACHE)
+			new_flags |= VM_CRASH_MARK;
+		break;
+	case MADV_CRASH_RESET:
+		/* Unmarking stays allowed whatever the VMA has become since. */
+		new_flags &= ~VM_CRASH_MARK;
+		break;
+#endif
 	case MADV_DODUMP:
 		/* Non-persistent memory cannot be dumped. */
 		if (!vma_is_persistent(vma))
@@ -1614,6 +1728,19 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	/* This is a write operation.*/
 	VM_WARN_ON_ONCE(madv_behavior->lock_mode != MADVISE_MMAP_WRITE_LOCK);
 
+#ifdef CONFIG_CRASH_MEMACTION
+	/* The rmap hooks only see the flag as folios arrive, so walk the rest. */
+	if ((new_flags ^ vma->vm_flags) & VM_CRASH_MARK) {
+		error = madvise_update_vma(new_flags, madv_behavior);
+		if (!error)
+			error = madvise_crash_mark_existing(
+					madv_behavior->vma, range->start,
+					range->end,
+					!!(new_flags & VM_CRASH_MARK));
+		goto out;
+	}
+#endif
+
 	error = madvise_update_vma(new_flags, madv_behavior);
 out:
 	/*
@@ -1732,6 +1859,11 @@ madvise_behavior_valid(int behavior)
 	case MADV_KEEPONFORK:
 	case MADV_GUARD_INSTALL:
 	case MADV_GUARD_REMOVE:
+#ifdef CONFIG_CRASH_MEMACTION
+	case MADV_CRASH_SECRET:
+	case MADV_CRASH_CACHE:
+	case MADV_CRASH_RESET:
+#endif
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:

-- 
2.55.0


