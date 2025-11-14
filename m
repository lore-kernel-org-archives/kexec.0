Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9AECDE004
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 05:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2oVKsIXyrJXkyM+6wrn/iLOKfHA/LtsIXpmykgi6E68=; b=P6fUiOZYWusi+TqoLkasADPNzL
	C3B39pf/DE9yeejQxdxSX9Q1Fswnt/0hERYbzrdIoikUwWA8mK1UcYUzt7rt8p7o+fxF0e1H+UlCx
	HiroqlFu0w+4rBkQUiNQLxfSnMRxyfgZOJB0PVXzjNdn3xcA0rwEfvFvrtA+HnHQDhqcJTxZuAI3j
	tCy0vuQCJvt3iLYTxiVDr59rco5luZS9txAVZ6G9qJMePZ4Fr0z1J5B13SiUENZ8NoV3FzhHGGfCL
	kqXl3mhG2wQKtiV9A3s+NbQ5z+mso3PWPjrEAQX1vp3y+j4S2vbpZIIsK4EXV83bfw0oCnt0OzNRJ
	jWEppK6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmA7-0000000BaZt-0siY;
	Fri, 14 Nov 2025 05:15:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJm9z-0000000BaX2-0Tou
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 05:15:49 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMlLHm022347;
	Fri, 14 Nov 2025 05:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2oVKsIXyrJXkyM+6w
	rn/iLOKfHA/LtsIXpmykgi6E68=; b=bh3ik9Dy1uFdHWAfF4PHleVPJlHZBWJvn
	SR0GLiVs0VGatsu14WDYa5lyDUkhMHXkqEuorLmq0mWOADpFMNzO2TnvA0Wz1zS6
	nXGw4PxEf4mjcuFkChqMXUHhAA392pck4PuCMnM3HExJ8stUZstZC6NvJHhtcUbf
	qSJic78JXL1Y1atOCYLce55FJwbdRYtRiU91I83FN6ea10eBZ/0B6hRQvcgYNasv
	gxFg4eYtB41T/JOxW1exIAs+Wl1JhAkfOfIuhOkIKZhUclKqGuqglRsPDntATLt0
	an2nPIiRo3RrNcupp/dHjlwIzjISLfTSM+RNmEqjGVi+tLbytj8sg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adrecs29w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 05:15:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AE5Fj8W020409;
	Fri, 14 Nov 2025 05:15:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adrecs29u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 05:15:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AE4NB1k011562;
	Fri, 14 Nov 2025 05:15:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1sb3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 05:15:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AE5FewL15860138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 05:15:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A0820043;
	Fri, 14 Nov 2025 05:15:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19BD720040;
	Fri, 14 Nov 2025 05:15:37 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.124.211.127])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Nov 2025 05:15:36 +0000 (GMT)
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
Subject: [PATCH v4 5/5] crash: export crashkernel CMA reservation to userspace
Date: Fri, 14 Nov 2025 10:45:04 +0530
Message-ID: <20251114051504.614937-6-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114051504.614937-1-sourabhjain@linux.ibm.com>
References: <20251114051504.614937-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX1AAJZaP/oujO
 uiu5H01dlBe3gRRPwCkBWPeZQJbyr9565VIe69d1T7P8t28QE0wYZsZJPOqhep5HNrdrL5tYpBl
 K87p8P4OsA9agLz5Vzk/ePFlmAJPrLHTHxmLOYYMSKqGGGFgdPpttSLTKjHfCCf8XmRkoObmgp5
 3Zuu3kpN3zD78DL8mkdClooVORl7gpCpL0fi7cRBo+R0JM9kwW86HAn7xd1OMloBNeZCqnaSzHw
 oBlnScwv8bUHuB+CbYWodiz/mSNjxw+CPKUj70EtQxhK9LBsUW1xqCfzc2NBi89Qt5FFVXnY41R
 c7qwCqnQomf2kADurKiI21HVT8zX3+ou/xyw7ni0srEdmg2NZiL7UcvWY4Z9993efArvhjd0tmW
 mukBd+O0YT05Tc1DQ+3FQIBxM/Hm3g==
X-Authority-Analysis: v=2.4 cv=E//AZKdl c=1 sm=1 tr=0 ts=6916bb02 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8
 a=JfrnYn6hAAAA:8 a=xHySkhmCpRGYbmLIrh4A:9 a=HkZW87K1Qel5hWWM3VKY:22
 a=IC2XNlieTeVoXbcui8wp:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ULITlymv-_B6FIobW1VyROl7jAgp9zCo
X-Proofpoint-ORIG-GUID: u8O023xO4rxTK2LTmYqQ9ChugD43PQZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511130179
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_211548_699717_C768BB7C 
X-CRM114-Status: GOOD (  18.38  )
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

Add a sysfs entry /sys/kernel/kexec/crash_cma_ranges to expose all
CMA crashkernel ranges.

This allows userspace tools configuring kdump to determine how much
memory is reserved for crashkernel. If CMA is used, tools can warn
users when attempting to capture user pages with CMA reservation.

The new sysfs hold the CMA ranges in below format:

cat /sys/kernel/kexec/crash_cma_ranges
100000000-10c7fffff

The reason for not including Crash CMA Ranges in /proc/iomem is to avoid
conflicts. It has been observed that contiguous memory ranges are sometimes
shown as two separate System RAM entries in /proc/iomem. If a CMA range
overlaps two System RAM ranges, adding crashk_res to /proc/iomem can create
a conflict. Reference [1] describes one such instance on the PowerPC
architecture.

Link: https://lore.kernel.org/all/20251016142831.144515-1-sourabhjain@linux.ibm.com/ [1]

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
 .../ABI/testing/sysfs-kernel-kexec-kdump        | 10 ++++++++++
 kernel/kexec_core.c                             | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
index 00c00f380fea..f59051b5d96d 100644
--- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
+++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
@@ -49,3 +49,13 @@ Description:	read only
 		is used by the user space utility kexec to support updating the
 		in-kernel kdump image during hotplug operations.
 User:		Kexec tools
+
+What:		/sys/kernel/kexec/crash_cma_ranges
+Date:		Nov 2025
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		Provides information about the memory ranges reserved from
+		the Contiguous Memory Allocator (CMA) area that are allocated
+		to the crash (kdump) kernel. It lists the start and end physical
+		addresses of CMA regions assigned for crashkernel use.
+User:		kdump service
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7476a46de5d6..da6ff72b4669 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1271,6 +1271,22 @@ static ssize_t crash_size_store(struct kobject *kobj,
 }
 static struct kobj_attribute crash_size_attr = __ATTR_RW(crash_size);
 
+static ssize_t crash_cma_ranges_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		len += sysfs_emit_at(buf, len, "%08llx-%08llx\n",
+				     crashk_cma_ranges[i].start,
+				     crashk_cma_ranges[i].end);
+	}
+	return len;
+}
+static struct kobj_attribute crash_cma_ranges_attr = __ATTR_RO(crash_cma_ranges);
+
 #ifdef CONFIG_CRASH_HOTPLUG
 static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -1289,6 +1305,7 @@ static struct attribute *kexec_attrs[] = {
 #ifdef CONFIG_CRASH_DUMP
 	&crash_loaded_attr.attr,
 	&crash_size_attr.attr,
+	&crash_cma_ranges_attr.attr,
 #ifdef CONFIG_CRASH_HOTPLUG
 	&crash_elfcorehdr_size_attr.attr,
 #endif
-- 
2.51.1


