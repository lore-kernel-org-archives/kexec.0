Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF801D61013
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T0k0Sub0Mq72s9Oiq6GYg291efYrwY1mCaY72weOR3A=; b=u/yPL9BRZfuOGnuoFhFyiHCbym
	jpHHvux8g9bWhEjCDAoPJduXtxypSXzT7JyrBGrOXIWdGwDX9zjalBGyGPQeXPzXESwfL58Fl70pe
	qvCqnbB3u8Z+D3yyGZ0sJMyNqqyJvPCd/Mhr10517aUHaeYwZmVAzz5uNd1fLGxPWPVR280dfjnR+
	7z2WQBFxU/y419b5eyXlDW4ic5Rk19455eftaxurlNRNA9KGUilkMlbP3P/kw3njvH0aYZLV+SybI
	3bpkk+nbW5JsIuSvn4BY2DEwhKTHJo05bB/HuH/bI8tFPW8lv6lPywqGFp+4iZ+wxOo3sLobeE/EJ
	PcBHDvCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlSAS-00000000ADR-3TR7;
	Thu, 29 Jan 2026 13:34:40 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlSAR-00000000ACd-0AAn
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 13:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=T0k0Sub0Mq72s9Oiq6GYg291efYrwY1mCaY72weOR3A=; b=Usg+EyHgxc+vK3WC1sLae3gn/s
	EXwaipTNSlZgfhUqAnEy2qW9CK7UApD7jillQZLggDEWrQmB5JldrbEPEoKVsLb8iGwkx6/YHD7qJ
	Kt/NBkIetJw2BzbYCN/dgMNGqsI8ReX/h0ui2i42wDTuWyCWjbw5/eg77Bf7LFYbmDjKsvn5RfIZz
	nkL3n2wOSfE56pvTvuCW6QvKhAVpVY/glllMDmSVjWRsBJFesyDE+aSsW7gKqWBVTfngao29qQ3VT
	J7zp6c4JIevUKPVEcvgz1C9f/OfjHhb7lGqLU20s+OlqSQZOrMfV0EmhJ3cwGEXrozK7m/Ppp6arS
	JnzXKcCQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vlSAE-000yg7-0Z; Thu, 29 Jan 2026 13:34:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 29 Jan 2026 05:34:10 -0800
Subject: [PATCH] vmcore_info: expose hardware error recovery statistics via
 sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org>
X-B4-Tracking: v=1; b=H4sIANJhe2kC/yXMQQrCMBAF0KsMf91AG7Q1uYoU0XRGRzCRjBal9
 O6iLt/mLTCuyoZICyrPaloyInUNIV2O+cxOJ0SCb33fdj64+ZZKZc1SDvY2MSey6XdDGEKatmg
 I98qir1+5H/+25+nK6fF9sK4fZq5Mx3QAAAA=
X-Change-ID: 20260129-vmcoreinfo_sysfs-ff4687979cd5
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, kexec@lists.infradead.org, 
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=4963; i=leitao@debian.org;
 h=from:subject:message-id; bh=K4nt5U+K0mzduximxBPcgwZwF5EZvnMTnL9rEKcw0Nk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpe2HeA+EAfkq6/EmsGFRAuwoQQGVZGLenY5RAi
 J431FQ/AiGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXth3gAKCRA1o5Of/Hh3
 bT21D/4g6McQp+JPE9FNSGB2O9+IDVRtAu7i+Q1IIlHk80am2cUjz8W2YLQj+glsV6h/zj+lqU6
 hDmP7XugMTHnfWnZw60aNEsuw/F5VhDhe6/arhW16XlQXeDdz1/P+t2cZCKGEsKR6syOEX+4zay
 AoDx7BgiKR8YpfYCfnfj3IP81z4AiNmLQD0MRDx37DxSbTT/c73h/DqMfAnk8lk7ZB1k5Tlj0dv
 do83UbVbvK4AXcPdyHhghkksj+a5U4xriI/Rz71qPjEMpCXXdl2K0cOmmThtewIOKMCmwwY+bfE
 K30XaahW1aDprq9XeaMPCvm1AIVEiIPSAE9j0xvcuc1UwgU9Ct5DgJjGDg4YrYjbILz7R7zJtr1
 OdoJ3U72NXUPauj6OAwb5GWENODaqESB66wTj9XaXwC1Sbi9Wa943++ldU5Id4P/jWT+TWdWco8
 eZ+Akt1/j/iaMyCoZmsv6bK3F9mjzxIsDCICv/F4fNnf1NgpQ+wITh2t7g5Blg7atxQJdCchW4A
 vKU9N2KIOnfzOhErZEQ6dk4+FBZr4JCqJBAZ8wfyeFZRWKOEGMvP/IEKd3rOgXYlDyN472fC8Z5
 oz/p4OVVgJcRgU0RErz8BSet5oExk/F7FxIrOgYl03UmvwaNH8GIVV2EdvvXIJvhO1t0vO215M4
 GPaO9yxxl2FzxBw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_053439_096915_C3C1032F 
X-CRM114-Status: GOOD (  16.83  )
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

Add a sysfs file at /sys/kernel/vmcore_stats and expose hardware error
recovery statistics that are already tracked by the kernel. This allows
userspace monitoring tools to track recovered hardware errors without
requiring kernel crashes.

This is useful to track recoverable hardware errors in a time series,
even if the host doesn't crash.

Create a generic vmcore_stats sysfs, and add a section for
hwerr_recovery that shows the counts per subsystem and timestamps:

  - cpu: CPU-related errors (MCE, ARM processor errors)
  - memory: Memory-related errors
  - pci: PCI/PCIe AER non-fatal errors
  - cxl: CXL errors
  - other: Other hardware errors

Example output:
  hwerr_recovery:
    cpu: 0 (0)
    memory: 2 (1738148257)
    pci: 1 (1738147000)
    cxl: 0 (0)
    other: 0 (0)

The value in parentheses is the timestamp (seconds since epoch) of the
last error of that type, or 0 if no errors have occurred.

These statistics provide visibility into the health of the system's
hardware and can be used by system administrators to proactively detect
failing components before they cause system crashes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org
To: bhe@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com
Cc: tony.luck@intel.com
Cc: xueshuai@linux.alibaba.com
Cc: vgoyal@redhat.com
Cc: zhiquan1.li@intel.com
Cc: olja@meta.com
---
 .../ABI/testing/sysfs-kernel-vmcore_stats          | 23 ++++++++++++++++
 kernel/vmcore_info.c                               | 31 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-vmcore_stats b/Documentation/ABI/testing/sysfs-kernel-vmcore_stats
new file mode 100644
index 0000000000000..b42f18d24c00b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-vmcore_stats
@@ -0,0 +1,23 @@
+What:		/sys/kernel/vmcore_stats
+Date:		January 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Shows statistics related to vmcore functionality. Currently
+		includes hardware error recovery statistics.
+
+		Format:
+		  Recovered hardware errors:
+		    metric: count (timestamp)
+
+		Statistics about recoverable hardware errors that the kernel
+		has handled since boot. Each metric shows the count and
+		timestamp (seconds since epoch) of the last error in
+		parentheses (0 if no errors have occurred).
+
+		Metrics:
+		    - cpu: CPU-related errors (MCE, ARM processor errors)
+		    - memory: Memory-related errors
+		    - pci: PCI/PCIe AER non-fatal errors
+		    - cxl: CXL (Compute Express Link) errors
+		    - other: Other hardware errors
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index fe9bf8db1922e..5974b4be08cbc 100644
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
@@ -135,6 +137,31 @@ void hwerr_log_error_type(enum hwerr_error_type src)
 }
 EXPORT_SYMBOL_GPL(hwerr_log_error_type);
 
+/* sysfs interface for hardware error recovery statistics */
+static ssize_t vmcore_stats_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf,
+			  "Recovered hardware errors:\n"
+			  "  cpu: %d (%lld)\n"
+			  "  memory: %d (%lld)\n"
+			  "  pci: %d (%lld)\n"
+			  "  cxl: %d (%lld)\n"
+			  "  other: %d (%lld)\n",
+			  atomic_read(&hwerr_data[HWERR_RECOV_CPU].count),
+			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_CPU].timestamp),
+			  atomic_read(&hwerr_data[HWERR_RECOV_MEMORY].count),
+			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_MEMORY].timestamp),
+			  atomic_read(&hwerr_data[HWERR_RECOV_PCI].count),
+			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_PCI].timestamp),
+			  atomic_read(&hwerr_data[HWERR_RECOV_CXL].count),
+			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_CXL].timestamp),
+			  atomic_read(&hwerr_data[HWERR_RECOV_OTHERS].count),
+			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_OTHERS].timestamp));
+}
+
+static struct kobj_attribute vmcore_stats_attr = __ATTR_RO(vmcore_stats);
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
@@ -244,6 +271,10 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	/* Create /sys/kernel/vmcore_stats */
+	if (sysfs_create_file(kernel_kobj, &vmcore_stats_attr.attr))
+		pr_warn("Failed to create vmcore_stats sysfs file\n");
+
 	return 0;
 }
 

---
base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
change-id: 20260129-vmcoreinfo_sysfs-ff4687979cd5

Best regards,
--  
Breno Leitao <leitao@debian.org>


