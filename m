Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F10E7DEF1
	for <kexec@archiver.kernel.org>; Mon,  2 Feb 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BsYw1jdHI6UNaHJ0xGEA+g0R+OyYdE59KzSX/GWoWYg=; b=4fvMEvaiLq/ulXej0bYp+X7z5f
	DqWoE4pqVm03H8Inmk3cMb3qEhgAMS4WzoYLJ8OAqeHHM9+KuWS3vQY24SKNnFTYX5aVrkY5VacqZ
	FpFeXl6mWF/g3C69Og6pmvIrs8Z7N+lzrNjwxfi01dKhpHf3n1Ggrwdk9UbRbbE9cWmSCHNJtayVX
	KfKA7TRG/3wHIsPVBY0Vp5Uw4yGsoRYgvwHPEuUXjL8FozK8CymEV8VdSG8Vq+2mz0byjimVX3k/1
	Ak0Ye2jVPkX8N0gUk34GXj84rie110/Z+buT3jrvAofa1zXKHO9QF1ZltZUrm0BTfTnu9aujJIuZv
	JHAQ3TwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmuuk-0000000567F-2FfG;
	Mon, 02 Feb 2026 14:28:30 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmuud-0000000564R-2xUc;
	Mon, 02 Feb 2026 14:28:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=BsYw1jdHI6UNaHJ0xGEA+g0R+OyYdE59KzSX/GWoWYg=; b=aTgBNQQhltAuw96wTOS8uy9t3o
	u5GM4R+satqAZlav3VkjHQMCbIG+RU7NskjwGA0dSj4hMrzgo3GbAQY6aonNxs5O34lCC8JVWXB3v
	20VQ2YCokPSqSK2xreRzSFq2dcdhkY71p3FBlRSJ2FhYaloOS6gMTGmL/sJzYm7H8d2IyQ3Gk3Kwy
	x8pNfhc+PtmsR1Yq3cwsj/0kUr/8gf54yPRr6qfmF39F41WG2wO3E8fcR4C0B+soL7U3O+sRwqt1w
	ZVwyNntOpXeIXXsnuzW2YYLxdpZPW2fi2O9huq1p51c0Ip/wltzgBdMk6rNaGHud87OYBeFFeLHmu
	1y8f8MTQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vmuuT-0046Xj-1B; Mon, 02 Feb 2026 14:28:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Feb 2026 06:27:40 -0800
Subject: [PATCH v2 2/2] docs: add ABI documentation for
 /sys/kernel/hwerr_recovery_stats/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-vmcoreinfo_sysfs-v2-2-8f3b5308b894@debian.org>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=3053; i=leitao@debian.org;
 h=from:subject:message-id; bh=18gfPfnS76lTnOnvubbkQRKtlWGXJGHF5diwW/VEeLw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgLRtcjZ4+WBywa2wxT1191HPWP7OKn4XR6Tn9
 uqH93TzJzmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYC0bQAKCRA1o5Of/Hh3
 bXbeEACoupF1Pf8XMs+rEdztojnWgDL4it51PtcayAHw+CQ6Wdp1MY6lxhkmj0g1+YNf+SwxbRl
 QynpeiRWj8Q15AddCGhpfuh7Uj4EuytJ6LXF18iIygYbwxlqC6GHxcYALJDCe/0RCpvnmrB5t0C
 KFSumDtE69FQYF2XESSku2W12rRODBRbnqvMWXdUkdVUobQyWmVhzGrntc7YDDX8MAg9si7Q6RQ
 WRrOTx28/G/RnNnzV/y4JBPjPJWV6Ibb7xGBrpVoiOJSJzEkGPBbKl6ZE+Fm3a+CmQp50aOLeWp
 yEscW50qSksuh0MyMdyDr1YhG+1vibIu/YUePZscz/cU7lK2dO+lORrafpeeEHHVbS5mnxmeM+R
 XDzkv+QiSPJIz1SAblR4iVeIwJYVuhI8irPOuv5KvdGWG1LE9aCEb/IZQKF3zQ3fOl5ywUK97JR
 SgoWnzj4yei259VzhSdUsgb9UR3RhGX8IX5TN8YJ7Yip9jK2Q4h3GL9loYly8g0c3ptWRDSaV4f
 eL50p/ADmpWoj899YL94PfCLUhZ8LSx+/QrwOdWmq3n6l46BPoEdrrF9LcXVnNDXIjw1tfAlhA8
 SAOGRYTZHatuaHp8sqoHRksVztne8OSrCPc70LI+pubdyQxWbmjuYKvYSVq59R3S/0PBxZm0oAF
 6TW1S81PupfKqIw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_062823_787206_F673FD06 
X-CRM114-Status: GOOD (  12.49  )
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

Document the new hwerr_recovery_stats sysfs directory that exposes
hardware error recovery statistics.

Update hw-recoverable-errors.rst to reference the new sysfs interface
for runtime monitoring.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../ABI/testing/sysfs-kernel-hwerr_recovery_stats  | 47 ++++++++++++++++++++++
 Documentation/driver-api/hw-recoverable-errors.rst |  3 +-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-hwerr_recovery_stats b/Documentation/ABI/testing/sysfs-kernel-hwerr_recovery_stats
new file mode 100644
index 0000000000000..4cb9f5a89fba9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-hwerr_recovery_stats
@@ -0,0 +1,47 @@
+What:		/sys/kernel/hwerr_recovery_stats/
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Directory containing hardware error recovery statistics.
+		These statistics track recoverable hardware errors that the
+		kernel has handled since boot.
+
+		Each file contains a single integer representing the count
+		of recovered errors for that subsystem.
+
+What:		/sys/kernel/hwerr_recovery_stats/cpu
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of CPU-related recovered errors (MCE, ARM processor
+		errors).
+
+What:		/sys/kernel/hwerr_recovery_stats/memory
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of memory-related recovered errors.
+
+What:		/sys/kernel/hwerr_recovery_stats/pci
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of PCI/PCIe AER non-fatal recovered errors.
+
+What:		/sys/kernel/hwerr_recovery_stats/cxl
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of CXL (Compute Express Link) recovered errors.
+
+What:		/sys/kernel/hwerr_recovery_stats/others
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of other hardware recovered errors.
diff --git a/Documentation/driver-api/hw-recoverable-errors.rst b/Documentation/driver-api/hw-recoverable-errors.rst
index fc526c3454bd7..4aefcd103be22 100644
--- a/Documentation/driver-api/hw-recoverable-errors.rst
+++ b/Documentation/driver-api/hw-recoverable-errors.rst
@@ -36,7 +36,8 @@ Data Exposure and Consumption
   types like CPU, memory, PCI, CXL, and others.
 - It is exposed via vmcoreinfo crash dump notes and can be read using tools
   like `crash`, `drgn`, or other kernel crash analysis utilities.
-- There is no other way to read these data other than from crash dumps.
+- It is also exposed via sysfs at ``/sys/kernel/hwerr_recovery_stats/`` for runtime
+  monitoring without requiring a crash dump.
 - These errors are divided by area, which includes CPU, Memory, PCI, CXL and
   others.
 

-- 
2.47.3


