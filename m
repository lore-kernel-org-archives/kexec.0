Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6E7C5AC7A
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K3SviOS6dfaElwqZsGFYvgNYmNLpXjvir7qqTUt7Jc4=; b=rqhlTIOHuGQFl5omsZ7zhE6sMS
	Dgy9xoUjQqH0R4iIZF15dymJRyoDb4GxHR9As/eNpidwNWhwUFrGggno/P6fFQKkUtAekbITkeYLC
	s8SFbhovRfoyrFTsV//mVCJvnRwcj3wRpqzov+JAksePjwd/GzAb8p8eHcpYzEs/n/2rlVjt5YjJl
	+VLHrGV60HaTn2OADtguFT7FXOtBNfa765VVbC4aqwb/HsakcttUnUmpM4ox3ch4vdllDJAYWhHTV
	l1KQhNPYt2l0cf1FXQWHKFQOpJmX24CRBmG3r1MIcDZ6pIlHjwPad6nlr0tEeimWG9b2q6sQA/iiI
	VXzLLuIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsLD4-00000008EIX-3krH;
	Fri, 07 Aug 2026 14:06:06 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsLD2-00000008EHc-00aI
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 14:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=K3SviOS6dfaElwqZsGFYvgNYmNLpXjvir7qqTUt7Jc4=; b=GxaLeyYHNZw0HZXIP+vjijRoCE
	zu2xXDts+Z7bKOgH+rIhfwCzToipY6I9hYWKnLvuyR8YdGYhUHHVPxuFgijvThFd05L3QrePApM6u
	yPqvEEHZ10uhsFPwwbz92HtT6SRl0C771gpsnnBasyqcLQcyI976wrnlfXCfLf1V0uUPKNNDS4a+B
	gyiuB9DOlsNRns8ixialnIqyM76s4SP0NXSrWG8IFBs27HHvvREzkSyVpav9wXDEPlpP3hr5MjZU3
	a8Y19qY5ptNbAsJjdV2hUM0pRmrgZ0l750Spl8trqryBEipOtK1XWyTTiILdPKZlYev17NNUfLC3o
	vdz475Pg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wsLCk-000TvW-00;
	Fri, 07 Aug 2026 14:05:47 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Aug 2026 07:05:09 -0700
Subject: [PATCH v4] kexec: keep the next kernel off hardware-poisoned pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-kexec_posioned-v4-1-70d57f14625d@debian.org>
X-B4-Tracking: v=1; b=H4sIABTmdWoC/2XMywqDMBCF4VcJs3bKTOIlddX3KKVEM9pQUIlFW
 orvXhRKL24P5/ufMEoMMkKpnhBlCmPoOyhVmiioL65rBYOHUoEmnVOhC7zKXerz0C9H8VjoqiK
 XcmocQaJgiNKE+xo8nhIFlzDe+vhY+xMv6ztl/1MTIyPnVFv2bKmRg5cquG7XxxaW1qS/vKGN1
 8jY7LVnm2Xc5OnGm4+3ZDbeIKM1zuXihUzGP36e5xdZtS9aLQEAAA==
X-Change-ID: 20260727-kexec_posioned-72bb0a4143a0
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, pratyush@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
 kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=9097; i=leitao@debian.org;
 h=from:subject:message-id; bh=SWLUcI/DF2JhAszQhmn2J1XYAQICne5Kz7Jfs0Ci4Cs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqdeY1kEEZkJGz1XhZQ+IcaILAez7sq3dqPdKGM
 QXOYA6OzZyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanXmNQAKCRA1o5Of/Hh3
 bWyeD/4zPXn1gQcSq4LJXP5wG6c1SwzSBFOrrPUWDFCNsSYbIfwrDkgXtBHmz7YiAK5oAMfaKeR
 PLCZybD3wwgN2md5wVg6+bKGjvDYZYVgpHlcLeLs9UtICZlI3dQJtVAdLUt9OCLTcf7U36VIQcp
 GtbED8jGl6S+T7rpw1fVx9csCJunaGfM2LWLgqR6vNqt6Bxhzzm4rVeoxmXiurlTDZ2kGM9olJz
 q6EfFlIqEKdTCFW7Gq2JZ0zWhKWL/DLeJCM/RzxWXBZarDQHs3c5jbclYLR3ApCinTqeZV41/7S
 Gyk5Vh1Lg2HdP511r29Jp8o1w5zGUkTzsmqze8CwdKaUDzytRQAz0s2rlVMfI47cihK7x32IIWY
 4FL3hDINkgryiY1K5fL6Rca2eFEckuSE2ywPyV30LCLqYYVonnSaw88wBXQzYyj48icJG/+llY3
 84YlUxbJRUm9ebqzu2OuwZ0XPH3kkFMcVQwfiw3D4AIudmS6Ytl06f21cPFniFY4GPGUgY8xeAw
 2ZUC/H7hMY1UCXCz45aa2bnXiECcGCOJt8uSFxBA6RnYGiPcpTv5oTbPtN4Fw/R9ro+HtRkO0yX
 hUx2ygcacZUmH7d03CaUNuT3SM3tcK1FjypWJFqubND/69b6UjhBHqmJzUFAUU7wDWJbUIxfP1O
 ljVFxeb1lznK6Pw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_070604_232748_0C3A7799 
X-CRM114-Status: GOOD (  27.38  )
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

Memory failures (such as unrecoverable ECCs errors) are getting more and
more common. The kernel knows how to handle it while running, marking it
as poisoned (and SIGBUS user tasks).

Poisoned memory is removed from the buddy allocator, but, not from
other places. A current problem is that kexec will load new kernel
on top of a bad/poisoned memory, which is undesirable.

If the next kernel's image, initrd or purgatory lands on poisoned frame,
the relocation copy writes to the bad memory and the machine checks
during the kexec.

Skip hardware-poisoned frames when placing segments: check them in the
kexec_file hole finder so it lays the next kernel down on good memory,
and reject a poisoned destination in sanity_check_segment_list() for
the kexec_load path, which cannot relocate.

The two hole finders walk in opposite directions, so each asks for the
end of the poison it has to clear: the top-down walk for the first
poisoned page in the window, the bottom-up walk for the last. A poisoned
hugetlb folio counts in full, as hugetlb keeps the flag on the folio and
the poisoned subpages on its raw hwpoison list.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Anchor the top-down hole finder on the first poisoned page in the
  window and the bottom-up one on the last, so each jumps clear of the
  poison in one step. New range_first_hwpoison(). (Kiryl Shutsemau)
- Count a poisoned hugetlb folio in full: the flag lives on the folio,
  not on the subpages, so the per-pfn scan missed poisoned tail pages.
  (Kiryl Shutsemau)
- Link to v3: https://patch.msgid.link/20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org

Changes in v3:
- Return the address of the last poisoned page in the range, or
  PHYS_ADDR_MAX when it is clean, instead of a bool plus an output
  parameter. Renamed to range_last_hwpoison(). (Pratyush Yadav)
- Add cond_resched() to the scan loop, as a segment can span half of
  memory. (Sashiko)
- Link to v2: https://patch.msgid.link/20260730-kexec_posioned-v2-1-f92d18551f64@debian.org

Changes in v2:
- Change from pfn_to_page() to pfn_to_online_page(). (Miaohe Lin)
- Return the poisoned address once we find a hit, to avoid the O(n^2)
  rescan. (Sashiko)
- Link to v1: https://patch.msgid.link/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org

To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Baoquan He <baoquan.he@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
To: Miaohe Lin <linmiaohe@huawei.com>
To: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
---
 include/linux/mm.h  | 14 +++++++++++
 kernel/kexec_core.c | 10 ++++++++
 kernel/kexec_file.c | 18 ++++++++++++++
 mm/memory-failure.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7fabe6c66b4b7..41b923901b193 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5192,6 +5192,8 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
+phys_addr_t range_first_hwpoison(phys_addr_t start, unsigned long size);
+phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -5204,6 +5206,18 @@ static inline void num_poisoned_pages_inc(unsigned long pfn)
 static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 }
+
+static inline phys_addr_t range_first_hwpoison(phys_addr_t start,
+					       unsigned long size)
+{
+	return PHYS_ADDR_MAX;
+}
+
+static inline phys_addr_t range_last_hwpoison(phys_addr_t start,
+					      unsigned long size)
+{
+	return PHYS_ADDR_MAX;
+}
 #endif
 
 #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d053..e097e980b1439 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -212,6 +212,16 @@ int sanity_check_segment_list(struct kimage *image)
 	}
 #endif
 
+	/*
+	 * Reject destinations that land on hardware-poisoned memory: the
+	 * relocation copy would machine-check on the bad frame.
+	 */
+	for (i = 0; i < nr_segments; i++) {
+		if (range_first_hwpoison(image->segment[i].mem,
+					 image->segment[i].memsz) != PHYS_ADDR_MAX)
+			return -EADDRNOTAVAIL;
+	}
+
 	/*
 	 * The destination addresses are searched from system RAM rather than
 	 * being allocated from the buddy allocator, so they are not guaranteed
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d86..9ba6cc01af929 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -475,6 +475,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 {
 	struct kimage *image = kbuf->image;
 	unsigned long temp_start, temp_end;
+	phys_addr_t poison;
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
@@ -504,6 +505,15 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		poison = range_first_hwpoison(temp_start, kbuf->memsz);
+		if (poison != PHYS_ADDR_MAX) {
+			/* we hit a poisoned page */
+			if (poison < kbuf->memsz)
+				return 0;
+			temp_start = poison - kbuf->memsz;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
@@ -520,6 +530,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 {
 	struct kimage *image = kbuf->image;
 	unsigned long temp_start, temp_end;
+	phys_addr_t poison;
 
 	temp_start = max(start, kbuf->buf_min);
 
@@ -546,6 +557,13 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		poison = range_last_hwpoison(temp_start, kbuf->memsz);
+		if (poison != PHYS_ADDR_MAX) {
+			/* we hit a poisoned page */
+			temp_start = poison + PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a8b03e2920ba8..c485e205fb633 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -96,6 +96,78 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
 		memblk_nr_poison_sub(pfn, i);
 }
 
+/*
+ * Return the first or the last hardware-poisoned online page in [start,
+ * start + size), or PHYS_ADDR_MAX if the range is clean.
+ */
+static phys_addr_t range_hwpoison(phys_addr_t start, unsigned long size,
+				  bool first)
+{
+	phys_addr_t poison = PHYS_ADDR_MAX;
+	unsigned long pfn, end_pfn;
+
+	if (!size || !atomic_long_read(&num_poisoned_pages))
+		return poison;
+
+	end_pfn = PHYS_PFN(start + size - 1);
+	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
+		struct page *page = pfn_to_online_page(pfn);
+		struct folio *folio;
+
+		cond_resched();
+
+		if (!page)
+			continue;
+
+		folio = page_folio(page);
+		if (folio_test_hugetlb(folio)) {
+			/*
+			 * hugetlbfs is a bit special, given the poison
+			 * information is at the folio, not at the page
+			 */
+			unsigned long folio_end;
+
+			/*
+			 * No hugetlb_lock: the scan is racy either way, a frame
+			 * can be poisoned right after it. Just don't let a folio
+			 * dissolved under us walk the scan backwards.
+			 */
+			folio_end = folio_pfn(folio) + folio_nr_pages(folio) - 1;
+			folio_end = max(folio_end, pfn);
+
+			if (folio_test_hwpoison(folio)) {
+				if (first)
+					return PFN_PHYS(pfn);
+				poison = PFN_PHYS(min(folio_end, end_pfn));
+			}
+			/* skip all the pfns that belong to hugetlb */
+			pfn = folio_end;
+			continue;
+		}
+
+		if (!PageHWPoison(page))
+			/* page is good, let's go to the next one */
+			continue;
+
+		if (first)
+			return PFN_PHYS(pfn);
+
+		poison = PFN_PHYS(pfn);
+	}
+
+	return poison;
+}
+
+phys_addr_t range_first_hwpoison(phys_addr_t start, unsigned long size)
+{
+	return range_hwpoison(start, size, true);
+}
+
+phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)
+{
+	return range_hwpoison(start, size, false);
+}
+
 /**
  * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.
  * @_name: name of the file in the per NUMA sysfs directory.

---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-kexec_posioned-72bb0a4143a0

Best regards,
--  
Breno Leitao <leitao@debian.org>


