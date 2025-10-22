Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BE5CCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUWxw1PDO7pQm1vOsqw6MfpQORiKMDXbZRHYu4Cx7Zo=; b=kYuhjb0Lg0X0UuXZoH1c3RaYM6
	Pvs1bChyWzudIU3PVm/QDwn8lqJoA3nBtadXZfWR6lqnR/fgqQ4Kmk9Kbzyw1Xs0y8zp5BZLEFJgL
	GgUrHMVbkAk1zQxCDBkcBZYt7moRhuHOSNr49gr2OhAfizdmYAJVq/Wxt1KUC7vcPEbJXvFqJjV6m
	MUmruV6KRlwhMmYhOoAQ59HeRhoYFlELbwZjLRXFU0mlEIPjAcMvS9TOzftHds1HdRI7aRTACDg0K
	TvR0PYNoBx37GEhdFQC0um8hw49OjzuOZM/6zEUkjkgke4kGOTDxKxlcq2GaeWQVDnG/RqC+RqGFU
	2WUZxzqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAm-000000034hg-3CLT;
	Wed, 22 Oct 2025 13:46:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAg-000000034fk-1HnG
	for kexec@bombadil.infradead.org;
	Wed, 22 Oct 2025 13:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cUWxw1PDO7pQm1vOsqw6MfpQORiKMDXbZRHYu4Cx7Zo=; b=ilTeOAs/mOToCRZHcF/DnHxyFq
	GITaMn3ev5rj8LBSVPszFEUuU9/c41oQwneezdwKJ+xuzTlUkfycjSGz1xkJRYMnmjuj7eo0CEJs5
	fkSIDqo44KxEi3CWJ5gKc3pmG32rzhbZO8Or06YDj90ngR0KOsnOOCuQpKJD6RO9E1Uu7iBcqi0Xh
	cZgn3Agjiyz7MsexhmFD/qxVROwvzDour7yubYbdhZeCBDGmsP8rP3ZAIifQLBbyx+2XCJwTx6Jl5
	/ZnTogYPo52dif6RpfBC9so+QNyWg4cGbrh+VwPRw0EvOsAloBTFCN5tIHevmA+wkVG16x/vMQCQb
	mll5JQfQ==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBYIx-00000000bCI-1fel
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:51:05 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7t019006623;
	Wed, 22 Oct 2025 13:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cUWxw1
	PDO7pQm1vOsqw6MfpQORiKMDXbZRHYu4Cx7Zo=; b=SRd2RpwDiGNxYASgzZuGXg
	8NZPFfyzfH3Cf4cEPJXcM1vGKPo1l3lwpcwhdnQhX6Y2YrVF6lASDaKaJkxQHJUV
	zqyCXD75rZh9JGBtkf2Y73WyVaaG9K8CHNqqQBCYgYUFaELmINMVYxP6dBi1emDH
	avOnh7lL6/i5Eq10PIYaj4qKdSN3EDlJrw7aOlPhXpgLheHWpxPdwQ/b7h0OZbuL
	QoDPpTK56bNPOk1kD8zTZx/Vu3HvqR8NhFlWbPgJ9+XK4cXL+uULzgyxGMXl/wPD
	r53/X4Kp1cdHdLmSBVbsVcY+xIEe5D7oRJbY6hkBE+E1sU82SxmVs8PsBRPUw0SA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vujqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAnxWE032092;
	Wed, 22 Oct 2025 13:46:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n0juk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MDkNTO37355940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:46:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0E920043;
	Wed, 22 Oct 2025 13:46:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39EB20040;
	Wed, 22 Oct 2025 13:46:21 +0000 (GMT)
Received: from shivang.com (unknown [9.124.221.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 13:46:21 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: horms@kernel.org
Cc: shivangu@linux.ibm.com, sourabhjain@linux.ibm.com,
        kexec@lists.infradead.org
Subject: [PATCH kexec-tools 2/4] ppc64: handle reboot CPU in case of user provided DTB
Date: Wed, 22 Oct 2025 19:16:07 +0530
Message-ID: <20251022134611.8921-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022134611.8921-1-shivangu@linux.ibm.com>
References: <20251022134611.8921-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ir6Zzk13qt8wOA6SmJoYs-7Jo4AeZVwE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3PWCOaSG1DTm
 /wUIlTWQhrj2UjvIsQpNUXjvhwnsifYFRNFPv4bO1TAGYYL08f/8WRW7DldOrqjudNIhkD70uY+
 woPYPUPfv5W7kctyaX7K3K6cK11xw1J1P6Azfh+F6UqKiKsP3PxzczWkfyBRtUUZUiCAbcqnrI2
 KPeFWGKfwquSd+lUwbwoHB+lWKvrUlYBxWPbL2huD6S+Z5+WY1f3cu0falYm0dZoW/U5H26EDud
 DylaI0CkftU9G77MsCpxMd/8DBupVuqMXndYSO5MTt7SqLHA4unA8YD7GILTo2Nu4bs9GfMxoCa
 FzWYkU7mzG0a8iAfB5g9OZy7EDebsyVHtsWnyCGu/0NYQZz9OglAMo722Qu8abhdeZrd5n7pohC
 SM+xpuwB0fbTYUo3wewPOH1kB28HOA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f8e034 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jazcbPdd8iy1FkQ8dJIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ir6Zzk13qt8wOA6SmJoYs-7Jo4AeZVwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_135103_768972_B1868675 
X-CRM114-Status: GOOD (  19.73  )
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

When restricting available CPUs for the next kexec'ed kernel, ensure the
reboot CPU is part of that available CPU's in new DTB. ppc64 requires
the booting CPU to be present in the new kernel’s DTB; otherwise, the
system will panic during bring-up.

Example Scenario
==============================

Current Kernel
--------------
Physical CPUs:  [1] [2] [3] [4] [5] [6] [7] [8]
Available set:   ^   ^   ^   ^   ^   ^   ^   ^
                 |   |   |   |   |   |   |   |
                 +---+---+---+---+---+---+---+
                      All CPUs available

Next Kernel (limited CPU set)
-----------------------------
Physical CPUs:  [4] [5] [6] [7]
Logical IDs:    [0] [1] [2] [3]

Mapping:
  Logical 0 → Physical 4
  Logical 1 → Physical 5
  Logical 2 → Physical 6
  Logical 3 → Physical 7

If next kernel should only boot on CPUs 6 and 7
------------------------------------------------
Selected CPUs:
  Physical CPUs: [6] [7]
  Logical IDs:   [2] [3]

Required reboot CPU = Logical ID [3]
                     → Physical CPU [7]

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c | 86 ++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index e287392..2084356 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -43,6 +43,7 @@
 #include <dirent.h>
 #include <assert.h>
 #include <linux/limits.h>
+#include <stdbool.h>
 
 uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
@@ -305,6 +306,88 @@ void patch_devicetree_with_initrd_info(char* dtb, uint64_t initrd_base,
 
 }
 
+int find_logical_cpu_from_physical(int physical_cpu) {
+
+	char possible_buffer[0x2f];
+	char physical_id_buffer[0x2f];
+	char physical_id_filename_buffer[0x5f];
+	char online_filename_buffer[0x5f];
+	char online_buffer[0x1f];
+	FILE *possible_file, *online_file;
+	FILE *physical_id_file;
+	int pc;
+	int is_online;
+	int first_cpu, last_cpu;
+
+	possible_file = fopen("/sys/devices/system/cpu/possible", "r");
+	fread(possible_buffer, 0x2f, 1, possible_file);
+	fclose(possible_file);
+	sscanf(possible_buffer, "%d-%d", &first_cpu, &last_cpu);
+
+	for (int lc = first_cpu; lc <= last_cpu; lc++) {
+		sprintf(online_filename_buffer,
+				"/sys/devices/system/cpu/cpu%d/online", lc);
+		online_file = fopen(online_filename_buffer, "r");
+		fread(online_buffer, 0xf, 1, online_file);
+		fclose(online_file);
+		sscanf(online_buffer, "%d", &is_online);
+
+		if (!is_online)
+			continue;
+
+		sprintf(physical_id_filename_buffer,
+				"/sys/devices/system/cpu/cpu%d/physical_id", lc);
+		physical_id_file = fopen(physical_id_filename_buffer, "r");
+		fread(physical_id_buffer, 0x2f, 1, physical_id_file);
+		fclose(physical_id_file);
+		sscanf(physical_id_buffer, "%d", &pc);
+
+		if (pc == physical_cpu)
+			return lc;
+	}
+
+	return -1;
+}
+
+static void set_valid_bootcpu(const void* dtb) {
+	int node = -1;
+	int len;
+	int nthreads;
+	const struct fdt_property *intserv;
+	__be32* intserv_data;
+	int i;
+	char cmd_buffer[0x5f];
+	int boot_cpuid;
+	bool found = false;
+
+	while ((node = fdt_next_node(dtb, node, NULL)) >= 0) {
+		intserv = fdt_get_property(dtb, node, "ibm,ppc-interrupt-server#s",
+				&len);
+		if (!intserv) continue;
+		intserv_data = (__be32*)intserv->data;
+		nthreads = len / sizeof(int);
+		for (i = 0; i < nthreads; i++) {
+			boot_cpuid = be32_to_cpu(intserv_data[i]);
+			int logical_cpu = find_logical_cpu_from_physical(boot_cpuid);
+			if (logical_cpu < 0)
+				continue;
+			sprintf(cmd_buffer, "echo %d >  /sys/kernel/reboot/cpu",
+					logical_cpu);
+			system(cmd_buffer);
+			printf("setting boot cpu: %d (physical_id: %d)\n",
+					logical_cpu, boot_cpuid);
+			found = true;
+			break;
+		}
+		if (found)
+			break;
+	}
+
+	if (!found) {
+		die("can't find a valid boot_cpu inside the FDT.\n");
+	}
+
+}
 
 static void patch_devicetree(char *dtb, uint64_t initrd_base,
 		uint64_t initrd_size)
@@ -324,6 +407,9 @@ static void patch_devicetree(char *dtb, uint64_t initrd_base,
 	fdt_set_boot_cpuid_phys(dtb, 0x0);
 	fdt_set_last_comp_version(dtb, 17);
 
+
+	set_valid_bootcpu(dtb);
+
 }
 
 static char* alloc_new_dtb(char* dtb, off_t* newsize) {
-- 
2.51.0


