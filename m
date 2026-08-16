Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A50C5DF66
	for <kexec@archiver.kernel.org>; Sun, 16 Aug 2026 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TB5hLITgaLSvnkEZ2ABO7VyYwwjhkPuh1sGrI3sQjr4=; b=IK1D54U1Zdv/8P719qqtuWpXMr
	4RZ8VgDqjEH+wP6ZCNSHz4i0PCJJiu2oPpuM0W0950UVUBOLhphE9fpQDHapxLvlTFOx0ivGd7+0c
	y0gtcWOMd/X59jj5cKdh3Ev5NPjMyYdaNsu9dP2KQi3Owp0uv1SHCquZG/woHhsocmbdpr+Q+jqy1
	FTrfyhjecmdO1l9E66hTgnHMTx2kznwjZl788aqgHTAfy1eViIo/MY/5uMFhNYWyQ2LlPjqR4O1nk
	VcfUZdc5qNrxzDc36HrpFMYzxbxlbNwzdFrK2/run+SAhCyW7hBIMDrYL/GR3zoW/U648Q4JT2ysf
	wyWMVVYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvWjW-00000004b2h-25Kj;
	Sun, 16 Aug 2026 09:00:46 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvWjT-00000004b2M-2fnp
	for kexec@lists.infradead.org;
	Sun, 16 Aug 2026 09:00:45 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2432737f8f.1
        for <kexec@lists.infradead.org>; Sun, 16 Aug 2026 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786870841; x=1787475641; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TB5hLITgaLSvnkEZ2ABO7VyYwwjhkPuh1sGrI3sQjr4=;
        b=SfsnEEppE11isUGuZKHUm2cyiES2be5p5aK7yl3HVsFxq9KgDNxderb+mhJP2Yvpxy
         PHPheE1Jj5qNxg+P2UUHHgXVEcmUc9JQ7Jj0g/c5QrAyPiIYbY5q6aZWoHyYJx763XzE
         Eq2G7fWUT/vCyrDfpEHgFniGQ04xSoXnkYuTcpf8B+w0VrjDcYNzO4Hd4Yj/UbGW5wmw
         qVajbSXRUGMNb7VXV8HA09pE68OWHub1ZsJi06Zuj3CHO2/+H1fPMTcAoI+MwPfMkYNa
         O/Nqf9OPRGoghthYzTUL24amwedg3zCLtpVnfDL2+BMLWoFZXZlDCQ4gI5+IkHyqmxZD
         XA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786870841; x=1787475641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TB5hLITgaLSvnkEZ2ABO7VyYwwjhkPuh1sGrI3sQjr4=;
        b=OTAjP2ngphyRSSt0PtrDR9yV/JALM5PEafHXY+FXPwG2MRvNsIrG61hJ5QMmsV5oFy
         Vzgw0VJJah6hK/+7/a7ykf2glraY+sGFL5CzLS3E8/8kvBZ3ssSfIDWSnlT5vr/xS6FK
         6QkKTY+RLfGZs58EJ+JLTwwHDmdcZMphLstFBiyxuzvqRVhfnZrsaOZbSwr+jma0LsJD
         NFt+G5mZ1Igow651V9/J7U2lx+NcaErCC3gxLcPYvwSHQ9K8SUtph3Nx6UT5RYJHYvLN
         G8GBzMWlta617T/BW4ClnnKkbLEKoiEHXfpMi1vB485v+7V6oSFUdNAEsgAB69wv7pKh
         iPyg==
X-Forwarded-Encrypted: i=1; AHgh+RoH9gkFRY/E783LP8BwuMW9C0oXqnNnUEpxwmGEvm156BOoPmGE0mCMEHyGYE+G03E8seV9Kw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxD6S7L2Z4afH5YJ1YYPFpAtj/7G5gBT7dp6zPqBLBbD2t8G7h+
	cqxB+GjqkU6NsU875ZZJy87YXeaVGcgCTzeM0FBvON5zR0h8YTe+iimE
X-Gm-Gg: AR+sD11+jw2IQ597nSYv25wpcAzlJ5WbIzvWfu7onnveoHN0S3ahsz6/TeoyOEqBx93
	nh34IAruRDe3rwAuDy2tEYy6wKT9BgOLz1kObCDD/Uty7o71XfRddFNeYwNjGyelVFKKXMZf/pr
	hRPl1I9B5xIeueJb36idHH4FO5klKbHN2iO6uIRN3LyI3LXDVtUf7cCvfZYL9awhpZLJFGEN2oG
	rpksmqQxKlB+HfsMSaI7nddFz0gmo0EJZ/rnHhirPV8KaEa2E9G7IdIS74/PVbpUcvo+5RomBei
	fcHKOEijbiCOhb4367Gk0lEdwZVY7Q8DWPoew0dhzuJTO8Gr5RLJa6xiBGNXdOwSYsWRz+DdHRy
	Tdd9+9gXPw7XSMmR2dPaOsfo+m920ysUY0ziJKXaOwJiYlrkiTxLmBRPpkIOArxlXAbf8897wEz
	yZ7RsH0RhizIdBhWHm/GTskq9reePw9SLRWHxjx1bBfPXtdyqIMiHdsykv
X-Received: by 2002:adf:f392:0:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-4816078c790mr19677263f8f.29.1786870840761;
        Sun, 16 Aug 2026 02:00:40 -0700 (PDT)
Received: from zen ([37.203.152.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b13c3sm18665907f8f.19.2026.08.16.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 02:00:39 -0700 (PDT)
From: Kiarash Azarnia <kiarash.azarnia@gmail.com>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: graf@amazon.com,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kho: fix signed shift UB in kho_preserved_memory_reserve()
Date: Sun, 16 Aug 2026 12:30:37 +0330
Message-ID: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_020043_697624_0CA7FF93 
X-CRM114-Status: GOOD (  13.47  )
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

kho_preserved_memory_reserve() computes the size of a preserved
reservation as:

	sz = 1 << (order + PAGE_SHIFT);

`1` is a signed int, so the shift is signed-int arithmetic. For order
19 (a 2 GiB region) it produces 1 << 31, which is unrepresentable in
int and is undefined behavior; in practice it yields 0x80000000,
sign-extended on the assignment to the u64 sz. For order >= 20 the
shift count exceeds the width of int, which is also undefined. The
return value of memblock_reserve() is ignored and memblock_cap_size()
clamps the bogus size, so the kernel silently reserves the wrong
amount of memory for the preserved region.

kho_alloc_preserve() caps order at MAX_PAGE_ORDER and cannot reach
order 19, but a boot-time reserve_mem= region of at least 2 GiB drives
kho_preserve_pages() to compute order 19, and kho_preserve_pages() is
EXPORT_SYMBOL_GPL(), so the path is reachable.

Cast the shift operand to u64 so the arithmetic is done in 64 bits:

	sz = (u64)1 << (order + PAGE_SHIFT);

Fixes: 3f2ad90060f6 ("kho: adopt radix tree for preserved memory tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Kiarash Azarnia <kiarash.azarnia@gmail.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 175c08a6e41e..c79f48bd64ac 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -501,7 +501,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	struct page *page;
 	u64 sz;
 
-	sz = 1 << (order + PAGE_SHIFT);
+	sz = (u64)1 << (order + PAGE_SHIFT);
 	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */
-- 
2.53.0


