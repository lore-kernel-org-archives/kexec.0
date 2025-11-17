Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A350ACEBF93
	for <kexec@archiver.kernel.org>; Mon, 17 Nov 2025 04:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kAgUP736+w/dAXgeAKsmaBm2Bawoay2q/0qlkSveY/I=; b=WPXSTPSc7HNT81l4z2BQ82TZyP
	kjJnAlvQOO4WUzeK+Id+O0ftxKTHEbzPR1XAbqYm601y1Ge1f/QfhctOXnJnXvG4beSbA4TvcWTWU
	nealVgH1UPU/wHoc9Gon9rzZYtZYUizLhUJLwEjd2siTYaHYbixRnXx1yBVxV/LAwmv5CYgpL2oQL
	QuSctqwzizq/6tOlMScQhyCaQ7SigBqPzDDqOz6pk6NvTuCNDQSeRJtdy2WGehZ26KrNDQkz8SsNz
	ncdAmL6vl5cmPMdBcMyqG2GUa8B1O2e1cXaaqGEtk/ragRGL68q0jmZAs35kbIYlaZChP1mOizH9x
	4ZKwimUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKr9L-0000000FQHy-3BVB;
	Mon, 17 Nov 2025 04:47:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKr9J-0000000FQGu-3zxa
	for kexec@lists.infradead.org;
	Mon, 17 Nov 2025 04:47:35 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGJQVac004165;
	Mon, 17 Nov 2025 04:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kAgUP736+w/dAXgeA
	KsmaBm2Bawoay2q/0qlkSveY/I=; b=OOJofWWSjHGcgj93yma/rToJGlRUYGXAH
	7AjOf6RJw9R9EsBLHQHlN4bBvB3Hel7j4vjF6wLNPkyAFqukZUGz6LRVq0ySvD+G
	wt3NaIh3PZenqbQuVG4qA+osz9WSbxZ8nJKF/aiA2i3m3zASJghaVdRcAuH+FUD1
	XV/QEy/4D//by+aFMEaXQ6hjU1wygSe16HIld1hMTi3Br3TxGMVNvQJeIpT13nxf
	mP1oNkx7kFOo2eYaODohbg05gYAfPDZGeY0P8lePIjwGrxELG6X7Px1zCyNDmRAA
	fGUewXdhK4xBcG2s1+j+Fa2EI98eRUj+9IaQmvPPZka6AjmuoHV8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjvvh9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 04:47:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AH4g6N8028017;
	Mon, 17 Nov 2025 04:47:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjvvh9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 04:47:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH30ePh022347;
	Mon, 17 Nov 2025 04:47:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umm0ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 04:47:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AH4lQx043712800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 04:47:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07CF20049;
	Mon, 17 Nov 2025 04:47:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AED420040;
	Mon, 17 Nov 2025 04:47:23 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 04:47:22 +0000 (GMT)
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
Subject: [PATCH v5 2/3] Documentation/ABI: mark old kexec sysfs deprecated
Date: Mon, 17 Nov 2025 10:17:07 +0530
Message-ID: <20251117044708.1337558-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117044708.1337558-1-sourabhjain@linux.ibm.com>
References: <20251117044708.1337558-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691aa8e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=JfrnYn6hAAAA:8
 a=Ie6jO2O-dg1Sisz_YqoA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6IaE0D4qigNw
 HXT7hWhAj6uk2c1NIg4DLGvz+mge1LxtgdMwIARG5Rm0XRJH6iMao++LB7p3uVqRXP7euFMbJ8u
 ULvsy+XEP3oa4OiV9qFrDPVbuAZLBhXitSVeC6i2+Zz/sr7oJ8cicK2AA8HCPEvVHVEJQJOJnXv
 +tEGWMbDute9tT3Xr9VJjwah1zZiE03L5gtYXJweaTm2FZy0Zvjmn1U4JuPV67+uKGhw7yI0FFP
 ccilgtZTGbEs5bvXck28cnQurakMp+P5qNlN1zrojWeWjcmR5BVGa5nJQE8AgvGtUhatwTmcrFw
 Mm1/7U6rqD4DYobTmufpCohvCYs5YO2TCzMiGaunox0lyjzwPhlrEmGEyR04wlksJiY/9yXN9Sx
 qQ6noxTUWdIeMQ3DLJUKUw4xeEbOjw==
X-Proofpoint-GUID: Fee9Le7WiUmVVcxqKav1L0eb7Pr5eq1o
X-Proofpoint-ORIG-GUID: ktFsjZdjB3zQhqUWJMHk955FPtRxrYAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_204734_001733_984E8E8B 
X-CRM114-Status: GOOD (  26.22  )
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
 .../ABI/obsolete/sysfs-kernel-kexec-kdump     | 59 +++++++++++++++++++
 .../ABI/testing/sysfs-kernel-kexec-kdump      | 44 --------------
 2 files changed, 59 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump

diff --git a/Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump b/Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
new file mode 100644
index 000000000000..96b4d41721cc
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
@@ -0,0 +1,59 @@
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
+What:		/sys/kernel/kexec_loaded
+Date:		Jun 2006
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Indicates whether a new kernel image has been loaded
+		into memory using the kexec system call. It shows 1 if
+		a kexec image is present and ready to boot, or 0 if none
+		is loaded.
+User:		kexec tools, kdump service
+
+What:		/sys/kernel/kexec_crash_loaded
+Date:		Jun 2006
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Indicates whether a crash (kdump) kernel is currently
+		loaded into memory. It shows 1 if a crash kernel has been
+		successfully loaded for panic handling, or 0 if no crash
+		kernel is present.
+User:		Kexec tools, Kdump service
+
+What:		/sys/kernel/kexec_crash_size
+Date:		Dec 2009
+Contact:	kexec@lists.infradead.org
+Description:	read/write
+		Shows the amount of memory reserved for loading the crash
+		(kdump) kernel. It reports the size, in bytes, of the
+		crash kernel area defined by the crashkernel= parameter.
+		This interface also allows reducing the crashkernel
+		reservation by writing a smaller value, and the reclaimed
+		space is added back to the system RAM.
+User:		Kdump service
+
+What:		/sys/kernel/crash_elfcorehdr_size
+Date:		Aug 2023
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Indicates the preferred size of the memory buffer for the
+		ELF core header used by the crash (kdump) kernel. It defines
+		how much space is needed to hold metadata about the crashed
+		system, including CPU and memory information. This information
+		is used by the user space utility kexec to support updating the
+		in-kernel kdump image during hotplug operations.
+User:		Kexec tools
diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
index 320ec75a4903..7e5e528665db 100644
--- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
+++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
@@ -1,47 +1,3 @@
-What:		/sys/kernel/kexec_loaded
-Date:		Jun 2006
-Contact:	kexec@lists.infradead.org
-Description:	read only
-		Indicates whether a new kernel image has been loaded
-		into memory using the kexec system call. It shows 1 if
-		a kexec image is present and ready to boot, or 0 if none
-		is loaded.
-User:		kexec tools, kdump service
-
-What:		/sys/kernel/kexec_crash_loaded
-Date:		Jun 2006
-Contact:	kexec@lists.infradead.org
-Description:	read only
-		Indicates whether a crash (kdump) kernel is currently
-		loaded into memory. It shows 1 if a crash kernel has been
-		successfully loaded for panic handling, or 0 if no crash
-		kernel is present.
-User:		Kexec tools, Kdump service
-
-What:		/sys/kernel/kexec_crash_size
-Date:		Dec 2009
-Contact:	kexec@lists.infradead.org
-Description:	read/write
-		Shows the amount of memory reserved for loading the crash
-		(kdump) kernel. It reports the size, in bytes, of the
-		crash kernel area defined by the crashkernel= parameter.
-		This interface also allows reducing the crashkernel
-		reservation by writing a smaller value, and the reclaimed
-		space is added back to the system RAM.
-User:		Kdump service
-
-What:		/sys/kernel/crash_elfcorehdr_size
-Date:		Aug 2023
-Contact:	kexec@lists.infradead.org
-Description:	read only
-		Indicates the preferred size of the memory buffer for the
-		ELF core header used by the crash (kdump) kernel. It defines
-		how much space is needed to hold metadata about the crashed
-		system, including CPU and memory information. This information
-		is used by the user space utility kexec to support updating the
-		in-kernel kdump image during hotplug operations.
-User:		Kexec tools
-
 What:		/sys/kernel/kexec/crash_cma_ranges
 Date:		Nov 2025
 Contact:	kexec@lists.infradead.org
-- 
2.51.1


