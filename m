Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA167C4332F
	for <kexec@archiver.kernel.org>; Sun, 29 Oct 2023 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3uQPVvw44yBKWoEswUQoWU/MYuf6A9R3MMBq2IomHDY=; b=UjhWh+aYlREMUs
	k2GHAEvKCKhlVtWIbBifkkvIuCJPMb3j5AXl9a3WK5KUT7DPJnC9ttNuOI2Kzdn7ADOlNh2nFFVky
	HyTUKtvw26sCev3aQtCd/LXcGk9zoBAB1P04jsB2DIQucPwTM0701dMm98AcBv+EYNa21IC+eIiSC
	dEscMJGPCWce92qCs0SJXXtnCq4EcXBx1b6bAjntkcS1WsPSpH+As0PznHZUidjMQJB5mWY9W+GHi
	jarVjAsk3eP4c2IxTFMKO79KgnhmBIVhfysEJjzjdWrTiu8xqI6+NC3KNyhpJ/ErQi4r8cZ2TUriN
	VpvVptDkXb1Zvy4a7N8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qx58D-001kFk-1Y;
	Sun, 29 Oct 2023 12:43:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qx58A-001kF4-2l
	for kexec@lists.infradead.org;
	Sun, 29 Oct 2023 12:43:04 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39T9En0r013029;
	Sun, 29 Oct 2023 12:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2vtuKMdFH9C+t0cshjZsmMRfeSNouMxWFvmQM5OWhUY=;
 b=lKEPtrWTi8XVJXQKxLV6DWu60rx9SVn/DO65DbIQZhbWdbbw++8FeUb8DwjR7D1yPYHF
 6E0HaPhVx34ooACOB4U47/V3PhaMzyuvyRJfLE8lBio46jTB/0cpP8WQxn2QzNkXHEpT
 TraGCAwv/+wIC05BVCOBqxEJgpGDCRnxeegybKEyTxcgJecFPFxk9w8G44c1Dn2hs4US
 GdJ+UkRZNNTP0AUZTlwxhM3YzHokqKhgsn3zc579EN90PTu5uCTvo91Qs+AV5IoDJCIK
 g+Tdz/ZauBlIXtttGnLgAjwe9f3EKMCUgDcipFSGKfjzuawpTqNtAMBNPTtautVWpVyR pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u18yxducp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Oct 2023 12:42:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39TBtZW2023686;
	Sun, 29 Oct 2023 12:42:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u18yxduc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Oct 2023 12:42:46 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39TBU4U1007713;
	Sun, 29 Oct 2023 12:42:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmn2ueh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Oct 2023 12:42:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39TCf3ul47055148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Oct 2023 12:41:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7211F20049;
	Sun, 29 Oct 2023 12:41:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A2B920040;
	Sun, 29 Oct 2023 12:40:58 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.28.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 29 Oct 2023 12:40:58 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Akhil Raj <lf32.dev@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v12 3/6] crash: add a new kexec flag for FDT update
Date: Sun, 29 Oct 2023 18:10:36 +0530
Message-ID: <20231029124039.6158-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029124039.6158-1-sourabhjain@linux.ibm.com>
References: <20231029124039.6158-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K_4Mjtn8p6eA7MzXs7v7UqBcqY2-ULF6
X-Proofpoint-GUID: ulrPz1rsntucKopmj8Jmx4BYEHVt4HrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-29_01,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310290109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_054302_901639_1E98A698 
X-CRM114-Status: GOOD (  23.09  )
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

The commit a72bbec70da2 ("crash: hotplug support for kexec_load()")
introduced a new kexec flag, `KEXEC_UPDATE_ELFCOREHDR`. Kexec tool uses
this flag to indicate kernel that it is safe to modify the elfcorehdr
of kdump image loaded using kexec_load system call.

Similarly, add a new kexec flag, `KEXEC_UPDATE_FDT`, for another kdump
component named FDT (Flatten Device Tree). Architectures like PowerPC
need to update FDT kdump image component on CPU hotplug events. Kexec
tool passing `KEXEC_UPDATE_FDT` will be an indication to kernel that FDT
segment is not part of SHA calculation hence it is safe to update it.

With the `KEXEC_UPDATE_ELFCOREHDR` and `KEXEC_UPDATE_FDT` kexec flags,
crash hotplug support can be added to PowerPC for the kexec_load syscall
while maintaining the backward compatibility with older kexec tools that
do not have these newly introduced flags.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Akhil Raj <lf32.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Cc: x86@kernel.org
---
 include/linux/kexec.h      | 6 ++++--
 include/uapi/linux/kexec.h | 1 +
 kernel/kexec.c             | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e9f70d7b7d16..16f03e79d82f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -323,6 +323,7 @@ struct kimage {
 #ifdef CONFIG_CRASH_HOTPLUG
 	/* If set, allow changes to elfcorehdr of kexec_load'd image */
 	unsigned int update_elfcorehdr:1;
+	unsigned int update_fdt:1;
 #endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
@@ -400,9 +401,10 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_UPDATE_FDT)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
+			KEXEC_UPDATE_FDT)
 #endif
 
 /* List of defined/legal kexec file flags */
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 01766dd839b0..3d5b3d757bed 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -13,6 +13,7 @@
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
+#define KEXEC_UPDATE_FDT	0x00000008
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 107f355eac10..baf3fe39fce7 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -132,6 +132,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 #ifdef CONFIG_CRASH_HOTPLUG
 	if (flags & KEXEC_UPDATE_ELFCOREHDR)
 		image->update_elfcorehdr = 1;
+	if (flags & KEXEC_UPDATE_FDT)
+		image->update_fdt = 1;
 #endif
 
 	ret = machine_kexec_prepare(image);
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
