Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3E8C88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 23:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uZE/najFT9R5zTEBz7Fhsb26kJqZDk8owuOeuq8Y1m4=; b=mz5jyZePOohiEtKsWZBiH8MKDi
	pXyvKzCNw8gKVdHd5S7IDZ7h8y/KrtPwvV8eEN5mUD42ZNJDG3tqGmJdtJLYtUsGAXUukQrcn3NzB
	1uuevj5Ru0DRMFGyRMVLxtvqbxz7iXSKpyQg32WBuKDTHwJAVqGe8iIffmMFgogiIUtJR5N0EIPTL
	5baFEtpDQBTfoMV5BMtVnNug7WARvFainwoqgsAC0Nnq+Zk/NaNCp1FMTtOhJ592Xji/O5qbBWSkS
	ZmJU0WaNvACTDQzhuMq605XI51geMyYCsQqeJjH0bpsFQXNf4EJ+u7IcKHDlBauI7FsM17APHmHzo
	U2tJWVwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6cnT-0000000854U-48hW;
	Tue, 15 Sep 2026 23:42:43 +0000
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6cnR-00000008545-386G
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 23:42:42 +0000
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMbZ9m2571673
	for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 19:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=uZE/najFT9R5zTEBz7Fhsb26kJ
	qZDk8owuOeuq8Y1m4=; b=Oe2VLdiGVsKZ19PvlL2qhCRXsxSeze/p+R148PoKqk
	JQU/6vxvqL+/5CyvNmq2sQGAWD8vVOmyvHNISYnC9p3ROhXQnEreUKiaMH5vYHrx
	kDhMOv8vW/a+eatdK895SrrI4ycPRWs5yTEjZ+BZil5/f+Nnk91NTJQhfRcyR9ji
	CNOZ+aL8PXpF6epP7fFhIzf6sBllao8JxnOoACzvuMLEG1MlsW9KUArXfFrVMdaV
	PA0luBiyaa6kC7X+G/Vvc7YO0fsSf1t1qeDAZ2qhGMXPYJV3xqsa/cPyVn8q1nuF
	EUK6AdtpUGXuLk6siHS6BHAraJD1j9x34g3Z/hUl5ELg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gqbwd9w6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 19:42:40 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53124d6a362so18682901cf.0
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789515759; x=1790120559; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uZE/najFT9R5zTEBz7Fhsb26kJqZDk8owuOeuq8Y1m4=;
        b=P5P4JfrQ7Slj7/EuflFlIJ3OFjBvj6OEFb5JXs7xUIDSdPf7yxY2HiMtNF9lvno68c
         gxTZqkihTlX3lhopeN5jlBrBNm9f9C1BXpiNm9fXH6nb7qkfD5rLeDedc+IgzCgC+x1t
         xfmKsIdiqgX1V1PbBmS7Nz7bRD+fEavhOqhZoaFiueQ7Sc/BqDsw4c6BAvFOWxbbo0ul
         IBOpYUMh7OjXqWmRfI/WJZhu2Uy6ablOZZpI9mPZQ3nv/9fgEQ05oKWzGp7PXOddM9A6
         BPs4eX/qUTB7hYg3HLyK28KlLqpGlAa10c3U4kFGWTd2QLwOVy4165ygNlqpT3pPEVqr
         NzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515759; x=1790120559;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uZE/najFT9R5zTEBz7Fhsb26kJqZDk8owuOeuq8Y1m4=;
        b=t2qETa3cyMtSVEVVonsz2v4DdUVJ2wtxrzR/UmuwH/ocNbsnH642RQlM5ufI6+JLGo
         O3CkpZxuzHHDEnoFqkrIxeF9qToTcG9YRgHJpWrdD690KDAuoKRcrUYQtNIZQj7v7f7D
         qGaEt6L1fD5iB72fremrBqdDoFrWA8LptkinrphUidlqsOv6+Ug7KjkDosgTLWmUKc3a
         jVi1GfnBv6Twn0UJbq6fYlt1uk6fHGu90UIo0oeMEZ0AlyOP2kHrJ7U8Z0rW4s5xQ3n2
         cV6CYHt8AdEAqcp4hRSUILIZtOGCotR/u5dzB5FjHLOfWCbivwzN+Mt9YO2kyXaSW58m
         vQ8w==
X-Forwarded-Encrypted: i=1; AKwUvBwSPkF56BF31FAZKY3nS7Za5BvB0iYZwAUJDLutRIm+NJIlOFMijtM0xXLSd8m+NB/DFCYdJg==@lists.infradead.org
X-Gm-Message-State: AFuF++nzDTEDlnz9EH5T3GHwN4gaX15OPlWAq5R3Vq4D8PdvOwcmotvR
	sis0pcbLHqt8273s46SD9+/SbtpZI4KCreeo9lhVRXV7Rt8afFoX1d4YElZ69SOXAe1/sVvIzpX
	pH8VNpf1PzDFOaL3s99KpiWu8t07lUfQR++2XMZh0ZWseo3T6UAs5kcE32A==
X-Gm-Gg: AYBFou1tQHWG62CdovU0yGb/EQOgluT+zv6RxIx2HN8rEAYqRwbM6mBjiNh9OObzhwQ
	fg8vFucIfRjW5qYzlon9Buiu1dvggczlNwlxKKxLlsoyyzb2gyiK7u+s7XdP/Fp0UNlopRAGVNA
	fztOscNKh4p3ZaqrXZZOSPgv/sC7L0DsnARotxnrUrP2YNMOsMX/Z7tqEjpE9sTvL/3QLdYk5du
	kuDGoLBk8PdIGmiZzCISDc4SYnHJqmNyKDO8DLSvaIgwzDwK5QXajaUl8Ry/PicLWfFsKYlxHcF
	LIPd7jHpeakNhb2qbB2h1Xkhyu719GqC8lnvl2Kn11L5uEcqq0mHv2HBKeFAqmV2UHwyYnvifHj
	AOJoy0c6ObFB5LPKr2684x7KZ1XI/b24mn3cLzPGD6swNXv4K
X-Received: by 2002:a05:622a:14d1:b0:516:e10f:7140 with SMTP id d75a77b69052e-5327f1aaad1mr8805311cf.35.1789515759174;
        Tue, 15 Sep 2026 16:42:39 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:516:e10f:7140 with SMTP id d75a77b69052e-5327f1aaad1mr8804961cf.35.1789515758797;
        Tue, 15 Sep 2026 16:42:38 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-179-204.net.columbia.edu. [128.59.179.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7f316sm11399396d6.25.2026.09.15.16.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:42:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 15 Sep 2026 19:42:15 -0400
Subject: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
X-B4-Tracking: v=1; b=H4sIANbXqWoC/yXMQQ6CMBBG4auQWTtJHQ2oVzEsoP4DY5CaFogJ4
 e5WWX6L91ZKiIZEt2KliMWShTHjeCjI983Yge2RTeKkdFdX8fLyIYK1mYeJNQwW+NyeLgKoSim
 Uw3eE2uc/vde709w+4affibbtC9g6lTh2AAAA
X-Change-ID: 20260907-vmcore-fault-folio-4b382eeff262
To: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789515757; l=2125;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dxg52INW+Mj6Q6Lb2jquqMFPjl6/Rh2+AATGon4TcZU=;
 b=vdxoyuEon/H05Tmo1Fpa9qQA+JGXLiAWR1tlAA1+IiA+X8bmd6jRJvtBx0LctZl43TGXziRTe
 +GTwRByLmR/A0o+4UaXDSlvV8ydx7axk3vRrDxpQ8p2sw2e06k6g4vx
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=JeEpPkKV c=1 sm=1 tr=0 ts=6aa9d7f0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=hXAsoc/zAxyCEdIRhrpmVw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=LFCUUKIxLatyyoosy-EA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 165x41kygfnh8XfsDNNs7sbc57FWy9l_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0NyBTYWx0ZWRfX76qF5Jt+CYBs
 O/d3YqNCnAcGYnSv43uornpHCDnUWpCNDQp+A4XuJMPzhCM2v8VdjK4ssX6DvI4RCs2J6pp+yYe
 62rBxzyxx4A/1FXc/NpaL6/fjIfDloT0m7UtLDgHrZ2bUu0HjPpjS1HCrULVcitwKq7HRK0rAn8
 sXREI/7m3W3IK+koHwH5kCiYmAoKM80ydKxnCU4xYakg10GhThOPWYFyHW8xtx0h6WPhsf33pTv
 S7M16eYmVAPVWylpA9w4MJK8WEdJSrN27MnUX69tWWaLaKWbqWtqA/iaPxKp0DCzooH+n7J+OLT
 MrnDcoWoNV5sK8vfB08GZ8YDVLRBsUctjJv680XRBYYvMuFXC1LXtqv2mzLY8PoJ1kTMiyXgPQB
 24xRWaYFflc4YD9VrIQa12wPDuhMPtP7mIy0Ee4RX0k12uhSzkbjnN7z0Nv8Qb6223U89CrcmLD
 C3BkL+fwUSx5ch3g68Q==
X-Proofpoint-GUID: 165x41kygfnh8XfsDNNs7sbc57FWy9l_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0NyBTYWx0ZWRfX0+fOhzfY7o4R
 Qm3VZoSscEj4uhpbJjtmKPydmOQy9xUlXJty/Al8DW4Kx2SZ5WE1m+E89ZmcJ/P6SGn3YiFQ17s
 2d0kNmXL6arMnYYMHGstlqRlM3thccG5K/2TKuOCCU6+UtTgvgPg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11906
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=10 adultscore=0
 impostorscore=10 malwarescore=0 bulkscore=10 suspectscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150347
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_164241_795838_E9A63D54 
X-CRM114-Status: GOOD (  15.85  )
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

Use a folio for the page cache page the s390 fault handler reads the
old kernel's memory into. This removes four compound_head() calls and
one of the last callers of find_or_create_page().

The vmcore mapping only has order-0 folios, so the logic is unchanged.

Compile tested for s390.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
This is based on the kexec-next branch of the liveupdate tree.
---
 fs/proc/vmcore.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 44d15436439f..2dc3803aa11d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -474,29 +474,30 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 	pgoff_t index = vmf->pgoff;
 	struct iov_iter iter;
 	struct kvec kvec;
-	struct page *page;
+	struct folio *folio;
 	loff_t offset;
 	int rc;
 
-	page = find_or_create_page(mapping, index, GFP_KERNEL);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
+	if (IS_ERR(folio))
 		return VM_FAULT_OOM;
-	if (!PageUptodate(page)) {
-		offset = (loff_t) index << PAGE_SHIFT;
-		kvec.iov_base = page_address(page);
-		kvec.iov_len = PAGE_SIZE;
-		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, PAGE_SIZE);
+	if (!folio_test_uptodate(folio)) {
+		offset = folio_pos(folio);
+		kvec.iov_base = folio_address(folio);
+		kvec.iov_len = folio_size(folio);
+		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, folio_size(folio));
 
 		rc = __read_vmcore(&iter, &offset);
 		if (rc < 0) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			return vmf_error(rc);
 		}
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	}
-	unlock_page(page);
-	vmf->page = page;
+	folio_unlock(folio);
+	vmf->page = folio_file_page(folio, index);
 	return 0;
 #else
 	return VM_FAULT_SIGBUS;

---
base-commit: 4d17a004cfd5489f88ad0a7a151dea11a533338b
change-id: 20260907-vmcore-fault-folio-4b382eeff262

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>


