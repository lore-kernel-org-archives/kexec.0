Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C87C30658
	for <kexec@archiver.kernel.org>; Tue,  2 Jul 2024 04:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GN21SLITbDGPeWuerYXdK3ANLRFCVF78OtKnUh3spBk=; b=W5MvV3uU/PFZjX
	xwtbJ9JMetfZLOlAkc0P/ioPUEnVna7SMLLhG5SEiBUqG3m5MOCdFFrOAc6F2BH/Cyy10DCcmmKIL
	DAtRUSkv7yAqIkVUQpYsKJTxj4rGjcQLeSwBBY1+pZf3SuA1rpox1nGg7Pps9oKcWbrD7EN0j+Pzs
	EZ7JCfBV3sLcwFCddsTKQ0AakBKZHgB0BGSpa4lTWvOn9vPqKL3zZHb5e+ZUoUA6k+lFjLbOMIdUY
	Mo/f9/F9bAnkJrQwvZ0ZC0ya2NqhPRu1R9V8/rS0+3sSeGUd7Lq7hsDunRWH8H2jpBb4vLjxNIjKH
	hmdQxAw/wZ/IlMlVfCXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOVAm-00000005VsR-2kj7;
	Tue, 02 Jul 2024 04:31:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOVAj-00000005VrB-1RhC
	for kexec@lists.infradead.org;
	Tue, 02 Jul 2024 04:31:18 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4623x80Z004736;
	Tue, 2 Jul 2024 04:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=3fao5LDLRLr5W
	PH03qJtVfuJT01vnEUpwWk2t/UoK0s=; b=iV+HcQGMRwErqOmi3gk1v0TPJ7Cdd
	eiB3XP5R6koKLCTSAxZK0/NUz/bi5r3Y5T9/4zHgj9Zc9nqdoTlKFsqGLnQ+Pywz
	tdOmpIjf6znFKMuoeIC7/baP8Xk2jxr636ghG27XQYftQigUbnKsEJr7/yuWGWSE
	QYyU/McfgVEeHc9OVHDuSc4sWNQ0jYiBdKwBbpwT3q7OxpZvrOawJLYd7wChbEmG
	WLQDM2FZKphEK4zgQ30eti6clXZqv9zd+fKHER35RTSyQ/vUuM3m/QS3yB6bB2e8
	9LbYNGMod4KoPPGlhUO+i3Aofa0h4UuOiNs6iOE8XvCi2+U8YteXb6w3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404a4302nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 04:31:14 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4624VER6022138;
	Tue, 2 Jul 2024 04:31:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404a4302nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 04:31:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4621oTfo005942;
	Tue, 2 Jul 2024 04:31:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vku34ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 04:31:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4624V7sr46072314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 04:31:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82E2B20043;
	Tue,  2 Jul 2024 04:31:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D53892004D;
	Tue,  2 Jul 2024 04:31:05 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jul 2024 04:31:05 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v3 3/3] doc/hotplug: update man and --help
Date: Tue,  2 Jul 2024 10:00:57 +0530
Message-ID: <20240702043057.200211-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
References: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WekqpbEqPtcfdtVrEq0eSlIosqrhlm_L
X-Proofpoint-GUID: 8KpygZ4skWkWawz-rKvZkEgvUpQ4hYwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_01,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407020029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_213117_435955_F0DD6CD3 
X-CRM114-Status: GOOD (  17.23  )
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
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
Changelog:

From v2 -> v3
  - Updated --hotplug option description

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
index 034cea6..9b7c34c 100644
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
