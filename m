Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703A6CED626
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OijQSmL3DVNAHG4vRMq9CPAE21tJXlql0115I6CHgLk=; b=ekvw6+d+yRtY5gPzsWhFwZfwyu
	c7mO3uwdeT8Zoy6AR0yZKsl+bB8XOaTCCGOC5xQEknuDKAUCdjzeUZ8wEJxyWB45ozm1RpliL7xQG
	sn7NccAynZemPnE6rmHZRJy2R0bDT3YdCo0vTlxfldS404Qj0fapnLsws/wPHVJ+oD267A9RYgJVL
	ZGmxgPQXzevFA17vcwaqUyt6sKXtkgY3yz9ippKCiTuyMcSj6ZlGpMm+dpKhwz/qt3a6e5+hznhVH
	WOLZjJ7TKdycTde44tdqFGPR26f0yvLhnuwuLvtA4GluATwEKxKZULFvJOOd8MSUcJdBzfZg5mjul
	oKh7elpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLK9N-00000000LtI-1jHA;
	Tue, 18 Nov 2025 11:45:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLK9K-00000000Lsf-28XV
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 11:45:32 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI0oce5032544;
	Tue, 18 Nov 2025 11:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OijQSmL3DVNAHG4vR
	Mq9CPAE21tJXlql0115I6CHgLk=; b=gOVgFH5+O7O5qiM1PU9E0S5VXbMHkCW5x
	sNPJmL7mY3iQD7EgIJoUmilOYbDFSTtTHM+qBju7ROXImGukoBZF8mGvIX1PNRuN
	uVi9sJeOAc+mWjLudkb5QQIRE02qXJqg+sOueQcxK1KZ6ZGjDmvr1S7EbhlmNnRz
	BPcENEmsGCcE/+Bebc4NQpkHl/UeRjJ7FKB4qkI0ndu9k4X3ax2HwJsJRYmOeg8J
	qp2okxjXDJ2mSV76Jy+oxzF8I3O6fSbgcaTdH9d7V2wLoDOc6ZPT6oOcdnU+G7hd
	AT0trBiwsbNxiZdOJcmahOCyjSWhrLKFDPKhRQDDL7o8lEEsoW7/w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1agy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:45:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AIBfBNS028113;
	Tue, 18 Nov 2025 11:45:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1agy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:45:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIBIOnx030791;
	Tue, 18 Nov 2025 11:45:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47xtyuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:45:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AIBjObQ49873210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 11:45:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF9B32004D;
	Tue, 18 Nov 2025 11:45:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3356C20040;
	Tue, 18 Nov 2025 11:45:20 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.39.25.190])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 11:45:19 +0000 (GMT)
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
Subject: [PATCH v6 1/3] kexec: move sysfs entries to /sys/kernel/kexec
Date: Tue, 18 Nov 2025 17:15:05 +0530
Message-ID: <20251118114507.1769455-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118114507.1769455-1-sourabhjain@linux.ibm.com>
References: <20251118114507.1769455-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691c5c59 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=JfrnYn6hAAAA:8
 a=U2Ygq2YiFZyyzztlTvUA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: dlpFKhDaGtTpgSSY-EjodQ6RrCrQ1Bsy
X-Proofpoint-ORIG-GUID: IICxkQjRsqB-msviBVi9_tiPwGJLXQlR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8EwWlSg80jtL
 WbC8QeGy3zhwh+F9/BbLO5N44zx2WoRQDpkDIgK8fR6VoQ2sxMlwfRBRzOcAliUc9aS6DPQPoLe
 hEJFlI/QkD0r8NTslt3JMADJB6u63ofWfCbDFEqt6kl3wnoPQNM+IZaN5eIMzhqROcXmvSGKF1Q
 EEOBXhEWraJQUo0Gvnkm8kSleNWn3pmc2/Gh3o5GqDRpwCvhG6AUBfL0neYhOWHLEmGbIG1jpg1
 rW60pYmgUMEVHPEfH6MKpfl3/25fdw5IzyZqZ1myHaexffajNz/2tyjMPjPMjsT0k8GbW5Wb5js
 aXy1rmm3i+wvMllINmHsZB7tvVFdSv0rKCbg3Kc5BRNHxNZqcchtwRLp9Fwd0D22wCwp4fNQzDv
 96WJvtJeNSJAfrxqYgNaZug964N3qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_034530_557168_F489DD7C 
X-CRM114-Status: GOOD (  24.31  )
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

Several kexec and kdump sysfs entries are currently placed directly
under /sys/kernel/, which clutters the directory and makes it harder to
identify unrelated entries. To improve organization and readability,
these entries are now moved under a dedicated directory,
/sys/kernel/kexec.

The following sysfs moved under new kexec sysfs node
+------------------------------------+------------------+
|    Old sysfs name         |     New sysfs name        |
|  (under /sys/kernel)      | (under /sys/kernel/kexec) |
+---------------------------+---------------------------+
| kexec_loaded              | loaded                    |
+---------------------------+---------------------------+
| kexec_crash_loaded        | crash_loaded              |
+---------------------------+---------------------------+
| kexec_crash_size          | crash_size                |
+---------------------------+---------------------------+
| crash_elfcorehdr_size     | crash_elfcorehdr_size     |
+---------------------------+---------------------------+
| kexec_crash_cma_ranges    | crash_cma_ranges          |
+---------------------------+---------------------------+

For backward compatibility, symlinks are created at the old locations
so that existing tools and scripts continue to work. These symlinks can
be removed in the future once users have switched to the new path.

While creating symlinks, entries are added in /sys/kernel/ that point
to their new locations under /sys/kernel/kexec/. If an error occurs
while adding a symlink, it is logged but does not stop initialization
of the remaining kexec sysfs symlinks.

The /sys/kernel/<crash_elfcorehdr_size | kexec/crash_elfcorehdr_size>
entry is now controlled by CONFIG_CRASH_DUMP instead of
CONFIG_VMCORE_INFO, as CONFIG_CRASH_DUMP also enables
CONFIG_VMCORE_INFO.

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
 kernel/kexec_core.c | 141 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c     |  89 +---------------------------
 2 files changed, 142 insertions(+), 88 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..02429499fb64 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
+#include <linux/sysfs.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1229,3 +1230,143 @@ int kernel_kexec(void)
 	kexec_unlock();
 	return error;
 }
+
+static ssize_t loaded_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", !!kexec_image);
+}
+static struct kobj_attribute loaded_attr = __ATTR_RO(loaded);
+
+#ifdef CONFIG_CRASH_DUMP
+static ssize_t crash_loaded_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", kexec_crash_loaded());
+}
+static struct kobj_attribute crash_loaded_attr = __ATTR_RO(crash_loaded);
+
+#ifdef CONFIG_CRASH_RESERVE
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
+#endif
+
+static ssize_t crash_size_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	ssize_t size = crash_get_memory_size();
+
+	if (size < 0)
+		return size;
+
+	return sysfs_emit(buf, "%zd\n", size);
+}
+static ssize_t crash_size_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned long cnt;
+	int ret;
+
+	if (kstrtoul(buf, 0, &cnt))
+		return -EINVAL;
+
+	ret = crash_shrink_memory(cnt);
+	return ret < 0 ? ret : count;
+}
+static struct kobj_attribute crash_size_attr = __ATTR_RW(crash_size);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+static struct kobj_attribute crash_elfcorehdr_size_attr = __ATTR_RO(crash_elfcorehdr_size);
+
+#endif /* CONFIG_CRASH_HOTPLUG */
+#endif /* CONFIG_CRASH_DUMP */
+
+static struct attribute *kexec_attrs[] = {
+	&loaded_attr.attr,
+#ifdef CONFIG_CRASH_DUMP
+	&crash_loaded_attr.attr,
+	&crash_size_attr.attr,
+#ifdef CONFIG_CRASH_RESERVE
+	&crash_cma_ranges_attr.attr,
+#endif
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
+#endif
+	NULL
+};
+
+struct kexec_link_entry {
+	const char *target;
+	const char *name;
+};
+
+static struct kexec_link_entry kexec_links[] = {
+	{ "loaded", "kexec_loaded" },
+#ifdef CONFIG_CRASH_DUMP
+	{ "crash_loaded", "kexec_crash_loaded" },
+	{ "crash_size", "kexec_crash_size" },
+#ifdef CONFIG_CRASH_RESERVE
+	{"crash_cma_ranges", "kexec_crash_cma_ranges"},
+#endif
+#ifdef CONFIG_CRASH_HOTPLUG
+	{ "crash_elfcorehdr_size", "crash_elfcorehdr_size" },
+#endif
+#endif
+};
+
+static struct kobject *kexec_kobj;
+ATTRIBUTE_GROUPS(kexec);
+
+static int __init init_kexec_sysctl(void)
+{
+	int error;
+	int i;
+
+	kexec_kobj = kobject_create_and_add("kexec", kernel_kobj);
+	if (!kexec_kobj) {
+		pr_err("failed to create kexec kobject\n");
+		return -ENOMEM;
+	}
+
+	error = sysfs_create_groups(kexec_kobj, kexec_groups);
+	if (error)
+		goto kset_exit;
+
+	for (i = 0; i < ARRAY_SIZE(kexec_links); i++) {
+		error = compat_only_sysfs_link_entry_to_kobj(kernel_kobj, kexec_kobj,
+							     kexec_links[i].target,
+							     kexec_links[i].name);
+		if (error)
+			pr_err("Unable to create %s symlink (%d)", kexec_links[i].name, error);
+	}
+
+	return 0;
+
+kset_exit:
+	kobject_put(kexec_kobj);
+	return error;
+}
+
+subsys_initcall(init_kexec_sysctl);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 0ff2179bc603..a9e6354d9e25 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -12,7 +12,7 @@
 #include <linux/sysfs.h>
 #include <linux/export.h>
 #include <linux/init.h>
-#include <linux/kexec.h>
+#include <linux/vmcore_info.h>
 #include <linux/profile.h>
 #include <linux/stat.h>
 #include <linux/sched.h>
@@ -119,68 +119,6 @@ static ssize_t profiling_store(struct kobject *kobj,
 KERNEL_ATTR_RW(profiling);
 #endif
 
-#ifdef CONFIG_KEXEC_CORE
-static ssize_t kexec_loaded_show(struct kobject *kobj,
-				 struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", !!kexec_image);
-}
-KERNEL_ATTR_RO(kexec_loaded);
-
-#ifdef CONFIG_CRASH_DUMP
-static ssize_t kexec_crash_loaded_show(struct kobject *kobj,
-				       struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", kexec_crash_loaded());
-}
-KERNEL_ATTR_RO(kexec_crash_loaded);
-
-#ifdef CONFIG_CRASH_RESERVE
-static ssize_t kexec_crash_cma_ranges_show(struct kobject *kobj,
-				    struct kobj_attribute *attr, char *buf)
-{
-
-	ssize_t len = 0;
-	int i;
-
-	for (i = 0; i < crashk_cma_cnt; ++i) {
-		len += sysfs_emit_at(buf, len, "%08llx-%08llx\n",
-				     crashk_cma_ranges[i].start,
-				     crashk_cma_ranges[i].end);
-	}
-	return len;
-}
-KERNEL_ATTR_RO(kexec_crash_cma_ranges);
-#endif /* CONFIG_CRASH_RESERVE */
-
-static ssize_t kexec_crash_size_show(struct kobject *kobj,
-				       struct kobj_attribute *attr, char *buf)
-{
-	ssize_t size = crash_get_memory_size();
-
-	if (size < 0)
-		return size;
-
-	return sysfs_emit(buf, "%zd\n", size);
-}
-static ssize_t kexec_crash_size_store(struct kobject *kobj,
-				   struct kobj_attribute *attr,
-				   const char *buf, size_t count)
-{
-	unsigned long cnt;
-	int ret;
-
-	if (kstrtoul(buf, 0, &cnt))
-		return -EINVAL;
-
-	ret = crash_shrink_memory(cnt);
-	return ret < 0 ? ret : count;
-}
-KERNEL_ATTR_RW(kexec_crash_size);
-
-#endif /* CONFIG_CRASH_DUMP*/
-#endif /* CONFIG_KEXEC_CORE */
-
 #ifdef CONFIG_VMCORE_INFO
 
 static ssize_t vmcoreinfo_show(struct kobject *kobj,
@@ -192,18 +130,6 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
-#ifdef CONFIG_CRASH_HOTPLUG
-static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
-			       struct kobj_attribute *attr, char *buf)
-{
-	unsigned int sz = crash_get_elfcorehdr_size();
-
-	return sysfs_emit(buf, "%u\n", sz);
-}
-KERNEL_ATTR_RO(crash_elfcorehdr_size);
-
-#endif
-
 #endif /* CONFIG_VMCORE_INFO */
 
 /* whether file capabilities are enabled */
@@ -273,21 +199,8 @@ static struct attribute * kernel_attrs[] = {
 #ifdef CONFIG_PROFILING
 	&profiling_attr.attr,
 #endif
-#ifdef CONFIG_KEXEC_CORE
-	&kexec_loaded_attr.attr,
-#ifdef CONFIG_CRASH_DUMP
-	&kexec_crash_loaded_attr.attr,
-	&kexec_crash_size_attr.attr,
-#ifdef CONFIG_CRASH_RESERVE
-	&kexec_crash_cma_ranges_attr.attr,
-#endif
-#endif
-#endif
 #ifdef CONFIG_VMCORE_INFO
 	&vmcoreinfo_attr.attr,
-#ifdef CONFIG_CRASH_HOTPLUG
-	&crash_elfcorehdr_size_attr.attr,
-#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.51.1


