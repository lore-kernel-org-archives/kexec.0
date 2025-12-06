Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993D3D3B7E1
	for <kexec@archiver.kernel.org>; Sat,  6 Dec 2025 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/fSuPodiX5EHH+jhfOMD50dY+Ip+73J2brCzGUDDF9k=; b=Ez4SEPk8daJDt9Ul7klYul3vKT
	x2bYVOfnZp6hBDK6a3CX0+RWmlZ+e8h+JAJYeo+c/Q7etnaAoqbyr3MT55ZFFW2P6+QmyD+NSHx5e
	28cph4jT/bHH4qITeJgfLpXHxAQ7w5304AyAmLokzd7Pp5WVwxZEc13inIjxwwLct7pxtWgGJqtVD
	FsLCcYWQ0xDddhq3bNkuGz2gUxsfxkyFod7tcnq7CCVD0kyeqnf1NL+m973stJCjYMpEOBUnN2foj
	qwopp82vyubpwYXRucBdD2bLsEKhol5B4xnk86oQZmn5973AWks9qxF8UBjuWCqUs7E4wbBwKjz8D
	+BwU1hqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1Iv-0000000BHiT-1QGl;
	Sat, 06 Dec 2025 23:03:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1It-0000000BHhW-10qW
	for kexec@lists.infradead.org;
	Sat, 06 Dec 2025 23:03:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3378E4411D;
	Sat,  6 Dec 2025 23:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EF5C4CEF5;
	Sat,  6 Dec 2025 23:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765062182;
	bh=YZifJ1dvIIR+mXezMnWNnfK3KMOuY+73A/Qwip8J2FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ml5Ukipu2YIRmfC2zWNaddAoSeT997AL8NgvuFYBfAl+b37rS4w9nWuzGNZoxFgMe
	 tv2qDqnGU3eYwsHM7C3pccFIoU3CqoJQTdYQcYgpyp8FPYjc4wvmEAKLHuBxTFJzw1
	 6dukN6uux6gsGXX3mMqy0ZIcODl5PAQ6EjwK9nog6kkER5K4xx8XDvSLxw+yme8qsS
	 ZjO5k7OvTyEFPOY0dtt+cLzux+zmWbbwHZtIOkdOZ4z0Meb9uIPVNPuWkuAMLFNIDH
	 L4v65ddsy8Fcy3wovhmFFJNavsXA3rv+KXK1nJZGXWMTGbi8EAUNAeJMbYzL1K6e8G
	 HN4m4uDjC8/ag==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [RFC PATCH 01/10] kho: drop restriction on maximum page order
Date: Sun,  7 Dec 2025 00:02:11 +0100
Message-ID: <20251206230222.853493-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251206230222.853493-1-pratyush@kernel.org>
References: <20251206230222.853493-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251206_150303_323444_148E1A55 
X-CRM114-Status: GOOD (  13.55  )
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

KHO currently restricts the maximum order of a restored page to the
maximum order supported by the buddy allocator. While this works fine
for much of the data passed across kexec, it is possible to have pages
larger than MAX_PAGE_ORDER.

For one, it is possible to get a larger order when using
kho_preserve_pages() if the number of pages is large enough, since it
tries to combine multiple aligned 0-order preservations into one higher
order preservation.

For another, upcoming support for hugepages can have gigantic hugepages
being preserved over KHO.

There is no real reason for this limit. The KHO preservation machinery
can handle any page order. Remove this artificial restriction on max
page order.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    This patch can be taken independent of hugetlb live update support.

 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..9aa128909ecf 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -234,7 +234,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 	 * check also implicitly makes sure phys is order-aligned since for
 	 * non-order-aligned phys addresses, magic will never be set.
 	 */
-	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
+	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC))
 		return NULL;
 	nr_pages = (1 << info.order);
 
-- 
2.43.0


