Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E5C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=06TheYrO+RqVpiOeLZzO2sVZrEIqfAB0lq+jheypzUY=; b=Yt9V8/akvO9l1jI8QwfwhArQn6
	vQuN3eHcorLoLjAQS+SiL2VmPoadF3eUtAsBDcCE3A39AcFHStz0/GF8eBNgUmTh2dkL7/rU6gbpu
	QfmxubQjE+urdNMWBKBIz0GHRS+QVkGaDDL/GpPOHVfm/z7mLK2d0cA/BIMy02c5PAF38Lt/Bc5T1
	FEWXchARD1T4QGHO7l/7CSNuX2IRu0FEqyf3Lw3idi/tgWJna3hFzzknTRPc1hnW58XwzINBmIu4e
	uES98yHIPZMpDbgtOfx0qw3dgEDlS9AL9m3UaWciGEAnFw0qgxIxqIU6tDncxvaucklGV7YTFmemL
	zsTvq0Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Sga-00000006cYd-2Tcs;
	Tue, 15 Sep 2026 12:54:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SgV-00000006cXP-120a
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 12:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=06TheYrO+RqVpiOeLZzO2sVZrEIqfAB0lq+jheypzUY=; b=eAxnG7eFY07PkfIkhn5Kjnbykf
	1klTwzy7t/1IXe2N4XCggL0OA4fphUHH2GUSwtXUBiIfB9oWf32GfuVBl+isJcmG9cT71EwDAW98m
	gPq4sA0lRLq1sCbgDDbYAS5/Nnom69e2qL5uZfh+XlN7sDU3Ei2GNTQI43Dz2xXwrqHnqIMVIhdYA
	f/bhbl2mHd0MVaY1yEcx7WjVeybk/lhGE6zy0dtkNLI+kF6z/m5ZWllfFVTCYy5WgjDN6NArcu55h
	Fbe2n2XK9eTHWn8Ido2ZHorzvnMCFU26mNNxFUy34XXtqceWCTaQE9gP30GHiZWrcqHFS8daMOfU9
	ohTOW3+A==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6SgR-00000006lsA-2Xsc
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 12:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=06TheYrO+RqVpiOeLZzO2sVZrEIqfAB0lq+jheypzUY=; b=Qcf3QIz55CcoaSldbU3zzTlL9y
	IesoBAEM54qeIhRkKwKFUEMm4nfEKwbtnDTM2Kwd/9YFqHwXxGoIriQlWqoQ7M5qGa7U48T1BTx8M
	DG1/EIn4i/N3wGOau9uP2DnOL3mq9IE36OTH+ACyOXN/gBOSOmzbXk9ZVPvdlo96o0jM8zTSCTRAZ
	w/lj1lQEIxmzspaxPkyvhiAs5vTFOfO4ATfnvHd+Ral4CQZ+gLnhbwATUF1OJc1jr457gY66mVZr9
	AqOKMoDcCVXOb6Tff4axnEA1/l9sQiiL4HEI2zrLGLxVnHMLBEzeJRxf24fQ868QdNF9UqbHy4YMW
	ghNx9N7Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6SgG-004P7U-0N;
	Tue, 15 Sep 2026 12:54:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Sep 2026 05:53:39 -0700
Subject: [PATCH v5 5/9] mm/memory-failure: efi: record hardware-poisoned
 frames into the poisoned-memory table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-hwpoison-kho-v5-5-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
In-Reply-To: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, 
 kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 hannes@cmpxchg.or, shakeel.butt@linux.dev
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
 Breno Leitao <leitao@debian.org>, harry@kernel.org, 
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3575; i=leitao@debian.org;
 h=from:subject:message-id; bh=OD6lOfDsuQ3Gx0O3nG+lnSFgQ/uCyiBdpWhEzT0xs4w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqqT/e9fGRdv2ojIBIylpv+WGyoKgen1RPvA/py
 wfutQvXLwSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqk/3gAKCRA1o5Of/Hh3
 bcZOD/9tYa5c1xoSwHHUjr+PBSVX2GYqBV2gH0IMO8Np0WO5iyG9Uz1fsyag/5SdmAC3g8xbHCi
 SU49YEZF/BxnxWXcegM8Hq2aRQQ/PsZzDmwpiOVkh1Yd0+m23cgfkxAHTeObj79QrvrpupuB0ZN
 ZfenMCr6f9nmRuuyXJgGAdN3SqmKKkHp/0pLf9jhrJVQppAmkL21OL/dcIL7MUn4ViSzT5ay1rg
 9bKerw/vl7i3oNZKiblmKUgY1iOw28hN1BLbiZ5OJAiotlCciX210WGqifZUCnD8F4v9XbMcL88
 GkxIZrs8wOD30AS0yt1/Hp6DziMWkY2qmOjX+0oLGASCVf77CT1Ki6jFrVtp6AwYJhTqVaTTviz
 VObWrgN1tVtc491/NDobzNW8fcbhu6gPkS6kU9dTdpXBMGlSjBGkdkhrmyZuarbh9+yY4cgwe+6
 lGdYm1vtptAfuVdrjaBkWTSEO0HaYCWL6UfQ1TBPZbU3oPBsjerrrMSO8RiB0OVDgkaTbgFHvMY
 1XsGOXMKOJm1ZBfnZ5E06uWG8cxlbQMS47XSWNyLn95gNQKRh2W9OwNwfvFxN/B5oyjgx0tmbmx
 aeFo0YF6GMWpENLcwZT/pidl1kpqjp6Tc/kh6QxZA3JoXkPIZMg0nTE2piBle5FZW0X0wk4m2kJ
 hAkVzZhu0+0Hnxg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_135447_673067_9AD507D3 
X-CRM114-Status: GOOD (  18.74  )
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

action_result() is where memory_failure() reports the outcome of a hard
offline, so hook it to set the frame's bit in the
LINUX_EFI_POISONED_MEMORY bitmap.

Soft-offlined pages reach num_poisoned_pages_inc() through
page_handle_poison() and are deliberately left out: they are still
functional and were offlined predictively, so recording them would turn
a prediction into a permanent loss for every kernel further down the
kexec chain.

A bit is only ever set, never cleared, given that multiple pages can set
the same bit, and it is not trivial to decide if the bit should be unset
when a page is unrecorded.

Unpoisoning a frame therefore does not hand its unit back to the next
kernel. That is a known limitation.

memory_failure() has already taken the frame out of this kernel's
allocator, so only the cross-kexec record happens here.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/poison.c | 27 +++++++++++++++++++++++++++
 include/linux/efi.h           |  2 ++
 mm/memory-failure.c           |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
index 3f12db3dc9b844..847592862f01d3 100644
--- a/drivers/firmware/efi/poison.c
+++ b/drivers/firmware/efi/poison.c
@@ -91,3 +91,30 @@ void __init efi_poisoned_memory_reserve(void)
 	memblock_add(start, end - start);
 	memblock_reserve(start, end - start);
 }
+
+/* The table, vetted at parse time, or NULL if this boot has none. */
+static struct linux_efi_poisoned_memory *efi_poisoned_memory(void)
+{
+	if (efi.poisoned_memory == EFI_INVALID_TABLE_ADDR)
+		return NULL;
+
+	return phys_to_virt(efi.poisoned_memory);
+}
+
+/*
+ * A bit is never cleared: it stands for a whole EFI_POISON_UNIT_SIZE, so an
+ * unpoison cannot tell whether the unit as a whole is good again.
+ */
+void efi_hwpoison_record_pfn(unsigned long pfn)
+{
+	struct linux_efi_poisoned_memory *pm = efi_poisoned_memory();
+	phys_addr_t addr = PFN_PHYS(pfn);
+	u64 unit;
+
+	if (!pm || addr < pm->phys_base)
+		return;
+
+	unit = (addr - pm->phys_base) / pm->unit_size;
+	if (unit < pm->size * BITS_PER_BYTE)
+		set_bit(unit, pm->bitmap);
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index dd3263456dd4a3..56402fdccd1149 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1288,8 +1288,10 @@ struct linux_efi_poisoned_memory {
 
 #ifdef CONFIG_EFI_POISONED_MEMORY
 void __init efi_poisoned_memory_reserve(void);
+void efi_hwpoison_record_pfn(unsigned long pfn);
 #else
 static inline void efi_poisoned_memory_reserve(void) { }
+static inline void efi_hwpoison_record_pfn(unsigned long pfn) { }
 #endif
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a2ca8df501caee..d9b8be696aac38 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -43,6 +43,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/dax.h>
+#include <linux/efi.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
 #include <linux/export.h>
@@ -1326,6 +1327,8 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
 	if (type != MF_MSG_ALREADY_POISONED && type != MF_MSG_PFN_MAP) {
 		num_poisoned_pages_inc(pfn);
 		update_per_node_mf_stats(pfn, result);
+		/* Only hard offlines are carried over to the next kernel. */
+		efi_hwpoison_record_pfn(pfn);
 	}
 
 	pr_err("%#lx: recovery action for %s: %s\n",

-- 
2.53.0-Meta


