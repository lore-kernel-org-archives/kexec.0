Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D99C30653
	for <kexec@archiver.kernel.org>; Sun,  7 Jul 2024 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3QZykBBBCWp228aimpKMXFBMdgZgyM1CnC+b5po5U6U=; b=oYGvTaip6MedZG
	4pRayRNix5pYo0E8lz3D1pVujcHLRjQvbpFXrYJDTjFk+NqFxrqe5KEmV1bzdsGt0gElwUDm48yNk
	IUcbtZA+rcx7shPYEvfrF78p6Ux2n/qPv3y0tep/d+aquMQH+Ql3D+2GMKo0o+HNb29a9lvH0Gpqi
	6H19JHo0WWe5t58EtgtPqlEAaQNEOIgPH8czVtKkVZWLST8rTMOXbZ1XjGNVLojBUj1VIbr2D4zN8
	wM+SD74Gnxx8zYnNE7BQa9LWvQSrz6jBoYbxddlLdI5PP0fZQrt2SIBVGKLPnI6fCzaDkb13fiYNv
	f1u79aPdiI9ju/9BNGuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTla-00000001w82-07Ur;
	Sun, 07 Jul 2024 15:25:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTlX-00000001w6s-1Ch2
	for kexec@lists.infradead.org;
	Sun, 07 Jul 2024 15:25:28 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467DuwAO008313;
	Sun, 7 Jul 2024 15:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=jx1gHjXyW7+fd
	Tbbb4UYLMjfNLHEbi3/G3g2cpqRbg8=; b=tNQ/IlPuqxto7ab0yoQWPGB2U+P9D
	JV5a1ttCRTPIEVz25m4EYXmeCJ7wOs6wRXxhIS4a+HJ2xnj+2uo9pTlFSrW4I5tq
	50VPuhH4zDxv0U3NNP/vgpMc4ELSNKyW+IKuBOeOvf7/ZCS8omuzboULV8XePRqw
	l0WdHqwM2RRhSCVJXLyqWt/rLwARYdOfdM7jZKwJCuPvbhk6EoctwzzFDAfIDB6A
	7usXbWk+dmwVr+sZlDPEaKmNYrwQdXBD8CbQqouDFsoV/gtzkD5Ub7sV0JuBEfn/
	Tyh/eP5AZsgS1mWbWQGP8nH8jyaYiS+ymVsYFABKSx7I+68pPYJ+un2fA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407kk3gwat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467FPMBr029279;
	Sun, 7 Jul 2024 15:25:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407kk3gwaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467B6xBD024598;
	Sun, 7 Jul 2024 15:25:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmahka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467FPFBJ19202410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 15:25:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF5420040;
	Sun,  7 Jul 2024 15:25:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACC0B2004B;
	Sun,  7 Jul 2024 15:25:12 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.10.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 15:25:12 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Coiby Xu <coxu@redhat.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Baoquan He <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v3 3/3] doc/hotplug: update man and --help
Date: Sun,  7 Jul 2024 20:54:56 +0530
Message-ID: <20240707152456.87899-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CHbJOzEX2tZPmBZm8y7Ecx6gyYJpPnwO
X-Proofpoint-ORIG-GUID: 5WN4naaeKb_R9SwfObYBeqeVKRzVHVEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=950
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407070126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_082527_485882_18598AC3 
X-CRM114-Status: GOOD (  16.59  )
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

Update the man page and --help option to make the description of the
--hotplug option easier to understand.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/kexec.8 | 8 ++++----
 kexec/kexec.c | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 9e995fe..793e876 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -140,10 +140,10 @@ Open a help file for
 .BR kexec .
 .TP
 .B \-\-hotplug
-Setup for kernel modification of the elfcorehdr. This option performs
-the steps needed to support kernel updates to the elfcorehdr in the
-presence of hot un/plug and/or on/offline events. This option only
-useful for KEXEC_LOAD syscall.
+Setup kexec segments such that kernel can safely update them on CPU/Memory
+hot add/remove events. If this option is enabled, kernel does in-kernel
+update of kexec segments on CPU/Memory hot add/remove events, thus avoiding
+the need to reload kdump kernel.
 .TP
 .B \-i\ (\-\-no-checks)
 Fast reboot, no memory integrity checks.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 59be075..7c614b0 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1093,7 +1093,9 @@ void usage(void)
 	       "                      back to the compatibility syscall when file based\n"
 	       "                      syscall is not supported or the kernel did not\n"
 	       "                      understand the image (default)\n"
-	       " --hotplug            Setup for kernel modification of elfcorehdr.\n"
+	       " --hotplug            Do in-kernel update of kexec segments on CPU/Memory\n"
+	       "                      hot add/remove events, avoiding the need to reload\n"
+	       "                      kdump kernel on online/offline events.\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
 	       "                      0 if not.\n"
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
