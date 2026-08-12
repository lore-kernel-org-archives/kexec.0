Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4485C5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eEO9P1mvess5y0n0KUnCYAeP/+IifPhRXEhfxRdjhi4=; b=3MGXnpMXMG/x2peBJKbtZi+Ny8
	d9j1xzi3I2HRvxldt7t7SZ+pj206MW8Bnxr4SXKWBzD+UoEA79iHPBjYlLmjxIueJyyl9Gx2bvb3k
	FZEO6VNaxc/UOAZQiTfI+vYkDVaE3V5FUbjL4UCy2cMCqaZql6lt6IOnkhz1fuAyamHjPmwIajApT
	9Dv+DU3WwguPKFFGMC0sinlmJIsWC4MD2wjFJvKSgrjrqTnXZfL2f+oWP78Bzn3yNBjMFCxtS5/MW
	x3Le8caIzSQtImnHrK/AI5MFn5b4uKqq/UyL2AJ6ZiHRCKIr7KXPQu0VJV9eW9H4Dji/hk8jo1Y2l
	Au+/ettA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7CA-0000000G5mY-2QuY;
	Wed, 12 Aug 2026 11:32:30 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7C7-0000000G5ji-3Uk9
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 11:32:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=eEO9P1mvess5y0n0KUnCYAeP/+IifPhRXEhfxRdjhi4=; b=lMBLiFDXe7xrvPugP2EHgSR/nH
	L6WHW8wD4ND+1rUNkQxYbTMBSHt1nDX8MJINlBdl1vpnF4+Trm6iXThbx/JbiNs51St77PFsP5b1P
	qFxuqyste7/BkihRa9OGHUaMM5LtxY9z0DIeeeXiBG0e673pZr4woHJYRrFP0uawOhd1V4Euojm9+
	znpnH9BeGXEtJLzX8BS9zUAwbro6R/SImQ6IGvRZPZ0w9VOpfq+/aUxFKNjLmm5T7KCAOGW4TyzbU
	w1m2yF2+H7oLYG0P9JN0vOA2dROstVc2+phcoYg65fULWiTk5EBkChKE3BevZm+w3p7ujzUfnWS8W
	v2Vgw5Yg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu7Bt-004JJP-1k;
	Wed, 12 Aug 2026 11:32:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Aug 2026 04:31:52 -0700
Subject: [PATCH v6 2/2] kexec: keep the next kernel off hardware-poisoned
 pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-kexec_posioned-v6-2-e477887086f0@debian.org>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
In-Reply-To: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, 
 riel@surriel.com, kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 Bradley Morgan <include@grrlz.net>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=6504; i=leitao@debian.org;
 h=from:subject:message-id; bh=DngnSfPX8XBe6I/yjyE8XagV4YyZPUZlPnCTWnEo5k4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqfFmsufCoDT5cFM1bcdNKZCitkrQyQY/M2Zqyk
 xSH76lNFveJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanxZrAAKCRA1o5Of/Hh3
 bdGFD/92nUsa8eZs63kMuOvyNiWyDpQeZzq//w2XgiP+7o6YoTuBSKV85sb0nS3tF+MRwuRswiK
 kb+9r1A32Qkkg1UGU2wnVMKiGJ9+wUejnaLVVYCpsT6oiPRC8Ew5vrbPmFemzhRD4HoiERfXqoy
 i2tF1+0PEsrL4bCpZNgpmYbgZXB5ZMJnGjymNBohy2bwbVCvusbh48Gi599QMoI+QU+/tHo/rdA
 UFMzRqfLcdMeEpV90Vyln3FTcsfm7ten97cC0jCQrzrBtbXHc1jHELYcSuDEs1nkTaFZe8AQGSs
 keyopJCpKyX8dO415r7FmadedOtaaoCC/5HsjBV8Zb1CcP+dKD8FDirBfa7G3F1dPz/oiUZfhLv
 hthfFOhT4/qi1XVIaPFURSqibxmfqUMGNQbcDBT36O0nQr6KlIr5hoF1LNOSeRnluQRjRmCMsbA
 Wje6t8igbkRm/I9JN1sPhOP5EiDZmNlvzqb6gVE1vuQH/9c+k+ga3+vo2CvrVhqRhONgLd9MzdB
 pn4DDzlqht+TGzDyX9bMuZmC6dwDEdvjno0gx041/whLGeoNS3VuxK53s1KA7u2PFfx5M/IoPzS
 XYdiG1bTrs80KIKtacvHg/Rb1SxCSDLzs1VpzLqzhWgDuIPqY2AHmh4Dl5I+EEAVSPZvyq+7q72
 r5jTQEUCzjaONKQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_043228_210568_ED5FF736 
X-CRM114-Status: GOOD (  22.57  )
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

If the next kernel's image, initrd or purgatory lands on a poisoned
frame, the relocation copy puts it on memory that is known bad. The
error happens on the first read from a bad page, and that is what we
want to avoid.

Skip hardware-poisoned frames that were detected by the memory failure
subsystem earlier when placing kexec segments.

To do so, add a helper that reports the first or the last poisoned page
in a range: memory is walked top-down by locate_mem_hole_top_down() and
bottom-up by locate_mem_hole_bottom_up(), so each direction needs a
different answer to stay clear of the poison.

kexec_load() gets its destinations from userspace and cannot move them,
so there sanity_check_segment_list() just rejects a segment that happens
to have a poisoned page.

is_page_hwpoison() also covers hugetlb, so a poisoned hugetlb folio is
skipped as a whole.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Bradley Morgan <include@grrlz.net>
---
 include/linux/mm.h  | 14 ++++++++++++++
 kernel/kexec_core.c | 10 ++++++++++
 kernel/kexec_file.c | 16 ++++++++++++++++
 mm/memory-failure.c | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)

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
index 01a64d98fbcd7..8b0fc8a5d3c36 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -475,6 +475,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 {
 	struct kimage *image = kbuf->image;
 	unsigned long temp_start, temp_end;
+	phys_addr_t poison;
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
@@ -506,6 +507,13 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		poison = range_first_hwpoison(temp_start, kbuf->memsz);
+		if (poison != PHYS_ADDR_MAX) {
+			/* we hit a poisoned page */
+			temp_start = poison - kbuf->memsz;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
@@ -522,6 +530,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 {
 	struct kimage *image = kbuf->image;
 	unsigned long temp_start, temp_end;
+	phys_addr_t poison;
 
 	temp_start = max(start, kbuf->buf_min);
 
@@ -548,6 +557,13 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
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
index a8b03e2920ba8..a2ca8df501cae 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -96,6 +96,46 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
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
+		if (page && is_page_hwpoison(page)) {
+			if (first)
+				return PFN_PHYS(pfn);
+
+			poison = PFN_PHYS(pfn);
+		}
+
+		cond_resched();
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

-- 
2.53.0-Meta


