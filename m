Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C3AC5AC67
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 10:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9jkdh6VKlKFhlDrgR60RC1avyqfvhVLkmPkcfqFabPg=; b=Xv4MLtMvKGSaG94fYog1d30j10
	HYjQBaarhghWIpAXy7l6sPNLNDILb9zq5j2z/Vasiz7umqZa05uAUVBEantdJqJ43oGcqPa22k9vG
	ijtys4bQL1Re9JnQCmfdzk5ERC8qli46UIJNkTZtB4iUBrOrbRu3LdIIN/TjS2wsPaUB+F5rU16NW
	L8RbraewNHPEBB/wtit0psGlbD+/CIQGBABKjrZpNgbw4NjHGSpPDcSgOXB7XP0OYQiB6cshWizMe
	+oj14W7z70Br6ZWiwCSry1zz8r6Qktgn88/5R7LaU/uUCfaSmaNpxwG2YpFtyjgzjYoWiVvoZC27x
	eOjNIwew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrv0v-00000005VQv-09Zz;
	Thu, 06 Aug 2026 10:07:49 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrv0q-00000005VM9-3DmE
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 10:07:48 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c2ae992beso159921f8f.2
        for <kexec@lists.infradead.org>; Thu, 06 Aug 2026 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786010862; x=1786615662; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9jkdh6VKlKFhlDrgR60RC1avyqfvhVLkmPkcfqFabPg=;
        b=qgriCz4t884frwMsFAtWcnspRlnxb4U3zhGy2spY/gb7qG6Yt3DoZQ5OZUyDSe2H/i
         BmYXSGqenEn45g6MooHLWBLMDRAhn7zMUFDbTxUAzrUVOcZhJxyPAz5HI25B851nZC3I
         KeM2GOdbK5bd0sqpGiUeMExMlR+wO4nhIH1vqqxtY99UUuR4jb5R8gGHWJf7/wTXbU5i
         gi41F4+xDO4KvEV9kITYxnCCMSLDKOcPqtNqqnq/WZscwp+ZssEopZJd1RjfXVHhiFku
         TMs8vj9o3FoJ9rdND3zuqtcNNWq/C4g7VxP2vWlJITWiN0mHJlb43Vg4BmdzFnXvlPrV
         j4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010862; x=1786615662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jkdh6VKlKFhlDrgR60RC1avyqfvhVLkmPkcfqFabPg=;
        b=rjLLssEQDg7a9JH9KABfKGvFuamgoHH5fOPj6dw/18r2sOjaTpeDIGjhFSlz3bo6Zv
         13iXXzXXoftaEljPSoVn8rTwWXHtdavEvxE7WASnq8PjtcPemxyMBF7+MqRJkZct3dNp
         N4X8gWUqmEO3s6FCYOIaN8yj5+PtHHhbYYV0y/327Y9qgb27TWqu8fFTgO6FZ9j87xtA
         3RuehcmUcebd/iaT9vmVezjqls2fCNLRT6jGuqyL41Lt1zYXLUgS55X1KPAYJVp2aIza
         uUZ2PFb5Tz5FyPBBUyd8eBWWX2ZkIcuj2i990zOtUyzKCi6NssDWlXLZXatC7OO3dm8d
         vDYg==
X-Forwarded-Encrypted: i=1; AHgh+RoU4eLKZATQSrvmfwg+V+2jmogOPL1vq7e49uta5WkqFCKTCMXuBnFgePu34ZRS0QCzzYbFiw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/Dot59Es/No0/qlTkg6h8xCgFFZH6iPdkxkC8ssWjnGJNIIip
	ErTZHmRkmeRD2kJ2uDE/8wAgXuS1SAny8FTwsU177EiI9U59QIP+wdgb
X-Gm-Gg: AR+sD11g08Ekk4f90ilAMJM3q3JbZ1aa8eTPCoo0MtK/KZoAHQhIXTM65SLnzMhk0wg
	d7BGLUI9+NIqtdOk7qzkBPtl6Ng/5XDAnSFLUZCz88Gqogdd4FmYCph68WXjcjfWYbHrivlLtXE
	ZtfvdJDc2xiMl9Qs39OtEBXHuR7PEaAG01Lv6qewwiV2oFf5TIbplRV5dBqMDtY6ykwvUBqVKrw
	uX57jIMFqht7PuFYJXtbDMXEtf4+C1YFcHOnnWE15mIDGZ4Qm44xM5jCDJHIRHNqaawTXExEzI+
	9wSuo3l+KKDS9q4cgm5ss1zTtxANVZlukVq1mg+nJwz1d2nbwRMbhVqe5IKofGLpZYHf6pd0lTX
	BXXvP9/GDFKZn5ttRTGkxMx2jagpwgGJ42x3IFGXhtsT5C2QoylxLa0lv5BGPtBdUB+ZberEUxN
	2vIXU3wMws+0iYAZ17I9rgM6ZHJDwRByGEVGJXSDa6NH9pLNNkf7TE3Idy4qGmSdEzGo4uS5jfs
	ynFR5Qzez/bbtJJl//b3eKxppCsTtmScI/n44b/DjzkDLh8hskcuYCny1bnuXrSFp8MOvtarifq
	kTVbXI9YLGHGBQ==
X-Received: by 2002:a05:6000:200f:b0:46f:7d90:8124 with SMTP id ffacd0b85a97d-47fec528a60mr10218590f8f.2.1786010861910;
        Thu, 06 Aug 2026 03:07:41 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a718bsm5427264f8f.5.2026.08.06.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:07:41 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org (open list:LIVE UPDATE),
	linux-kernel@vger.kernel.org (open list:LIVE UPDATE),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Cc: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: [PATCH] mm/memfd_luo: use real folio index in retrieve error logs
Date: Thu,  6 Aug 2026 14:05:39 +0400
Message-ID: <20260806100543.138902-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_030744_845546_98393A94 
X-CRM114-Status: GOOD (  11.07  )
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

From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>

memfd_luo_retrieve_folios() logs "folio index %ld" on its error paths
but passes the loop counter 'i' instead of the folio's actual index
held in the local 'index' variable (pfolio->index).

Pass 'index' to the three pr_err() calls so the logged index matches
the folio that actually failed. Since the saved index is a u64, use %llu with an
unsigned long long cast when printing it.

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
---
 mm/memfd_luo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..652dd21e6ef0 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -451,16 +451,16 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 		err = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
 		if (err) {
-			pr_err("shmem: failed to charge folio index %ld: %d\n",
-			       i, err);
+			pr_err("shmem: failed to charge folio index %llu: %d\n",
+			       (unsigned long long)index, err);
 			goto unlock_folio;
 		}
 
 		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
 					      mapping_gfp_mask(mapping));
 		if (err) {
-			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
-			       i, err);
+			pr_err("shmem: failed to add to page cache folio index %llu: %d\n",
+			       (unsigned long long)index, err);
 			goto unlock_folio;
 		}
 
@@ -472,8 +472,8 @@ static int memfd_luo_retrieve_folios(struct file *file,
 		npages = folio_nr_pages(folio);
 		err = shmem_inode_acct_blocks(inode, npages);
 		if (err) {
-			pr_err("shmem: failed to account folio index %ld(%ld pages): %d\n",
-			       i, npages, err);
+			pr_err("shmem: failed to account folio index %llu(%ld pages): %d\n",
+			       (unsigned long long)index, npages, err);
 			goto remove_from_cache;
 		}
 
-- 
2.52.0


