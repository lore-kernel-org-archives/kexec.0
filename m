Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00F5CD3429
	for <kexec@archiver.kernel.org>; Wed, 12 Nov 2025 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FawzPcCnJhEDHfkIczwzjxl0yiXWQbXOBFm/LlfD61w=; b=TAMp4uPnEuh/VeP+g34YfxK9No
	pCDHcWJWOf0Ex/gcllYHBvPbncF5pyjQUxTQs8dZdQK/OjcSYOkkosKGLTMxW5qrLK08ngRfVqsX8
	QlglcdeSnbl4BZecJGrUALgdG5R0344TqKND7fPsTqFDJV77aVTijY00/upi7a8Q83hChZphdxoj9
	2i+iEPSdjhzuvHs4/pWFLItjIyl2VwsfDPOt2xC9ySlo9jL3nncNmEF9AyESGrszbw3FLFsR0gvur
	y1bsMZoHvIJTL88MpvRFQcJupLzgDWocnReyMz+HQ9GZxThC9uRAFMc4aVEetGLyafgY78iUGHBjk
	2J3KXpTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJEPm-00000009EA3-3u2V;
	Wed, 12 Nov 2025 17:13:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJEPk-00000009E9J-2EgN
	for kexec@lists.infradead.org;
	Wed, 12 Nov 2025 17:13:50 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC8I4f2024315;
	Wed, 12 Nov 2025 17:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FawzPcCnJhEDHfkIc
	zwzjxl0yiXWQbXOBFm/LlfD61w=; b=bczZhfP2YK9aC8MasoYz/AL7W58/S98bn
	csuZsamcsk9Sl3ltqyM+cJeJsNxefr0o12kwztf+58b5IS22HbBMk3tSYCdrraap
	hM0Cyb8wpMD91QNK1pueaVIp2Dxx0/jBsp4S77jA2C0PfE15lHZ820PDk09bEV04
	y502pAGNsakmgjxWEQzAm/p/jGD/VTv80f4cgUh3vdWAaOtNvqSUyvSJIzvlyKAe
	Rb5te609EOdN4nbUw/DTw4sT72Zp5F4N+Ykadx9paSaEFD9dproq/hX1BM6JSPp6
	VGPWbIG14QMeXZ44Y6OGBWFkSe9KrC1HOyWmcFz6nIs3lleM7SiFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjak4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 17:13:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACGx3oF026797;
	Wed, 12 Nov 2025 17:13:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjak4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 17:13:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACGmhan028978;
	Wed, 12 Nov 2025 17:13:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6shkf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 17:13:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACHDc8D28377760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 17:13:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C1B520043;
	Wed, 12 Nov 2025 17:13:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0280820040;
	Wed, 12 Nov 2025 17:13:36 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.124.218.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 17:13:35 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: [PATCH 2/2] Documentation/ABI: remove old fadump sysfs doc
Date: Wed, 12 Nov 2025 22:43:28 +0530
Message-ID: <20251112171328.298109-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112171328.298109-1-sourabhjain@linux.ibm.com>
References: <20251112171328.298109-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6914c047 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=JfrnYn6hAAAA:8 a=voM4FWlXAAAA:8 a=cx1aSUdoMbGpntF6QmcA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX13D9A9Rr2l2K
 tHPTj6I2BiytBP1dwo4hs3NWLYxfhXRhFqvynlUgXxRoE915LcGEaznBib018FcxzJny/r8BBMP
 hYO2LWos8kUQPgeGWofBTpK/PVD2BqNmmb3wsNq0YChaw2TxbtkNWC/HSSsvwR1AjK1vGZ/rgE5
 cAYKckttxsVGGbM60d9ZpddGcs4OgpLCS7v16M7ta9fivmh/BRIW7iGjMjxzKfQ2lUugWkNgrjM
 N9oP6f29hdj/sGNKAfH16Gs2WLP+ZeONYM6guk+JIYBJc8s+wPY+jSCrXIrwIk3ytBW87TkULrL
 NBGUNGtSrlVNIgd0R7vumbEZNj4kTb/JIueRNZpI9xOMOz0CLXcdF3Tn02wHtUHMazy4LImiWz5
 xbF87yMiKWqbt0iMIe/PcEgJQAtKAw==
X-Proofpoint-GUID: h2UtomryfbRwGynCaovyUjEaooC2c8Tw
X-Proofpoint-ORIG-GUID: dM0w-RBRePaovMZODTDWIGWgqgYT7kS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_091348_813899_672282D5 
X-CRM114-Status: GOOD (  29.01  )
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

Patch with title "powerpc/fadump: remove old sysfs symlink" removed the
deprecated fadump sysfs. So remove the respective ABI documents.

Additionally remove the reference of old fadump sysfs from fadump
document.

The alternative sysfs is documented at:
Documentation/ABI/testing/sysfs-kernel-fadump

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 .../ABI/obsolete/sysfs-kernel-fadump_enabled  |  9 -----
 .../obsolete/sysfs-kernel-fadump_registered   | 10 ------
 .../obsolete/sysfs-kernel-fadump_release_mem  | 10 ------
 .../arch/powerpc/firmware-assisted-dump.rst   | 33 +++++++------------
 4 files changed, 11 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem

diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled b/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
deleted file mode 100644
index e9c2de8b3688..000000000000
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
+++ /dev/null
@@ -1,9 +0,0 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/enabled.
-
-What:		/sys/kernel/fadump_enabled
-Date:		Feb 2012
-Contact:	linuxppc-dev@lists.ozlabs.org
-Description:	read only
-		Primarily used to identify whether the FADump is enabled in
-		the kernel or not.
-User:		Kdump service
diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
deleted file mode 100644
index dae880b1a5d5..000000000000
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
+++ /dev/null
@@ -1,10 +0,0 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/registered.
-
-What:		/sys/kernel/fadump_registered
-Date:		Feb 2012
-Contact:	linuxppc-dev@lists.ozlabs.org
-Description:	read/write
-		Helps to control the dump collect feature from userspace.
-		Setting 1 to this file enables the system to collect the
-		dump and 0 to disable it.
-User:		Kdump service
diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
deleted file mode 100644
index ca2396edb5f1..000000000000
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
+++ /dev/null
@@ -1,10 +0,0 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/release_mem.
-
-What:		/sys/kernel/fadump_release_mem
-Date:		Feb 2012
-Contact:	linuxppc-dev@lists.ozlabs.org
-Description:	write only
-		This is a special sysfs file and only available when
-		the system is booted to capture the vmcore using FADump.
-		It is used to release the memory reserved by FADump to
-		save the crash dump.
diff --git a/Documentation/arch/powerpc/firmware-assisted-dump.rst b/Documentation/arch/powerpc/firmware-assisted-dump.rst
index 7e266e749cd5..717e30e8b6cd 100644
--- a/Documentation/arch/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/arch/powerpc/firmware-assisted-dump.rst
@@ -19,9 +19,9 @@ in production use.
 - Unlike phyp dump, userspace tool does not need to refer any sysfs
   interface while reading /proc/vmcore.
 - Unlike phyp dump, FADump allows user to release all the memory reserved
-  for dump, with a single operation of echo 1 > /sys/kernel/fadump_release_mem.
+  for dump, with a single operation of echo 1 > /sys/kernel/fadump/release_mem.
 - Once enabled through kernel boot parameter, FADump can be
-  started/stopped through /sys/kernel/fadump_registered interface (see
+  started/stopped through /sys/kernel/fadump/registered interface (see
   sysfs files section below) and can be easily integrated with kdump
   service start/stop init scripts.
 
@@ -86,13 +86,13 @@ as follows:
    network, nas, san, iscsi, etc. as desired.
 
 -  Once the userspace tool is done saving dump, it will echo
-   '1' to /sys/kernel/fadump_release_mem to release the reserved
+   '1' to /sys/kernel/fadump/release_mem to release the reserved
    memory back to general use, except the memory required for
    next firmware-assisted dump registration.
 
    e.g.::
 
-     # echo 1 > /sys/kernel/fadump_release_mem
+     # echo 1 > /sys/kernel/fadump/release_mem
 
 Please note that the firmware-assisted dump feature
 is only available on POWER6 and above systems on pSeries
@@ -152,7 +152,7 @@ then everything but boot memory size of RAM is reserved during
 early boot (See Fig. 2). This area is released once we finish
 collecting the dump from user land scripts (e.g. kdump scripts)
 that are run. If there is dump data, then the
-/sys/kernel/fadump_release_mem file is created, and the reserved
+/sys/kernel/fadump/release_mem file is created, and the reserved
 memory is held.
 
 If there is no waiting dump data, then only the memory required to
@@ -281,7 +281,7 @@ the control files and debugfs file to display memory reserved region.
 
 Here is the list of files under kernel sysfs:
 
- /sys/kernel/fadump_enabled
+ /sys/kernel/fadump/enabled
     This is used to display the FADump status.
 
     - 0 = FADump is disabled
@@ -290,15 +290,15 @@ Here is the list of files under kernel sysfs:
     This interface can be used by kdump init scripts to identify if
     FADump is enabled in the kernel and act accordingly.
 
- /sys/kernel/fadump_registered
+ /sys/kernel/fadump/registered
     This is used to display the FADump registration status as well
     as to control (start/stop) the FADump registration.
 
     - 0 = FADump is not registered.
     - 1 = FADump is registered and ready to handle system crash.
 
-    To register FADump echo 1 > /sys/kernel/fadump_registered and
-    echo 0 > /sys/kernel/fadump_registered for un-register and stop the
+    To register FADump echo 1 > /sys/kernel/fadump/registered and
+    echo 0 > /sys/kernel/fadump/registered for un-register and stop the
     FADump. Once the FADump is un-registered, the system crash will not
     be handled and vmcore will not be captured. This interface can be
     easily integrated with kdump service start/stop.
@@ -308,13 +308,13 @@ Here is the list of files under kernel sysfs:
    This is used to display the memory reserved by FADump for saving the
    crash dump.
 
- /sys/kernel/fadump_release_mem
+ /sys/kernel/fadump/release_mem
     This file is available only when FADump is active during
     second kernel. This is used to release the reserved memory
     region that are held for saving crash dump. To release the
     reserved memory echo 1 to it::
 
-	echo 1  > /sys/kernel/fadump_release_mem
+	echo 1  > /sys/kernel/fadump/release_mem
 
     After echo 1, the content of the /sys/kernel/debug/powerpc/fadump_region
     file will change to reflect the new memory reservations.
@@ -335,17 +335,6 @@ Note: /sys/kernel/fadump_release_opalcore sysfs has moved to
 
     echo 1  > /sys/firmware/opal/mpipl/release_core
 
-Note: The following FADump sysfs files are deprecated.
-
-+----------------------------------+--------------------------------+
-| Deprecated                       | Alternative                    |
-+----------------------------------+--------------------------------+
-| /sys/kernel/fadump_enabled       | /sys/kernel/fadump/enabled     |
-+----------------------------------+--------------------------------+
-| /sys/kernel/fadump_registered    | /sys/kernel/fadump/registered  |
-+----------------------------------+--------------------------------+
-| /sys/kernel/fadump_release_mem   | /sys/kernel/fadump/release_mem |
-+----------------------------------+--------------------------------+
 
 Here is the list of files under powerpc debugfs:
 (Assuming debugfs is mounted on /sys/kernel/debug directory.)
-- 
2.51.1


