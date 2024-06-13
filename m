Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6A9C27C4F
	for <kexec@archiver.kernel.org>; Thu, 13 Jun 2024 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MoezhmooPMEogrY/FXdETwq5HMO3judSzjXR18CxAuQ=; b=wC3tErLN/GH4/Y
	beK7nYWKLg9pXl76o8ks7QiPmFyPKD4sDQqE1ROfE8lMbyGZWUwJprgt74XElcXfsO0cpuhjKCl+g
	euJE+6AKYmOAMhn52p5lox3NRYOSpjppW5L0qjIGv5/wNq5iakXeSYZhWDJ8vNvVRFMbzAgtKh+8k
	QaozguUtvR2iguhsWfaUsBAJRagyNvjWG9x5XRv/VWXqssGT0GHBWzn9jZG7mKvKhmF3qjjVrIe0L
	WhmGSzS2NeLuGL/vVjCI6AfHAEuQG+UvCLs00KzKyG+78NtaExFIZHhRsKx3SbgBF/FQ6bAUkwz1A
	sicbKQUG6IMLiOY8Z0Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHpnw-00000000D4D-13Sk;
	Thu, 13 Jun 2024 19:08:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHpnr-00000000D27-2Vom
	for kexec@lists.infradead.org;
	Thu, 13 Jun 2024 19:08:08 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DHQFf0004683;
	Thu, 13 Jun 2024 19:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=5Tafsw9nK+5l5
	QRng5Au/ZZj6fHsc47eRqZIZOewXHM=; b=qH+ryc4P/JnvhQGkDDuK2+GqE2dg7
	wBQwYJcgnYWTRknmvk2aBo53K3J1yJPl7BRJtxv/VPI5ct3wdVfpWa6OwVqMMV7V
	UcfMHCbadw2CJl8cYc3LsJEYl8/C7q0quRRy+eY3IusKAs/I/9Loz2x+2u+WVn9E
	hmNr8/1d0cSZJ5lsdpNuvEr1InLNuIaWr86VatHjqbMHa9dVRjv8IgwjPVvSLMVg
	oSrh1zGJREhIRFz/09niznpq2klr1LwpQrljzDSo1Yupbdy1bqcXz6S17cC7pF23
	ebQ6NL83CUlRJbptHEZY0EA4cPLjrUjxF9akD+5/NWEX6l61bo/e8hTaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr4amrd8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 19:08:05 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DJ84bB003131;
	Thu, 13 Jun 2024 19:08:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr4amrd8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 19:08:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DHt6B8008879;
	Thu, 13 Jun 2024 19:08:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b3t6qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 19:08:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DJ7v4149807626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 19:08:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A1920049;
	Thu, 13 Jun 2024 19:07:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654D920040;
	Thu, 13 Jun 2024 19:07:55 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.56.50])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 19:07:55 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH v2 3/3] doc/hotplug: update man and --help
Date: Fri, 14 Jun 2024 00:37:38 +0530
Message-ID: <20240613190738.1852258-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
References: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D5Eu9pcvFetkyQMF0sQ2SeguOJFpiKO5
X-Proofpoint-GUID: 5_dd3RIQupatV7PX6J-0SB1q_UCn0aty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406130134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_120807_664282_34A09648 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---

Changelog:

Since v1:
  - Updated --hotplug option description

---
 kexec/kexec.8 | 8 ++++----
 kexec/kexec.c | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 9e995fe..92fa3d5 100644
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
+update of kexec segments on CPU/Memory hot add/remove events. Helps avoid
+the need to reload kdump kernel.
 .TP
 .B \-i\ (\-\-no-checks)
 Fast reboot, no memory integrity checks.
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 034cea6..db8e2b3 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1093,7 +1093,9 @@ void usage(void)
 	       "                      back to the compatibility syscall when file based\n"
 	       "                      syscall is not supported or the kernel did not\n"
 	       "                      understand the image (default)\n"
-	       " --hotplug            Setup for kernel modification of elfcorehdr.\n"
+	       " --hotplug            Do in-kernel update of kexec segments on CPU/Memory\n"
+	       "                      hot add/remove events. This avoids the need to reload\n"
+	       "                      kdump kernel or on/offline events.\n"
 	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
 	       "                      0 if not.\n"
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
