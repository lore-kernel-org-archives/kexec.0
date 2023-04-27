Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CDAC77B7C
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hyf1t6z6dkikLycDrMaS5OPeSxSYjy9PrdUf15DuUKk=; b=CmPglppOVID9a8
	1QZQYJhwT3oT7Ni4xca8rOSs69/kiAHl7sfTh527JyR6iVVEwjZ1hZDzeKMnfbg8AUsty67DiM1GC
	hyMhDGnMCeTHOOmNm3XTj4LBPqVOf3nRN1la+q92i+0FA1SlkSa+KgzoFyj8iayrUPuDUIhaOk28f
	m0ikIZ4Ynuv2okUA4Tb5baj9GgD4sOJf3NKpHY9b6T6lnqZY0AEK6p2XLwwQPlbuJerrLqDqm0SGL
	NKVs1jDSd2m4E1YsPm/YuzMnkD1Mh5HupXkQxcBmbEUOE2FyrMJlJFmhGVVD5mDGpc8wnf9ciXWR1
	ZktbZBf6CXj8AeHk7y0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prpD7-0056bk-2j;
	Thu, 27 Apr 2023 00:10:09 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prpCy-0056SJ-3B
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 00:10:04 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx0jh015505;
	Thu, 27 Apr 2023 00:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=MfX2UCA2WLfnR/ast08TW20ISh9rczjU8Ar+dRs48HA=;
 b=GCWhljQNjE5AjIClKhqzHeKVW3z5kr5UBJP7HEDWHVPjD+xiaPJ2/5t9JZYlCLAGl/i7
 yvTMTaC3FGePZ3YrF4pTNY5ulz6nyTG1wx4O2xEl56aT+LOheMQ72F2eqB71yGtxnX33
 o/hrmAtnO3q1uFdVKVmX1jK+/8S2wrSpWAvtkAkE9A4H6AT9NupoiSiA9BPoU69PpeL1
 VoaJtJ2XB0hsW0yKsZDTdd1p+zgv2sLxe8Xm5EP2E3B7UpH96KL1y7cW/00QTYOxaYPR
 XXZ0vDADFP4dLfYAb/Ef7z3nTdE2ZfvilGGHVUfiEBjCMvZFLCCUdIorty/kdB5tRZZL RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460dampk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNBFC2007555;
	Thu, 27 Apr 2023 00:09:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938W013888;
	Thu, 27 Apr 2023 00:09:11 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-6;
	Thu, 27 Apr 2023 00:09:11 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 05/21] mm: PKRAM: implement byte stream operations
Date: Wed, 26 Apr 2023 17:08:41 -0700
Message-Id: <1682554137-13938-6-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.9.4
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270000
X-Proofpoint-GUID: oHWiWle6IkzwQxWZ4r-eqosGLrXgVc0t
X-Proofpoint-ORIG-GUID: oHWiWle6IkzwQxWZ4r-eqosGLrXgVc0t
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_171001_199754_AA659DE3 
X-CRM114-Status: GOOD (  28.47  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This patch adds the ability to save an arbitrary byte streams to a
a PKRAM object using pkram_write() to be restored later using pkram_read().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  11 +++++
 mm/pkram.c            | 123 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 130ab5c2d94a..b614e9059bba 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -14,10 +14,12 @@
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
  * @PKRAM_DATA_folios: obj contains folio data
+ * @PKRAM_DATA_bytes: obj contains byte data
  */
 enum pkram_data_flags {
 	PKRAM_DATA_none		= 0x0,	/* No data types configured */
 	PKRAM_DATA_folios	= 0x1,	/* Contains folio data */
+	PKRAM_DATA_bytes	= 0x2,	/* Contains byte data */
 };
 
 struct pkram_data_stream {
@@ -36,18 +38,27 @@ struct pkram_stream {
 
 	__u64 *folios_head_link_pfnp;
 	__u64 *folios_tail_link_pfnp;
+
+	__u64 *bytes_head_link_pfnp;
+	__u64 *bytes_tail_link_pfnp;
 };
 
 struct pkram_folios_access {
 	unsigned long next_index;
 };
 
+struct pkram_bytes_access {
+	struct page *data_page;		/* current page */
+	unsigned int data_offset;	/* offset into current page */
+};
+
 struct pkram_access {
 	enum pkram_data_flags dtype;
 	struct pkram_stream *ps;
 	struct pkram_data_stream pds;
 
 	struct pkram_folios_access folios;
+	struct pkram_bytes_access bytes;
 };
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 610ff7a88c98..eac8cf6b0cdf 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -44,6 +45,9 @@ struct pkram_link {
 struct pkram_obj {
 	__u64	folios_head_link_pfn;	/* the first folios link of the object */
 	__u64	folios_tail_link_pfn;	/* the last folios link of the object */
+	__u64	bytes_head_link_pfn;	/* the first bytes link of the object */
+	__u64	bytes_tail_link_pfn;	/* the last bytes link of the object */
+	__u64	data_len;	/* byte data size */
 	__u64	obj_pfn;	/* points to the next object in the list */
 };
 
@@ -138,6 +142,11 @@ static void pkram_truncate_obj(struct pkram_obj *obj)
 	pkram_truncate_links(obj->folios_head_link_pfn);
 	obj->folios_head_link_pfn = 0;
 	obj->folios_tail_link_pfn = 0;
+
+	pkram_truncate_links(obj->bytes_head_link_pfn);
+	obj->bytes_head_link_pfn = 0;
+	obj->bytes_tail_link_pfn = 0;
+	obj->data_len = 0;
 }
 
 static void pkram_truncate_node(struct pkram_node *node)
@@ -310,7 +319,7 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	if (flags & ~PKRAM_DATA_folios)
+	if (flags & ~(PKRAM_DATA_folios | PKRAM_DATA_bytes))
 		return -EINVAL;
 
 	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
@@ -326,6 +335,10 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 		ps->folios_head_link_pfnp = &obj->folios_head_link_pfn;
 		ps->folios_tail_link_pfnp = &obj->folios_tail_link_pfn;
 	}
+	if (flags & PKRAM_DATA_bytes) {
+		ps->bytes_head_link_pfnp = &obj->bytes_head_link_pfn;
+		ps->bytes_tail_link_pfnp = &obj->bytes_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -432,7 +445,7 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		return -ENODATA;
 
 	obj = pfn_to_kaddr(node->obj_pfn);
-	if (!obj->folios_head_link_pfn) {
+	if (!obj->folios_head_link_pfn && !obj->bytes_head_link_pfn) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
@@ -443,6 +456,10 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		ps->folios_head_link_pfnp = &obj->folios_head_link_pfn;
 		ps->folios_tail_link_pfnp = &obj->folios_tail_link_pfn;
 	}
+	if (obj->bytes_head_link_pfn) {
+		ps->bytes_head_link_pfnp = &obj->bytes_head_link_pfn;
+		ps->bytes_tail_link_pfnp = &obj->bytes_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -493,6 +510,9 @@ void pkram_finish_access(struct pkram_access *pa, bool status_ok)
 
 	if (pa->pds.link)
 		pkram_truncate_link(pa->pds.link);
+
+	if ((pa->dtype == PKRAM_DATA_bytes) && (pa->bytes.data_page))
+		pkram_free_page(page_address(pa->bytes.data_page));
 }
 
 /*
@@ -547,6 +567,22 @@ int pkram_save_folio(struct pkram_access *pa, struct folio *folio)
 	return __pkram_save_page(pa, page, page->index);
 }
 
+static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+
+	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX) {
+		link = pkram_new_link(pds, pa->ps->gfp_mask);
+		if (!link)
+			return -ENOMEM;
+	}
+
+	pkram_add_link_entry(pds, page);
+
+	return 0;
+}
+
 static struct page *__pkram_prep_load_page(pkram_entry_t p)
 {
 	struct page *page;
@@ -662,10 +698,53 @@ struct folio *pkram_load_folio(struct pkram_access *pa, unsigned long *index)
  *
  * On success, returns the number of bytes written, which is always equal to
  * @count. On failure, -errno is returned.
+ *
+ * Error values:
+ *    %ENOMEM: insufficient amount of memory available
  */
 ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
 {
-	return -EINVAL;
+	struct pkram_node *node = pa->ps->node;
+	struct pkram_obj *obj = pa->ps->obj;
+	size_t copy_count, write_count = 0;
+	void *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	while (count > 0) {
+		if (!pa->bytes.data_page) {
+			gfp_t gfp_mask = pa->ps->gfp_mask;
+			struct page *page;
+			int err;
+
+			page = pkram_alloc_page((gfp_mask & GFP_RECLAIM_MASK) |
+					       __GFP_HIGHMEM | __GFP_ZERO);
+			if (!page)
+				return -ENOMEM;
+			err = __pkram_bytes_save_page(pa, page);
+			if (err) {
+				pkram_free_page(page_address(page));
+				return err;
+			}
+			pa->bytes.data_page = page;
+			pa->bytes.data_offset = 0;
+		}
+
+		copy_count = min_t(size_t, count, PAGE_SIZE - pa->bytes.data_offset);
+		addr = kmap_local_page(pa->bytes.data_page);
+		memcpy(addr + pa->bytes.data_offset, buf, copy_count);
+		kunmap_local(addr);
+
+		buf += copy_count;
+		obj->data_len += copy_count;
+		pa->bytes.data_offset += copy_count;
+		if (pa->bytes.data_offset >= PAGE_SIZE)
+			pa->bytes.data_page = NULL;
+
+		write_count += copy_count;
+		count -= copy_count;
+	}
+	return write_count;
 }
 
 /**
@@ -679,5 +758,41 @@ ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
  */
 size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
 {
-	return 0;
+	struct pkram_node *node = pa->ps->node;
+	struct pkram_obj *obj = pa->ps->obj;
+	size_t copy_count, read_count = 0;
+	char *addr;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	while (count > 0 && obj->data_len > 0) {
+		if (!pa->bytes.data_page) {
+			struct page *page;
+
+			page = __pkram_load_page(pa, NULL);
+			if (IS_ERR_OR_NULL(page))
+				break;
+			pa->bytes.data_page = page;
+			pa->bytes.data_offset = 0;
+		}
+
+		copy_count = min_t(size_t, count, PAGE_SIZE - pa->bytes.data_offset);
+		if (copy_count > obj->data_len)
+			copy_count = obj->data_len;
+		addr = kmap_local_page(pa->bytes.data_page);
+		memcpy(buf, addr + pa->bytes.data_offset, copy_count);
+		kunmap_local(addr);
+
+		buf += copy_count;
+		obj->data_len -= copy_count;
+		pa->bytes.data_offset += copy_count;
+		if (pa->bytes.data_offset >= PAGE_SIZE || !obj->data_len) {
+			put_page(pa->bytes.data_page);
+			pa->bytes.data_page = NULL;
+		}
+
+		read_count += copy_count;
+		count -= copy_count;
+	}
+	return read_count;
 }
-- 
1.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
