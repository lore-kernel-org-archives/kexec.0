Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BDAC433EF
	for <kexec@archiver.kernel.org>; Mon, 20 Jun 2022 07:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=69bJlvYw/4WsDtSqGMi1M6yraCITIuWMjdVCgLAOfrA=; b=IipKowFWxueK6L
	6T7nS7eFGEgFzkJGuOx3Kn111QTdkbGyM+3kT/fyUwen0wOBmuk6NUPTd7wZdWFi79Tt4A5u5V7kr
	hyDGOjvmOdaHvQz5zBwWr9/xc6ZpV2nz6igGTc3idHnFiZ78cCEyj6DOOWBBplFpWZFdoCFJ2DLnS
	6h4PG/s9MDGWmDMgMNoYHWCmxnDbOvrE0XnmD+q3CeigJ6EF696zCZ4hvQvU4ditp0jIPco+oC6+3
	+6HjH6Jl3emq3gg1hSCkk1xDZ1OZQwy/O7xbKgjJf++8KeySKIFm0ILpia/WpY4GqzYwXRN2wXeGp
	OcrK/wnr9E3EORkjytqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BPb-00GZFp-SM; Mon, 20 Jun 2022 07:01:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BPY-00GZE0-Ev
	for kexec@lists.infradead.org; Mon, 20 Jun 2022 07:01:26 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K4qSBq031702;
	Mon, 20 Jun 2022 07:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=kVvO+bT4rNmS9/UUtR0K2QvMZgpA8y073ftNj61bnWg=;
 b=FKWAW+k6U7EB+bhKCK4ZXfhKfsw6hOI4PkeAu6Bd89NDcn8FaVAb9kBETngaEjC3wb8x
 7HLym65HzRwQDvj0w9UzBCD9mR3yz0nQ2fT5baSy8yNsOLu56bQQLikqplWzwtC8ON+t
 wIqBiRISYt9swRA2KAZa0FHZArKrfT+HZO3zAWq+DJvS76y2BBFQtqBlBRwOOxwdUjMp
 r+ijMirjSqHliMtT5tvFBrhlxcBZwaOMdd9p+zBKL8ffj40mBxIFes1bsKuDorZwbzhd
 It7gx50Cm7CQrD7MBlj9bhV4kpQ//pg7es0xNE1J+T0JRw2LsJLtCje/pE43d44zHkqm zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr27saqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:17 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25K69o3n030294;
	Mon, 20 Jun 2022 07:01:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr27sapp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K6qLFq015585;
	Mon, 20 Jun 2022 07:01:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 3gs6b9220h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K71Bc518088430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jun 2022 07:01:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80062A4055;
	Mon, 20 Jun 2022 07:01:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BA9EA404D;
	Mon, 20 Jun 2022 07:01:09 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.109.136])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jun 2022 07:01:08 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v5 0/5] In kernel handling of CPU hotplug events for crash kernel
Date: Mon, 20 Jun 2022 12:31:01 +0530
Message-Id: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DhO--2spq5rYst0NXowZOqEydi7hjmwP
X-Proofpoint-ORIG-GUID: NVdI63ajNJ2lbqxdOdXBV0fa7J0UW1hg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_04,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_000124_777693_131BD1C3 
X-CRM114-Status: GOOD (  29.36  )
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

This patch series implements the crash hotplug handler on PowerPC introduced
by https://lkml.org/lkml/2022/6/13/3382 patch series.


The Problem:
============
Post hotplug/DLPAR events the capture kernel holds stale information about the
system. Dump collection with stale capture kernel might end up in dump capture
failure or an inaccurate dump collection.


Existing solution:
==================
The existing solution to keep the capture kernel up-to-date is observe the
hotplug event via udev rule and trigger a full capture kernel reload post
hotplug event. 

Shortcomings:
------------------------------------------------
- Leaves a window where kernel crash might not lead to successful dump
  collection.
- Reloading all kexec components for each hotplug is inefficient. Since only
  one or two kexec components need to be updated due to hotplug event reloading
  all kexec component is redundant.
- udev rules are prone to races if hotplug events are frequent.

More about issues with an existing solution is posted here:
 - https://lkml.org/lkml/2020/12/14/532
 - https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-February/240254.html

Proposed Solution:
==================
Instead of reloading all kexec segments on hotplug event, this patch series
focuses on updating only the relevant kexec segment. Once the kexec
segments are loaded in the kernel reserved area then an arch-specific hotplug handler
will update the relevant kexec segment based on hotplug event type.

As mentioned above this patch series implemented a PowerPC crash hotplug
handler for the CPU. The crash hotplug handler memory is in our TODO list.


A couple of minor changes are required to realize the benefit of the patch
series:

- disalble the udev rule:

  comment out the below line in kdump udev rule file:
  RHEL: /usr/lib/udev/rules.d/98-kexec.rules
  # SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_reload_cpu"

- kexec tool needs to be updated with patch for kexec_load system call
  to work (not needed if -s option is used during kexec panic load):

---
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 695b8b0..1dc6490 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -45,6 +45,29 @@ uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;
 
+#define MAX_CORE 256
+#define PER_CORE_NODE_SIZE 1500
+
+/**
+ * get_crash_fdt_mem_sz() - calcuate mem size for crash kernel FDT
+ * @fdt: pointer to crash kernel FDT
+ *
+ * Calculate the buffer space needed to add more CPU nodes in FDT after
+ * capture kenrel load due to hot add events.
+ *
+ * Some assumption are made to calculate the additional buffer size needed
+ * to accommodate future hot add CPUs to the crash FDT. The maximum core count
+ * in the system would not go beyond MAX_CORE and memory needed to store per core
+ * date in FDT is PER_CORE_NODE_SIZE.
+ *
+ * Certainly MAX_CORE count can be replaced with possible core count and
+ * PER_CORE_NODE_SIZE to some standard value instead of randomly observed
+ * core size value on Power9 LPAR.
+ */
+static unsigned int get_crash_fdt_mem_sz(void *fdt) {
+	return fdt_totalsize(fdt) + (PER_CORE_NODE_SIZE * MAX_CORE);
+}
+
 int elf_ppc64_probe(const char *buf, off_t len)
 {
 	struct mem_ehdr ehdr;
@@ -179,6 +202,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	uint64_t max_addr, hole_addr;
 	char *seg_buf = NULL;
 	off_t seg_size = 0;
+	unsigned int mem_sz = 0;
 	struct mem_phdr *phdr;
 	size_t size;
 #ifdef NEED_RESERVE_DTB
@@ -329,7 +353,13 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	if (result < 0)
 		return result;
 
-	my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		mem_sz = get_crash_fdt_mem_sz((void *)seg_buf);
+		fdt_set_totalsize(seg_buf, mem_sz);
+		info->fdt_index = info->nr_segments;
+	}
+
+	my_dt_offset = add_buffer(info, seg_buf, seg_size, mem_sz,
 				0, 0, max_addr, -1);
 
 #ifdef NEED_RESERVE_DTB
diff --git a/kexec/kexec.c b/kexec/kexec.c
index f63b36b..846b1a8 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -672,6 +672,9 @@ static void update_purgatory(struct kexec_info *info)
 		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
 			continue;
 		}
+		if (info->fdt_index == i)
+			continue;
+
 		sha256_update(&ctx, info->segment[i].buf,
 			      info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 595dd68..0906a1b 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -169,6 +169,7 @@ struct kexec_info {
 	int command_line_len;
 
 	int skip_checks;
+       // Given that we might need to update mutliple kexec segments
+       // then having array to keep indexes of all hotplug kexec segments
+       // will be helpful.
+	unsigned int fdt_index;
 };
 
 struct arch_map_entry {
---

---
Changelog:

v1 -> v2:
  - Use generic hotplug handler introduced by https://lkml.org/lkml/2022/2/9/1406, a
    significant change from v1.

v2 -> v3
  - Move fdt_index and fdt_index_vaild variables to kimage_arch struct.
  - Rebase patche on top of https://lkml.org/lkml/2022/3/3/674 [v5]
  - Fixed warning reported by checpatch script

v3 -> v4:
  - Update the logic to find the additional space needed for hotadd CPUs post
    kexec load. Refer "[RFC v4 PATCH 4/5] powerpc/crash hp: add crash hotplug
    support for kexec_file_load" patch to know more about the change.
  - Fix a couple of typo.
  - Replace pr_err to pr_info_once to warn user about memory hotplug
    support.
  - In crash hotplug handle exit the for loop if FDT segment is found.

v4 -> v5:
  - Replace COFNIG_CRASH_HOTPLUG with CONFIG_HOTPLUG_CPU.
  - Move fdt segment identification for kexec_load case to load path
    instead of crash hotplug handler
  - Keep new attribute defined under kimage_arch to track FDT segment
    under CONFIG_HOTPLUG_CPU config.
---

Sourabh Jain (5):
  powerpc/kexec: make update_cpus_node non-static
  powerpc/crash hp: update kimage_arch struct
  powerpc/crash hp: add crash hotplug support for kexec_file_load
  powerpc/crash hp: add crash hotplug support for kexec_load
  powerpc/crash hp: add crash page helper functions

 arch/powerpc/include/asm/kexec.h  |   4 +
 arch/powerpc/kexec/core_64.c      | 169 ++++++++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c       |  74 +++++++++++++
 arch/powerpc/kexec/file_load_64.c |  92 +---------------
 4 files changed, 252 insertions(+), 87 deletions(-)

-- 
2.36.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
