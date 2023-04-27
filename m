Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106E7C7EE24
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7567yITTx3enK6Qa3qgl7x1S0Z2fImwBBsKH9ky6Jpk=; b=EO3UW9lrfywqAG
	ttCZ8rE7GY6MltBj8AhnQtT4RFSIH5Kp+1NeGg5V7ntW63O7eOGJ+1BqX0tRBp90uFVCmpvgsvnkO
	CWjrwVBYq32cXP7t0jmANyFPKWgdpo9yuOcn/byVtUfIrgFg56WkiBaZTVylPAXnApbMbGqvxMzbU
	9/H251f2b1S6MZl9Rzx7fz6/rVBV5lvm/uGloYeRWjD51DeedtLsPyvh6CJAToRUPnYbxmL/n8/Sb
	lMVwMFdgsPEgjOC+gGYi1AZb1zfo3UHwh8peTOQQbqg2uUvl+b2AoNZvQZOjR2/07UYW6wmyalCTu
	adzozFQSWG2gVvpaPQmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prpD6-0056az-2b;
	Thu, 27 Apr 2023 00:10:08 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prpCy-0056Rw-1E
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 00:10:02 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx8Pf014802;
	Thu, 27 Apr 2023 00:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=/klwynvryfeEh0hvbf4HAyTY1q/nlnl3HuBNmoKxWqE=;
 b=0j0n+Kwn3Bvz2+mjvASxMuPf8yoNwQ+WflTC1dDKD5SawtcQeSwCAX5Kl9PhTbjLM7XR
 0SZX9uzBB7nHTzqDuYT3ExaruHA9SVIUtnOMZT42jsPxL3vRnz7XBauO5nY7dbWI8FGa
 k+a1xB0bz8FRktPPGJfMWdBAzSN67DoN4vn/wLfmsPxiBZXp0NViGyfMYOIiBfLxFYT4
 YXmoG776eXjaC1bOyRIBJqyj52I0AsEr/DhPR3yHpLY7noBzb6XnjLZj8fFYuYmVKzKv
 Q/FhZ+/q1DvdVY6ADsoIdHyzTV0xawqFouIVJzNEoW/6uIlQ72P899/I2IKT1PoYoTBo 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fatms1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNIv5l007334;
	Thu, 27 Apr 2023 00:09:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938m013888;
	Thu, 27 Apr 2023 00:09:23 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-14;
	Thu, 27 Apr 2023 00:09:23 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 13/21] PKRAM: prevent inadvertent use of a stale superblock
Date: Wed, 26 Apr 2023 17:08:49 -0700
Message-Id: <1682554137-13938-14-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: dA85op-dAowHiRV38HyLZKKt_wYwuMGr
X-Proofpoint-GUID: dA85op-dAowHiRV38HyLZKKt_wYwuMGr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_171000_448785_FBB38217 
X-CRM114-Status: GOOD (  17.28  )
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

When pages have been saved to be preserved by the current boot, set
a magic number on the super block to be validated by the next kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index c63b27bb711b..befdffc76940 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -22,6 +22,7 @@
 
 #include "internal.h"
 
+#define PKRAM_MAGIC		0x706B726D
 
 /*
  * Represents a reference to a data page saved to PKRAM.
@@ -110,6 +111,8 @@ struct pkram_region_list {
  * The structure occupies a memory page.
  */
 struct pkram_super_block {
+	__u32	magic;
+
 	__u64	node_pfn;		/* first element of the node list */
 	__u64	region_list_pfn;
 	__u64	nr_regions;
@@ -179,6 +182,11 @@ void __init pkram_reserve(void)
 		err = PTR_ERR(pkram_sb);
 		goto out;
 	}
+	if (pkram_sb->magic != PKRAM_MAGIC) {
+		pr_err("PKRAM: invalid super block\n");
+		err = -EINVAL;
+		goto out;
+	}
 	/* An empty pkram_sb is not an error */
 	if (!pkram_sb->node_pfn) {
 		pkram_sb = NULL;
@@ -1012,6 +1020,7 @@ static void __pkram_reboot(void)
 	 */
 	memset(pkram_sb, 0, PAGE_SIZE);
 	if (!err && node_pfn) {
+		pkram_sb->magic = PKRAM_MAGIC;
 		pkram_sb->node_pfn = node_pfn;
 		pkram_sb->region_list_pfn = rl_pfn;
 		pkram_sb->nr_regions = nr_regions;
-- 
1.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
