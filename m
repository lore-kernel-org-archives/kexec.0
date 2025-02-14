Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB7FC021A4
	for <kexec@archiver.kernel.org>; Fri, 14 Feb 2025 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FjT8dSaAT+lOi/YMEolFGYFqGJzx8VOdPbUby3MGc6M=; b=QpmUpsPWtubR3k16Fn0gV4m0Gq
	wDzgACXdObjK3tIHN0mhEw1D5ZMyd3xmZ8khhISXJb27+Q/LsTt3QYH8dzRbAo1H1/YVCdCXOqNCR
	myEZ5i5IRbScxEBmWM3fOypqNGwDDvwrAm44frlIcAhWw+7xGkq+codHfnIErpyeSOFwT6WdO8M5l
	h4Zw/LnlVYEOuhf9u7RPjr2KHQdht4cFtQoQrELYtkn4YAXJVs5QgT+cQhqdXUpcxnm39wLuszrSH
	WxN6S45yRNxMh8/kBYGcV81w899u8HwYU5YgBDJ69WWZ8hxYdc9pFQEGWlewC4dQRR4UqDJSoF0Af
	3jeF9uYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tivDW-0000000EtDC-2kA9;
	Fri, 14 Feb 2025 12:54:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tivD0-0000000Et92-2CJ0
	for kexec@lists.infradead.org;
	Fri, 14 Feb 2025 12:54:19 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAPt9H000666;
	Fri, 14 Feb 2025 12:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FjT8dSaAT+lOi/YMEolFGYFqGJzx8VOdPbUby3MGc
	6M=; b=FaAzXhG6jighwx/li5GEt566XZkWqYU+oFNuTzHc+Wocu9L2NFfIReCES
	nm8A6EfvWFz2GUtWlXL15i3A16w2MdXljcaBliVlSDYChMYUAhe+Bhho44tN0t/4
	+d9n3AJgDoPr7rGYSnTX5VPbf7mXJA8t6cV+ymfGOXFZTyjEWel5g4PODMZ3MMEQ
	nhgROOwgGJIUxl3kpW7a5DpTJI9+iUgRZYLeRQmap+2bSPSUEI70kFobRt4nnBEw
	dRD67fyqZu4rUnFkapGf+xrCI785ZZuGfnrUhaGlgAdFwH5/99K5PMuUVXGpZzaS
	u8Snu4Ey+sicoCGQ8fR4OShgsf4fw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvab9b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:54:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E8vDDF028667;
	Fri, 14 Feb 2025 12:54:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma23732-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:54:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ECs7HW42926508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:54:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D812920043;
	Fri, 14 Feb 2025 12:54:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E647C20040;
	Fri, 14 Feb 2025 12:54:04 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.78.252])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 12:54:04 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: akpm@linux-foundation.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.com>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: Fix kexec_locate_mem_hole() for missing CONFIG_KEXEC_HANDOVER
Date: Fri, 14 Feb 2025 18:24:02 +0530
Message-ID: <20250214125402.90709-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ERu89rXI1toBcblDuM23P6X9jJATPNiB
X-Proofpoint-ORIG-GUID: ERu89rXI1toBcblDuM23P6X9jJATPNiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=777 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250214_045418_566965_B99909A7 
X-CRM114-Status: GOOD (  16.24  )
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

While adding KHO support, commit 7d128945e003 ("kexec: add KHO support
to kexec file loads") returns early from kexec_locate_mem_hole() if
CONFIG_KEXEC_HANDOVER is not defined.

Due to this, kexec_locate_mem_hole() does not locate a hole for the
kexec segment, and kbuf.mem holds 0x0. This leads to a kexec_file_load
syscall failure in sanity_check_segment_list(). This impacts both
kexec and kdump kernels.

Without this patch included:
----------------------------
kexec --initrd=initrd.img ./vmlinuz --append="`cat /proc/cmdline`" -lsd
Try gzip decompression.
Try LZMA decompression.
[   59.745154] kexec_file: kernel: 000000003473b9a0 kernel_size: 0x2cdacf0
[   59.753713] ima: kexec measurement buffer for the loaded kernel at 0x0.
[   59.753759] kexec_elf: Loaded the kernel at 0x0
[   59.753777] kexec_elf: Loaded purgatory at 0x0
[   59.753783] kexec_elf: Loaded initrd at 0x0
[   59.758657] kexec_elf: Loaded device tree at 0x0
syscall kexec_file_load not available.

With this patch included:
-------------------------
kexec --initrd=initrd.img ./vmlinuz --append="`cat /proc/cmdline`" -lsd
Try gzip decompression.
Try LZMA decompression.
[  112.091308] kexec_file: kernel: 000000009eb0432d kernel_size: 0x2cdacf0
[  112.099881] ima: kexec measurement buffer for the loaded kernel at 0x3fd9c0000.
[  112.099935] kexec_elf: Loaded the kernel at 0x2f60000
[  112.099953] kexec_elf: Loaded purgatory at 0x3fd9b0000
[  112.099969] kexec_elf: Loaded initrd at 0x5eb0000
[  112.104993] kexec_elf: Loaded device tree at 0x3fd650000
[  113.484422] kexec_file: nr_segments = 5
[  113.484452] kexec_file: segment[0]: buf=0x00000000b6970fc9 bufsz=0x82 mem=0x3fd9c0000 memsz=0x10000
[  113.484473] kexec_file: segment[1]: buf=0x00000000cabe3fe7 bufsz=0x2cc9ca4 mem=0x2f60000 memsz=0x2f50000
[  113.489144] kexec_file: segment[2]: buf=0x00000000deec4aaf bufsz=0x310 mem=0x3fd9b0000 memsz=0x10000
[  113.489195] kexec_file: segment[3]: buf=0x0000000081960708 bufsz=0x581a9c6 mem=0x5eb0000 memsz=0x5820000
[  113.498768] kexec_file: segment[4]: buf=0x00000000c1be9ac7 bufsz=0x6632 mem=0x3fd650000 memsz=0x10000
[  113.498819] kexec_file: kexec_file_load: type:0, start:0x3fd9b0000 head:0x5f1c0002 flags:0x8

To fix this, return 1 from kexec_locate_mem_hole() in kexec_internal.h.
This ensures that kexec_locate_mem_hole() locates a memory hole if
CONFIG_KEXEC_HANDOVER is not defined.

Note: The kexec tool printing "kexec_file_load not available" does not
necessarily mean that the kernel lacks support for the kexec_file_load
syscall. Instead, it occurs because multiple errors are handled under
the same condition.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Closes: https://lore.kernel.org/all/8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com/
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Rebased on top of next-20250213

---
 kernel/kexec_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index c535dbd3b5bd..66ce6872fda1 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -50,7 +50,7 @@ int kho_fill_kimage(struct kimage *image);
 static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 				      int (*func)(struct resource *, void *))
 {
-	return 0;
+	return 1;
 }
 
 static inline int kho_fill_kimage(struct kimage *image) { return 0; }
-- 
2.48.1


