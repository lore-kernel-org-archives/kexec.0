Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C976C79FBF
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6tS1Yb/K4/AvrXAKqpEiR5JcZF8qOSHzE/V/IVZb4Y=; b=UObJnBg2POR2I7fH1SquWj4xa+
	LCvVOV1j8syNIy1PFiqnkq06d5fkDbHmOlQmu/pRK4lyn6X5iSMsRJw2qbP8mNJGBsLybGgCM7Ocm
	H5lFjVuLAAMamoK+YqiKoQTIvXKscJ/YCXRufSvvAYrrXQCn4u+kJfm4X4TlTuO2c3t7PMbe5j0dX
	/EcsVov2eNrrKP4mGuw7X1ulTggeJ/Xc+lYW1ohT/YA0vcuFYZ5bfuv+liuLm+iaC/xJyJ2nO9aiN
	IyjJtbpnvljuQWVNTBRDoMl6tRpDHH/5B8U2UJjjWAkEbNfAB1Er6iAY4O/F9quTqFoPTveJuaZVI
	W1f/aayA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4I0V-0000000Bkl8-1fss;
	Wed, 09 Sep 2026 13:06:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4I0T-0000000BkjM-3qQk
	for kexec@bombadil.infradead.org;
	Wed, 09 Sep 2026 13:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=S6tS1Yb/K4/AvrXAKqpEiR5JcZF8qOSHzE/V/IVZb4Y=; b=IDU8UdgBg1g/rWh+11it5LkgQa
	BwWbTRGw0gK0GxtxBFdHrNSqeaoS+H6WaQhwJHiICdLz36ZIHzf76L2zQIPNPGjd40q3kN9r5BIap
	uDg2fbLzNGC3e+xlFnOqTyqAzY3q0fqbZ4SBC4iEGl5bqZJuUfH9mEzuY4osD8F88FhFOJ2YVY+wO
	/dw67BlSOXHfeX/HVztKZVFFf5aLE4jB7r+VeBwzw4DlmMzOfshqQe09MNGFs0mMKa//NOyUU0ro/
	4DZQB24ZQK1yglj6jvAvPf8kPW4YT4uQALTu3SkU3nJM68/N4EaOVHPR+VWJ59yPcTDd34CIdLDaQ
	Crd0Hbmg==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4I0Q-00000001CpP-3wyb
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:06:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=S6tS1Yb/K4/AvrXAKqpEiR5JcZF8qOSHzE/V/IVZb4Y=; b=Emhkd0c+jSvCqWB2hHCtjCVesP
	UhfV/ilBH7u6HeVo0QjEBjWeAvWtB/am1I2Jjzvp5kmD0JgYOiuty/biWlGwPK3JjqvNwcBieI1gA
	cMWauvnYu0O6U0YiCAm0GrwtzfVJpG7CL4YlS8GaCBmvb3XLbL0W8jufZc6w0mOOFioSmPHk6K2KL
	51FnXQUStPA2WHw044vrjr5Be+QO6o+eDCsadF8z0qyZuZLDBZzdTfDR9VgA/uzeibE+bgEoTbj5U
	+PGhdfjNDrKihMdF6WQdc5wMDt+gvq47Mhi+Jwl+/N5IoQWOASSemJ6jJ7sp3IU5365R+yW0Mxvx4
	plHr9DKw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4I07-0034eB-1Y;
	Wed, 09 Sep 2026 13:06:07 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 09 Sep 2026 06:05:24 -0700
Subject: [PATCH v4 5/5] mm/memory-failure: keep inherited poisoned frames
 out of the buddy allocator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-hwpoison-kho-v4-5-359313564495@debian.org>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
In-Reply-To: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
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
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
 Breno Leitao <leitao@debian.org>, harry@kernel.org, kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4020; i=leitao@debian.org;
 h=from:subject:message-id; bh=drOYIVpoY7AQaUepXy25YegitABVihsyPIT5xNKQkkg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqoVmYmVxCxsLeTjYv3u9z+EL2a6qkRIZ1SrEGK
 HBAjZjn6WSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqFZmAAKCRA1o5Of/Hh3
 bRI/D/91oPLXxFDp9Rr/sQrlT/YiQl/S/8FOn4S2vYWZTtNRBuE6K3TFP9w3UvAoN+cWuKRQDda
 XWJAC9s+Z8+75ZltnjS7OgNk33KsMJ0svQnxXhH7BTbLvwFaQxY2+FAOdrKdvJCBfmJqhuF6afv
 mOhJAzwB/G2S7STW7sOEWTGbF5x4oHQOMZfYR4LJ1BuDtIBRopdYsVmdAbdqaHQqMJrycH6hUo8
 rLuI4EY9jtzNm/iLF8pjAa6nQTud8KwEpVgCWFHJyJeBCVYUEXeXpOXhWvIQOwIpP2qIDiWKvTo
 1orI/+xNunPwlAZoZBYFk7HUOvb8grxKRsqiI/yxrgLE8O8CoHwXYtRweyJYszYoBC0Kq7FV7+X
 8gDlNuvn+sfnUV/MkvQUyHFGULb35erkJr3A0GWPAMlfBZKrXajCasv6QugF96KhusrEHAVNXTn
 Ev+TQ3mv+U10TiZC0p1wGD65m6Qj04HciA1gXgcOOYq4Rt7g3MV6p25u5xAFkNQadTcVdZQWnpe
 KGz3bVI3BbSxBn5F0ApC92q6tOsBUy3h9zGcv13nEFo/L+BZ77T7rMbmuiXkFO1h3ssVgaJWpw+
 eoFti/Uk+3h3UnYR1x13WahcQzdkvtfrcb+mLQPSkI6up7nKhavfmYRZYN4eehwnv4YW+3leRYd
 pfRrIgOdOLAQ4YQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_140627_107057_3E20D493 
X-CRM114-Status: GOOD (  16.60  )
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

When the pages are being given to the allocator, check if they are
poisoned, and mark them as such.

Similar to unaccepted memory, hook it in __free_pages_core(), and thus
the frames never enter the allocator, rather than being taken back out
of it.

hwpoison_boot_page() leaves a frame in the state a frame poisoned by this
kernel would be in, so everything that already understands PG_hwpoison
covers it, the kexec segment placement check included.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/mm.h  |  5 +++++
 mm/memory-failure.c | 15 +++++++++++++++
 mm/page_alloc.c     | 25 +++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b68824fcfbef1..9d9f2e8fdc136 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5225,6 +5225,7 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
+void __meminit hwpoison_boot_page(struct page *page);
 phys_addr_t range_first_hwpoison(phys_addr_t start, unsigned long size);
 phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size);
 #else
@@ -5232,6 +5233,10 @@ static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
 }
 
+static inline void hwpoison_boot_page(struct page *page)
+{
+}
+
 static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d9b8be696aac3..f6afdb2a89a94 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -137,6 +137,21 @@ phys_addr_t range_last_hwpoison(phys_addr_t start, unsigned long size)
 	return range_hwpoison(start, size, false);
 }
 
+static void update_per_node_mf_stats(unsigned long pfn, enum mf_result result);
+
+/* Not num_poisoned_pages_inc(): its per block half divides by zero this early. */
+void __meminit hwpoison_boot_page(struct page *page)
+{
+	if (PageHWPoison(page))
+		return;
+
+	SetPageHWPoison(page);
+	set_page_count(page, 1);
+	/* The page has been completely isolated == MF_RECOVERED */
+	update_per_node_mf_stats(page_to_pfn(page), MF_RECOVERED);
+	atomic_long_inc(&num_poisoned_pages);
+}
+
 /**
  * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.
  * @_name: name of the file in the per NUMA sysfs directory.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 404896b53003e..9e2ce833fd409 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1579,6 +1579,19 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 		free_one_page(zone, page, pfn, order, fpi_flags);
 }
 
+/* Flag the frames an earlier kernel recorded as bad. */
+static void __meminit poison_block(struct page *page, unsigned int order)
+{
+	unsigned long i, nr_pages = 1UL << order;
+
+	for (i = 0; i < nr_pages; i++) {
+		struct page *p = page + i;
+
+		if (range_contains_poisoned_memory(page_to_phys(p), PAGE_SIZE))
+			hwpoison_boot_page(p);
+	}
+}
+
 void __meminit __free_pages_core(struct page *page, unsigned int order,
 		enum meminit_context context)
 {
@@ -1613,6 +1626,18 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 	}
 
+	/* First: a block parked by __free_unaccepted() never returns here. */
+	if (range_contains_poisoned_memory(page_to_phys(page),
+					   PAGE_SIZE << order)) {
+		poison_block(page, order);
+		/*
+		 * TODO: free the frames in the block that are not poisoned.
+		 * They stay out of the allocator and still count in
+		 * managed_pages, so a unit costs up to a block.
+		 */
+		return;
+	}
+
 	if (page_contains_unaccepted(page, order)) {
 		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
 			return;

-- 
2.53.0-Meta


