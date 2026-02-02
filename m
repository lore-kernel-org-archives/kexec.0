Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FDEE7DEEE
	for <kexec@archiver.kernel.org>; Mon,  2 Feb 2026 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCFb4xxEV2N7KzX/8XoJeWKKN9wS7tz47sg5Z5hO/c4=; b=2BxanI3S39fD5sbL3NCKEttgV8
	1ExzG7jR2g745fMUFI/L27SwSJaI5DpNv6NqwR7tH8NsdBFWE6QnOjDzN0eopAyqu2nqRk3DxrGJ5
	cslnlQocz5GkK7Q+UaF8CQ0hJclhbE5qUW7FDzPiavptQMr5kBXF+x/xcEM5Ar8NGoZOOhfuSv9Nm
	ptVK296ohs40B6OluguIXHpErX6mtQQNuqFGrtLU8oZ4AXbElZ91TeLSdw5fDmyD571c0Zuq1MxOv
	IXDTyQt5HWmoH18cJE4hEPz7nqt/m1F8xdhIP6+hONGYKhr1KV4mZGxuOR7LabwEQai2hd+jbPl2l
	18WbRDvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmuui-0000000565X-3CnQ;
	Mon, 02 Feb 2026 14:28:28 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmuuc-0000000564P-16JX;
	Mon, 02 Feb 2026 14:28:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pCFb4xxEV2N7KzX/8XoJeWKKN9wS7tz47sg5Z5hO/c4=; b=Nhbu0VYP5qTK/s7HyyQREOyam0
	Zr2Pj3ksZVl3YspztLX8aZJrLG2MIPsanMki3avg4U09a8bbgGudCOOS/2DfdUluDn4wGg8Ikcf+D
	engXbwdRtM8ezeXXpTuFlc4VxUxROW3OMSUMa/17Q/o4Urwel3/BjJHaYy3PfXGwXG+KMRYjW9C5b
	rWrOjcrk/Dee/c2M+MZ6wOTvBeCRT/tCLKOO4ygn62B/oYUqO3aw52IKQkU2ALeTnPTJYsLtznVw/
	FWhjpZIAxOzFozgN1FyqQ4rpLe3QJhz6ZfPFaSxowDpOSAz6PwpU/JDUBtQ8CuRYX+P2ZB+tINPyg
	9AV7EUuA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vmuuO-0046Xd-NY; Mon, 02 Feb 2026 14:28:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Feb 2026 06:27:39 -0800
Subject: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=3683; i=leitao@debian.org;
 h=from:subject:message-id; bh=U8EjTz/5T7IsTrWh7ZVcmmDz3W/0lTlfkat5cxh/2+Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgLRtwiUfi29mGTnW4ixNZP7zWlKBlM3vszSJq
 AEuwxTr9ZeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYC0bQAKCRA1o5Of/Hh3
 bVU7D/4/ExbTJHPtttzMSuBhk++xqEFTGnO6/RhPBgJukq8LwzOrL2hTvO+rp4eeK8XuIhLXwwg
 bqHzyu8rolbjXfhhAaHIUgSvhChUcCPBHq8yzLTAJKn/I2EEVNOz/ZBR1sdHNNQD2D/Zdsn5EZ6
 fW2qiKLSsVchqc/HvA7aGm19p4Wk5BIQ+cbiaiKgkzZqCKe0V49KH5KP1NiVlLFjR/lPVrO2jp6
 fCp/Z7HPXRA8+GpYjT9O6ScKytWNNGmDlN2qZOwbU/RNqGej1tUlbL/Xtcr9c0tZzh9AoZTUUdJ
 tO+RmLebtx5DBsWl5jOzTE9XcA/eQJFIYM/Hy4+/3BTRscC2Jo3CyJf+XicmaKxF/KG3CdnOjNQ
 4vhgMhqdKw5xeXA/+eJ5ZiVNymjHTM/ohxmqvrcq9LVj1Cd6Ppnm29eQBchEaWY5f8xJCGsnAtK
 Crnwg+xpSxZJT2CXLzbm2f2q7+GgSrw60Prdml0pQyPGTwl4DorPYv83f+5ji1wMkmE3sk0AJxF
 SxxrLb6nVEGwdT3edG53ysA++T6Y0oRN/0ZWzWvM+RIuARAOznbXwibF1eNELSbsQyAf+Vnl6Q+
 YT+QI/GpAb0Km9KE73ggMe3TFKAw1/8N4ZudMe7rXnTtyvg8hlhjuLwSd2YKPXq53KGojpz/U06
 uxWw7bKkJrqqotw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_062822_323561_1EE24D58 
X-CRM114-Status: GOOD (  14.97  )
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

Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
hardware error recovery statistics that are already tracked by the
kernel. This allows userspace monitoring tools to track recovered
hardware errors without requiring kernel crashes.

This is useful to track recoverable hardware errors in a time series,
even if the host doesn't crash.

The sysfs directory contains one file per error subsystem:

  /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
  /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
  /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
  /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
  /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors

Each file contains a single integer representing the count of recovered
errors for that subsystem.

These statistics provide visibility into the health of the system's
hardware and can be used by system administrators to proactively detect
failing components before they cause system crashes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e2784038bbed7..b7fcd21be7c59 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -6,6 +6,8 @@
 
 #include <linux/buildid.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
@@ -139,6 +141,56 @@ void hwerr_log_error_type(enum hwerr_error_type src)
 }
 EXPORT_SYMBOL_GPL(hwerr_log_error_type);
 
+/* sysfs interface for hardware error recovery statistics */
+#define HWERR_ATTR_RO(_name, _type)					\
+static ssize_t _name##_show(struct kobject *kobj,			\
+			    struct kobj_attribute *attr, char *buf)	\
+{									\
+	return sysfs_emit(buf, "%d\n",					\
+			  atomic_read(&hwerr_data[_type].count));	\
+}									\
+static struct kobj_attribute hwerr_##_name##_attr = __ATTR_RO(_name)
+
+HWERR_ATTR_RO(cpu, HWERR_RECOV_CPU);
+HWERR_ATTR_RO(memory, HWERR_RECOV_MEMORY);
+HWERR_ATTR_RO(pci, HWERR_RECOV_PCI);
+HWERR_ATTR_RO(cxl, HWERR_RECOV_CXL);
+HWERR_ATTR_RO(others, HWERR_RECOV_OTHERS);
+
+static struct attribute *hwerr_recovery_stats_attrs[] = {
+	&hwerr_cpu_attr.attr,
+	&hwerr_memory_attr.attr,
+	&hwerr_pci_attr.attr,
+	&hwerr_cxl_attr.attr,
+	&hwerr_others_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group hwerr_recovery_stats_group = {
+	.attrs = hwerr_recovery_stats_attrs,
+};
+
+static struct kobject *hwerr_recovery_stats_kobj;
+
+static int __init hwerr_recovery_stats_init(void)
+{
+	hwerr_recovery_stats_kobj = kobject_create_and_add("hwerr_recovery_stats",
+							   kernel_kobj);
+	if (!hwerr_recovery_stats_kobj) {
+		pr_warn("Failed to create hwerr_recovery_stats kobject\n");
+		return -ENOMEM;
+	}
+
+	if (sysfs_create_group(hwerr_recovery_stats_kobj,
+			       &hwerr_recovery_stats_group)) {
+		kobject_put(hwerr_recovery_stats_kobj);
+		pr_warn("Failed to create hwerr_recovery_stats sysfs group\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
@@ -248,6 +300,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	/* Create /sys/kernel/hwerr_recovery_stats/ directory */
+	hwerr_recovery_stats_init();
+
 	return 0;
 }
 

-- 
2.47.3


