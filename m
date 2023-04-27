Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13D8C77B7C
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y+DguW2LzpdyyarjZJivguBl0FYLJp34EEWh2hTMkc8=; b=sFeAt2fCGn2Bz3
	dQ61o7iR0xUDjdfsE6lwOZs0M/6lGi+qDDcvXCqT3hezqaeFDlJIP4jDP4q1eKw9iXffStqBIKTVc
	NVtYd4f33tYdmo5W4UJL/U6OaF7xX/hj0pHvgN5fKRFiZ8Spk7tiMuv3uPzyXCsAJtn0hXThSHsSe
	9Wgb2CL0xdTv06TSLELG9jEm2GF3lS+4XntuJoI6zXPVQHNt+GoRkIjAp1IiYIDqYhjCQQJeWmpbb
	l3H3IvSB/GnweaGiJp8QZ/rXTzBuLPYPQXDrPbKtj6focBHXjCq3p4vKfIWMOFVpzj3aTE6awJ3pA
	n+7N+1bQNGmA23Kwh0wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prpDC-0056ic-2n;
	Thu, 27 Apr 2023 00:10:14 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prpD1-0056WF-19
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 00:10:06 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx63C014744;
	Thu, 27 Apr 2023 00:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=43eGY+TDyN1Z/nEUhZp/pkRJ381CTkYO9EwFJXyHijs=;
 b=lFddECHUFaWe4SvxIWe74XuldZD3XhgVHok2PgKl2CS5V9ILX3LvwHV30JNs3cypkMZR
 8uiAfjJTFIhtWlrJRlFDLbAorKgQgvIuVOLrLSEI6IxPSo58U7I0ugig8LUpDtroQYf0
 qEQ1xL25lZRaIfxmaXWpRfGNpN5jYkV1m5iS+Qye7WwBzoSapoardIE7ZBZBnESy+/4m
 gSbsTmhPLiFOZ+wkOz++c0c0sgsqgkb4FrVZUnIxbqFMpcl7ubrUGjWlxLi5zPvEIXaS
 CguZa3wdyDWhJpmUoSLf4r4OI1kFIpshJwuSTa3CKlRl9yR0fibdnDQCo6NYgE9+jhUZ TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fatmse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMn2Cq007147;
	Thu, 27 Apr 2023 00:09:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938w013888;
	Thu, 27 Apr 2023 00:09:30 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-19;
	Thu, 27 Apr 2023 00:09:30 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 18/21] mm: PKRAM: allow preserved memory to be freed from userspace
Date: Wed, 26 Apr 2023 17:08:54 -0700
Message-Id: <1682554137-13938-19-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: -W4-EPoCWhe2SX1_zknW2SnhXj4oiT4p
X-Proofpoint-GUID: -W4-EPoCWhe2SX1_zknW2SnhXj4oiT4p
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_171003_432515_8431E3B8 
X-CRM114-Status: GOOD (  17.71  )
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

To free all space utilized for preserved memory, one can write 0 to
/sys/kernel/pkram. This will destroy all PKRAM nodes that are not
currently being read or written.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 474fb6fc8355..d404e415f3cb 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -493,6 +493,32 @@ static void pkram_truncate_node(struct pkram_node *node)
 	node->obj_pfn = 0;
 }
 
+/*
+ * Free all nodes that are not under operation.
+ */
+static void pkram_truncate(void)
+{
+	struct page *page, *tmp;
+	struct pkram_node *node;
+	LIST_HEAD(dispose);
+
+	mutex_lock(&pkram_mutex);
+	list_for_each_entry_safe(page, tmp, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (!(node->flags & PKRAM_ACCMODE_MASK))
+			list_move(&page->lru, &dispose);
+	}
+	mutex_unlock(&pkram_mutex);
+
+	while (!list_empty(&dispose)) {
+		page = list_first_entry(&dispose, struct page, lru);
+		list_del(&page->lru);
+		node = page_address(page);
+		pkram_truncate_node(node);
+		pkram_free_page(node);
+	}
+}
+
 static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
 {
 	__u64 link_pfn = page_to_pfn(virt_to_page(link));
@@ -1252,8 +1278,19 @@ static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
 	return sprintf(buf, "%lx\n", pfn);
 }
 
+static ssize_t store_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int val;
+
+	if (kstrtoint(buf, 0, &val) || val)
+		return -EINVAL;
+	pkram_truncate();
+	return count;
+}
+
 static struct kobj_attribute pkram_sb_pfn_attr =
-	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+	__ATTR(pkram, 0644, show_pkram_sb_pfn, store_pkram_sb_pfn);
 
 static struct attribute *pkram_attrs[] = {
 	&pkram_sb_pfn_attr.attr,
-- 
1.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
