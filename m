Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12003F532C0
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UG6U+6kAmFzvMZjga5OgV1LR5RVhGZN2WyiuuoZC9eg=; b=dNMp1rzwWLxQXGFld0jxtOC9BD
	bPqOz3nKeTwB9mrYexpWYpIeTkYVBFAuttXL7HKnpySiTFqVUExUrBb0vdHUdhCg/1o7ZSNC29h9U
	YpNcNABMgcrJYjGi5NJnbKRA3wuGddsN1cT4lkEXB9CaSsjGzvpCmlxIw4ohTgmsUxFIHn63LhKHM
	leGnD5YXEo3rtuIj/dLhPP5numvl84tvCwKuhtnz0y6Oyk6tNwchLTmf7q72TdZ8NqG0Z/JKJ807d
	J2L5zNP2GZtfvWIGPG0SDunmSg5QJ1iJYnegSKMIBFYw+mGK48FkCoozyWKt9GFqOOY31xqOs3Umz
	hCA3TZEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAj-00000000BZZ-0sq1;
	Mon, 23 Mar 2026 23:59:01 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAe-00000000BSx-2KJ8
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:59 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b06395b8deso10425145ad.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310335; x=1774915135; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UG6U+6kAmFzvMZjga5OgV1LR5RVhGZN2WyiuuoZC9eg=;
        b=ansvFkpuIJDh+t7fcV3+b6pNJqIWJ9bqEJjaNmgdHqePR8Tr6/8cWcXisimcKf5dw/
         l8WcpJJ93AtEGuy1p3xuMLNuJMRLaen2NCyiSeiTDLe8zKdeMd12Zfa/99HX1HHCjdFh
         FHqw7phBV8+B7LJPjA3dkjPAd5DjgLlE2CYrjWkkbbvGJNYQitGPTZFVoTwMoOf4uJnq
         m0+sJvV43KrU4tSg9vur9mfih64q7ALQou9BleAAyUjVGwWJXBsPddhaZl/27hB0wY17
         ADQm1mXeVGuXcZNkGxDlzomr2GD1E/mR2aW+VdQu3K7MGROqAKp48uHsmjbNPwYXMuqn
         zZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310335; x=1774915135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UG6U+6kAmFzvMZjga5OgV1LR5RVhGZN2WyiuuoZC9eg=;
        b=CBba+0siZjrsM05n1g7cNja1+QSxtQ58iLwxCpyt7vp6re0a0AAB18cV4GoKuj71f0
         AIGqw+RCbdQXEBDbHEBdfg08ANl0/IOmXRFeOcdVe66H9/o8/EwC0tDiFSKLojORJ/O1
         tyvbnnSC5mlv8Zmtff23EOCWGj46xABUgmXjRONswzdmPv6etdYz2C8UnblM3Ka5rTPh
         hN1oiIF0MAn2NFZV/MNQFafvgZjGdjAOIK1GsmpWU/qYoNxI2LNN2gvnVFny9Kov/ncq
         2b87/3ZufID0s7I7sCk3dy7F2Su7pH7PhUOilHT/9TqloB7Xn9dKwQXVnBCzQe28zJlN
         5ajw==
X-Forwarded-Encrypted: i=1; AJvYcCUhP6QBJNSGvKf4xm9u20eQKu2A2FsFPNyFRs7J1wqzSPqOSfpiizic8hE/7KlefRC0dMh4OA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxV0JOkemm2Qcn1C19pqop9Hqm6vPmQKaPfpwNRCAJFlRomQ28N
	7vvbqpR6ky507852qiutVGOavA+uAo87jWDkPEyB7Q3Hiq172IOlXAUJRZAmUxNM6i7Dt03T1MA
	ZLpO8+gBD83BSFw==
X-Received: from pgcp23.prod.google.com ([2002:a63:7417:0:b0:c74:1130:c2ea])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:5493:b0:39b:f026:6f7c with SMTP id adf61e73a8af0-39bf0267ba0mr8201078637.49.1774310334903;
 Mon, 23 Mar 2026 16:58:54 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:02 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-11-dmatlack@google.com>
Subject: [PATCH v3 10/24] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_165856_666731_7BD8DA36 
X-CRM114-Status: GOOD (  17.61  )
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

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c             |  4 ++++
 drivers/vfio/group.c                   |  9 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c |  6 ++++++
 drivers/vfio/vfio.h                    | 18 ++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index edf322315a41..6844684a3d8e 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -91,6 +91,10 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
+	/* Device file must be retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD */
+	if (vfio_liveupdate_incoming_is_preserved(device))
+		return -EBUSY;
+
 	return vfio_device_cdev_open(device, &file);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..0fa9761b13d3 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -311,6 +311,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
+	/*
+	 * This device was preserved across a Live Update. Accessing it via
+	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
+	 */
+	if (vfio_liveupdate_incoming_is_preserved(device)) {
+		vfio_device_put_registration(device);
+		return -EBUSY;
+	}
+
 	fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
 	if (fd < 0)
 		vfio_device_put_registration(device);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index b960ec3ffbf2..6f760ace7065 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -47,6 +47,12 @@
  *   ...
  *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
+ * .. note::
+ *    After kexec, if a device was preserved by the previous kernel, attempting
+ *    to open a new file for the device via its character device
+ *    (``/dev/vfio/devices/X``) or via ``VFIO_GROUP_GET_DEVICE_FD`` will fail
+ *    with ``-EBUSY``.
+ *
  * Restrictions
  * ============
  *
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..8fcc98cf9577 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
+#include <linux/pci.h>
 
 struct iommufd_ctx;
 struct iommu_group;
@@ -462,4 +463,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
 static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+#ifdef CONFIG_PCI_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return to_pci_dev(d)->liveupdate_incoming;
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif /* CONFIG_PCI_LIVEUPDATE */
+
 #endif
-- 
2.53.0.983.g0bb29b3bc5-goog


