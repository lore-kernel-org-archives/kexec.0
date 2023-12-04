Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03690C4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 05:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+2DbmV0X62jy4grezpETjwtmw3fOFVJ2D1N1KF41ny0=; b=QeumZmg13Wkgpd
	ps/iH+6Z8nH16850762ZJFDrS4HnOBdTm+bFnI3TN0AcReSaRnuljnK5V5O1z6aP7FwrorXadkJrk
	Tg1vqTvPJOUAcdYebJwMamXxMT82ak/N3gvq1DYLe3t+D7MLTb+sdxl6xm5nBrOMAH0+BYuEePmSK
	dgOHRlcYLwKgeHVSq/gMsSfxFx1L+6EzhP/Fnn+Zaw/heNLBCeA2FXWrwO5hQorb52/A+sR0xmuCJ
	Xb+Gglz8EDjqxX78m2TyuugK650tZrTFZ22/6guQspWMAeFrx04XUFoNi+DNdUFdBCiz7dN7BR+yY
	moVZoJIydFBxDhzTodUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA1ad-00330A-0x;
	Mon, 04 Dec 2023 05:33:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA1aV-0032xg-2h
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 05:33:49 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44rfcO011271;
	Mon, 4 Dec 2023 05:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iLZAwxKLfdHbavc/+JNK76zPz9jW2Xal6th/Gh9ZIIU=;
 b=SE1+bH6CDG9y7XuxnoYOq2EPo2oisRqOh0HFmzXyj4aoYs3HHu20f67eOfm86Fu7TAqh
 dCkS5MkwM/ab8mtMd+PeZe7fvpKLY3NED6kVidYpsWSUT3BNxLiyVX8jht4yfNBtyUFU
 QIzYe6wPGTol0ei7bb4VhoS0w7ZSCWT8Uvgrkv9/9WTG6FSgIa+BzkADlgb9SMYHD5LZ
 j4mn1G/GMn2QZlTdZ+T5wMVJORD0fRk2/wmnPwDTx4Ci5tjgypkVUSjbJrciZCQ+e4r7
 J0zrKS84dx1NXbE375iuhV2rpS3RQn0o/j5Pn+WxyFkQk/QIX7/cBpm5AHygm1vWV/rw ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3us84x10tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B45LLwh024392;
	Mon, 4 Dec 2023 05:33:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3us84x10sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44nZvq014913;
	Mon, 4 Dec 2023 05:33:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8dk49n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 05:33:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B45XRsw43123026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 05:33:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B210020040;
	Mon,  4 Dec 2023 05:33:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 922CF20043;
	Mon,  4 Dec 2023 05:33:22 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.c4p-in.ibmmobiledemo.com (unknown [9.43.24.184])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 05:33:22 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
Subject: [PATCH v13 3/6] crash: add a new kexec flag for FDT update
Date: Mon,  4 Dec 2023 11:02:50 +0530
Message-ID: <20231204053253.25305-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231204053253.25305-1-sourabhjain@linux.ibm.com>
References: <20231204053253.25305-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o5C53qyVL9jGek2U1Yb0nt5Uh-sAHa_V
X-Proofpoint-ORIG-GUID: l89ydKwzanUUSzSapO8FMaNjV6i6HwJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_213348_072661_58E9B8CE 
X-CRM114-Status: GOOD (  24.44  )
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
index 0f6ea35879ee..bcedb7625b1f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -319,6 +319,7 @@ struct kimage {
 #ifdef CONFIG_CRASH_HOTPLUG
 	/* If set, allow changes to elfcorehdr of kexec_load'd image */
 	unsigned int update_elfcorehdr:1;
+	unsigned int update_fdt:1;
 #endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
@@ -396,9 +397,10 @@ bool kexec_load_permitted(int kexec_image_type);
 
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
index 8f35a5a42af8..97eb151cd931 100644
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
