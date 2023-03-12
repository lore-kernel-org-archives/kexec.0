Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A800AC6FD19
	for <kexec@archiver.kernel.org>; Sun, 12 Mar 2023 18:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Av5rGc15Lpp/ZG3EKtRwyc0HyNBFBC9IalhXffFNS8A=; b=MK4O2xe7yVeDpJ
	wdP6RuzcuxV4C6SUq95Wa2TsIEr9jXkfJ6pu/oM5eS1m9uozJKGZvhfgc8p12X0AO/7faWkLBZ8Hk
	W6R8ljPV+g+SpWLrtZgRA8gfE/VeT60WMG5mzq3k+Sdx5/mxXrUafWKYib7kdeh6wOfRc0gJrCYPv
	5leX90YiOF3Hhcowv5X7N08v/VefswHzGL2kJdpuFKwZ3tByJgQ02Oj1X/0JImSWG5hFuQwileCO2
	QYC9IkY/xH+wNBrG2YYCfma/ElginYso7eCkRdRvpL9hEYtwFFZMZSLrEK93nK++lts9GdSvFt9qS
	3CNDjUDZ1t5Mhnh5doQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbQC3-003CJN-7D; Sun, 12 Mar 2023 18:13:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbQB5-003Bvp-UP
	for kexec@lists.infradead.org; Sun, 12 Mar 2023 18:12:21 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CDfo37032417;
	Sun, 12 Mar 2023 18:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=klmr4OqZZeiX4cpPm91pBrDaVNlNLbURP4kGEMHP01c=;
 b=qVJfFzxxhMW6JeYILxMLrKJmuh6c4XOgJHu8Cxnu42MjT5ja1WU29wZRfs/DkcazBXcD
 KjGxMnta42FfZwrvQ0pUyPkGc65qjxgBRWt3Wwi+Jf7Xr2iVlG5nxtNktklzYqex+dbO
 dkFUQbbII6WRAGzjVJ/Mj0/9cEjDJGMPAfK43ruyEySN17oSiG4bxP9q9DnwDGAyI/EU
 TLzstBj+J0FZc8pvVsUALKzNeh2+gFXaXKSlSLwkPHN/vDezYXu3dqFsTON0ahsqIWSw
 VgphkvPXTSlpSct2cgeaEPVxk7eqVVHW6mNpGtuyevaskj1jaW2fAt/fFmfoz1exVcEJ tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93k208jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:12 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32CICB0O011103;
	Sun, 12 Mar 2023 18:12:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93k208j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32CAKcdh030084;
	Sun, 12 Mar 2023 18:12:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p8gwfa75u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32CIC6Y866126294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Mar 2023 18:12:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DE6E2004B;
	Sun, 12 Mar 2023 18:12:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57AEC20049;
	Sun, 12 Mar 2023 18:12:04 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.41.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Mar 2023 18:12:04 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v9 3/6] powerpc/crash: add a new member to the kimage_arch struct
Date: Sun, 12 Mar 2023 23:41:51 +0530
Message-Id: <20230312181154.278900-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
References: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f9f5MhXr-VK_ao8q1fBceFNjh_tC8xSc
X-Proofpoint-GUID: uHWEOPEsjcUrqPTQ_kLrmzx2FTcxwjxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303120157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230312_111216_140587_4BB97FDB 
X-CRM114-Status: GOOD (  22.52  )
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
Cc: eric.devolder@oracle.com, bhe@redhat.com, kexec@lists.infradead.org, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A new member "fdt_index" is added to the kimage_arch struct to hold
the index of the FDT (Flattened Device Tree) segment from the kexec
the segment array.

fdt_index will provide direct access to the FDT segment in the kexec
segment array after the kdump kernel is loaded.

The new attribute will be used in the arch crash hotplug handler
(added in upcoming patches) on every CPU and memory hotplug event.

The fdt_index is populated for both kexec_load and kexec_file_load
case.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h |  5 +++++
 arch/powerpc/kexec/core_64.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 8090ad7d97d9d..348eb96e8ca67 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -103,6 +103,8 @@ void kexec_copy_flush(struct kimage *image);
 struct crash_mem;
 int update_cpus_node(void *fdt);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
+int machine_kexec_post_load(struct kimage *image);
+#define machine_kexec_post_load machine_kexec_post_load
 #endif
 
 #if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
@@ -118,6 +120,9 @@ extern const struct kexec_file_ops kexec_elf64_ops;
 struct kimage_arch {
 	struct crash_mem *exclude_ranges;
 
+#if defined(CONFIG_CRASH_HOTPLUG)
+	int fdt_index;
+#endif
 	unsigned long backup_start;
 	void *backup_buf;
 	void *fdt;
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 0b292f93a74cc..531486c973988 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -77,6 +77,37 @@ int machine_kexec_prepare(struct kimage *image)
 	return 0;
 }
 
+int machine_kexec_post_load(struct kimage *kimage)
+{
+#if defined(CONFIG_CRASH_HOTPLUG)
+	int i;
+	void *ptr;
+	unsigned long mem;
+
+	/* Mark fdt_index invalid */
+	kimage->arch.fdt_index = -1;
+
+	/* fdt_index remains invalid if it is not a crash kernel load */
+	if (kimage->type != KEXEC_TYPE_CRASH)
+		return 0;
+	/*
+	 * Find the FDT segment index in kexec segment array and
+	 * assign it to kimage's member fdt_index to enable direct
+	 * access to FDT segment later on.
+	 */
+	for (i = 0; i < kimage->nr_segments; i++) {
+		mem = kimage->segment[i].mem;
+		ptr = __va(mem);
+
+		if (ptr && fdt_magic(ptr) == FDT_MAGIC) {
+			kimage->arch.fdt_index = i;
+			break;
+		}
+	}
+#endif
+	return 0;
+}
+
 /* Called during kexec sequence with MMU off */
 static notrace void copy_segments(unsigned long ind)
 {
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
