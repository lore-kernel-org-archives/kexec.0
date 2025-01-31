Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBC5C0218F
	for <kexec@archiver.kernel.org>; Fri, 31 Jan 2025 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qAdUnNKmBH1eKv3zgMFklMhoIriu1ZAuWX2RsAtfbDE=; b=DpH6PMj0yACWWgMbhv3XHCgL9W
	yPW4lw2cGTWUSbEgm+fY+N38UqTzbdxmbKLzeeS1G8kCDeiK3Ug5ycoarn7YZ33yztbDgkARNw9jj
	HLXQy6vOHjb8o3x7+4jIhl46VRUsfqtIRZaTLSIiyneJr65b+beDec0qeWxpQWAy+h8CNkYXi/apK
	w87TPasPuiqLYSBg/JGnSWQExjcUsGMmY2iBzmlS6c3aTGJC7cCSmis6OxAspsj9J/9+MhUmO4r90
	faAlIg0KAOkCj3TGXI7vnivy84iS4QpJJesHeyq5leHERgE9zJpAvH+pIofDDYP5749bira5b5wns
	Wa/wA7+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpXP-0000000AY87-2xFG;
	Fri, 31 Jan 2025 11:50:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpMd-0000000AWYm-1jti
	for kexec@lists.infradead.org;
	Fri, 31 Jan 2025 11:39:12 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OKQG021890;
	Fri, 31 Jan 2025 11:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qAdUnNKmBH1eKv3zg
	MFklMhoIriu1ZAuWX2RsAtfbDE=; b=HM/35rfqlHU2vseFhpgc4IVCrAui7Kx3r
	YnJMJKpHHuxgOyVHg1NqRuiku6vzVOO3OeQ94BEFBI9uNcOUxzj58LDoYLyP472r
	ZbTRUm9ArmoRxvlqdWrcf9In6Lzfdo6fHAgpRZwIH2U/q7P5RXlorg2ZDZCNecAV
	/nB78JaZy+BESnIl/MbOPh/4EAKIxCRWSZMHiOL9M80VB7vYgBSzWUanvcO1GHaW
	jfoWWnP/RWPqwTu2gezAnhuSjjgoWnK5wA8YzVKKmCL+rxOFW0rX2XjRRXAIYQEB
	R6PmksqLHc2whXahcsUhkyGv1ywbLTeFiyoe8TkX0DTLPheNp9pQg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gnby9ygm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 11:39:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V8BIPM017237;
	Fri, 31 Jan 2025 11:39:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gfaybb3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 11:39:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VBd0jd55116062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 11:39:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1659D20104;
	Fri, 31 Jan 2025 11:39:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 332AD20101;
	Fri, 31 Jan 2025 11:38:57 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.16.21])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 11:38:56 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] powerpc/crash: Use generic APIs to locate memory hole for kdump
Date: Fri, 31 Jan 2025 17:08:27 +0530
Message-ID: <20250131113830.925179-5-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131113830.925179-1-sourabhjain@linux.ibm.com>
References: <20250131113830.925179-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PMa6BNvwUSUAVmJqHQ-Fr_m_B2jzuPuU
X-Proofpoint-GUID: PMa6BNvwUSUAVmJqHQ-Fr_m_B2jzuPuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_033911_572632_886EE148 
X-CRM114-Status: GOOD (  26.22  )
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
components, PowerPC has its own set of APIs to locate holes in the
crashkernel memory for loading kexec segments for kdump. However, for
loading kexec segments in the kexec case, PowerPC already uses generic
APIs to locate holes.

The previous patch in this series, titled "crash: Let arch decide usable
memory range in reserved area," introduced arch-specific hook to handle
such special regions in the crashkernel area. So, switch PowerPC to use
the generic APIs to locate memory holes for kdump and remove the
redundant PowerPC-specific APIs.

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
 2 files changed, 13 insertions(+), 252 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 270ee93a0f7d..8d9d20e0b02b 100644
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
-- 
2.48.1


