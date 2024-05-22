Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95FC25B7C
	for <kexec@archiver.kernel.org>; Wed, 22 May 2024 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z2BttuYIJyNlTjLQm+opWoBlO83Yb+hCEc/1mNFQpoI=; b=slaYsIHxSBqpg1
	ghJAO++Qz/GmREK1AtS4azyCfawbPlNyh7zbLqBAZWuHtRfBDrb9dQ+EeqMhhn7GvavIXJOT2xYmK
	Yre03AB3P+kCZ+A0YlIkqM6K09Nk0S/wL+Z383hIShx3BInYsfVkuNvnPQB+SeKELZ42JW74rxpQg
	fHv2xpEowh1VFeicU1Ro06Ugl3rXgAEnxUk+MfEubVsXTypVpQbIdvbwkRA7FXEXW5tAg9mes7U73
	yaFpTZQb7lK3YIe+sZC87fHbFk7jsRXKHOY6LumMsyDBWGEMlnsEoxNXbe5ckExOgBYUqAWlLnzUl
	uB5TA7/C5wJTz6QcaDiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lne-000000031cl-0pbt;
	Wed, 22 May 2024 13:14:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lnb-000000031ZU-0Ngf
	for kexec@lists.infradead.org;
	Wed, 22 May 2024 13:14:32 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MClMmt022908
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tOFDpdpVAjRTtGhe3Ay9dzY5KJGfF1MUtN67bZdFOpQ=;
 b=cpKYg92MUzQMe3U0QaIE0vkzRIROekEn2ie+rLxhvapbNa2Mc5rW4h9U8JRWkA1OhIM1
 M6uHM/S8KjN80lL5rixMgJxnh8bv+DCZIThIB9AzbelGqPu0hYSREnDaE0IHLSweQQYl
 NbzJD9b0DwO+EvTW7QVwT2JR6jIiFLrN9GboiiZj7Okb9uPI9CE/5nS1ZzPWQpR64Th8
 N6K8nw+7T0km6NAEL4zGhlNacdvU4WQuci9OOPm8efb7Vx54Uj6PdOpduFYiOgS6+g4f
 CkeDrHi1Ra+6QmN4FiruDEh3tt093UBQyKHfXzg2oA8g+9oqv/er+jorwABYQc5k5Qjy 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9h1002p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:15 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDEERS031421
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9h1002p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:14:14 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCJIZB007818;
	Wed, 22 May 2024 13:14:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c33ntk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:14:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44MDE8E050069922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:14:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 294082004B;
	Wed, 22 May 2024 13:14:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2899D20040;
	Wed, 22 May 2024 13:14:05 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.79.246])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2024 13:14:04 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH 2/3] powerpc/kexec_load: add hotplug support
Date: Wed, 22 May 2024 18:43:52 +0530
Message-ID: <20240522131353.198327-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
References: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _9hxV175OLVnBBqdV0po5huh0vZKc5aI
X-Proofpoint-ORIG-GUID: eebQxl862HnR7iGQM8geqs_2_s_3-6iN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_06,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_061431_177341_667B05EA 
X-CRM114-Status: GOOD (  36.36  )
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

Kernel commits b741092d5976 ("powerpc/crash: add crash CPU hotplug
support") and 849599b702ef ("powerpc/crash: add crash memory hotplug
support") added crash CPU/Memory hotplug support on PowerPC. This patch
extends that support for the kexec_load syscall.

During CPU/Memory hotplug events on PowerPC, two kexec segments,
elfcorehdr, and FDT, get updated by the kernel. To ensure the kernel
can safely update these two kexec segments for the kdump image loaded
using the kexec_load system call, the following changes are made:

1. Extra size is allocated for both elfcorehdr and FDT to accommodate
   additional resources in the future. For the elfcorehdr, the size hint
   is taken from /sys/kernel/crash_elfcorehdr_size sysfs, while for FDT,
   extra size is allocated to hold possible CPU nodes.

2. Both elfcorehdr and FDT are skipped from SHA calculation.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c  |  16 ++-
 kexec/arch/ppc64/fdt.c              | 200 +++++++++++++++++++++++++++-
 kexec/arch/ppc64/include/arch/fdt.h |   2 +-
 kexec/arch/ppc64/kexec-elf-ppc64.c  |   2 +-
 kexec/arch/ppc64/kexec-ppc64.c      |  12 +-
 5 files changed, 225 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 6d47898..c14b593 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -476,7 +476,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 				uint64_t max_addr, unsigned long min_base)
 {
 	void *tmp;
-	unsigned long sz;
+	unsigned long sz, memsz;
 	uint64_t elfcorehdr;
 	int nr_ranges, align = 1024, i;
 	unsigned long long end;
@@ -531,8 +531,18 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		}
 	}
 
-	elfcorehdr = add_buffer(info, tmp, sz, sz, align, min_base,
-				max_addr, 1);
+	memsz = sz;
+	/* To support --hotplug, replace the calculated minimum size with the
+	 * value from /sys/kernel/crash_elfcorehdr_size and align it correctly.
+	 */
+	if (do_hotplug) {
+		if (elfcorehdrsz > sz)
+			memsz = _ALIGN(elfcorehdrsz, align);
+	}
+
+	/* Record the location of the elfcorehdr for hotplug handling */
+	info->elfcorehdr = elfcorehdr = add_buffer(info, tmp, sz, memsz, align,
+						   min_base, max_addr, 1);
 	reserve(elfcorehdr, sz);
 	/* modify and store the cmdline in a global array. This is later
 	 * read by flatten_device_tree and modified if required
diff --git a/kexec/arch/ppc64/fdt.c b/kexec/arch/ppc64/fdt.c
index 8bc6d2d..10abc29 100644
--- a/kexec/arch/ppc64/fdt.c
+++ b/kexec/arch/ppc64/fdt.c
@@ -17,6 +17,13 @@
 #include <libfdt.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <dirent.h>
+#include <sys/stat.h>
+
+#include "../../kexec.h"
+#include "../../kexec-syscall.h"
 
 /*
  * Let the kernel know it booted from kexec, as some things (e.g.
@@ -46,17 +53,208 @@ static int fixup_kexec_prop(void *fdt)
 	return 0;
 }
 
+static inline bool is_dot_dir(char * d_path)
+{
+	return d_path[0] == '.';
+}
+
+/*
+ * Returns size of files including file name size under the given
+ * @cpu_node_path.
+ */
+static unsigned int get_cpu_node_size(char *cpu_node_path)
+{
+	DIR *d;
+	struct dirent *de;
+	struct stat statbuf;
+	unsigned int cpu_node_size = 0;
+	char cpu_prop_path[2 * PATH_MAX];
+
+	d = opendir(cpu_node_path);
+	if (!d)
+		return 0;
+
+	while ((de = readdir(d)) != NULL) {
+		if (de->d_type != DT_REG)
+			continue;
+
+		memset(cpu_prop_path, '\0', PATH_MAX);
+		snprintf(cpu_prop_path, 2 * PATH_MAX, "%s/%s", cpu_node_path, de->d_name);
+
+		if (stat(cpu_prop_path, &statbuf))
+			continue;
+
+		cpu_node_size += statbuf.st_size;
+		cpu_node_size += strlen(de->d_name);
+	}
+
+	return cpu_node_size;
+}
+
+/*
+ * Checks if the node specified by the given @path represents a CPU node.
+ *
+ * Returns true if the @path has a "device_type" file containing "cpu";
+ * otherwise, returns false.
+ */
+static bool is_cpu_node(char *path)
+{
+	FILE *file;
+	bool ret = false;
+	char device_type[4];
+
+	file = fopen(path, "r");
+	if (!file)
+		return false;
+
+	memset(device_type, '\0', 4);
+	if (fread(device_type, 1, 3, file) < 3)
+		goto out;
+
+	if (strcmp(device_type, "cpu"))
+		goto out;
+
+	ret = true;
+
+out:
+	fclose(file);
+	return ret;
+}
+
+static unsigned int get_threads_per_cpu(char *path)
+{
+	struct stat statbuf;
+	if (stat(path, &statbuf))
+		return 0;
+
+	return statbuf.st_size / 4;
+}
+
+/*
+ * Finds the following CPU attributes:
+ *
+ * cpus_in_system: Currently available CPU nodes present under
+ *                 /proc/device-tree/cpus.
+ * threads_per_cpu: Number of threads per CPU, based on the device tree entry
+ *                  /proc/device-tree/cpus/<cpu_node>/ibm,ppc-interrupt-server#s.
+ * cpu_node_size: Size of files including file name size under a CPU node.
+ *
+ * Returns 0 on success, else -1.
+ */
+static unsigned int get_cpu_info(int *_cpus_in_system, int *_threads_per_cpu,
+				 int *_cpu_node_size)
+{
+	DIR *d;
+	struct dirent *de;
+	int first_cpu = 1;
+	char path[PATH_MAX];
+	char *cpus_node_path = "/proc/device-tree/cpus";
+	int cpus_in_system = 0, threads_per_cpu = 0, cpu_node_size = 0;
+
+	d = opendir(cpus_node_path);
+	if (!d)
+		return -1;
+
+	while ((de = readdir(d)) != NULL) {
+		if ((de->d_type != DT_DIR) || is_dot_dir(de->d_name))
+			continue;
+
+		memset(path, '\0', PATH_MAX);
+		snprintf(path, PATH_MAX, "%s/%s/%s", cpus_node_path,
+			 de->d_name, "device_type");
+
+		/* Skip nodes with device_type != "cpu" */
+		if (!is_cpu_node(path))
+			continue;
+
+		/*
+		 * Found the first node under /proc/device-tree/cpus with
+		 * device_type == "cpu"
+		 */
+		if (first_cpu) {
+			memset(path, '\0', PATH_MAX);
+			snprintf(path, PATH_MAX, "%s/%s", cpus_node_path, de->d_name);
+			cpu_node_size = get_cpu_node_size(path);
+
+			memset(path, '\0', PATH_MAX);
+			snprintf(path, PATH_MAX, "%s/%s/%s", cpus_node_path,
+				 de->d_name, "ibm,ppc-interrupt-server#s");
+			threads_per_cpu = get_threads_per_cpu(path);
+
+			first_cpu = 0;
+		}
+
+		cpus_in_system++;
+	}
+
+	closedir(d);
+
+	dbgprintf("cpus_in_system: %d, threads_per_cpus: %d, cpu_node_size: %d\n",
+		  cpus_in_system, threads_per_cpu, cpu_node_size);
+
+	if (!(cpus_in_system && threads_per_cpu && cpu_node_size))
+		return -1;
+
+	*_cpus_in_system = cpus_in_system;
+	*_threads_per_cpu = threads_per_cpu;
+	*_cpu_node_size = cpu_node_size;
+
+	return 0;
+}
+
+/*
+ * Calculates the extra size needed for the flattened device tree (FDT) based
+ * on the difference between the possible number of CPU nodes and the number
+ * of CPU nodes present under /proc/device-tree/cpus.
+ */
+static unsigned int kdump_fdt_extra_size(void)
+{
+	unsigned int extra_size = 0;
+	int cpus_in_system = 0, threads_per_cpu = 0, cpu_node_size = 0;
+	int possible_cpus;
+
+	/* ALL possible CPUs are present in FDT so no extra size required */
+	if (sysconf(_SC_NPROCESSORS_ONLN) == sysconf(_SC_NPROCESSORS_CONF))
+		return 0;
+
+	if (get_cpu_info(&cpus_in_system, &threads_per_cpu, &cpu_node_size)) {
+		die("Failed to get cpu info\n");
+	}
+
+	/*
+	 * Maximum number of CPU nodes with device_type = "cpu" possible under
+	 * /proc/device-tree/cpus/
+	 */
+	possible_cpus = sysconf(_SC_NPROCESSORS_CONF) / threads_per_cpu;
+
+	if (cpus_in_system > possible_cpus)
+		die("Possible CPU nodes can't be less than active CPU nodes\n");
+
+
+	extra_size = (possible_cpus - cpus_in_system) * cpu_node_size;
+	dbgprintf("kdump fdt extra size: %u\n", extra_size);
+
+	return extra_size;
+}
 
 /*
  * For now, assume that the added content fits in the file.
  * This should be the case when flattening from /proc/device-tree,
  * and when passing in a dtb, dtc can be told to add padding.
  */
-int fixup_dt(char **fdt, off_t *size)
+int fixup_dt(char **fdt, off_t *size, unsigned long kexec_flags)
 {
 	int ret;
 
 	*size += 4096;
+
+	/* To support --hotplug option for the kexec_load syscall, consider
+	 * adding extra buffer to FDT so that the kernel can add CPU nodes
+	 * of hot-added CPUs.
+	 */
+	if (do_hotplug && (kexec_flags & KEXEC_ON_CRASH))
+		*size += kdump_fdt_extra_size();
+
 	*fdt = realloc(*fdt, *size);
 	if (!*fdt) {
 		fprintf(stderr, "%s: out of memory\n", __func__);
diff --git a/kexec/arch/ppc64/include/arch/fdt.h b/kexec/arch/ppc64/include/arch/fdt.h
index b19f185..5f340b0 100644
--- a/kexec/arch/ppc64/include/arch/fdt.h
+++ b/kexec/arch/ppc64/include/arch/fdt.h
@@ -3,6 +3,6 @@
 
 #include <sys/types.h>
 
-int fixup_dt(char **fdt, off_t *size);
+int fixup_dt(char **fdt, off_t *size, unsigned long kexec_flags);
 
 #endif
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index bdcfd20..858c994 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -345,7 +345,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 		create_flatten_tree(&seg_buf, &seg_size, cmdline);
 	}
 
-	result = fixup_dt(&seg_buf, &seg_size);
+	result = fixup_dt(&seg_buf, &seg_size, info->kexec_flags);
 	if (result < 0)
 		return result;
 
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index fb27b6b..f27d76b 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -24,6 +24,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <string.h>
+#include <libfdt.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <dirent.h>
@@ -968,7 +969,16 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
-int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info)
 {
+	if (!seg_ptr)
+		return 0;
+
+	if (info->elfcorehdr == (unsigned long) seg_ptr->mem)
+		return 1;
+
+	if (seg_ptr->buf && fdt_magic(seg_ptr->buf) == FDT_MAGIC)
+		return 1;
+
 	return 0;
 }
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
