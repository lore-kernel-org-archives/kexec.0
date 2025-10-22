Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17734CCD1BE
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XaMnIB2DxyQKikcg1iikZoH9YtDjYyWy+dVbInpzkr4=; b=aeEuHHax/+D8abelBua6kw2AX6
	ktzTH+dLNXpVN1b2wN864EcyRPpU140fKll0AoLj9Vx/15WN54S6o69wzneHOd38g28dMAGTVxYhj
	Uji71+FtjTfS9Gmhi5oPjYzN4gBJmWznf/J3qPi7iwhP/tOevHbNdA6tNmdfWHkVOCIdo1hn3NqFa
	k6b3TH1cgbPpLGJDz+W7HRNZu0MfqPOManfBwjVal/YUsz5nqOJBsGrASlBBThIHnbZkrLEP3zfTK
	v5Zz7/NLMr0fUT+CSlAlNLLZdOPP6qZHT3/i9yU7cYU8boo4QQulbfNFOH8CIWLYCDL+9V4OvoQ7v
	2Wi41Cdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAi-000000034fs-49W0;
	Wed, 22 Oct 2025 13:46:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAe-000000034fA-0Nn3
	for kexec@bombadil.infradead.org;
	Wed, 22 Oct 2025 13:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XaMnIB2DxyQKikcg1iikZoH9YtDjYyWy+dVbInpzkr4=; b=UUQ2AFd5z9jTUcN5BsMUVDBgEK
	3lbuscMPNtG9oJ6/a8xv6nTboo//0gpfLz900DBm/8DUihF0CexT8MPXWTQZrG91SmVhan4cg4k7h
	/XBP6eR/t7SVFnYDY6UapeS93BYcZKPGtJQlg5LTdp/GKzTVSmYmP6DvRArS54L46tAlDXbzfsDYM
	udUuspSWzGYIAzMvmdyECmARH68dNBK9HG2eyGhH73Bfj6UdZ9mRlyd2m0or0EJNlIoMHtRGUZHtp
	ndPatq6J7A4osNaFIllAnPBGynkX7EtJ1a4mSNwd//IVdAHUm/Cmv53jpbfMusBgHPDDDiW3AqGN5
	r7ey7jhA==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBYIu-00000000bBk-3YkC
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:51:02 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBbEGv009814;
	Wed, 22 Oct 2025 13:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XaMnIB2DxyQKikcg1
	iikZoH9YtDjYyWy+dVbInpzkr4=; b=dHGvGxh44I/mNNj2tHrW9OAMOY8E6wJmR
	vDXRmMEq3pu24L8LJSLkjcC3mRDAuTujY+v4bTaZnzT3uc0h1nM9nSV/6vutep5c
	zAZ9SX0XpEPI96AJyF0KPDg+/wVpry0swrFQzwoJjw94ICiCDEAjTygF1vg7ggvh
	oxIJeK2GwFangr8QFpZs58/qqsQ9RyKxjBHkGugJUcMQW2hAouDHv9mVFh/7OAiF
	Ygq/0EklcKPwUgu2DSch+g/ST4nz7zxn5QjcMkHH61azbPxRqRsjO0f/3Eab0sAy
	Q+4hYcg5t0zreaViMpJhTYphYSjxsEwnlD3barIBPEUwFYUTHaZPA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hkgr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBbKYi002306;
	Wed, 22 Oct 2025 13:46:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejgdmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MDkK4O47120706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:46:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C75F2004B;
	Wed, 22 Oct 2025 13:46:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D307320043;
	Wed, 22 Oct 2025 13:46:18 +0000 (GMT)
Received: from shivang.com (unknown [9.124.221.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 13:46:18 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: horms@kernel.org
Cc: shivangu@linux.ibm.com, sourabhjain@linux.ibm.com,
        kexec@lists.infradead.org
Subject: [PATCH kexec-tools 1/4] ppc64: ensure /memreserve/ sections exist in user-provided FDT
Date: Wed, 22 Oct 2025 19:16:06 +0530
Message-ID: <20251022134611.8921-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022134611.8921-1-shivangu@linux.ibm.com>
References: <20251022134611.8921-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8rAEDfn8Cmfj
 wptou4yl+Axnf9UPUhZ9MbeqbxhkqDNVLnnMdXdlcbiZaq7xvnMNLQc3dKxx2oyZR30L1lc6Zl+
 F47G4ete8ZaryTwUbnbnWgjx1YyIQDx8TYyOCqOOKHgqCi3fJvLSSqdsvuj7lKHhQaHZnMmu1zf
 2S/VCZZ21H018mOgP+rjo/mKhi37Iz1YwOwRg2fEsYBdABuxtXfdg7fwD97Js9e3EDVdCsDe6RZ
 OapeMj52GCw0Nviy2qPsz3QQUMwwA479FO2/C3z0z/6aSpmLaWimMJu2yCtRpxKIVF01j4vRwbR
 A0qjQSq4GY2lFmivT1HIOOrcz1Db5BosYOsuh5bIeYddpjgt6MOoYcJNt8uMQ9E0GqWn2rT4QUt
 rs5rdf0uNTm8nInEVWFG6Nn1AjTQ6g==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f8e031 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=R7YbrHiY4W6HiT2JyBEA:9
X-Proofpoint-GUID: bD_aysBkivbDtdz08n3sDtC5hGWJzY0X
X-Proofpoint-ORIG-GUID: bD_aysBkivbDtdz08n3sDtC5hGWJzY0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_135101_275270_EB4AF1F5 
X-CRM114-Status: GOOD (  21.69  )
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

User-provided FDTs may lack `/memreserve/` sections, leading to hangs
during kexec. To fix this, allocate a new FDT buffer and use libfdt to
add reserve entries for the initrd, RTAS/OPAL regions (via
/proc/device-tree), and the FDT itself.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c | 165 +++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 858c994..e287392 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -40,6 +40,9 @@
 #include <libfdt.h>
 #include <arch/fdt.h>
 #include <arch/options.h>
+#include <dirent.h>
+#include <assert.h>
+#include <linux/limits.h>
 
 uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
@@ -180,6 +183,162 @@ out:
 	return ret;
 }
 
+static int read_proc_file(char* filename, char* buf) {
+	FILE* f;
+	int len;
+
+	f = fopen(filename, "r");
+	if (f == NULL) {
+		perror("unable to open file");
+	}
+	len = fread(buf, 1, 10, f);
+	fclose(f);
+
+	return len;
+}
+
+
+static void add_reserve_mem(void* dtb, uint64_t where, uint64_t length)
+{
+	int ret;
+
+	ret = fdt_add_mem_rsv(dtb, where, length);
+	assert(ret == 0 && "Failed to add memory reservation block to FDT.");
+
+	return;
+}
+
+/* this function is similar to kexec/fs2dt.c's checkprop function, only part
+ * different here is, this version uses libfdt's function to mark the reserve
+ * section
+ */
+static void checkprop(void* dtb, char *name, unsigned *data, int len)
+{
+	static unsigned long long base, size, end;
+
+	if ((data == NULL) && (base || size || end))
+		die("unrecoverable error: no property data");
+	else if (!strcmp(name, "linux,rtas-base"))
+		base = be32_to_cpu(*data);
+	else if (!strcmp(name, "opal-base-address"))
+		base = be64_to_cpu(*(unsigned long long *)data);
+	else if (!strcmp(name, "opal-runtime-size"))
+		size = be64_to_cpu(*(unsigned long long *)data);
+	else if (!strcmp(name, "linux,tce-base"))
+		base = be64_to_cpu(*(unsigned long long *) data);
+	else if (!strcmp(name, "rtas-size") ||
+			!strcmp(name, "linux,tce-size"))
+		size = be32_to_cpu(*data);
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-start")) {
+		if (len == 8)
+			base = be64_to_cpu(*(unsigned long long *) data);
+		else
+			base = be32_to_cpu(*data);
+	} else if (reuse_initrd && !strcmp(name, "linux,initrd-end")) {
+		if (len == 8)
+			end = be64_to_cpu(*(unsigned long long *) data);
+		else
+			end = be32_to_cpu(*data);
+	}
+
+	if (size && end)
+		die("unrecoverable error: size and end set at same time\n");
+	if (base && size) {
+		add_reserve_mem(dtb, base, size);
+		base = size = 0;
+	}
+	if (base && end) {
+		add_reserve_mem(dtb, base, end-base);
+		base = end = 0;
+	}
+}
+
+static void file_traversal(void *dtb, const char *pathname) {
+	DIR *dir = opendir(pathname);
+	if (!dir) {
+		perror("opendir failed");
+		return;
+	}
+
+	struct dirent *entry;
+	while ((entry = readdir(dir)) != NULL) {
+		// Skip '.' and '..'
+		if (entry->d_name[0] == '.')
+			continue;
+
+		char full_path[PATH_MAX];
+		snprintf(full_path, sizeof(full_path), "%s/%s", pathname, entry->d_name);
+
+		// Check if entry is a directory
+		if (entry->d_type == DT_DIR) {
+			file_traversal(dtb, full_path);
+		} else {
+			char file_data[10];
+			int readlen = read_proc_file(full_path, file_data);
+			if (readlen > 0) {
+				checkprop(dtb, entry->d_name,
+					(unsigned *)file_data, readlen);
+			}
+		}
+	}
+
+	closedir(dir);
+}
+
+void patch_devicetree_with_initrd_info(char* dtb, uint64_t initrd_base,
+		uint64_t initrd_size) {
+
+	int ret, offset;
+	unsigned long initrd_end = initrd_base + initrd_size;
+	uint64_t base_be = cpu_to_be64(initrd_base);
+	uint64_t end_be  = cpu_to_be64(initrd_end);
+
+	ret = 0;
+	offset = fdt_path_offset(dtb, "/chosen");
+	assert(offset >= 0 && "failed to find the /chosen node");
+
+	ret = fdt_setprop(dtb, offset, "linux,initrd-start", &base_be, sizeof(base_be));
+	assert(ret == 0 && "failed to set initrd-start on dtb");
+
+	ret = fdt_setprop(dtb, offset, "linux,initrd-end", &end_be, sizeof(end_be));
+	assert(ret == 0 && "failed to set initrd-end on dtb");
+
+}
+
+
+static void patch_devicetree(char *dtb, uint64_t initrd_base,
+		uint64_t initrd_size)
+{
+	int ret;
+
+	patch_devicetree_with_initrd_info(dtb, initrd_base, initrd_size);
+
+	file_traversal(dtb, "/proc/device-tree");
+
+	ret = fdt_add_mem_rsv(dtb, initrd_base, initrd_size);
+	assert(ret == 0 && "failed to add rsvmap");
+
+	ret = fdt_add_mem_rsv(dtb, 0, fdt_totalsize(dtb));
+	assert(ret == 0 && "failed to add rsvmap");
+
+	fdt_set_boot_cpuid_phys(dtb, 0x0);
+	fdt_set_last_comp_version(dtb, 17);
+
+}
+
+static char* alloc_new_dtb(char* dtb, off_t* newsize) {
+	int ret;
+
+	*newsize = fdt_totalsize(dtb) + 256;
+	dtb = (char*) realloc(dtb, *newsize);
+	ret = fdt_open_into(dtb, dtb, *newsize);
+
+	assert(ret == 0 &&
+		"fdt_open_into failed");
+
+	return dtb;
+}
+
 int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info)
 {
@@ -340,6 +499,12 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	if (devicetreeblob) {
 		/* Grab device tree from buffer */
 		seg_buf = slurp_file(devicetreeblob, &seg_size);
+
+		if (ramdisk) {
+			seg_buf = alloc_new_dtb(seg_buf, &seg_size);
+			patch_devicetree(seg_buf, initrd_base, initrd_size);
+		}
+
 	} else {
 		/* create from fs2dt */
 		create_flatten_tree(&seg_buf, &seg_size, cmdline);
-- 
2.51.0


