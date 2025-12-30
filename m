Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A97E9410F
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 05:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1e9uUTBz+40NmI3fTdEqfK4QSWJZfTGjPJYHjncr7mA=; b=ilv47J820YGkeyqd1Dmfr7w9uY
	YmNU8fi5Xh2teN5PrC84mAOSyc8FcuO1ga4bFc7q6Zt6Q+e0Ptu1b90HWCd3RHlNqTZz5BzgR+PrW
	JMLHEalXdwUa1B2Wri5BDyt2rUDu06ySkH2sJ23l4LT5qZ5h3nDwg4rKh5ZRadl3yYcptGSiWvuPS
	jTWETTzCbPy79pRbBRCq3kz5sCY+nvVJ/q97ZWFlMLVNpYlYIVaK5gEAgvGZJ4qrdcdWzTZwu7Nd9
	8uIWJLMH8pNZ+1syw50qRuR1oaN+L6DFcqS+XS3a0fgvQKqthFUXiNXgfIdMlfd1Q55xYiN4tLZpF
	fDQSaGpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaSgD-00000004RTA-3sqp;
	Tue, 30 Dec 2025 05:54:01 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaSgC-00000004RSm-0RVd
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 05:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1767074035; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F3LqCm8Wah5SBnBGInhkixRT8PUDVR2E15M73CB8WywTLJSMDzNgCe6FVWotXanoYQeZzamIjDpy+CxMh0VU6a+GEtMM6On8v78MeQL9Xmk07DwcflUna9e2FNcQ+ahFgYD4kEYRytVCQxpWU3DM7IssI+RzN6psRKcXspy0BTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767074035; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1e9uUTBz+40NmI3fTdEqfK4QSWJZfTGjPJYHjncr7mA=; 
	b=aabst8O1DRV87rkCvI+Ifr1GD9xnXvDzDYgX66zJkTSgM3sCFBwgiGRUdXdk5hq47G+gyMVQE6pf4e0pNCOtsFQB9NXF147493f6M7mlx6/133nNk2eFOET710657yZ0rr40QO5RSaTI+a3ImYHUweHueqWp59xLPs2CMsfPWgg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767074035;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1e9uUTBz+40NmI3fTdEqfK4QSWJZfTGjPJYHjncr7mA=;
	b=kEwyYJ+ECDAUV1X7n4SwslKEQ85vASPzYdmhkXNGkZXzuI8Rvho6xHz70H4YDWOs
	4s07dPdxdeFuOxz4KAKEo5ZgT0sB9sKWCUqd75EKOsVA2bC6cqEPjZyoScDWk2QQCKu
	QrFcPol/o0Q/sTpIhLvTTL4W4X4IWvwtj3BgyxfI=
Received: by mx.zohomail.com with SMTPS id 1767074032492365.5149488909235;
	Mon, 29 Dec 2025 21:53:52 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH] liveupdate/kho: Warn when kho_scratch is insufficient for sparsemem
Date: Tue, 30 Dec 2025 13:53:45 +0800
Message-ID: <20251230055345.70035-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251229_215400_195626_5DA6B079 
X-CRM114-Status: GOOD (  22.96  )
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

With KHO enabled, the successor kernel can temporarily run memblock in
scratch-only mode during early boot. In that mode, SPARSEMEM may allocate
a per-node scratch buffer via sparse_buffer_init(map_count *
section_map_size()), which requires a single contiguous, aligned memblock
allocation.

If the maximum usable scratch range in a node is smaller than the
estimated buffer size, kexec handover can hang very early in the
successor kernel, and we may even have no chance to see the error on
the console.

Estimate the worst-case per-node requirement from the running kernel's
sparsemem layout and compare it against the reserved scratch list by
splitting scratch ranges per nid, sorting and merging them, and applying
the section_map_size() alignment constraint. Warn once when scratch
appears too small.

This check is a heuristic based on the running kernel's sparsemem layout
and cannot account for all differences in a successor kernel. Keep it as
a warning instead of rejecting kexec loads to avoid false positives
causing unexpected regressions. Users can adjust kho_scratch accordingly
before attempting a handover.

To reduce boot-time overhead(particularly on large NUMA servers), run
the check from a late initcall via system_long_wq instead of in
kho_reserve_scratch().

Signed-off-by: Li Chen <me@linux.beauty>
---
 kernel/liveupdate/kexec_handover.c | 396 +++++++++++++++++++++++++++++
 1 file changed, 396 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..69f9b8461043 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -18,9 +18,14 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
+#include <linux/math64.h>
+#include <linux/mmzone.h>
 #include <linux/page-isolation.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/unaligned.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 
 #include <asm/early_ioremap.h>
 
@@ -504,6 +509,353 @@ static bool __init kho_mem_deserialize(const void *fdt)
 struct kho_scratch *kho_scratch;
 unsigned int kho_scratch_cnt;
 
+#ifdef CONFIG_SPARSEMEM
+/*
+ * These are half-open physical ranges: [start, end).
+ */
+struct kho_phys_range {
+	phys_addr_t start;
+	phys_addr_t end;
+};
+
+static u64 kho_section_map_size_bytes(void)
+{
+	u64 size;
+
+	size = (u64)sizeof(struct page) * PAGES_PER_SECTION;
+	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP)) {
+#ifdef PMD_SIZE
+		return ALIGN(size, PMD_SIZE);
+#else
+		return PAGE_ALIGN(size);
+#endif
+	}
+
+	return PAGE_ALIGN(size);
+}
+
+static u64 kho_phys_range_aligned_usable(phys_addr_t start, phys_addr_t end, u64 align)
+{
+	phys_addr_t aligned_start;
+
+	if (end <= start)
+		return 0;
+
+	if (!align)
+		return end - start;
+
+	aligned_start = (phys_addr_t)(DIV64_U64_ROUND_UP((u64)start, align) * align);
+	if (aligned_start >= end)
+		return 0;
+
+	return end - aligned_start;
+}
+
+static int kho_phys_range_cmp(const void *a, const void *b)
+{
+	const struct kho_phys_range *ra = a;
+	const struct kho_phys_range *rb = b;
+
+	if (ra->start < rb->start)
+		return -1;
+	if (ra->start > rb->start)
+		return 1;
+
+	if (ra->end < rb->end)
+		return -1;
+	if (ra->end > rb->end)
+		return 1;
+
+	return 0;
+}
+
+static unsigned int kho_scratch_count_pieces_in_nid(phys_addr_t start, phys_addr_t end, int nid)
+{
+	unsigned long start_sec;
+	unsigned long end_sec;
+	unsigned long sec;
+	unsigned int pieces = 0;
+	phys_addr_t piece_start = start;
+	int piece_nid = pfn_to_nid(PFN_DOWN(start));
+
+	if (end <= start)
+		return 0;
+
+	start_sec = pfn_to_section_nr(PFN_DOWN(start));
+	end_sec = pfn_to_section_nr(PFN_DOWN(end - 1));
+
+	/*
+	 * Split at sparsemem section boundaries and classify pieces by nid.
+	 * This assumes nid ownership is section-granular, consistent with
+	 * SPARSEMEM grouping and sparse_init() run detection.
+	 */
+	for (sec = start_sec + 1; sec <= end_sec; sec++) {
+		phys_addr_t boundary = PFN_PHYS(section_nr_to_pfn(sec));
+		int this_nid = pfn_to_nid(section_nr_to_pfn(sec));
+
+		if (this_nid != piece_nid) {
+			if (piece_nid == nid && piece_start < boundary)
+				pieces++;
+			piece_start = boundary;
+			piece_nid = this_nid;
+		}
+	}
+
+	if (piece_nid == nid && piece_start < end)
+		pieces++;
+
+	return pieces;
+}
+
+static void kho_scratch_add_pieces_in_nid(struct kho_phys_range *ranges,
+					  unsigned int *nr, phys_addr_t start,
+					  phys_addr_t end, int nid)
+{
+	unsigned long start_sec;
+	unsigned long end_sec;
+	unsigned long sec;
+	phys_addr_t piece_start = start;
+	int piece_nid = pfn_to_nid(PFN_DOWN(start));
+
+	if (end <= start)
+		return;
+
+	start_sec = pfn_to_section_nr(PFN_DOWN(start));
+	end_sec = pfn_to_section_nr(PFN_DOWN(end - 1));
+
+	/* See comment in kho_scratch_count_pieces_in_nid(). */
+	for (sec = start_sec + 1; sec <= end_sec; sec++) {
+		phys_addr_t boundary = PFN_PHYS(section_nr_to_pfn(sec));
+		int this_nid = pfn_to_nid(section_nr_to_pfn(sec));
+
+		if (this_nid != piece_nid) {
+			if (piece_nid == nid && piece_start < boundary)
+				ranges[(*nr)++] = (struct kho_phys_range){
+					.start = piece_start,
+					.end = boundary,
+				};
+			piece_start = boundary;
+			piece_nid = this_nid;
+		}
+	}
+
+	if (piece_nid == nid && piece_start < end)
+		ranges[(*nr)++] = (struct kho_phys_range){
+			.start = piece_start,
+			.end = end,
+		};
+}
+
+static u64 kho_scratch_max_usable_for_nid(int nid, u64 align, bool *skipped)
+{
+	struct kho_phys_range *ranges;
+	unsigned int nr_ranges = 0;
+	unsigned int i;
+	u64 max_usable = 0;
+
+	if (!kho_scratch || !kho_scratch_cnt)
+		return 0;
+
+	/*
+	 * All scratch regions (lowmem/global/per-node) are represented in
+	 * kho_scratch[]. For @nid, split each region into per-nid pieces,
+	 * then:
+	 *   - sort pieces by start address
+	 *   - merge overlapping/adjacent pieces into contiguous ranges
+	 *   - apply @align to compute the maximum usable contiguous bytes
+	 */
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		phys_addr_t start;
+		phys_addr_t end;
+
+		if (!kho_scratch[i].size)
+			continue;
+
+		start = kho_scratch[i].addr;
+		end = start + kho_scratch[i].size;
+		nr_ranges += kho_scratch_count_pieces_in_nid(start, end, nid);
+	}
+
+	if (!nr_ranges)
+		return 0;
+
+	ranges = kvcalloc(nr_ranges, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges) {
+		*skipped = true;
+		return 0;
+	}
+
+	nr_ranges = 0;
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		phys_addr_t start;
+		phys_addr_t end;
+
+		if (!kho_scratch[i].size)
+			continue;
+
+		start = kho_scratch[i].addr;
+		end = start + kho_scratch[i].size;
+		kho_scratch_add_pieces_in_nid(ranges, &nr_ranges, start, end, nid);
+	}
+
+	/* ranges[] is half-open [start, end). */
+	sort(ranges, nr_ranges, sizeof(*ranges), kho_phys_range_cmp, NULL);
+
+	if (nr_ranges) {
+		phys_addr_t cur_start = ranges[0].start;
+		phys_addr_t cur_end = ranges[0].end;
+
+		for (i = 1; i < nr_ranges; i++) {
+			if (ranges[i].start <= cur_end) {
+				cur_end = max(cur_end, ranges[i].end);
+				continue;
+			}
+
+			/* Finalize a merged range and start a new one. */
+			max_usable = max(max_usable,
+					 kho_phys_range_aligned_usable(cur_start, cur_end, align));
+			cur_start = ranges[i].start;
+			cur_end = ranges[i].end;
+		}
+
+		/* Finalize last merged range. */
+		max_usable = max(max_usable,
+				 kho_phys_range_aligned_usable(cur_start, cur_end, align));
+	}
+
+	kvfree(ranges);
+	return max_usable;
+}
+
+static int kho_check_scratch_for_sparse(int *bad_nid, u64 *required_bytes,
+					u64 *max_usable_bytes, u64 *map_count,
+					u64 *section_map_size_bytes, bool *skipped)
+{
+	unsigned long sec_nr;
+	u64 section_map_size;
+	u64 *max_run_sections;
+	int prev_nid = NUMA_NO_NODE;
+	int nid;
+	u64 run_sections = 0;
+	u64 worst_required = 0;
+	u64 worst_deficit = 0;
+	int ret = 0;
+
+	*skipped = false;
+
+	section_map_size = kho_section_map_size_bytes();
+	if (!section_map_size)
+		return 0;
+
+	*bad_nid = NUMA_NO_NODE;
+	*required_bytes = 0;
+	*max_usable_bytes = 0;
+	*map_count = 0;
+	*section_map_size_bytes = section_map_size;
+
+	max_run_sections = kvcalloc(nr_node_ids, sizeof(*max_run_sections),
+				    GFP_KERNEL);
+	if (!max_run_sections) {
+		*skipped = true;
+		return 0;
+	}
+
+	/*
+	 * Keep the run detection consistent with sparse_init(): it walks present
+	 * sections and breaks runs on nid changes only.
+	 */
+	for_each_present_section_nr(0, sec_nr) {
+		unsigned long pfn = section_nr_to_pfn(sec_nr);
+
+		nid = pfn_to_nid(pfn);
+		if (nid != prev_nid) {
+			if (prev_nid != NUMA_NO_NODE)
+				max_run_sections[prev_nid] = max(max_run_sections[prev_nid],
+								 run_sections);
+			prev_nid = nid;
+			run_sections = 0;
+		}
+
+		run_sections++;
+	}
+
+	if (prev_nid != NUMA_NO_NODE)
+		max_run_sections[prev_nid] = max(max_run_sections[prev_nid],
+						 run_sections);
+
+	for_each_online_node(nid) {
+		u64 max_run = max_run_sections[nid];
+		u64 required;
+		u64 max_usable;
+		u64 deficit;
+
+		required = max_run * section_map_size;
+		if (!required)
+			continue;
+
+		max_usable = kho_scratch_max_usable_for_nid(nid, section_map_size,
+							    skipped);
+		if (*skipped)
+			break;
+		if (max_usable >= required)
+			continue;
+
+		/*
+		 * Pick the "worst" node by deficit ratio using MiB units to
+		 * avoid overflow; this is a warning-only heuristic.
+		 */
+		deficit = required - max_usable;
+		if (ret) {
+			u64 required_mib = max_t(u64, 1, required >> 20);
+			u64 deficit_mib = max_t(u64, 1, deficit >> 20);
+			u64 worst_required_mib = max_t(u64, 1, worst_required >> 20);
+			u64 worst_deficit_mib = max_t(u64, 1, worst_deficit >> 20);
+
+			if (deficit_mib * worst_required_mib <
+			    worst_deficit_mib * required_mib)
+				continue;
+			if (deficit_mib * worst_required_mib ==
+			    worst_deficit_mib * required_mib &&
+			    deficit < worst_deficit)
+				continue;
+		}
+
+		worst_required = required;
+		worst_deficit = deficit;
+		*bad_nid = nid;
+		*required_bytes = required;
+		*max_usable_bytes = max_usable;
+		*map_count = max_run;
+		*section_map_size_bytes = section_map_size;
+		ret = -ENOMEM;
+	}
+
+	kvfree(max_run_sections);
+	return ret;
+}
+
+#else /* CONFIG_SPARSEMEM */
+
+static u64 kho_section_map_size_bytes(void)
+{
+	return 0;
+}
+
+static int kho_check_scratch_for_sparse(int *bad_nid, u64 *required_bytes,
+					u64 *max_usable_bytes, u64 *map_count,
+					u64 *section_map_size_bytes, bool *skipped)
+{
+	(void)bad_nid;
+	(void)required_bytes;
+	(void)max_usable_bytes;
+	(void)map_count;
+	(void)section_map_size_bytes;
+	(void)skipped;
+	return 0;
+}
+
+#endif /* CONFIG_SPARSEMEM */
+
 /*
  * The scratch areas are scaled by default as percent of memory allocated from
  * memblock. A user can override the scale with command line parameter:
@@ -1259,6 +1611,50 @@ struct kho_in {
 static struct kho_in kho_in = {
 };
 
+static void kho_scratch_sanity_workfn(struct work_struct *work)
+{
+	int bad_nid;
+	u64 required_bytes;
+	u64 section_map_size;
+	u64 map_count;
+	u64 max_usable_bytes;
+	bool skipped;
+	int err;
+
+	if (!kho_enable || kho_in.scratch_phys)
+		return;
+
+	err = kho_check_scratch_for_sparse(&bad_nid, &required_bytes,
+					   &max_usable_bytes, &map_count,
+					   &section_map_size, &skipped);
+	if (skipped) {
+		pr_warn_once("scratch: sparsemem sanity skipped (temp alloc unavailable)\n");
+		return;
+	}
+
+	if (err != -ENOMEM)
+		return;
+
+	pr_warn_once("scratch: node%d max=%lluMiB need=%lluMiB for sparse_buffer_init(map_count=%llu section_map_size=%lluKiB); kexec may fail\n",
+		     bad_nid,
+		     (unsigned long long)(max_usable_bytes >> 20),
+		     (unsigned long long)(required_bytes >> 20),
+		     (unsigned long long)map_count,
+		     (unsigned long long)(section_map_size >> 10));
+}
+
+static DECLARE_WORK(kho_scratch_sanity_work, kho_scratch_sanity_workfn);
+
+static int __init kho_scratch_sanity_init(void)
+{
+	if (!kho_enable || kho_in.scratch_phys)
+		return 0;
+
+	queue_work(system_long_wq, &kho_scratch_sanity_work);
+	return 0;
+}
+late_initcall(kho_scratch_sanity_init);
+
 static const void *kho_get_fdt(void)
 {
 	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
-- 
2.52.0


