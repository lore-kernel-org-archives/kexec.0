Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078CEC7618E
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aNUcGGNZJIFJytuf0S9t6gIra+XGJaSbvtc+UQiHvmY=; b=emaxGcoCQGDl7g
	opmNMvfmGcTFpniGIq3zS+YOsrusTyDdWqogAa+1nN8JMy5mQfXTllAX5e7kiRlAcy08WsM0dG/tC
	r11WV17CzklDiAgzKWY+rpz+h0tjPhQ5/x9aq47gB1l1FKehj/itYH3MLpMLUooqMG/jL6RtfSB21
	u51uuxtz8tmiduOVdlwDViXXbqfiT0cMGvPmNmIhsWaKaS/EFflyGvV2eZsVcvL1gvvKhw+pbi0sv
	77FAW1wj59DlG8AuGcoVAhy1PKs6skq0irEy4Sm/JWVQANvcidaLgGLMaQzLa0gXIKdUv3vceaJrB
	EgAxcSFg7UHi+h7On+yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prpD8-0056cy-2b;
	Thu, 27 Apr 2023 00:10:10 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prpCz-0056Sy-1D
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 00:10:04 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxER0025323;
	Thu, 27 Apr 2023 00:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=iVHkxnhPmN3ZiIllDQA4XN9d0CPfj30tNxwbJaWlZYE=;
 b=uln3/Y5F+Sv5bX0Aapb9pqhswccVRvqb/9UqSXysiUWJfvKaAtGgueeexgYxPSyeDVU1
 JY61SJ0QAxIz9xFLQu1a+bfAQ7BoRsRMO/zykqYENeQfQX2Tsp31Pwuci7L745E6EStq
 al6VWV501TMo24pZir/gWgRySI/5HjAKGGrMSanISa8maMcnnLFivFO29ZEDyZLAdXSZ
 RWl2os1ejhXGKljBNkHolMvKGrZDQUtuY+vOxt6u02F5SFOr5ARd7jtA13Qssv/4Q+Nd
 ZEr7Z+4EcuFibdjMmqSjL+Co/bgWhtdnklJ3asiCwPFLUA3oIv16J3DXTRhyeQz5K8J3 vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622tyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNRYCp007326;
	Thu, 27 Apr 2023 00:09:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mprm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938s013888;
	Thu, 27 Apr 2023 00:09:27 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-17;
	Thu, 27 Apr 2023 00:09:27 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 16/21] PKRAM: provide a way to check if a memory range has preserved pages
Date: Wed, 26 Apr 2023 17:08:52 -0700
Message-Id: <1682554137-13938-17-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: 2bK9bjHYj08MJyIhhXZ9v97WqmZ7xyPq
X-Proofpoint-GUID: 2bK9bjHYj08MJyIhhXZ9v97WqmZ7xyPq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_171001_442489_EA626A45 
X-CRM114-Status: GOOD (  16.85  )
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

When a kernel is loaded for kexec the address ranges where the kexec
segments will be copied to may conflict with pages already set to be
preserved. Provide a way to determine if preserved pages exist in a
specified range.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 29109e875604..bec9ae75e802 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -104,11 +104,13 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 void pkram_reserve(void);
 void pkram_cleanup(void);
 void pkram_ban_region(unsigned long start, unsigned long end);
+int pkram_has_preserved_pages(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_cleanup(void) { }
 static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
+static inline int pkram_has_preserved_pages(unsigned long start, unsigned long end) { return 0; }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index cef75bd8ba99..474fb6fc8355 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1690,3 +1690,23 @@ void __init pkram_cleanup(void)
 		pkram_reserved_pages--;
 	}
 }
+
+static int has_preserved_pages_cb(unsigned long base, unsigned long size, void *private)
+{
+	int *has_preserved = (int *)private;
+
+	*has_preserved = 1;
+	return 1;
+}
+
+/*
+ * Check whether the memory range [start, end) contains preserved pages.
+ */
+int pkram_has_preserved_pages(unsigned long start, unsigned long end)
+{
+	int has_preserved = 0;
+
+	pkram_find_preserved(start, end, &has_preserved, has_preserved_pages_cb);
+
+	return has_preserved;
+}
-- 
1.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
