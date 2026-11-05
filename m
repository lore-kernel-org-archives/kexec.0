Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A087606A32C
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=04fsB/uf;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FgiHimHL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Message-Id:MIME-Version:Subject:Date:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ab9/FtU+evEOIDbPSbhyDZc8Br1EcYdUtbtpoFOf6ao=; b=04fsB/ufIdUI6ty0TKwk+oCQ+X
	SzX9Q5zr77GUhYNEFQj3C2lFDrt4njD5FG3qtJhx03rBCABVIjADqjtsPqlYg06+4/aMtdUUWN/DP
	rVREr2XuqlIjHoT1gSIYKfE36GkMWBAfaEGnG+w2k8Uoe7Royd7VvRlJadBatAdv+1057nTdDID6R
	DCFcm9LMQDs+V70Tr2wdGCzsbsi5556vuBsINtJcB7b8uxiejS4Zd0MVP7waLDGkS0uONbnMkRo0g
	v19x+HfcDq9N1zb6RMYeyoB3w2cPFRit6vCZ8IqCzNxfsdhC+JNJPbsVxG4OrYwBr4TtnW5XGXYB5
	EGJslsag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxQW-000000096bX-2Rzw;
	Thu, 05 Nov 2026 13:22:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxQT-000000096ax-3yIZ
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 13:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793884963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ab9/FtU+evEOIDbPSbhyDZc8Br1EcYdUtbtpoFOf6ao=;
	b=FgiHimHLa2j5Wo+Js1yF4BOtNTrc5qJJn6BTd4srfvqpmcvnOVuCUxg7qwdSAZYHCmeEGL
	V7BzSf2DyAHTKuXfrIPyp2/wJaADtO+36RS2qeFw8iEnepvqvHa95wOtydET0/1CWVEC4F
	8S/dsIAN7HfDRBMPWmF/iy5jMQica3E=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-O6KqWF7bOu2dYtB-WhNCEg-1; Thu, 05 Nov 2026 08:22:41 -0500
X-MC-Unique: O6KqWF7bOu2dYtB-WhNCEg-1
X-Mimecast-MFC-AGG-ID: O6KqWF7bOu2dYtB-WhNCEg_1793884961
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd633da24f8so2186825a12.2
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 05:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884960; x=1794489760;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ab9/FtU+evEOIDbPSbhyDZc8Br1EcYdUtbtpoFOf6ao=;
        b=xRkc2iiKpxVK4O+M05SNTkJ46RSybawukY8la4+43WYNYRnnxFvltCGqcQlLS33DNU
         sbVle84mxcFtdddYjxyC/f9cy6dcB8WGOXpQunacyIoCG+90uQR1tVMAPUsqxWTg9LgA
         LzYcGCn2kJd6ZNcjpp2BE2vHhkscFy7KWkJbv9di02mScytz/vxYQfVUl4fsFE51MHAt
         unz3U757Qq/Ddm0pVXsz7dBldDHe1JqAE5Aom4W5lSml0u/919+8bxfxO1sFG4Ok5N1L
         xDVCI8QgGoReQP45uGeyCptzLw6/9f4yfU7V4mzMEMyk9qGmn+ByKCO1ZW01UkIoB+Pp
         XhOQ==
X-Gm-Message-State: APuU4Z8au791h3aMDZZZyWs4JvE2xywgnHcHyQzGuY1ymM0XD7opD+S6
	wGoF902yDB7RA3e4RWACx3X4hkupzITjGqIbp/afjvrgAU6WzxIkid3tr3ntunzOa2ITaYUFX0j
	EknYpoAOw3XU7A0OZRMDYrq8/e2k1wAQrSpf4fnUU9i62ZgcHaI22VwElpm/UmM6luBxgeyKjri
	zz6T4bv9ERtzyHl0JR/HYERCOeKm4Eabu8wZu0ktTkKpQXow==
X-Gm-Gg: AYBFou34fvfVYqXiVsmSjq2M8eU7+Nc53HO4PcU49zf0hbRE3mMZESULEY9s6kj5jMV
	ktyqsc9xnEF+lhU0YlrLGweJ6EgRdGNvhkFumvX45KNuGn2z42KyvBhD6A4qsP1DKNghLKhihtP
	n942VOsntRmttHMt9d1Iq10SJwQ4iJutsoLbgPqXhqx9ZDG3P5nPHnsz8sIXuMhXoVi+epw3vwC
	koSP87Dp1vHc3jjRqQHG6K8L19yeK0JfUzqS4mtR6KKYzVMMasL3GHem+4mz/u/3cgQzl+6n6/c
	MXbvDnKd+SPrM/i83ErqPV+W/z6JkigDRszMpMPFOztsfmyf0DmUkhh70JKEZnzpyfrf5AZWbQ2
	EdpnZJZHBPuLIfWn1qKpckgN6jOYQO9BzcAVIdoWvEkGm7D6TQnwmgh5EuI6pc4H1j4EyiSrUec
	qxs8dwnFr9i5t8prg=
X-Received: by 2002:a17:90b:3c08:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3ae89812f18mr17182385a91.37.1793884960450;
        Thu, 05 Nov 2026 05:22:40 -0800 (PST)
X-Received: by 2002:a17:90b:3c08:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3ae89812f18mr17182351a91.37.1793884959900;
        Thu, 05 Nov 2026 05:22:39 -0800 (PST)
Received: from mpilaniy-mac.redhat.corp ([2401:4900:1f28:63e0:edae:927e:c670:b679])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31601b7sm3856804a91.5.2026.11.05.05.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:22:39 -0800 (PST)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
Date: Thu, 05 Nov 2026 18:51:33 +0530
Subject: [PATCH] kho: fix restore order for NUMA-split preservations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261105-kho-numa-v1-1-e807879644cc@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubbaLMKryMXMYYeMNpOSdzdc/
 ur/fRd4dIQe6uQChwd5Wm2ESBPQRtkRGfXRkPGsEIJLNpuV2bAolmuUpZLYV7qCmG8OBzq/q6b
 97UM3od7fPdz3AwbzeB1sAAAA
X-Change-ID: 20261103-kho-numa-5ce38a3ed9c9
To: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Mukesh Pilaniya <mpilaniy@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884955; l=3669;
 i=mpilaniy@redhat.com; s=20261103; h=from:subject:message-id;
 bh=2j7UXRooyvW22SzIaRB/dl4RDz1nl9MFyxNiZyzuBgw=;
 b=vdaovpNvxbtOZRXpNitY6GqWoF6nDPZnjCousaLKgOJwI/K78h/4L2Dco1VA9V3Xcs/fKO107
 0UkOGgTHLK7Cw6fzuSyiGE2vzHPSQcKHjK954qch/bS6j+SUWRF3KTp
X-Developer-Key: i=mpilaniy@redhat.com; a=ed25519;
 pk=dOf4ctfH7dkkTYewUPOzloK8/0QFmb+uPo0tKgpSdzU=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M_G23kpO-s2FjakyP7I_IJW2ASdrj0GhyZ7gLIvyGXs_1793884961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_052246_067261_A91BA2DD 
X-CRM114-Status: GOOD (  17.38  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kho_preserve_pages() uses __kho_preserve_pages_order() to reduce the
order of a preservation so that it does not span multiple NUMA nodes.
kho_restore_pages() does not use that helper; it recomputes the order
from the pfn alignment and the remaining length only.

When a preservation was split at a NUMA boundary, restore picks a larger
order than preserve did and jumps over the next key. Those pages never
get restored: they stay memblock-reserved and keep the KHOP magic in
page->private, while kho_restore_pages() returns success for the pages
that were restored. The consumer has no way to notice that part of its
buffer was not restored.

Fix this by reading the order from the key being restored. The order is
already stored in page->private by kho_preserved_memory_reserve() and is
validated by kho_restore_page(). Advance by that order instead of
recomputing it. This also keeps restore independent of the incoming
kernel's NUMA topology.

Example: QEMU is started with two NUMA nodes:

  node0: [0x40000000, 0xC0400000)   2052 MiB
  node1: [0xC0400000, 0x1C0000000)  4092 MiB

The module preserves [0xC0000000, 0xC0800000) (8 MiB, 2048 pages). The
range is 8 MiB aligned and the node boundary sits exactly 4 MiB into it, so
preserve emits two order-10 keys, the first at 0xC0000000 and the second at
0xC0400000. Restore computes order 11 for the first page, restores the
first key and jumps straight to the end of the range, skipping the second
key.

Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
---
 kernel/liveupdate/kexec_handover.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3181..7d30ad9cc512 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -511,7 +511,8 @@ static void kho_init_folio(struct page *page, unsigned int order)
 		prep_compound_page(page, order);
 }
 
-static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
+static struct page *kho_restore_page(phys_addr_t phys, bool is_folio,
+				     unsigned int *order)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
 	unsigned long nr_pages;
@@ -530,6 +531,9 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
 		return NULL;
 	nr_pages = (1 << info.order);
 
+	if (order)
+		*order = info.order;
+
 	/* Clear private to make sure later restores on this page error out. */
 	page->private = 0;
 
@@ -550,7 +554,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = kho_restore_page(phys, true);
+	struct page *page = kho_restore_page(phys, true, NULL);
 
 	return page ? page_folio(page) : NULL;
 }
@@ -573,13 +577,13 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 	unsigned long pfn = start_pfn;
 
 	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
+		unsigned int order;
+		struct page *page;
 
+		page = kho_restore_page(PFN_PHYS(pfn), false, &order);
 		if (!page)
 			return NULL;
-		pfn += 1 << order;
+		pfn += 1UL << order;
 	}
 
 	return pfn_to_page(start_pfn);

---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-kho-numa-5ce38a3ed9c9

Best regards,
--  
Mukesh Pilaniya <mpilaniy@redhat.com>


