Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C5FC55184
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pozz8qpib4iafMr8P/yl3aNa9zYQsoROn+obz5UP7zw=; b=bfjfNNIvlMXQ8yuUiKLNC/CRed
	2RpDZ8lHQ7De+znM2B7+Y/yVCN0N52wrFyk10a9SRV16lzllLrQ9PSGnlCpRfiK/Q6A9sfHd2s90Q
	OBDyvzW7S8+zh6rUBcyJOrlySxS73FYPG0e54ggL+wiTYq6q/q8ii3L1+jx9d2r/cE9j+UFbsuDwo
	/67EL8H0r2q9hxzXIA99MHEYPQElRdiGkUfNhrC/ISwbrOTFHRGbfQVpdDXpXpkmYlYacqIMf2APW
	1JO0PLzsvosL4QcSds2mPAJo4fOkpnvZdFBuzbEtRCoQ/L9dc5zOWZA8VACtr8zaQuI8r1sdRBVEB
	KFpDhTIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqs0o-0000000H3s2-31u6;
	Mon, 03 Aug 2026 12:43:22 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqs0l-0000000H3ni-0HMX
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 12:43:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=pozz8qpib4iafMr8P/yl3aNa9zYQsoROn+obz5UP7zw=; b=eG0P7Sgpi6kaMXPiTxV+xUE4+f
	8Lv/au4TOBz/KASPHNJUhUKBuLCKSVKb97MUPfsIan3h9nxR8PUUL77iqR89ylwpPuMieOFCQ4LOR
	U20T0icIIJywK28+fCBPG6v8keZl30uD3BJuWGS8RC34keJeXh6b01VVZYiYKADWlPBRpKSuhHd3L
	QL8TTebtogi3McRT3GXqZmjw0Tdx23siT1+jlwLlmae27oNwHB3JWvqWSsLhQ52bgLQ3kE7ima8OY
	NN5aejsCURpQ0BrGk6z1gBwS1xJbVTyKMATqymO00DXV2LkL0cpT6dW9jPkZ3++QJX7c1eV8DTG7N
	FpBGZVAQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wqs0R-00CMfi-3C;
	Mon, 03 Aug 2026 12:43:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 03 Aug 2026 05:41:10 -0700
Subject: [PATCH v3] kexec: keep the next kernel off hardware-poisoned pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org>
X-B4-Tracking: v=1; b=H4sIAGWMcGoC/2XMywqDMBCF4VcJszYlE2+pK9+jlBLNREPBSFKCR
 Xz3olDoZXs4/7dCpOAoQsNWCJRcdH6ChuUZg37U00DcGWgYSCErUcua32mh/jb7/UiG17LrhC6
 wyLWAjMEcyLrlAC/XjMHo4sOH5+En3Nc3pX6phBw5VqJXaFAJS62hzunp5MMAu5XkR5+Lv15y5
 PYsDaqyRFsVX/22bS8l9rSr7QAAAA==
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
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7480; i=leitao@debian.org;
 h=from:subject:message-id; bh=pomWKg7l4noDyqRugbLncVBJpDkQOVQ2vMRlBLBRWdg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqcIzPPRv+oxN927PSThtT3svnsDpyR4vSBgZnt
 F7W26Ybx9eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanCMzwAKCRA1o5Of/Hh3
 bV4gD/9+v93z62DBiX+Nv30ybtlwF+ZciqZ3sIK6yQqEEFdTwytF5eADkjD/uIIO91asdFXY+0m
 Ef2IbY9JgVdLjV/mPZF+0TJbk+Cu4bo5wfFaziBp3RexVZ1twXrIx7Veaf4guWNpIacy7gTXPgh
 Y7q5SVJxJNZKIgZvSO3dX6jry/lXbS7pL2iy7ZGXxZS4TCnmD/5fIVx0jYGhrtozd4DzE1r5GvM
 sxNrrHvUTX0X5z305QKML4aW4d/PKoShWpZWaXrc7nJCh9QttElbpEb+jng/ZKJm3zQ0gBTy/KG
 1U6/tZKFcTTD9oS8FCtPPI+UHgTEeCY8w9MUD4ef168xtt8g265F6V3HKFZuBIDQWHvDoNYmZEy
 Nsf7z7QO16dQCFk+uXHbpaOa6hMNbxE/x5OuwvlGcMoEQ6EG5UExZoBkVWZjoG12XWoaXKGW+Mq
 gkBKFoxPwPvlK/1KFkfskN3yoYZvVU9mv/ON1QKRbjZtpVjRQ0QUIlc3HYs1cnSgE+aBfEelitl
 EQE/Cb3eK3CZEoXNGJDd7QVQeLSVVYUKl6keigzVvZ5jT0NudiUq5GU0pq7Dwe7laByOxvJl2Do
 vL8guPnrken8ktRZ4NSz5hwcZfbLAPpW8q5q8rs8dZl5ZQ7P4DMMh8/Hn66aHiNX+6ZUewwnyMl
 ecKrym23SAxir/A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_054319_280466_C564C482 
X-CRM114-Status: GOOD (  26.65  )
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

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Tested on x86_64 under virtme-ng, poisoning frames through
/sys/kernel/debug/hwpoison/corrupt-pfn:

 - kexec_file_load(): poisoning a page inside the range the previous load
   picked moves the kernel from 0x13b000000 to 0x138000000, and moves the
   crash kernel's elfcorehdr, the only bottom-up user on x86, from
   0xaf000000 to 0xaf001000.
 - kexec_load(): a one page segment aimed at a poisoned frame fails with
   EADDRNOTAVAIL, while the same segment on a clean frame still loads.
 - No splat with CONFIG_DEBUG_ATOMIC_SLEEP=y, and the box kexecs into the
   relocated kernel.
---
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
 include/linux/mm.h  |  7 +++++++
 kernel/kexec_core.c | 13 +++++++++++++
 kernel/kexec_file.c | 18 ++++++++++++++++++
 mm/memory-failure.c | 25 +++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7fabe6c66b4b7..fa4f55eff2415 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5192,6 +5192,7 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
+phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
@@ -5204,6 +5205,12 @@ static inline void num_poisoned_pages_inc(unsigned long pfn)
 static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 {
 }
+
+static inline phys_addr_t range_last_hwpoison(phys_addr_t start,
+					      unsigned long size)
+{
+	return PHYS_ADDR_MAX;
+}
 #endif
 
 #if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d053..f2a519a4a6d93 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -212,6 +212,19 @@ int sanity_check_segment_list(struct kimage *image)
 	}
 #endif
 
+	/*
+	 * Reject destinations that land on hardware-poisoned memory: the
+	 * relocation copy would machine-check on the bad frame.
+	 */
+	for (i = 0; i < nr_segments; i++) {
+		phys_addr_t poison;
+
+		poison = range_last_hwpoison(image->segment[i].mem,
+					     image->segment[i].memsz);
+		if (poison != PHYS_ADDR_MAX)
+			return -EADDRNOTAVAIL;
+	}
+
 	/*
 	 * The destination addresses are searched from system RAM rather than
 	 * being allocated from the buddy allocator, so they are not guaranteed
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d86..530c919412a92 100644
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
 
+		poison = range_last_hwpoison(temp_start, kbuf->memsz);
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
index a8b03e2920ba8..ef0e989c25d93 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -96,6 +96,31 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
 		memblk_nr_poison_sub(pfn, i);
 }
 
+/*
+ * Return the address of the last hardware-poisoned online page in
+ * [start, start + size), or PHYS_ADDR_MAX if the range is clean.
+ */
+phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)
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
+		if (page && PageHWPoison(page))
+			poison = PFN_PHYS(pfn);
+
+		cond_resched();
+	}
+
+	return poison;
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


