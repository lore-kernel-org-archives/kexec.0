Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF71ACD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gc9QK/7ZvXL3YWAwN0KCcbTGVvK6GenZl2ozt4yOZIg=; b=cTOHpptLcZW6D6qN1FaoAASUYb
	2LXIwTLldNd+bROP2/aBNEFWTCXB0PlexaIRvTjMKRh5mvLGL5/ezIDPOWTyyQmY0kwFYMPyAsbQb
	+MqsCEqki4eDVumytkdcPpdtGHU3kyEOcq6K7z6MEm/t+NUvJi48woJdXf5FdRFFnJDZyGOJ45xg5
	ab9oXp6sk+80/HRdBXgF7AnjNSUdJn9crEQxAV7w/FYQxQSKPpSBqHUpKR+mYI0UTXeQI1EscM9Mc
	RZjF4hUGvBfIjSbCxiyCn93bnbS3IkeKkEVzxdTrANbYrMXc6tzXT+l0G8nCSdPogUeli5KKazdFC
	lP3wCygQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzt2-00000009UO2-23cn;
	Fri, 15 May 2026 21:16:00 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsy-00000009UKF-0M4i
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:57 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-132d1b2519eso781316c88.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879755; x=1779484555; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc9QK/7ZvXL3YWAwN0KCcbTGVvK6GenZl2ozt4yOZIg=;
        b=M9xCX/wgdtNQuWNGU9z7Q3xH8ZMwVpV6OJxo6UJW2+BUi3FPOxg10LOm6AVWSfDnmj
         RW/WwOrjOSTHQypVZUl3aF2O34++K9R2gaUij6+NrKFMn2dXq3ilLcLfHFAOwzrUSBpH
         knAAJDw308e8w33PzzwoKslMthbUGXCKO2cS8QUbnz7Q092/RIwK8TSH58XKcgWKgOJG
         i90NX2YsxeugSejBK4R1lFzwL7H9Y5IocAxIBv3V+FNuPUXonK0/LcHwpCoBju2k+QCi
         9O8aqO1zkdcebSmouzhCS+lv3xsMkyVgepiPA1QJ65RgMZMPhhpIifZsWlUlvnuG3TbX
         78lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879755; x=1779484555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gc9QK/7ZvXL3YWAwN0KCcbTGVvK6GenZl2ozt4yOZIg=;
        b=WVjPoZNU1Ko9WV3LrpG0PBvp2kqUDGPtu41IVoDqqswLBkk+yx5BLPuVrED1j+9hnF
         TSOY/b7NzEF57jG/KK5JN6gmSPqxL5WyCKlp0NTavHYOuJoANb3Q6BJkffKY9m4YAnlT
         1dFb/flrbDJbKqjLNTF18X0t4fLdqn3ERkhZTC5rD05uquCaekS8lzicQpkA53pZl5Wd
         1EUFxJFH56aPTJ9YnAao7CNKAeV2pU0cntKALdyXCebSP1ec+EoYYBYOJzqv0BRZsyKr
         uzZA0Y4bTFue5Oj3aKHWdO4nIStFp8SX2ut+y8PKsu4B6gYBpA8M0lzhfoW6McbcHkp0
         IOyw==
X-Forwarded-Encrypted: i=1; AFNElJ/tJee/9blv2zxH4weJW5Bwa1VneFxN67pJBLc0OQXTipBs3lDP6fDfyV0S0NRWVBm6FTRe2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKAuHMjgXTdGBwQ9NuA7ztYrL1tfZBB3nu3sm5UgyyiajnKyUB
	cBzvKU738Fj+AuR37TIgA72sPemzPa+bLgMRYe/1b0r0JCWJ6C5eCZ55
X-Gm-Gg: Acq92OEeGNiRF78BZGUoDQbiMIUg/47DLRLXo6bxA+md9FM+lmxda0nkk9XQ0exBy0T
	pvvHD5oh/eGZIL/tQpqOJuGDrMATTaJn0HOmU2QgsIeiqzftEO5diBJFUqHeyibmYhw668K4FDI
	ItyC4MCheqW2jLWtH7GmIwBZBnZrYfmbHy1Gf9/FAtrnb2xDtlZ/2oUIq8wjh2zbtNay+KLlW9z
	DsKA1PfKkL9l9QvIMpYftmxB8/Jg5VmZfbomAqo8t1qXBSQ2g/c8Wm7F8TMacAKwiEhgBVRQGb5
	Dj1aRWxYEhVoLVk1BNFUvS4e+E9rraVm41zZT+QApfwap0FAZ9HVr7cEeyyLWueE1wdOKhRkiVn
	iGo3vWurJP4r7Be6xT+DMCUkiI9uoLzcDKkFpEZfWvOpdSE1WdDlyxVke/6LSD2q6fz9aYro14k
	l0cKcYXGSKE9dEaBjj0T03AoguIx4PBkbfGxzJ7s4PWQ==
X-Received: by 2002:a05:7022:661e:b0:12d:de3f:d844 with SMTP id a92af1059eb24-13504951829mr2578587c88.39.1778879755329;
        Fri, 15 May 2026 14:15:55 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm11368464c88.5.2026.05.15.14.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:54 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 36/38] x86/slaunch: Secure Launch late initcall platform module
Date: Fri, 15 May 2026 14:14:08 -0700
Message-ID: <20260515211410.31440-37-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141556_145551_A0F7F7FF 
X-CRM114-Status: GOOD (  26.25  )
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The Secure Launch platform module is a late init module. During the
init call, the TPM event log is read and measurements taken in the
early boot stub code are located. These measurements are extended
into the TPM PCRs using the mainline TPM kernel driver.

The platform module also registers the securityfs nodes to allow
fetching and writing events from/to the DRTM TPM event log. In
addition, on Intel, access to TXT register fields is made available
for reading.

Co-developed-by: garnetgrimm <grimmg@ainfosec.com>
Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
Co-developed-by: Ross Philipson <ross.philipson@gmail.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/slmodule.c | 353 +++++++++++++++++++++++++++++++++++++
 2 files changed, 354 insertions(+)
 create mode 100644 arch/x86/kernel/slmodule.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index bf2471701662..8b039ed0a902 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
new file mode 100644
index 000000000000..9688249e274c
--- /dev/null
+++ b/arch/x86/kernel/slmodule.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup, securityfs exposure and finalization.
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026 Assured Information Security, Inc.
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <linux/tpm.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <crypto/sha2.h>
+#include <linux/efi.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
+
+/*
+ * The macro DECLARE_TXT_PUB_READ_U is used to read values from the TXT
+ * public registers as unsigned values.
+ */
+#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)			\
+static ssize_t txt_pub_read_u##size(unsigned int offset,		\
+		loff_t *read_offset,					\
+		size_t read_len,					\
+		char __user *buf)					\
+{									\
+	char msg_buffer[msg_size];					\
+	u##size reg_value = 0;						\
+	void __iomem *txt;						\
+									\
+	txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,				\
+			TXT_NR_CONFIG_PAGES * PAGE_SIZE);		\
+	if (!txt)							\
+		return -EFAULT;						\
+	memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));	\
+	iounmap(txt);							\
+	snprintf(msg_buffer, msg_size, fmt, reg_value);			\
+	return simple_read_from_buffer(buf, read_len, read_offset,	\
+			&msg_buffer, msg_size);				\
+}
+
+DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
+DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
+DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
+
+#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)		\
+static ssize_t txt_##reg_name##_read(struct file *flip,			\
+		char __user *buf, size_t read_len, loff_t *read_offset)	\
+{									\
+	return txt_pub_read_u##reg_size(reg_offset, read_offset,	\
+			read_len, buf);					\
+}									\
+static const struct file_operations reg_name##_ops = {			\
+	.read = txt_##reg_name##_read,					\
+}
+
+DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
+DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
+DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
+DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
+DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
+DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
+DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
+
+/*
+ * Securityfs exposure
+ */
+struct memfile {
+	char *name;
+	void *addr;
+	size_t size;
+};
+
+static struct memfile sl_evtlog = { "eventlog", NULL, 0 };
+static void *txt_heap;
+static struct txt_heap_event_log_pointer2_1_element *evtlog21;
+static DEFINE_MUTEX(sl_evt_log_mutex);
+static struct tcg_efi_specid_event_head *efi_head;
+
+static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	ssize_t size;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	mutex_lock(&sl_evt_log_mutex);
+	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
+				       sl_evtlog.size);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	return size;
+}
+
+static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
+			       size_t datalen, loff_t *ppos)
+{
+	ssize_t result;
+	char *data;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	/* No partial writes. */
+	result = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	data = memdup_user(buf, datalen);
+	if (IS_ERR(data)) {
+		result = PTR_ERR(data);
+		goto out;
+	}
+
+	mutex_lock(&sl_evt_log_mutex);
+	if (evtlog21)
+		result = tpm2_log_event(evtlog21, sl_evtlog.addr,
+					sl_evtlog.size, datalen, data);
+	else
+		result = tpm_log_event(sl_evtlog.addr, sl_evtlog.size,
+				       datalen, data);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	kfree(data);
+out:
+	return result;
+}
+
+static const struct file_operations sl_evtlog_ops = {
+	.read = sl_evtlog_read,
+	.write = sl_evtlog_write,
+	.llseek = default_llseek,
+};
+
+struct sfs_file {
+	const char *name;
+	const struct file_operations *fops;
+};
+
+#define SL_TXT_ENTRY_COUNT	7
+static const struct sfs_file sl_txt_files[] = {
+	{ "sts", &sts_ops },
+	{ "ests", &ests_ops },
+	{ "errorcode", &errorcode_ops },
+	{ "didvid", &didvid_ops },
+	{ "ver_emif", &ver_emif_ops },
+	{ "scratchpad", &scratchpad_ops },
+	{ "e2sts", &e2sts_ops }
+};
+
+/* sysfs file handles */
+static struct dentry *slaunch_dir;
+static struct dentry *event_file;
+static struct dentry *txt_dir;
+static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
+
+static long slaunch_expose_securityfs(void)
+{
+	long ret = 0;
+	int i;
+
+	slaunch_dir = securityfs_create_dir("slaunch", NULL);
+	if (IS_ERR(slaunch_dir))
+		return PTR_ERR(slaunch_dir);
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		txt_dir = securityfs_create_dir("txt", slaunch_dir);
+		if (IS_ERR(txt_dir)) {
+			ret = PTR_ERR(txt_dir);
+			goto remove_slaunch;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
+			txt_entries[i] =
+				securityfs_create_file(sl_txt_files[i].name, 0440, txt_dir,
+						       NULL, sl_txt_files[i].fops);
+			if (IS_ERR(txt_entries[i])) {
+				ret = PTR_ERR(txt_entries[i]);
+				goto remove_files;
+			}
+		}
+	}
+
+	if (sl_evtlog.addr) {
+		event_file = securityfs_create_file(sl_evtlog.name, 0440,
+						    slaunch_dir, NULL,
+						    &sl_evtlog_ops);
+		if (IS_ERR(event_file)) {
+			ret = PTR_ERR(event_file);
+			goto remove_files;
+		}
+	}
+
+	return 0;
+
+remove_files:
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		while (--i >= 0)
+			securityfs_remove(txt_entries[i]);
+		securityfs_remove(txt_dir);
+	}
+
+remove_slaunch:
+	securityfs_remove(slaunch_dir);
+
+	return ret;
+}
+
+static void slaunch_teardown_securityfs(void)
+{
+	int i;
+
+	securityfs_remove(event_file);
+	if (sl_evtlog.addr) {
+		memunmap(sl_evtlog.addr);
+		sl_evtlog.addr = NULL;
+	}
+	sl_evtlog.size = 0;
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++)
+			securityfs_remove(txt_entries[i]);
+
+		securityfs_remove(txt_dir);
+
+		if (txt_heap) {
+			memunmap(txt_heap);
+			txt_heap = NULL;
+		}
+	}
+
+	securityfs_remove(slaunch_dir);
+}
+
+static void __init slaunch_intel_evtlog(void __iomem *txt)
+{
+	struct slr_entry_log_info *log_info;
+	struct txt_os_mle_data *params;
+	struct slr_table *slrt;
+	void *os_sinit_data;
+	u64 base, size;
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* now map TXT heap */
+	txt_heap = memremap(base, size, MEMREMAP_WB);
+	if (!txt_heap)
+		slaunch_reset(txt, "Error memremap TXT heap failed\n", SL_ERROR_HEAP_MAP);
+
+	params = (struct txt_os_mle_data *)slaunch_txt_get_heap_table(txt_heap,
+								      TXT_OS_MLE_DATA_TABLE);
+
+	/* Get the SLRT and remap it */
+	slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
+	if (!slrt)
+		slaunch_reset(txt, "Error memremap SLR Table failed\n", SL_ERROR_SLRT_MAP);
+	size = slrt->size;
+	memunmap(slrt);
+
+	slrt = memremap(params->slrt, size, MEMREMAP_WB);
+	if (!slrt)
+		slaunch_reset(txt, "Error memremap SLR Table failed\n", SL_ERROR_SLRT_MAP);
+
+	log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+	if (!log_info)
+		slaunch_reset(txt, "Error SLR Table missing entry\n", SL_ERROR_SLRT_MISSING_ENTRY);
+
+	sl_evtlog.size = log_info->size;
+	sl_evtlog.addr = memremap(log_info->addr, log_info->size, MEMREMAP_WB);
+	if (!sl_evtlog.addr)
+		slaunch_reset(txt, "Error memremap TPM event log failed\n", SL_ERROR_EVENTLOG_MAP);
+
+	memunmap(slrt);
+
+	/* Determine if this is TPM 1.2 or 2.0 event log */
+	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
+		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return; /* looks like it is not 2.0 */
+
+	/* For TPM 2.0 logs, the extended heap element must be located */
+	os_sinit_data = slaunch_txt_get_heap_table(txt_heap, TXT_OS_SINIT_DATA_TABLE);
+
+	evtlog21 = txt_find_log2_1_element(os_sinit_data);
+
+	/*
+	 * If this fails, things are in really bad shape. Any attempt to write
+	 * events to the log will fail.
+	 */
+	if (!evtlog21)
+		slaunch_reset(txt, "Error locate TPM20 event log element failed\n",
+			      SL_ERROR_TPM_INVALID_LOG20);
+
+	/* Save pointer to the EFI SpecID log header */
+	efi_head = (struct tcg_efi_specid_event_head *)(sl_evtlog.addr +
+							sizeof(struct tcg_pcr_event));
+}
+
+static void __init slaunch_tpm_open_locality2(void __iomem *txt)
+{
+	struct tpm_chip *tpm;
+	int rc;
+
+	tpm = tpm_default_chip();
+	if (!tpm)
+		slaunch_reset(txt, "Could not get default TPM chip\n", SL_ERROR_TPM_INIT);
+
+	rc = tpm_chip_set_locality(tpm, 2);
+	if (rc)
+		slaunch_reset(txt, "Could not set TPM chip locality 2\n", SL_ERROR_TPM_INIT);
+}
+
+static int __init slaunch_module_init(void)
+{
+	void __iomem *txt;
+
+	/* Check to see if Secure Launch happened */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
+		return 0;
+
+	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+		      PAGE_SIZE);
+	if (!txt)
+		panic("Error ioremap of TXT priv registers\n");
+
+	/* Only Intel TXT is supported at this point */
+	slaunch_intel_evtlog(txt);
+	slaunch_tpm_open_locality2(txt);
+	iounmap(txt);
+
+	return slaunch_expose_securityfs();
+}
+
+static void __exit slaunch_module_exit(void)
+{
+	slaunch_teardown_securityfs();
+}
+
+late_initcall(slaunch_module_init);
+__exitcall(slaunch_module_exit);
-- 
2.47.3


