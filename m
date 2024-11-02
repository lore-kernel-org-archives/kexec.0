Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BF2E6F09A
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 01:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lnk4JiULbBrrUj6zDOuBiWOWZLkXZ0E2Yvb+RV+9yoA=; b=GdEW27IXCkczPs
	heod6DQ6LVG6UsMDU4RwcWX60vPl1o8zztUkiKjMSlxwzyOQr1z1QQCdzziN8DT3+mTWH9xPG2Z13
	BDw/cKXfPq0ImIiaK7mto9rZpMHec8Fuhs/iIFGlLmcCB8KHkWGRgBRHcpf5ktt+BY59AZ19oLiOo
	avWLHfy8V0DLELTuHqmLoDdQCs650rPZQTOUwi4XmIVjEjTc2Ix2vM2OM6gJhc7enYEx77cbu1he/
	s1xoZmmY/9Km5v21iIaXuYigpPJDfcd+aDsRl/GUlImo/xnuKdCayOc9X+3Nch8Hxv4vmeWeV1KQP
	n//Z+QIKEvWdGANg1i5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7354-00000008pI3-3xLc;
	Sat, 02 Nov 2024 01:37:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7352-00000008pH2-0M5O
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 01:37:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A1323A44B06;
	Sat,  2 Nov 2024 01:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE197C4CECD;
	Sat,  2 Nov 2024 01:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730511449;
	bh=dg3Vvk9BW/08Uyv9TSnw8NEQAwhAZCODUD7UGzdocAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLMvs0L+DA7kvp+zMAyuyHd2pZmYG/dz+fmCBnOBeoZEoG05ipe1OYdEp/Vcpx/4V
	 jdohUR73m/hgg5nDraEzZ1L/FlVnczAcB4pzO6YQcHjk2VsY3jQfVxL0UMoDNapJFm
	 8vCo0IVo/gVA2Ugeb1oDBY1u23yrHnf2gBzT1OXPrYuH2b89+RK584kvX+LVFGzplk
	 WSyuPaE6r2Ty/WBWQQD4AleDUnWltHoyAQG02Qzhq2jFd+fVhdgHD2PX0f7ULDz3uN
	 56AdymL4OsOgpYk1TOh9nWmK6q/xEdVIRK2kUcfjDFf92T4clf4W/dXd6KzAdTvFRZ
	 ipZfuH4lcvklg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: James.Bottomley@hansenpartnership.com,
	andrew.cooper3@citrix.com,
	ardb@kernel.org,
	baolu.lu@linux.intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dpsmith@apertussolutions.com,
	dwmw2@infradead.org,
	ebiederm@xmission.com,
	herbert@gondor.apana.org.au,
	hpa@zytor.com,
	iommu@lists.linux-foundation.org,
	kanth.ghatraju@oracle.com,
	kexec@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luto@amacapital.net,
	mingo@redhat.com,
	mjg59@srcf.ucam.org,
	nivedita@alum.mit.edu,
	tglx@linutronix.de,
	trenchboot-devel@googlegroups.com,
	x86@kernel.org
Subject: [RFC PATCH] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
Date: Sat,  2 Nov 2024 03:37:14 +0200
Message-ID: <20241102013716.1036396-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240913200517.3085794-18-ross.philipson@oracle.com>
References: <20240913200517.3085794-18-ross.philipson@oracle.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_183732_284362_A7063CBE 
X-CRM114-Status: GOOD (  25.78  )
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

DRTM needs to be able to set the locality used by kernel. Provide
TPM_IOC_SET_LOCALITY operation for this purpose. It is enabled only if
the kernel command-line has 'tpm.set_locality_enabled=1'. The operation
is one-shot allowed only for tpm_tis for the moment.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
NOTE: Only compile-tested.
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 .../userspace-api/ioctl/ioctl-number.rst      |  2 +
 drivers/char/tpm/tpm-chip.c                   |  2 +-
 drivers/char/tpm/tpm-dev.c                    | 70 +++++++++++++++++++
 drivers/char/tpm/tpm_tis_core.c               |  2 +
 include/linux/tpm.h                           | 10 +++
 include/uapi/linux/tpm.h                      | 11 +++
 7 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/tpm.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..9e760de6c307 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6727,6 +6727,11 @@
 	torture.verbose_sleep_duration= [KNL]
 			Duration of each verbose-printk() sleep in jiffies.
 
+	tpm.set_locality_enabled= [HW,TPM]
+			Enable one-shot locality setting after the boot. It can
+			can be set with the TPM_IOC_SET_LOCALE ioctl applied to
+			/dev/tpm0. The parameter is set by default as '0'.
+
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e4be1378ba26..3eba57ab2fb1 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -338,6 +338,8 @@ Code  Seq#    Include File                                           Comments
 0xA3  90-9F  linux/dtlk.h
 0xA4  00-1F  uapi/linux/tee.h                                        Generic TEE subsystem
 0xA4  00-1F  uapi/asm/sgx.h                                          <mailto:linux-sgx@vger.kernel.org>
+0xA4  00-1F  uapi/linux/tpm.h                                        TPM
+                                                                     <mailto:linux-integrity@vger.kernel.org>
 0xA5  01-05  linux/surface_aggregator/cdev.h                         Microsoft Surface Platform System Aggregator
                                                                      <mailto:luzmaximilian@gmail.com>
 0xA5  20-2F  linux/surface_aggregator/dtx.h                          Microsoft Surface DTX driver
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7df7abaf3e52..c8016342352a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->default_locality);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 97c94b5e9340..bb9c346947aa 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -13,8 +13,74 @@
  * Device file system interface to the TPM
  */
 #include <linux/slab.h>
+#include <uapi/linux/tpm.h>
 #include "tpm-dev.h"
 
+static bool set_locality_enabled;
+module_param(set_locality_enabled, bool, 0644);
+
+/*
+ * Set a locality as a one-shot operation. A chip must declare support for it
+ * with %TPM_CHIP_FLAG_SET_LOCALITY_ENABLED, which will cleared after setting
+ * the locality.
+ */
+static long tpm_ioc_set_locality(struct tpm_chip *chip, u8 __user *localityp)
+{
+	u8 locality;
+
+	if (!set_locality_enabled)
+		return -ENOIOCTLCMD;
+
+	if (chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&locality, localityp, sizeof(locality)))
+		return -EFAULT;
+
+	if (locality >= TPM_MAX_LOCALITY)
+		return -EINVAL;
+
+	chip->default_locality = locality;
+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+	return 0;
+}
+
+static long tpm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct file_priv *priv = file->private_data;
+	void __user *argp = (void __user *)arg;
+	struct tpm_chip *chip = priv->chip;
+	int ret;
+
+	mutex_lock(&priv->buffer_mutex);
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		goto out;
+
+	switch (cmd) {
+	case TPM_IOC_SET_LOCALITY:
+		tpm_ioc_set_locality(chip, argp);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	tpm_put_ops(chip);
+
+out:
+	mutex_unlock(&priv->buffer_mutex);
+	return 0;
+}
+
+#ifdef CONFIG_COMPAT
+static long tpm_compat_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	return tpm_ioctl(filep, cmd, arg);
+}
+#endif
+
 static int tpm_open(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip;
@@ -59,6 +125,10 @@ static int tpm_release(struct inode *inode, struct file *file)
 
 const struct file_operations tpm_fops = {
 	.owner = THIS_MODULE,
+	.unlocked_ioctl = tpm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = tpm_compat_ioctl,
+#endif
 	.open = tpm_open,
 	.read = tpm_common_read,
 	.write = tpm_common_write,
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..3517db710423 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1111,6 +1111,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 587b96b4418e..27071ef13b7a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -147,6 +147,12 @@ struct tpm_chip_seqops {
  */
 #define TPM2_MAX_CONTEXT_SIZE 4096
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -202,6 +208,9 @@ struct tpm_chip {
 	/* active locality */
 	int locality;
 
+	/* the default locality used by the kernel (default 0) */
+	u8 default_locality;
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
 
@@ -348,6 +357,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(11),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
diff --git a/include/uapi/linux/tpm.h b/include/uapi/linux/tpm.h
new file mode 100644
index 000000000000..654080e1b1e5
--- /dev/null
+++ b/include/uapi/linux/tpm.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_TPM_H
+#define _UAPI_TPM_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define TPM_MAGIC 0xA4
+#define TPM_IOC_SET_LOCALITY _IOW(TPM_MAGIC, 0x00, u8)
+
+#endif /* _UAPI_TPM_H */
-- 
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
