Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9858C25B7D
	for <kexec@archiver.kernel.org>; Wed, 22 May 2024 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fwYu0csewYkybUKzaUJiEj0INlalCN5hrKFJFe5hU7Y=; b=s2l0GT2bD2EBEK
	Lie9MNu6bmcevGZ3juRbofwVNmawGfuhsRMrhqqF7/bR6scNqGd/A6L5Ps64pVMHgcJRx+jH0LAko
	rYkxr/6mCvJTl4QAwX6o4MTf67gwVS5Kw3b9okhsoiJmSVbDCBoxyisZumxrTzrb3tOLNspmGYAyL
	1ZlyLqCKSMM+phUYLRpRrYDWDMB4hjd+nQbIncFwtMynaBXDDiFVSs28ydiVAvYYvAXZ+5ObDnre4
	x7RsBJt8tlomOEdPfdyuRHUrI4EoSCa3XWY2nJgM3vez8xWcKbCz5wEatuJt3LW9URZoyB5UJYdp8
	IFzXubQvot0DioiieoMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lnT-000000031as-1o62;
	Wed, 22 May 2024 13:14:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lnQ-000000031a0-0oxM
	for kexec@lists.infradead.org;
	Wed, 22 May 2024 13:14:21 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MD5GX9008630
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7I9ivGdzIJXZGUWUEYi4P4LRCAOw8PFkFWk9OQqleXc=;
 b=iwqBD+k1Yzc8LsUvj/75sCz0QPWza1o6NX/07bphBDujNRQc9XWiHFxrvW220P4NEM6g
 eOkgLhkHA6MyhJnvaswJlEaCy9XmGUXqP6DG4cahRLjNJ7WvTZj6cK23P8+bHV2kzvkd
 ln9KXMUodDnCj07V3aJ90J0btvUyYh2dZiLlukOscZYUwu+UvEXdda+Ion0P23o7UABz
 6aFncRHJ3uJytGDMNQXi3sPX1uJk2OUMivzZ+TG0VO2yCjaa2qsyAhKGijRqTRbGX7Fd
 nYiQ40AtAjmKd0USp1EmYTQqo6AmExuAARcSunDD5hUdp2YqOE8Hz02ECtmakiI9Ii6R og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9h9dr0ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:18 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDEInY021218
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9h9dr0rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:14:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCIJ3H008126;
	Wed, 22 May 2024 13:14:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vm3pwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:14:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44MDEC1r53281030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:14:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2900020040;
	Wed, 22 May 2024 13:14:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58EFF20049;
	Wed, 22 May 2024 13:14:09 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.79.246])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2024 13:14:09 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH 3/3] doc/hotplug: update man and --help
Date: Wed, 22 May 2024 18:43:53 +0530
Message-ID: <20240522131353.198327-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
References: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: awO_ahOzK-OB9C3H_DJQOCoClr9b2hF7
X-Proofpoint-GUID: HB4TM250MrtNRyvhpVz2vXWxPLVjpRfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_06,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=952 adultscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_061420_374898_6DFC926A 
X-CRM114-Status: GOOD (  20.09  )
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
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/kexec.8 | 8 ++++----
 kexec/kexec.c | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 9e995fe..7dddae9 100644
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
+Helps avoid kdump kernel reload on CPU/Memory hotplug or on/offline events.
+If this option is enabled, the kexec segments will be set up in a way that
+the kernel can safely update them on CPU/memory hotplug and/or on/offline
+events. This option is only useful for the KEXEC_LOAD syscall.
 .TP
 .B \-i\ (\-\-no-checks)
 Fast reboot, no memory integrity checks.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 034cea6..2b06438 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1093,7 +1093,8 @@ void usage(void)
 	       "                      back to the compatibility syscall when file based\n"
 	       "                      syscall is not supported or the kernel did not\n"
 	       "                      understand the image (default)\n"
-	       " --hotplug            Setup for kernel modification of elfcorehdr.\n"
+	       " --hotplug            Helps avoid kdump kernel reload on CPU/Memory hotplug\n"
+	       "		      or on/offline events.\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
 	       "                      0 if not.\n"
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
