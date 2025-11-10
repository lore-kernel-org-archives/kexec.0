Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7696FCCFA1A
	for <kexec@archiver.kernel.org>; Mon, 10 Nov 2025 04:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsU1RZLnrbaQXMov3T1w4F/vxwR9IwkqfqhPedHcRTA=; b=rZdvMjsgqv4QH0IScQ8DeN7N5h
	afngPu3VZK0MJI31EmgGWisBpBQAiP/rKTEEyb4B8CcqyrZ0ytMWz4qvEbyo0tLXbajHEU10ZlmI6
	bQ+GjjDUmhIGA1pZX9nf0GDyooThR1ys7s923aAx2DABJvRrkidRw6MjiZ7+QcH2NkdV4UrrWpe0p
	Y9ExrxsOYunUTP6IzsPUNIseydtdc7j4XpTaE+vfXLgIf71luKPwLmU1nIlrVS/kEmEdjtL0ui0nV
	pF+1QsetJnAJI++xiyN6XzTNjfy4qpn6L9xFVKDdPdITg66CVrvYDrWs4XVsfDW8P+tEYytPxVN8a
	vzQJnPeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIJZh-00000004iib-053b;
	Mon, 10 Nov 2025 04:32:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIJZc-00000004ih6-2H7v
	for kexec@lists.infradead.org;
	Mon, 10 Nov 2025 04:32:13 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9MhGkq005929;
	Mon, 10 Nov 2025 04:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vsU1RZLnrbaQXMov3
	T1w4F/vxwR9IwkqfqhPedHcRTA=; b=I18ULFW3o4o87tQwhpR7UH5HFmbg791Yf
	nVfWlOigRZzkcuVpLYt5KOr1FZqpf6Ag9k8X8g1jD+ZiGpn9e7rdZBNacVognnZT
	eBVqa1CGpne/UmelScEO9yl/o+fjseexLa3aLMQzPAWRAUXhHATVJeYcoxD13r8y
	HbbaQb0jDwRyZ/VuSjgEFSkv+fjXQFLmYrlKeGw7rb572WMLMO0X/FtbzDkooQFm
	ntHNrsUNzhYDl7scSe2tYfaJtwMV3dADwI749lmKsBu7yINiSklnyjeK8G/bPLZB
	R2HGk76+K+GE52LVIIat2wXdfUde4KrH7h0bZEzEmQGrGqRZVrGNA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc6xfw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:32:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AA4Ug5l003607;
	Mon, 10 Nov 2025 04:32:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc6xfw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:32:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9NJEFG028859;
	Mon, 10 Nov 2025 04:32:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6s40yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:32:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA4W5Ev25100650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 04:32:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3611220040;
	Mon, 10 Nov 2025 04:32:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AFE720049;
	Mon, 10 Nov 2025 04:32:01 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 04:32:01 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Jiri Bohac <jbohac@suse.cz>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
Subject: [PATCH v3 3/5] Documentation/ABI: mark old kexec sysfs deprecated
Date: Mon, 10 Nov 2025 10:01:41 +0530
Message-ID: <20251110043143.484408-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110043143.484408-1-sourabhjain@linux.ibm.com>
References: <20251110043143.484408-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX7+mOY26QI/Rr
 jaBNK97njnroifwJP5ZwiHGQwqizOsCj1gYG3LB/UU5rZTI2N76LELvfiGHglV6gsI7i4lz7PPi
 /qmOxVcxbBg1XI8WwEMDiM7JnM6NDSXjKwosuyvEQztG1X7Voy4CkISk49WYdKYmX1I9FX/0ovW
 7ZXFtBfAhyt1xilXidtDer2DnpELXWdURnDd3IOBp0XvIUTyiZcBjZfm/MbzsgdCKd/O+wWjPXd
 ixNz/yEMTMkzTjVah6YvLnIEpyLW9CHXs9kJerEoTJl2WaBF8tSUWnRwCvceW1w5gVBTMyUPKg9
 xpfY9amX4QrZsJUHephSpPN8kqGl+5rHNHqfhggcG1KDBYzmqii6qXhHPjOVQGseKxd6mDFVYmr
 zVv2NCCaKgFw26t68MBUt1SOFeiTPA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69116acb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=JfrnYn6hAAAA:8
 a=LRU2jnFezOS3J6eLL00A:9 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Xlo5PES5yS8RFhqcRxzTDaJQHsWcKfzP
X-Proofpoint-ORIG-GUID: 8eh60D0z_xXaYRhK5KlM0QTnlYsqDFcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251109_203212_590650_4402E6B8 
X-CRM114-Status: GOOD (  14.61  )
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

The previous commit ("kexec: move sysfs entries to /sys/kernel/kexec")
moved all existing kexec sysfs entries to a new location. The ABI
document is updated to include a note about the deprecation of the old
kexec sysfs entries.

The following kexec sysfs entries are deprecated:
- /sys/kernel/kexec_loaded
- /sys/kernel/kexec_crash_loaded
- /sys/kernel/kexec_crash_size
- /sys/kernel/crash_elfcorehdr_size

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 .../sysfs-kernel-kexec-kdump                     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 rename Documentation/ABI/{testing => obsolete}/sysfs-kernel-kexec-kdump (61%)

diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
similarity index 61%
rename from Documentation/ABI/testing/sysfs-kernel-kexec-kdump
rename to Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
index 96b24565b68e..96b4d41721cc 100644
--- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
+++ b/Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
@@ -1,3 +1,19 @@
+NOTE: all the ABIs listed in this file are deprecated and will be removed after 2028.
+
+Here are the alternative ABIs:
++------------------------------------+-----------------------------------------+
+| Deprecated                         | Alternative                             |
++------------------------------------+-----------------------------------------+
+| /sys/kernel/kexec_loaded           | /sys/kernel/kexec/loaded                |
++------------------------------------+-----------------------------------------+
+| /sys/kernel/kexec_crash_loaded     | /sys/kernel/kexec/crash_loaded          |
++------------------------------------+-----------------------------------------+
+| /sys/kernel/kexec_crash_size       | /sys/kernel/kexec/crash_size            |
++------------------------------------+-----------------------------------------+
+| /sys/kernel/crash_elfcorehdr_size  | /sys/kernel/kexec/crash_elfcorehdr_size |
++------------------------------------+-----------------------------------------+
+
+
 What:		/sys/kernel/kexec_loaded
 Date:		Jun 2006
 Contact:	kexec@lists.infradead.org
-- 
2.51.1


