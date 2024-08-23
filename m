Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B052FC531DC
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Qwg66KPV6a/93iKQaBYBacrsdDxIJLzLPFyHpzSk6WM=; b=jWodPk4MoIRzj9
	nS67ozTgvnEQdvuflbaTj2/FcsB/G4iP0/msj66Xq8MU4pu3d+feaJ3pzepjl+7M55toaoJGIXHdc
	p//bibcSWtSCJwRD7UH7kR67dOM5W46nslaSPHz5cRYR5SiMq4OhyOyD6d5HxRO0Kf0+pNG0hn8BV
	AdrW4V9JYpDWIwfI/fbltwN298lf2+tsnaPCX/cRxHfOEBGfs730Ealr9GTqwEHnYMzJfmjx1rMFe
	9fDPxHJ6uiFjC74gJx1lPnU4w5XwFMQarIdQ2/UTKd7OWCxQToR41sKX52edfpEWhrzWayZlH10x6
	SswVCz6fuXOOmTa0MAsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shSqd-0000000GaV2-1Q4T;
	Fri, 23 Aug 2024 11:52:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shSqS-0000000GaTU-1Xfr
	for kexec@lists.infradead.org;
	Fri, 23 Aug 2024 11:52:46 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N6SW2w011158;
	Fri, 23 Aug 2024 11:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=vTkBDv5ceaxAf2c7bC/ZTr2ksX
	6JSrRgLGjmVWqKHZ0=; b=gDQSys6nsZiJjfDrxlUc4XaM3oMoLb3yRZ2oO5hxDM
	cp86L7E0SxOjdzSWyT8hAoT4wKVlq4dscgTWVWGuTPbzccTAk0Vjo+elPDxJ1iDy
	YZdzUDt34LokwtbggVUiqEmPdIhsHnyOr5stTsLmi+LWFbFv5kQRA9PmawKmarIY
	56t6MTBULYYv8r7iiOK9JbaoaplzTtFrgP8+9CnDweEZafNlqm11TJ7CucBKRw8Q
	Ah9tb8k1pMh2ls1rVgQ/oiW5kyn/xe2UMz66MND+7z7vUpyFYS3p/nRdZFVa+tLU
	VPuaYJZ0S8U/P1qbeP17mAghbHmVyFcmJvUqK1TbKA7Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc53tqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 11:52:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NBqbp3020368;
	Fri, 23 Aug 2024 11:52:37 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc53tqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 11:52:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47N7nT0x029443;
	Fri, 23 Aug 2024 11:52:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dmsf3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 11:52:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NBqVwL55509296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 11:52:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082B82004B;
	Fri, 23 Aug 2024 11:52:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B6A20040;
	Fri, 23 Aug 2024 11:52:28 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.120.212])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 11:52:28 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH] [RFC] crash: Lock-free crash hotplug support reporting
Date: Fri, 23 Aug 2024 17:22:26 +0530
Message-ID: <20240823115226.835865-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8hfry96WB_4XfsoQF-PgNWc7OgRd_3At
X-Proofpoint-GUID: _QnM_hpx8XMPIJVMiYp6BS7xmF0q5KAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_045244_783211_00CE8733 
X-CRM114-Status: GOOD (  23.42  )
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

On a CPU/Memory hotplug event, the kexec lock is taken to update the
kdump image. At the same time, this lock is also required to report
the support for crash hotplug to user-space via the
/sys/devices/system/[cpu|memory]/crash_hotplug sysfs interface, to
avoid kdump reload.

The kexec lock is needed to report crash hotplug support because the
crash_hotplug variable, which tracks crash hotplug support, is part of
the kdump image, and the kdump image needs to be updated during a
hotplug event.

Given that only one kdump image can be loaded at any given time, the
crash_hotplug variable can be placed outside the kdump image and set or
reset during kdump image load and unload. This allows crash hotplug
support to be reported without taking the kexec lock.

This would help in situation where CPU/Memory resource are hotplug from
system in bulk.

Commit e2a8f20dd8e9 ("Crash: add lock to serialize crash hotplug
handling") introduced to serialize the kexec lock during bulk CPU/Memory
hotplug events. However, with these changes, the kexec lock for crash
hotplug support reporting can be avoided altogether.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 include/linux/kexec.h | 11 ++++-------
 kernel/crash_core.c   | 27 +++++++++------------------
 kernel/kexec.c        |  5 ++++-
 kernel/kexec_file.c   |  7 ++++++-
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..bd755ba6bac4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -318,13 +318,6 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
-#ifdef CONFIG_CRASH_HOTPLUG
-	/* If set, it is safe to update kexec segments that are
-	 * excluded from SHA calculation.
-	 */
-	unsigned int hotplug_support:1;
-#endif
-
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
 #endif
@@ -370,6 +363,10 @@ struct kimage {
 	unsigned long elf_load_addr;
 };
 
+#ifdef CONFIG_CRASH_HOTPLUG
+extern unsigned int crash_hotplug_support;
+#endif
+
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..3428deba0070 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -30,6 +30,13 @@
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
 
+#ifdef CONFIG_CRASH_HOTPLUG
+/* if set, it is safe to update kexec segments that are
+ * excluded from sha calculation.
+ */
+unsigned int crash_hotplug_support;
+#endif
+
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
@@ -500,23 +507,7 @@ static DEFINE_MUTEX(__crash_hotplug_lock);
  */
 int crash_check_hotplug_support(void)
 {
-	int rc = 0;
-
-	crash_hotplug_lock();
-	/* Obtain lock while reading crash information */
-	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
-		crash_hotplug_unlock();
-		return 0;
-	}
-	if (kexec_crash_image) {
-		rc = kexec_crash_image->hotplug_support;
-	}
-	/* Release lock now that update complete */
-	kexec_unlock();
-	crash_hotplug_unlock();
-
-	return rc;
+	return crash_hotplug_support;
 }
 
 /*
@@ -552,7 +543,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	image = kexec_crash_image;
 
 	/* Check that kexec segments update is permitted */
-	if (!image->hotplug_support)
+	if (!crash_hotplug_support)
 		goto out;
 
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
diff --git a/kernel/kexec.c b/kernel/kexec.c
index a6b3f96bb50c..d5c6b51eaa8b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -116,6 +116,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		/* Uninstall image */
 		kimage_free(xchg(dest_image, NULL));
 		ret = 0;
+#ifdef CONFIG_CRASH_HOTPLUG
+		crash_hotplug_support = 0;
+#endif
 		goto out_unlock;
 	}
 	if (flags & KEXEC_ON_CRASH) {
@@ -136,7 +139,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 #ifdef CONFIG_CRASH_HOTPLUG
 	if ((flags & KEXEC_ON_CRASH) && arch_crash_hotplug_support(image, flags))
-		image->hotplug_support = 1;
+		crash_hotplug_support = 1;
 #endif
 
 	ret = machine_kexec_prepare(image);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3d64290d24c9..b326edb90fd7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -378,7 +378,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 #ifdef CONFIG_CRASH_HOTPLUG
 	if ((flags & KEXEC_FILE_ON_CRASH) && arch_crash_hotplug_support(image, flags))
-		image->hotplug_support = 1;
+		crash_hotplug_support = 1;
 #endif
 
 	ret = machine_kexec_prepare(image);
@@ -432,6 +432,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		arch_kexec_protect_crashkres();
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (flags & KEXEC_FILE_UNLOAD)
+		crash_hotplug_support = 0;
+#endif
+
 	kexec_unlock();
 	kimage_free(image);
 	return ret;
-- 
2.46.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
