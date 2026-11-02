Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2860EA5E0
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lORS2kK4;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i8VK4ZGs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=; b=lORS2kK4Qb1z5JAe+kSwcnMUFT
	H5uW4OJt5TXq29gVXR4ackr0KoAyQH2pX9lvS0Wq4WNTnmKQifRVp+EY8vZDqKL2ixhhod0QTEVwv
	J6cbW2RhPaGaiBttJrt5tP1SBlb7oy+E0N53rOI0Ud8y2mQl3vl5Ocu6m7bwRIQK4Nm9CNEhKx8hv
	2lW73NbwOaa90NhWE928bpbXf/Xd8s/y3RBQELzx9APRgppQkgbp68jBapU8eSqdn528E6X6CIjOQ
	yTs198hsQuoHAzXCep/+GHGrMJrrF8L28suwsPhH640GGbfhN+U+U5qKt8CEniNXAdaCyaBJT+aTD
	QGspjcQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu64-0000000H9o3-1BjS;
	Mon, 02 Nov 2026 15:37:20 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5z-0000000H9cK-01Bp
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:18 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so3414253a12.0
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633833; x=1794238633; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
        b=i8VK4ZGsJ4vGLlCnRUnAoOXyuh/hQVgsuY6YVxq/Rve2h1rxi79W4qL8a/MO7cI4LJ
         q1zp1YMB7Z0JYXtvTYfG2qW0f4hSp4HSXVEmEmaNMeQRc36fS4p7JT5GxZYFOeOf7Zb4
         byVGt8p+gym4YXkEvLHXWYWkgksb0btKkUYD/YQ0scI80a4hV+6PCRK50wYgA5rShytv
         jf8FqsRlhiwQ1mr2c8OlA8vwOXWV9OeXrugijCjtN0FAc76pc+BhZ2PH7Lzf/vmezI5X
         Md3oFirGKk2ce/SeUHcWa0YDdeW4/4Fvxjoj9IfCXEG3I71eKvjvu9G+y2s2HegJEJeI
         Kdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633833; x=1794238633;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
        b=yP94rs4icvwuOHYhwGcca2vW/V2RY7qzTEpOAXpAMy/f+NdrBhEOBuzso1f0b5Px3Q
         FspwpR7blP6M7bt9cBL7uso5cC/PrXCXnJvY3VjB34yGZ28zG10srN/1z7mM8I+/OWnS
         yknJIHnz6MSvzgF4zNyIsKS7M+1YMZZvuGRbbLNDZGfH3UuIz6dyoZfLuUGdl9B49T8o
         FwO8OamMIka2kbfnuSZriH074xP0++uuOn/VbCuLWHv2o0eWy/1JtSwo0KnP+46/L7Q8
         8q/2u5VEaVlQgryobVwAjVwW0BmLZ3p2RqwMfLKOGIrk+xc+LO9/6Rm6+41P4hAz0Ow6
         Afuw==
X-Gm-Message-State: APuU4Z9QEAXaf/uuRpFP6wn4hh8vuEi1jr6XaFMy3WwC4chplcPd8Dyu
	MrHK+FZvsI+rQHyxa9VRd8Pc0mXHE1J31nvN+HvaVyst4GEDofAaeJ7EDp+lX6181jQUxB3zMi1
	b3+a7lf6zqK8qm8ozXZp3NxaUxyspZ/gvwGnnYkJFLoHCoVZT/aDGI5TPDjbJGiQMPEMW0xtjTI
	e8HbvUG5iY9frRsIrtW/KTADeqek6tOyThRUj7QdePCg/yUA==
X-Received: from plhb8.prod.google.com ([2002:a17:903:2288:b0:2e9:84f0:65ba])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b47:b0:3ac:9f00:3bc7
 with SMTP id 98e67ed59e1d1-3ae8980dccamr9246672a91.33.1793633832641; Mon, 02
 Nov 2026 07:37:12 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:41 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-13-vipinsh@google.com>
Subject: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_073715_126030_1775E109 
X-CRM114-Status: GOOD (  16.85  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Matlack <dmatlack@google.com>

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c             |  8 ++++++++
 drivers/vfio/group.c                   |  9 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c |  6 ++++++
 drivers/vfio/vfio.h                    | 18 ++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 38e691eceab5..f0018eae3c4d 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -58,6 +58,14 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep
 		}
 
 		*filep = file;
+	} else if (vfio_liveupdate_incoming_is_preserved(device)) {
+		/*
+		 * Since it is live update preserved device, it must be
+		 * retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD instead of
+		 * opening /dev/vfio/devices/vfioX.
+		 */
+		ret = -EBUSY;
+		goto err_free_device_file;
 	}
 
 	file->private_data = df;
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..62b4eaabc829 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -316,6 +316,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
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
index f13c757b4567..64810010f983 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -43,6 +43,12 @@
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
index 12557d45dfee..e6ca4c3fda06 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
+#include <linux/pci.h>
 
 struct iommufd_ctx;
 struct iommu_group;
@@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
 static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return pci_liveupdate_is_incoming(to_pci_dev(d));
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
+
 #endif
-- 
2.56.0.317.g454f8302e1-goog


