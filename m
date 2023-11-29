Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871A8C07E98
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VIw3Jv/+mZii5sssDVKU5Kgsvz3z/AJrrQBpa4k/ceY=; b=0H7+pif33oV/60
	AJG5gMwTLGeWxbsNZBcVb5rmPevbYL66J+AFx6d5bUEHHKtQjcIBYemdT2sd6eRWeWQc7K+7fEH/K
	sdw49w03j8mfKWBHpt0WVPM8eI4rmkoPCAnGbtrzVjVkEZ7YNqI3S9G6arqqXL0w9LYyYH6Ydw9Jz
	WM6lgfkNCQGkAEgv3946zUYdJdBwS4tbFnBP9Q4RnOvBfs1cPTaZkyts1IV9hxqsjbjqFFQUXN1m+
	X56SMXKMC4we8zqVJHWp2DoltlZMc+JQogATH7KYXssuRO9jPoRBbie8R+4eM+JsZixVkKn/Rj6sl
	p1M3rzcywf6mArHdP1fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8K1I-008Nxd-20;
	Wed, 29 Nov 2023 12:50:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8K1E-008NwR-0l
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 12:50:22 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATCJdGN001969
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=X40T3Qp/0aknrM0j7dH2iohlB+JJRfzjcuIG8qM+9yI=;
 b=dLeqOuGuRwxeL914HtQF8+NtrHbHXyxqd9iMfRoalj3KQpbpzflyjqagdW8vYD5bcVph
 /tt7jB7v6c6i+6RzxeU8pUichA6yaEKYDxkwCu/7whM3qltCp3N+jlRfxAZVkyJmww8T
 bBAp8M3R3LOv7k2AvcA34G7DDvvxFkykFZn+J5XizWJ2rCDOj6z3UyNP/XUUAg0TNHxK
 4OE1Oncl4vd5f1KfLW9GUPz07/HK/pZy/6QQ/LehAvjcMofxm5cozbiV9okXNKzHvaBH
 GsccdNCZ4dFxa7m0gWa4GBk4NUg4g3e8MWBNehZHZtC+YgNOagS6SFmcuvpYki7VC1cP /w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up4nu9s7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATB43ld025714
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk6urq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATCoCM745351560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 12:50:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76F1D20043;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 672C320040;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 1F4FDE0A0E; Wed, 29 Nov 2023 13:50:12 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: kexec@lists.infradead.org
Subject: [PATCH 1/2] s390x: fix virtual vs physical address confusion
Date: Wed, 29 Nov 2023 13:50:11 +0100
Message-Id: <d3b09ef4a138e8a8b8bfaa710cdc4ebce03cef81.1701261329.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701261329.git.agordeev@linux.ibm.com>
References: <cover.1701261329.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QnBTdX7Sr3njHjd9xNYK-mIcMysrMMZO
X-Proofpoint-ORIG-GUID: QnBTdX7Sr3njHjd9xNYK-mIcMysrMMZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=971 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_045020_505599_8F118B5E 
X-CRM114-Status: GOOD (  20.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Physical and virtual addresses are the same on S390X.
That led to misuse of readmem() address type.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390x.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390x.c b/arch/s390x.c
index c4fed6f..a01f164 100644
--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -167,7 +167,7 @@ _kl_rsg_table_deref_s390x(unsigned long vaddr, unsigned long table,
 		return 0;
 	}
 
-	if (!readmem(VADDR, table + offset, &entry, sizeof(entry))) {
+	if (!readmem(PADDR, table + offset, &entry, sizeof(entry))) {
 		if (level)
 			ERRMSG("Can't read region table %d entry\n", level);
 		else
@@ -201,7 +201,7 @@ static ulong _kl_pg_table_deref_s390x(unsigned long vaddr, unsigned long table)
 	unsigned long offset, entry;
 
 	offset = pte_offset(vaddr);
-	readmem(VADDR, table + offset, &entry, sizeof(entry));
+	readmem(PADDR, table + offset, &entry, sizeof(entry));
 	/*
 	 * Check if the page table entry could be read and doesn't have
 	 * the reserved bit set.
@@ -227,17 +227,22 @@ static unsigned long long
 vtop_s390x(unsigned long vaddr)
 {
 	unsigned long long paddr = NOT_PADDR;
+	unsigned long long swapper_pg_dir;
 	unsigned long table, entry;
 	int level, len;
 
-	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
+	swapper_pg_dir = SYMBOL(swapper_pg_dir);
+	if (swapper_pg_dir == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
 		return NOT_PADDR;
 	}
-	table = SYMBOL(swapper_pg_dir);
+	table = vaddr_to_paddr(swapper_pg_dir);
 
 	/* Read the first entry to find the number of page table levels. */
-	readmem(VADDR, table, &entry, sizeof(entry));
+	if (!readmem(PADDR, table, &entry, sizeof(entry))) {
+		ERRMSG("Can't read swapper_pg_dir entry.\n");
+		return NOT_PADDR;
+	}
 	level = TABLE_LEVEL(entry);
 	len = TABLE_LENGTH(entry);
 
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
