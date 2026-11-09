Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE04606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ef3RSPV0;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=OlgkO6OZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Uj9rpq6NO7gzpBiYRUl6Mtox+W43apz9DjS7lO60lsw=; b=Ef3RSPV02OSAZxECCflm3UBPNL
	CtSbPdoYSknPMSZwW6Mrx+z+hvuVr2Ub6AoIrtc2DE79KdplNhulzLk0C1EnQp5zyoW0uPIKkFzkn
	i1qC4dDiwSvnfHATCWRnPKKjuFdEnOjTkmrJSSL9fbPkdtzKCIvlrZj8wrDCPlws9QNnjb+CIdpJ/
	ik/Xh6RPez5mExaUkjrafhfHLssYwbGAw1mLlyztKxgTNiPFGEYUKxIBjYZzDZA9y1Y3H3OL4+Pla
	4kXOTE8UaehSVI4tNc8WHIojZ8GtNZ0bqKNs1j9Hswsu74YB56YJfdcxZfsPeJu9gWGTS4UAamXJw
	0xa0UyQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQV3o-00000001Y8e-0CFx;
	Mon, 09 Nov 2026 19:29:44 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQV3l-00000001Y7S-0M8y
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 19:29:42 +0000
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9J2LTc2738081;
	Mon, 9 Nov 2026 11:29:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=Uj9rpq6NO
	7gzpBiYRUl6Mtox+W43apz9DjS7lO60lsw=; b=OlgkO6OZhWtvcabXDYaSe95Ja
	wS9Fe0kV46Rz+qGiX8tUaZglwbJhTj6Hw1cq07iitNouFxXTM1s0V7dNJMh0aD0/
	NsKTEj5agud/u591c8SD5PrIO7KLLWCXelEGFF4BxyIZ9YgJ7sxI/nDQTDOe5/PJ
	t2vCYFD8UXcfyFcCOAwyB3JeUzOXaTBCHxTNJYQ8QPNzdi6E2ACqWXj+s1bi/R8p
	LhhAjUE2eKQEyxwFa4kQr9J05ebNdZI+XRyV5EZjv5LzfdinTETPw5Unqaf9gBSe
	FBvYLMoKZIj8f0DYSAnXuoGcSOA+Z12MzA953eBFGNilMTDOZNIPK3Jg1D5ZA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4htsfqr468-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 09 Nov 2026 11:29:36 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 9 Nov
 2026 19:29:34 +0000
From: Yenda Li <yuandali@meta.com>
To: <kexec@lists.infradead.org>, Kazuhito Hagio <k-hagio-ab@nec.com>
CC: YAMAZAKI Masamitsu <m-yamazaki2@nec.com>, Tao Liu <ltao@redhat.com>,
        "Yenda Li" <yuandali@meta.com>
Subject: [PATCH makedumpfile] Avoid a bitmap write per page in exclude_zero_pages_cyclic()
Date: Mon, 9 Nov 2026 11:28:08 -0800
Message-ID: <20261109192811.1367226-1-yuandali@meta.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iibFhfRW17ukBXuJ11l3T663p3FR0XvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NyBTYWx0ZWRfX+Xxp7urrtqxZ
 qwBxVygt4PbazKgzU3+tR+2EfJbBRg9embFZtV9E336SxIIgNCq16p/xIda0SCkrmRxlfsWyzHo
 upEYigNNO+56TAJ6Cj9ue0aI+NVDkapsE0kpU+RXWwetPlBkFETXuaSZR0JyBXtVgFimgcK/YBx
 q8R3xrCIjQhnkyFN3qOZyO3cEj7sirLIQxuPka7HD3W6AzqN7hBCxr8E77E+DUa5slP9QiLLjnj
 6anL0gh1tZJkQrUBzOLiFRw/+2LCIPEnpjVUAci6PgWm1krrfheR5j/T85Mx15O1uIxW3Ceazvx
 Q/1hGVyroO/9EA/zNfDYYZSXNd/lNrQkPe/Nn/frhEIQ1emOiTSygsnHTFNhK6MEmX8UQkI7SU7
 nAJ58AA/JjjXklQylzdr2dKM6ybmyhs/QjKX2sc0JHT79gXAwetE9xugP07aRtokU4XM4sUJgJW
 NvDpAJAjEYu29sZ1p2Q==
X-Authority-Analysis: v=2.4 cv=XKul2ghE c=1 sm=1 tr=0 ts=6af21f20 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=aNFsSRD0UWZUxFVJxTEA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: iibFhfRW17ukBXuJ11l3T663p3FR0XvQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NyBTYWx0ZWRfX6ZofRmSenXDM
 PsblSEgnFuG4YeHlYJKXBLE1lpuj5l7DO5OY408wB5i3sDTjFpCHpSIK5aSU/GHt68UuWUiOL8n
 a6Q+nKhCOgkFI/6YmAaOrkrtZGAUc4A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_112941_148419_9B491880 
X-CRM114-Status: GOOD (  16.44  )
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

When the bitmaps are file-backed (non-cyclic mode, e.g. with
--work-dir), exclude_zero_pages_cyclic() calls sync_2nd_bitmap() for
every pfn in a PT_LOAD segment before is_dumpable().  Each call does an
lseek() and a 4 KiB write() of the current bitmap block, even when the
block has not changed.  Creating an ELF dump with zero-page exclusion
therefore makes one 4 KiB write() per page of memory: about 268 million
write() calls, 1 TiB in total, on a 1 TiB machine.

The sync is only needed when is_dumpable_file() is about to load a
different block into the shared buffer, which would otherwise drop the
bits cleared by clear_bit_on_2nd_bitmap() in the current block.  Use
the condition is_dumpable_file() itself uses to decide to reload, and
sync only then.  The last dirty block is still written by the
sync_2nd_bitmap() call that follows exclude_zero_pages_cyclic() in
create_2nd_bitmap().

Measured on a 2 GiB x86_64 guest image with
"-E --message-level 31 -d 31 --work-dir=DIR" (bitmap file on btrfs,
warm page cache), median of 10 runs each:

                          before        after
  wall time               552 ms        100 ms
  write() to bitmap file  524,353       81
  kernel instructions     3.71G         0.27G

The dump file and the final bitmap were byte-identical before and
after.

On a 256 GiB AMD EPYC server, in the kdump kernel with 4 CPUs and the
same options, makedumpfile took 22.7 s instead of 99.5 s, and the
zero-page pass took 2.1 s instead of 75.9 s.  These were two different
crashes of the same machine, with makedumpfile 1.7.9 before and after
applying this change; the function is identical in 1.8.0.

Dumps that keep the bitmaps in memory (cyclic mode) and the
kdump-compressed formats are not affected.

The problem was found, and this change drafted, with the help of an AI
coding assistant (Claude Code), which profiled makedumpfile with perf
and strace and proposed the fix.  I reviewed the change and tested it
as described above.

Fixes: 679a818f7716 ("[PATCH 07/13] Integrate filtering process for ELF path.")
Signed-off-by: Yenda Li <yuandali@meta.com>
---
 makedumpfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b21917b..c017eca 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6317,7 +6317,14 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 		if (!is_in_segs(paddr))
 			continue;
 
-		if (!sync_2nd_bitmap())
+		/*
+		 * is_dumpable() rereads the bitmap block from the bitmap file
+		 * when pfn is in another block, which would drop the bits
+		 * cleared below.  Write the block back only then: syncing for
+		 * every pfn costs one lseek() and one 4 KiB write() per page.
+		 */
+		if ((pfn == 0 || info->bitmap2->no_block != pfn / PFN_BUFBITMAP)
+		    && !sync_2nd_bitmap())
 			goto out_error;
 
 		if (!is_dumpable(info->bitmap2, pfn, cycle))
-- 
2.53.0-Meta


