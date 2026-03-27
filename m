Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0667310BA434
	for <kexec@archiver.kernel.org>; Fri, 27 Mar 2026 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJh+fSdSH5NQ/gboRRLrSOUWnglDImWXDS4hyVsChMM=; b=p69bAy9JLccNaRSC16H2tG1n8y
	AFpaZrbZnHNxr5a/2AQnGxN7VK9FpB5NaPkgK5w/Nx73LTn/BqP/Dkp02vljgJ+B/NA07V16DsabL
	ZEmpeJ/5BodvlTYluW2/uz0ncgoTOCs78uXe9/09hDVR/LOJgbgCDTU2DSccstpnfqStzBE4qaNWW
	Tfs/eth0IAW0cP8JuGOul0MlnMxPMzjfsVf9IjfKIdAJOXEGtQALntj7F3bkVsYz7oKStvzKWKeyC
	0Mn6GvFu1C0RaDLTOachWFXMROwUVdv3S6l+M24XGn8DJWRrqvSYFCIuhsE6pSL2ywAulTjp5XPng
	o0hnqalw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Gmc-00000008KDY-2JLb;
	Fri, 27 Mar 2026 23:40:06 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6GmW-00000008KCr-1AQj
	for kexec@lists.infradead.org;
	Fri, 27 Mar 2026 23:40:01 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b0c12be0ecso36575ad.0
        for <kexec@lists.infradead.org>; Fri, 27 Mar 2026 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654798; x=1775259598; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJh+fSdSH5NQ/gboRRLrSOUWnglDImWXDS4hyVsChMM=;
        b=ODhxFk0182FANiqz4mcNsnKD9MyqwYliQVOA8nA3RNwWdPPXoaMoOdelxtNFHejlpO
         Wrn+fBFk2qP14bbWasLmY/8O7viUh2kYKnvOfS2ZwiLu0ksGA3Lo9cBUMpRReFTXuK52
         T0X5d6IRKB4Gu+btq9IxtJzLeCfnvMld99r0GrDKR3kAZrofyRxUHr8+Es3ZaKP0jRUf
         UGx+aJDuUANooYk9EjKT7TKKbv+A5hI2IhpPfvCKiWqRZQKHXrcY1Xebu1Hy1g1meDUr
         a4Hq6jQF8ziBPQ7XFY6ed8/pwprapDN+r8nIkcUzMPpRB9nEsBlf3xT0Je5iZcaxHGbr
         sMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654798; x=1775259598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJh+fSdSH5NQ/gboRRLrSOUWnglDImWXDS4hyVsChMM=;
        b=Hsicv7JQqSdYegeSHfX5ds4A+9kPU/AhBzZMR0RZpS4j6yY059jHGwFmhcDVJCQPUz
         plpk5Ykssu9YitX5CCxqK/MAQ0Y6crm4HD5nGdIZO9KyAvfwCTnUDYR4rsx5k4dIq0CW
         TeFNo+D3iLEfJpJOLNY9JYpuZnv6r6zHBWYdSgCPcvWNCFINWcn3hvneo4QfSd0BLHuq
         dstjsLJTQf60JS9Hx3IDFXYKTE6/glivdodXyo7I9nRx66N32Ol9LJUhGvgmgCDxCtGA
         oEq/A+mzBcOyoNTF11Wxh8VI/R6uNVZtf21QYkvbKTXNBAJqRLVIS8yr2DM5wbe83rTF
         UKtA==
X-Forwarded-Encrypted: i=1; AJvYcCXAe59gMnO5EzRXrPy6s5b0arPFaWj5MGwY+1yB5S6GyJCWS8CXoMJFfxTuQzZI24/YHQ1Tbg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5YjTrlgCgwlRt7rgh95l/vGF9dYW/ewrihY2BHxgtMVDQ4wAr
	FnCFcDzXTja5cH/lIywSp/cNBhgIXSsfdp3Nsnlax4Kss+wdGfey63udvvgRQ9xoHg==
X-Gm-Gg: ATEYQzzqw1Sp5wZl9sR6eJN5KqfjulOmZOPsXdjXWaUV6JTpX2KATSsP1cNhvqEuwhX
	voidWvgRabrcngR/T5eqp7VfqNAcF1GFPv+CC2zKzRR0NJR7D4cz2TGtGWRmjhboBC1ExjF2yc2
	pp8da6G67/vCCyL7jCTlflCpBABUMIUIGqE2rjMzJ/vpF1H8Em7DiO2sYL4cDL/1bJH8Ob9XNRd
	QooZTg0iQHLqltGNInQfT4D0sQjvcGXGRKk8ZyB6eRjnv41+ysXjcmN8vE2pSXU8Xs2tVjkV388
	T2HlM0I7UE6T/AhRQ5BqRUCqY/ZaeiF8usxl1PCel9+Z+9HbdneXd6Ey9q8q9P/s2jwwn70ON7Q
	AQTPrfKsn89B+zHiI2/fTsIGoKMgMR+D4sAnnqRuaY2G8RECAkv/RFZv5QYr0t9D46LSi3mp7c/
	gGfw5BcFSAjbT2+CrrJoHeDG6TQOqjPmNRpMI4KMTft531Cb7i+a4onC0MgPxFYA==
X-Received: by 2002:a17:902:e84c:b0:2ae:6755:a24f with SMTP id d9443c01a7336-2b241ba1a2amr1512495ad.0.1774654797569;
        Fri, 27 Mar 2026 16:39:57 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642b43sm5138615ad.9.2026.03.27.16.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 16:39:56 -0700 (PDT)
Date: Fri, 27 Mar 2026 23:39:53 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, 
	Askar Safin <safinaskar@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <accS5UUyP8Qw1bUW@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-8-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323235817.1960573-8-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_164000_400638_941F7583 
X-CRM114-Status: GOOD (  39.04  )
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

On Mon, Mar 23, 2026 at 11:57:59PM +0000, David Matlack wrote:
>From: Vipin Sharma <vipinsh@google.com>
>
>Implement the live update file handler callbacks to preserve a vfio-pci
>device across a Live Update. Subsequent commits will enable userspace to
>then retrieve this file after the Live Update.
>
>Live Update support is scoped only to cdev files (i.e. not
>VFIO_GROUP_GET_DEVICE_FD files).
>
>State about each device is serialized into a new ABI struct
>vfio_pci_core_device_ser. The contents of this struct are preserved
>across the Live Update to the next kernel using a combination of
>Kexec-Handover (KHO) to preserve the page(s) holding the struct and the
>Live Update Orchestrator (LUO) to preserve the physical address of the
>struct.
>
>For now the only contents of struct vfio_pci_core_device_ser the
>device's PCI segment number and BDF, so that the device can be uniquely
>identified after the Live Update.
>
>Require that userspace disables interrupts on the device prior to
>freeze() so that the device does not send any interrupts until new
>interrupt handlers have been set up by the next kernel.
>
>Reset the device and restore its state in the freeze() callback. This
>ensures the device can be received by the next kernel in a consistent
>state. Eventually this will be dropped and the device can be preserved
>across in a running state, but that requires further work in VFIO and
>the core PCI layer.
>
>Note that LUO holds a reference to this file when it is preserved. So
>VFIO is guaranteed that vfio_df_device_last_close() will not be called
>on this device no matter what userspace does.

LUO session holding the reference is also in userspace. Just to be
accurate, maybe say something like that the LUO will hold a reference
until the FD is preserved and vfio_df_device_last_close() will not be
called until file is unpreserved.
>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>Co-developed-by: David Matlack <dmatlack@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/vfio/pci/vfio_pci.c            |   2 +-
> drivers/vfio/pci/vfio_pci_core.c       |  57 +++++----
> drivers/vfio/pci/vfio_pci_liveupdate.c | 156 ++++++++++++++++++++++++-
> drivers/vfio/pci/vfio_pci_priv.h       |   4 +
> drivers/vfio/vfio_main.c               |   3 +-
> include/linux/kho/abi/vfio_pci.h       |  15 +++
> include/linux/vfio.h                   |   2 +
> 7 files changed, 213 insertions(+), 26 deletions(-)
>
>diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>index 41dcbe4ace67..351480d13f6e 100644
>--- a/drivers/vfio/pci/vfio_pci.c
>+++ b/drivers/vfio/pci/vfio_pci.c
>@@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
> 	return 0;
> }
>
>-static const struct vfio_device_ops vfio_pci_ops = {
>+const struct vfio_device_ops vfio_pci_ops = {
> 	.name		= "vfio-pci",
> 	.init		= vfio_pci_core_init_dev,
> 	.release	= vfio_pci_core_release_dev,
>diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>index d43745fe4c84..81f941323641 100644
>--- a/drivers/vfio/pci/vfio_pci_core.c
>+++ b/drivers/vfio/pci/vfio_pci_core.c
>@@ -585,9 +585,42 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
> }
> EXPORT_SYMBOL_GPL(vfio_pci_core_enable);
>
>+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
>+{
>+	struct pci_dev *pdev = vdev->pdev;
>+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
>+
>+	lockdep_assert_held(&vdev->vdev.dev_set->lock);
>+
>+	if (!vdev->reset_works)
>+		return;
>+
>+	/*
>+	 * Try to get the locks ourselves to prevent a deadlock. The
>+	 * success of this is dependent on being able to lock the device,
>+	 * which is not always possible.
>+	 *
>+	 * We cannot use the "try" reset interface here, since that will
>+	 * overwrite the previously restored configuration information.
>+	 */
>+	if (bridge && !pci_dev_trylock(bridge))
>+		return;
>+
>+	if (!pci_dev_trylock(pdev))
>+		goto out;
>+
>+	if (!__pci_reset_function_locked(pdev))
>+		vdev->needs_reset = false;
>+
>+	pci_dev_unlock(pdev);
>+out:
>+	if (bridge)
>+		pci_dev_unlock(bridge);
>+}
>+EXPORT_SYMBOL_GPL(vfio_pci_core_try_reset);
>+
> void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
> {
>-	struct pci_dev *bridge;
> 	struct pci_dev *pdev = vdev->pdev;
> 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
> 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
>@@ -687,27 +720,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
> 	 */
> 	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
>
>-	/*
>-	 * Try to get the locks ourselves to prevent a deadlock. The
>-	 * success of this is dependent on being able to lock the device,
>-	 * which is not always possible.
>-	 * We can not use the "try" reset interface here, which will
>-	 * overwrite the previously restored configuration information.
>-	 */
>-	if (vdev->reset_works) {
>-		bridge = pci_upstream_bridge(pdev);
>-		if (bridge && !pci_dev_trylock(bridge))
>-			goto out_restore_state;
>-		if (pci_dev_trylock(pdev)) {
>-			if (!__pci_reset_function_locked(pdev))
>-				vdev->needs_reset = false;
>-			pci_dev_unlock(pdev);
>-		}
>-		if (bridge)
>-			pci_dev_unlock(bridge);
>-	}
>-
>-out_restore_state:
>+	vfio_pci_core_try_reset(vdev);
> 	pci_restore_state(pdev);
> out:
> 	pci_disable_device(pdev);
>diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>index 5ea5af46b159..c4ebc7c486e5 100644
>--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
>+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
>@@ -6,27 +6,178 @@
>  * David Matlack <dmatlack@google.com>
>  */
>
>+/**
>+ * DOC: VFIO PCI Preservation via LUO
>+ *
>+ * VFIO PCI devices can be preserved over a kexec using the Live Update
>+ * Orchestrator (LUO) file preservation. This allows userspace (such as a VMM)
>+ * to transfer an in-use device to the next kernel.
>+ *
>+ * .. note::
>+ *    The support for preserving VFIO PCI devices is currently *partial* and
>+ *    should be considered *experimental*. It should only be used by developers
>+ *    working on expanding the support for the time being.
>+ *
>+ *    To avoid accidental usage while the support is still experimental, this
>+ *    support is hidden behind a default-disable config option
>+ *    ``CONFIG_VFIO_PCI_LIVEUPDATE``. Once the kernel support has stabilized and
>+ *    become complete, this option will be enabled by default when
>+ *    ``CONFIG_VFIO_PCI`` and ``CONFIG_LIVEUPDATE`` are enabled.
>+ *
>+ * Usage Example
>+ * =============
>+ *
>+ * VFIO PCI devices can be preserved across a kexec by preserving the file
>+ * associated with the device in a LUO session::
>+ *
>+ *   device_fd = open("/dev/vfio/devices/X");
>+ *   ...
>+ *   ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, { ..., device_fd, ...});
>+ *
>+ * .. note::
>+ *    LUO will hold an extra reference to the device file for as long as it is
>+ *    preserved, so there is no way for the file to be destroyed or the device
>+ *    to be unbound from the vfio-pci driver while it is preserved.
>+ *
>+ * Retrieving the file after kexec is not yet supported.
>+ *
>+ * Restrictions
>+ * ============
>+ *
>+ * The kernel imposes the following restrictions when preserving VFIO devices:
>+ *
>+ *  * The device must be bound to the ``vfio-pci`` driver.
>+ *
>+ *  * ``CONFIG_VFIO_PCI_ZDEV_KVM`` must not be enabled. This may be relaxed in
>+ *    the future.
>+ *
>+ *  * The device not be an Intel display device. This may be relaxed in the
>+ *    future.

Seems there is a typo. The device "may"/"must" not be?
>+ *
>+ *  * The device file must have been acquired from the VFIO character device,
>+ *    not ``VFIO_GROUP_GET_DEVICE_FD``.
>+ *
>+ *  * The device must have interrupt disable prior to kexec. Failure to disable
>+ *    interrupts on the device will cause the ``reboot(LINUX_REBOOT_CMD_KEXEC)``
>+ *    syscall (to initiate the kexec) to fail.
>+ *
>+ * Preservation Behavior
>+ * =====================
>+ *
>+ * The eventual goal of this support is to avoid disrupting the workload, state,
>+ * or configuration of each preserved device during a Live Update. This would
>+ * include allowing the device to perform DMA to preserved memory buffers and
>+ * perform P2P DMA to other preserved devices. However, there are many pieces
>+ * that still need to land in the kernel.
>+ *
>+ * For now, VFIO only preserves the following state for for devices:
>+ *
>+ *  * The PCI Segment, Bus, Device, and Function numbers of the device. The
>+ *    kernel guarantees the these will not change across a kexec when a device
>+ *    is preserved.
>+ *
>+ * Since the kernel is not yet prepared to preserve all parts of the device and
>+ * its dependencies (such as DMA mappings), VFIO currently resets and restores
>+ * preserved devices back into an idle state during kexec, before handing off
>+ * control to the next kernel. This will be relaxed in future versions of the
>+ * kernel once it is safe to allow the device to keep running across kexec.
>+ */
>+
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>+#include <linux/kexec_handover.h>
> #include <linux/kho/abi/vfio_pci.h>
> #include <linux/liveupdate.h>
> #include <linux/errno.h>
>+#include <linux/vfio.h>
>
> #include "vfio_pci_priv.h"
>
> static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
> 					     struct file *file)
> {
>-	return false;
>+	struct vfio_device *device = vfio_device_from_file(file);
>+	struct vfio_pci_core_device *vdev;
>+	struct pci_dev *pdev;
>+
>+	if (!device)
>+		return false;
>+
>+	/* Live Update support is limited to cdev files. */
>+	if (!vfio_device_cdev_opened(device))
>+		return false;
>+
>+	if (device->ops != &vfio_pci_ops)
>+		return false;
>+
>+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>+	pdev = vdev->pdev;
>+
>+	/*
>+	 * Don't support specialized vfio-pci devices for now since they haven't
>+	 * been tested.
>+	 */
>+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM) || vfio_pci_is_intel_display(pdev))
>+		return false;
>+
>+	return true;
> }
>
> static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> {
>-	return -EOPNOTSUPP;
>+	struct vfio_device *device = vfio_device_from_file(args->file);
>+	struct vfio_pci_core_device_ser *ser;
>+	struct vfio_pci_core_device *vdev;
>+	struct pci_dev *pdev;
>+
>+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>+	pdev = vdev->pdev;
>+
>+	ser = kho_alloc_preserve(sizeof(*ser));
>+	if (IS_ERR(ser))
>+		return PTR_ERR(ser);
>+
>+	ser->bdf = pci_dev_id(pdev);
>+	ser->domain = pci_domain_nr(pdev->bus);
>+
>+	args->serialized_data = virt_to_phys(ser);
>+	return 0;
> }
>
> static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
> {
>+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>+}
>+
>+static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
>+{
>+	struct vfio_device *device = vfio_device_from_file(args->file);
>+	struct vfio_pci_core_device *vdev;
>+	struct pci_dev *pdev;
>+	int ret;
>+
>+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>+	pdev = vdev->pdev;
>+
>+	guard(mutex)(&device->dev_set->lock);
>+
>+	/*
>+	 * Userspace must disable interrupts on the device prior to freeze so
>+	 * that the device does not send any interrupts until new interrupt
>+	 * handlers have been established by the next kernel.
>+	 */
>+	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
>+		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
>+		return -EINVAL;
>+	}
>+
>+	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
>+	if (ret)
>+		return ret;
>+
>+	vfio_pci_core_try_reset(vdev);

nit: I see you have already added a comment earlier saying that device will
be reset to a clean state as all the of the dependencies to preserve the
state for continous DMA are not there. Maybe we can add a comment here
to specify that this will go away once we have full preservation
support.
>+	pci_restore_state(pdev);
>+	return 0;
> }
>
> static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
>@@ -42,6 +193,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> 	.can_preserve = vfio_pci_liveupdate_can_preserve,
> 	.preserve = vfio_pci_liveupdate_preserve,
> 	.unpreserve = vfio_pci_liveupdate_unpreserve,
>+	.freeze = vfio_pci_liveupdate_freeze,
> 	.retrieve = vfio_pci_liveupdate_retrieve,
> 	.finish = vfio_pci_liveupdate_finish,
> 	.owner = THIS_MODULE,
>diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>index cbf46e09da30..fa5c7f544f8a 100644
>--- a/drivers/vfio/pci/vfio_pci_priv.h
>+++ b/drivers/vfio/pci/vfio_pci_priv.h
>@@ -11,6 +11,10 @@
> /* Cap maximum number of ioeventfds per device (arbitrary) */
> #define VFIO_PCI_IOEVENTFD_MAX		1000
>
>+extern const struct vfio_device_ops vfio_pci_ops;
>+
>+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev);
>+
> struct vfio_pci_ioeventfd {
> 	struct list_head	next;
> 	struct vfio_pci_core_device	*vdev;
>diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>index 742477546b15..8b222f71bbab 100644
>--- a/drivers/vfio/vfio_main.c
>+++ b/drivers/vfio/vfio_main.c
>@@ -1436,7 +1436,7 @@ const struct file_operations vfio_device_fops = {
> #endif
> };
>
>-static struct vfio_device *vfio_device_from_file(struct file *file)
>+struct vfio_device *vfio_device_from_file(struct file *file)
> {
> 	struct vfio_device_file *df = file->private_data;
>
>@@ -1444,6 +1444,7 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
> 		return NULL;
> 	return df->device;
> }
>+EXPORT_SYMBOL_GPL(vfio_device_from_file);
>
> /**
>  * vfio_file_is_valid - True if the file is valid vfio file
>diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
>index e2412b455e61..876aaf81dd92 100644
>--- a/include/linux/kho/abi/vfio_pci.h
>+++ b/include/linux/kho/abi/vfio_pci.h
>@@ -9,6 +9,9 @@
> #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
> #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>
>+#include <linux/compiler.h>
>+#include <linux/types.h>
>+
> /**
>  * DOC: VFIO PCI Live Update ABI
>  *
>@@ -25,4 +28,16 @@
>
> #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>
>+/**
>+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
>+ * device.
>+ *
>+ * @domain: The device's PCI domain number (segment).
>+ * @bdf: The device's PCI bus, device, and function number.
>+ */
>+struct vfio_pci_core_device_ser {
>+	u32 domain;
>+	u16 bdf;
>+} __packed;
>+
> #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
>diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>index e90859956514..e9d3ddb715c5 100644
>--- a/include/linux/vfio.h
>+++ b/include/linux/vfio.h
>@@ -81,6 +81,8 @@ struct vfio_device {
> #endif
> };
>
>+struct vfio_device *vfio_device_from_file(struct file *file);
>+
> /**
>  * struct vfio_device_ops - VFIO bus driver device callbacks
>  *
>-- 
>2.53.0.983.g0bb29b3bc5-goog
>

