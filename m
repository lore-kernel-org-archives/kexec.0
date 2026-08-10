Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52547C5B56C
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M4ZuA5M6RkD29gUcHfwnbTxPc3xPq/YfIHf5PjSwt4A=; b=b6JdzlcDtmi0YXpE1h9RBpwVBJ
	IeeDUF7Rf9QP+wdUsCt6uhJv4o73c4bHiNj89zy/VEP55e5Ideg8Ak5rOl5eIzCbWGdGB29+lpg3u
	qU0cLjzXfrbFa/VHaWaHJkk8b4qu2VoYRNvN5rFf7uPfsyP0+X/0ioilI5CfPP24B6vn1e+zN1cqv
	7yA89bp9g9qGP9xBBRmtk1CrVR3Zmx+RPebz/he04XENQSm6xWWm+yLwbLUqe8ap+E/ZUMGRTzbDJ
	qvl1GEa8DUZqcf9swnpcnoeCMnzps54KwnOM3AvzqbeT7dUDFiycOXYo7iS24cZunfJlOK00g8MwP
	GwN4s8cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQ8P-0000000BuUM-2Oq7;
	Mon, 10 Aug 2026 13:33:45 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQ8J-0000000BuTS-3VtB
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 13:33:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=M4ZuA5M6RkD29gUcHfwnbTxPc3xPq/YfIHf5PjSwt4A=; b=ZFZuEIqATspEl36CdO+8X+D/Tp
	FJ+RU9/NffoQV7DoNjQ1lz9LC3HX9NpIKx40tUM9okP5FfKZMWLhZY+6iVcBY+YninrcCs2v4Bl06
	2piXIB6GZxtjIm/nyivOeuc3TatIyJhNKQ7WF2juk5I5QT45XIUp5kihA15BrFUl5cY9AsykjU2ci
	RSkjHZ+zWCZ+1xewR/PUfUs/rXJotjmonleIxU2TrI+/qDlOxqNZyR24KRgcnTX1RJUqpUgSoMwu1
	+8jqQmPQFWoQ7mvU9ekWP8zv39SbEhb2mWn/tRVMyEifYy3lIiIL4JlOvGx7CEfWIe93bsHBAgcH7
	VUzUqIgA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtQ7t-002mgl-2u;
	Mon, 10 Aug 2026 13:33:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Aug 2026 06:32:04 -0700
Subject: [PATCH v5] kexec: keep the next kernel off hardware-poisoned pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
X-B4-Tracking: v=1; b=H4sIANPSeWoC/2XQTWrDMBCG4auIWXuKRv/1qvcopcjWKBEFO8hFp
 ATfvThQmlbb4Xvexdxg41p4g1HcoHIrW1kXGIUdBMznuJwYS4JRgJLKSa88fvCV5/fLegw5oVf
 TJKMho6OEQcClci7Xe/D1bRBwLtvnWr/u/UbH9ScV/qcaISE5OQdKFGTml8RTicvTWk9wtJp68
 Fp2XiFhflaJgrWUnem8/vVB6s5rJAw6RseJpbbUefPou1c0g4ReJuszGads+uP3ff8GpFBJ8m0
 BAAA=
X-Change-ID: 20260727-kexec_posioned-72bb0a4143a0
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, 
 kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=8448; i=leitao@debian.org;
 h=from:subject:message-id; bh=fcxYIOs/vy8wB7NClKG7Nu5A9xU+96w3y9opFudFG1s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqedMUVUszL1AO7A8JlMeC+ztg9Q1uQcgOu3BPB
 fI8nGd54LaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCannTFAAKCRA1o5Of/Hh3
 bYxND/92sMdiCE0yNz/tVqsJ0/LCu1nI/zfJHy0MAR+DGopZRIIvPB4XSbwo2BOXRhndIXZoTQN
 BBQscJdTaaAQ/yk1KvlunHo/IeX5YAFYPFJ0DDXb0Ylu/Lir0jIQcLbuLWskyWilaPZmXBQG2k3
 BFuTmKiTCxBs5pXLXaYASXf84evafHYJ+RNxKR/MivLNtd/k5ygvmVZ9Ng2274zlTyECxPLYbzI
 mS8YVciD2dLDcgor8kOcH5KDYVap5/sir9bAV/DqkZODD9y5pGDHqKInIprKB8NtZMzqPb6cfKA
 o5imMImSb7hi7iPsPDxTx+VDvyIDV3JHpIRBrBfkRAgfcsRyDOaiRwh0APzc6G+g59G1rkZkdeK
 Q/vIPHJhrAyVDsBr1ADlnq9mf8TCr9lrslUCZuB4kwIFGwyJxqnUdhkknqfQAQ4XQ/UT1YPpbE5
 01tD6jpA9uAmMwfeb3GkKBR8gNytPy9X0YGExjKmVwhagTbUsCsVMOm+6edONkl8v+Osp1HryxI
 hOAHR+TUUDahoner8Aao/JEC8YT1hORR29uZsWjoyRzHt8009LK0GuK7KJyv4jioXkTIskPGt2S
 I5qdIHbQOPPhnvtSMYrHmXIqf4s+vzhF3RasU72+cXwHZ0wX7CgwlXolCuPxSUOkOxbVNu73kdw
 urlq18A+tv8GN6A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_063340_093749_4DDB9023 
X-CRM114-Status: GOOD (  26.42  )
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
Changes in v5:
- Return -EHWPOISON instead of -EADDRNOTAVAIL
- Leverage is_page_hwpoison() instead of per-page check
- Link to v4: https://patch.msgid.link/20260807-kexec_posioned-v4-1-70d57f14625d@debian.org

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
 include/linux/mm.h  | 14 ++++++++++++++
 kernel/kexec_core.c | 10 ++++++++++
 kernel/kexec_file.c | 18 ++++++++++++++++++
 mm/memory-failure.c | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

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
index dc770b9a6d053..7ee8c9f078f6b 100644
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
+			return -EHWPOISON;
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
index a8b03e2920ba8..f3875680e7955 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -96,6 +96,47 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
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
+
+		cond_resched();
+
+		if (!page || !is_page_hwpoison(page))
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


