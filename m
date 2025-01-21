Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF89C0218D
	for <kexec@archiver.kernel.org>; Tue, 21 Jan 2025 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TEOsjd0kOfsKjU6sQKsR5plpv3P+yDUOpn9HqWpc7cA=; b=bIr1It1vEYzGOH86iyLiVfpGus
	l0hXNIYw/cOp5ftN4JLiFoVHFMrlSJ7TMXZ3WL+iE5MnsohZSAfseijheMD/Wb5ur1N+Rh39rLXtJ
	X1nROKSpEfG17h1srXibUG1YF3iud84iKteZtxORbXpAyRkgG2yE3SMmr32oSK2VduoyKWrenldA9
	U2EfEgPm9dRmGsfGqeoAieru8Q/ECQenvhM1eRFW/gtQoxkAbZXKWwd3xDfpMv3pn1cNEPq90Pj85
	nUwsZhEK4yNroa7zf8OyhO3jQyllONcXDafcM/oIGsbH6OYByJJjLByRIYkDFVpqjJpq58JgMuwQO
	z3JQPqZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taCqs-00000007nYR-3HsY;
	Tue, 21 Jan 2025 11:55:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taCqq-00000007nVD-0TE3
	for kexec@lists.infradead.org;
	Tue, 21 Jan 2025 11:55:25 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L20r90003876;
	Tue, 21 Jan 2025 11:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TEOsjd0kOfsKjU6sQ
	KsR5plpv3P+yDUOpn9HqWpc7cA=; b=NjcELZ0wEBwvM9KR0Thwo/TP78WgpPLWB
	Wc444RChwANsWPsMc5vTp2ovNypawzDfv74BFXFgdx8p42M+SUP+kxtujXPqZSy3
	MzCniyUqnJyXulKJnfKq1bwAvrd6PPJvXnoKgk7s2A/Hq8pimUo9Oa6Rd913bK/E
	RpBSspetFs2Uj2/NHCrD3/nBbpjZ1Q6dO8rkEk+kPXb41ioZ2EDuKE8HURWJsapa
	KMOePOWGqBU+47GWPZCS8VgYsnS8LmpM+6ysji2fw8OOPhx89yBtUthcQvN/QEoT
	qVBnpBRfWXKBhAeBpqIrjjDxWIxnvVM1Y73bvdkuf1tuf/7U675Uw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44a2dyabcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:55:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50LAPPpG029594;
	Tue, 21 Jan 2025 11:55:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnayr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:55:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50LBtCse62259546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 11:55:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 760B52004B;
	Tue, 21 Jan 2025 11:55:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B87B20040;
	Tue, 21 Jan 2025 11:55:09 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.54.128])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jan 2025 11:55:09 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] crash: option to let arch decide mem range is usable
Date: Tue, 21 Jan 2025 17:24:42 +0530
Message-ID: <20250121115442.1278458-7-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r4yBdaaAIm9mwvVi3LINExR4QewaPzip
X-Proofpoint-ORIG-GUID: r4yBdaaAIm9mwvVi3LINExR4QewaPzip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501210095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_035524_278860_EE7F84DE 
X-CRM114-Status: GOOD (  29.60  )
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

On PowerPC, the memory reserved for the crashkernel can contain
components like RTAS, TCE, OPAL, etc., which should be avoided when
loading kexec segments into crashkernel memory. Due to these special
components, PowerPC has its own set of functions to locate holes in the
crashkernel memory for loading kexec segments for kdump. However, for
loading kexec segments in the kexec case, PowerPC uses generic functions
to locate holes.

So, let's use generic functions to locate memory holes for kdump on
PowerPC by adding an arch hook to handle such special regions while
loading kexec segments, and remove the PowerPC functions to locate
holes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h  |   6 +-
 arch/powerpc/kexec/file_load_64.c | 259 ++----------------------------
 include/linux/kexec.h             |   9 ++
 kernel/kexec_file.c               |  12 ++
 4 files changed, 34 insertions(+), 252 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 64741558071f..5e4680f9ff35 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -95,8 +95,10 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 
-int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
-#define arch_kexec_locate_mem_hole arch_kexec_locate_mem_hole
+int arch_check_excluded_range(struct kimage *image, unsigned long start,
+			      unsigned long end);
+#define arch_check_excluded_range  arch_check_excluded_range
+
 
 int load_crashdump_segments_ppc64(struct kimage *image,
 				  struct kexec_buf *kbuf);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index dc65c1391157..e7ef8b2a2554 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -49,201 +49,18 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
 
-/**
- * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
- *                              in the memory regions between buf_min & buf_max
- *                              for the buffer. If found, sets kbuf->mem.
- * @kbuf:                       Buffer contents and memory parameters.
- * @buf_min:                    Minimum address for the buffer.
- * @buf_max:                    Maximum address for the buffer.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
-				      u64 buf_min, u64 buf_max)
-{
-	int ret = -EADDRNOTAVAIL;
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range_rev(i, &start, &end) {
-		/*
-		 * memblock uses [start, end) convention while it is
-		 * [start, end] here. Fix the off-by-one to have the
-		 * same convention.
-		 */
-		end -= 1;
-
-		if (start > buf_max)
-			continue;
-
-		/* Memory hole not found */
-		if (end < buf_min)
-			break;
-
-		/* Adjust memory region based on the given range */
-		if (start < buf_min)
-			start = buf_min;
-		if (end > buf_max)
-			end = buf_max;
-
-		start = ALIGN(start, kbuf->buf_align);
-		if (start < end && (end - start + 1) >= kbuf->memsz) {
-			/* Suitable memory range found. Set kbuf->mem */
-			kbuf->mem = ALIGN_DOWN(end - kbuf->memsz + 1,
-					       kbuf->buf_align);
-			ret = 0;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-/**
- * locate_mem_hole_top_down_ppc64 - Skip special memory regions to find a
- *                                  suitable buffer with top down approach.
- * @kbuf:                           Buffer contents and memory parameters.
- * @buf_min:                        Minimum address for the buffer.
- * @buf_max:                        Maximum address for the buffer.
- * @emem:                           Exclude memory ranges.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int locate_mem_hole_top_down_ppc64(struct kexec_buf *kbuf,
-					  u64 buf_min, u64 buf_max,
-					  const struct crash_mem *emem)
+int arch_check_excluded_range(struct kimage *image, unsigned long start,
+			      unsigned long end)
 {
-	int i, ret = 0, err = -EADDRNOTAVAIL;
-	u64 start, end, tmin, tmax;
-
-	tmax = buf_max;
-	for (i = (emem->nr_ranges - 1); i >= 0; i--) {
-		start = emem->ranges[i].start;
-		end = emem->ranges[i].end;
-
-		if (start > tmax)
-			continue;
-
-		if (end < tmax) {
-			tmin = (end < buf_min ? buf_min : end + 1);
-			ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
-			if (!ret)
-				return 0;
-		}
-
-		tmax = start - 1;
-
-		if (tmax < buf_min) {
-			ret = err;
-			break;
-		}
-		ret = 0;
-	}
-
-	if (!ret) {
-		tmin = buf_min;
-		ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
-	}
-	return ret;
-}
-
-/**
- * __locate_mem_hole_bottom_up - Looks bottom up for a large enough memory hole
- *                               in the memory regions between buf_min & buf_max
- *                               for the buffer. If found, sets kbuf->mem.
- * @kbuf:                        Buffer contents and memory parameters.
- * @buf_min:                     Minimum address for the buffer.
- * @buf_max:                     Maximum address for the buffer.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int __locate_mem_hole_bottom_up(struct kexec_buf *kbuf,
-				       u64 buf_min, u64 buf_max)
-{
-	int ret = -EADDRNOTAVAIL;
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end) {
-		/*
-		 * memblock uses [start, end) convention while it is
-		 * [start, end] here. Fix the off-by-one to have the
-		 * same convention.
-		 */
-		end -= 1;
-
-		if (end < buf_min)
-			continue;
-
-		/* Memory hole not found */
-		if (start > buf_max)
-			break;
-
-		/* Adjust memory region based on the given range */
-		if (start < buf_min)
-			start = buf_min;
-		if (end > buf_max)
-			end = buf_max;
-
-		start = ALIGN(start, kbuf->buf_align);
-		if (start < end && (end - start + 1) >= kbuf->memsz) {
-			/* Suitable memory range found. Set kbuf->mem */
-			kbuf->mem = start;
-			ret = 0;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-/**
- * locate_mem_hole_bottom_up_ppc64 - Skip special memory regions to find a
- *                                   suitable buffer with bottom up approach.
- * @kbuf:                            Buffer contents and memory parameters.
- * @buf_min:                         Minimum address for the buffer.
- * @buf_max:                         Maximum address for the buffer.
- * @emem:                            Exclude memory ranges.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int locate_mem_hole_bottom_up_ppc64(struct kexec_buf *kbuf,
-					   u64 buf_min, u64 buf_max,
-					   const struct crash_mem *emem)
-{
-	int i, ret = 0, err = -EADDRNOTAVAIL;
-	u64 start, end, tmin, tmax;
-
-	tmin = buf_min;
-	for (i = 0; i < emem->nr_ranges; i++) {
-		start = emem->ranges[i].start;
-		end = emem->ranges[i].end;
-
-		if (end < tmin)
-			continue;
-
-		if (start > tmin) {
-			tmax = (start > buf_max ? buf_max : start - 1);
-			ret = __locate_mem_hole_bottom_up(kbuf, tmin, tmax);
-			if (!ret)
-				return 0;
-		}
-
-		tmin = end + 1;
+	struct crash_mem *emem;
+	int i;
 
-		if (tmin > buf_max) {
-			ret = err;
-			break;
-		}
-		ret = 0;
-	}
+	emem = image->arch.exclude_ranges;
+	for (i = 0; i < emem->nr_ranges; i++)
+		if (start < emem->ranges[i].end && end > emem->ranges[i].start)
+			return 1;
 
-	if (!ret) {
-		tmax = buf_max;
-		ret = __locate_mem_hole_bottom_up(kbuf, tmin, tmax);
-	}
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_CRASH_DUMP
@@ -1004,64 +821,6 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
 	return ret;
 }
 
-/**
- * arch_kexec_locate_mem_hole - Skip special memory regions like rtas, opal,
- *                              tce-table, reserved-ranges & such (exclude
- *                              memory ranges) as they can't be used for kexec
- *                              segment buffer. Sets kbuf->mem when a suitable
- *                              memory hole is found.
- * @kbuf:                       Buffer contents and memory parameters.
- *
- * Assumes minimum of PAGE_SIZE alignment for kbuf->memsz & kbuf->buf_align.
- *
- * Returns 0 on success, negative errno on error.
- */
-int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
-{
-	struct crash_mem **emem;
-	u64 buf_min, buf_max;
-	int ret;
-
-	/* Look up the exclude ranges list while locating the memory hole */
-	emem = &(kbuf->image->arch.exclude_ranges);
-	if (!(*emem) || ((*emem)->nr_ranges == 0)) {
-		pr_warn("No exclude range list. Using the default locate mem hole method\n");
-		return kexec_locate_mem_hole(kbuf);
-	}
-
-	buf_min = kbuf->buf_min;
-	buf_max = kbuf->buf_max;
-	/* Segments for kdump kernel should be within crashkernel region */
-	if (IS_ENABLED(CONFIG_CRASH_DUMP) && kbuf->image->type == KEXEC_TYPE_CRASH) {
-		buf_min = (buf_min < crashk_res.start ?
-			   crashk_res.start : buf_min);
-		buf_max = (buf_max > crashk_res.end ?
-			   crashk_res.end : buf_max);
-	}
-
-	if (buf_min > buf_max) {
-		pr_err("Invalid buffer min and/or max values\n");
-		return -EINVAL;
-	}
-
-	if (kbuf->top_down)
-		ret = locate_mem_hole_top_down_ppc64(kbuf, buf_min, buf_max,
-						     *emem);
-	else
-		ret = locate_mem_hole_bottom_up_ppc64(kbuf, buf_min, buf_max,
-						      *emem);
-
-	/* Add the buffer allocated to the exclude list for the next lookup */
-	if (!ret) {
-		add_mem_range(emem, kbuf->mem, kbuf->memsz);
-		sort_memory_ranges(*emem, true);
-	} else {
-		pr_err("Failed to locate memory buffer of size %lu\n",
-		       kbuf->memsz);
-	}
-	return ret;
-}
-
 /**
  * arch_kexec_kernel_image_probe - Does additional handling needed to setup
  *                                 kexec segments.
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..407f8b0346aa 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -205,6 +205,15 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif
 
+#ifndef arch_check_excluded_range
+static inline int arch_check_excluded_range(struct kimage *image,
+					    unsigned long start,
+					    unsigned long end)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..fba686487e3b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -464,6 +464,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		/* Make sure this does not conflict with exclude range */
+		if (arch_check_excluded_range(image, temp_start, temp_end)) {
+			temp_start = temp_start - PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
@@ -498,6 +504,12 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		/* Make sure this does not conflict with exclude range */
+		if (arch_check_excluded_range(image, temp_start, temp_end)) {
+			temp_start = temp_start + PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
-- 
2.47.1


