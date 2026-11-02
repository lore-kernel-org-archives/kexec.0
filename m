Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262260A7F00
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HhYIcby3;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mqj0uaLG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z+ppaxYmKgFAGGAkOJ55j6j/Hm1uYafLIHrUuvA3BIk=; b=HhYIcby3VEQyjzikMm6FVS1Uwl
	UpSd7bJ+7znAUzVQpGUeEkFQ4GB72YnG40YKKcLOzpHCVkotbTen9QzU1Lj69C5QdzPeJda8jvmUz
	IhoJHmXgYLtipMufkKoSai4ADxFzUhjjw1+Qt4j+P0gOCUn0J5i+3GEBBA0mYjbia+jtSxazmjyA1
	NjWmP/RZACp+lmMuerZJ3Q1hIgQ0KSWzpjwEzhY5ZJaHICugf8r5P9hu/GsI3pNMi/A6k0Ddbg6E/
	4df099uyTYOiVsqPQ/ffcsmZcGj/rxkOpb1jIH1dGiJww00soX4GNgEgWuzhbLYLD5q1PLTKKEPuR
	DOn1Ag0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu60-0000000H9h3-1w14;
	Mon, 02 Nov 2026 15:37:16 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5v-0000000H9X1-2Oix
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:13 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e869e00005so49835125ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633830; x=1794238630; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+ppaxYmKgFAGGAkOJ55j6j/Hm1uYafLIHrUuvA3BIk=;
        b=Mqj0uaLGZYgB4UVHYhC9cgfsC8Yl1yLnMhL3pYN6lPVr8JzRqq6CQYViRwKtogqtS2
         gDPkMhuMYLF0lnznqy/mdatMY2M4x74rn7nMgOUPTehj3lMTvDzMOoAbPEvs0oEsSu47
         vuEWy/Vzl/lxKsJPR9jbXoDDWU3R0Azanugep6tLrHI8N8I4JxBPRCSVzAx6AuUgLRBW
         8zG4aoeTr39ePgNQC3BEalNRsZ7U01aWqPtIx+WLT/i5ymzGgsLTnkDepQL0Hk2TNeM6
         Vn2BbkLDu8uNyyYcproCZvDcCg39taOg+9RPQybRnJ6mltg5C0MDt6yrrKcQ2BT9dhXG
         wlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633830; x=1794238630;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+ppaxYmKgFAGGAkOJ55j6j/Hm1uYafLIHrUuvA3BIk=;
        b=a+lXgE7UKWobAENOytws1HvnCdjzJjmYzo7fhP7W9X62a9W+C7gUkTwubuEbIeLn+g
         abSe1LafyovHWfBtirZUC4IOAONINSFTklUoyyAm+f/LfAHNcWUVLZxGYsY7maYJOFvI
         uyz3dgBjvdjvZd6Ywv1dx84igRHXVIPBjkLhMRFCWAQ4cvFBVuHPJZHbmjQp1fY79m2S
         Re/3RUtxKF7w8b2ri5nPakndiXoTt0zmQB50Srligr31PRGc2xEJjJDnye8/PheMmDyh
         KTX2a9MYTolrGOUu1seVjGgtSTpOAB7wb4JFocMC5iK6muIzpAS7KIpNP1v5cQp2ui3s
         hN8A==
X-Gm-Message-State: APuU4Z9mJ2cUr8VVJsaLE61FmrXkBZRCvLlneeGF5v0c5V5K4DKqoSd7
	miTqTBBkVFBb6dZJkW0AGBjrGBJXpIGUQYf8rHM91seJuITrlMzDYSKfghlCzujJEtzfJrImk5N
	bL+SEi+yyVpQRDPlrkJp8pAq/fPD6draAXjq+RC6nNc8PDIsI927wR6RvUAHe3xIXlgh0iBCVbq
	saSYlJ/q+8CtrGJqnT+E3gTHxHzIijeEUKTrpawhTDhPX5Fg==
X-Received: from pgca18-n1.prod.google.com ([2002:a05:6a02:6392:10b0:cd8:b247:58f0])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134c:b0:3ab:9c73:12f
 with SMTP id 98e67ed59e1d1-3ae897ee533mr8958349a91.24.1793633829608; Mon, 02
 Nov 2026 07:37:09 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:38 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-10-vipinsh@google.com>
Subject: [PATCH v6 09/27] vfio: Refactor vfio_device_fops_cdev_open()
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
X-CRM114-CacheID: sfid-20261102_073711_629653_7FB1A67F 
X-CRM114-Status: GOOD (  14.19  )
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

Refactor vfio_device_fops_cdev_open() to use a static helper
vfio_device_cdev_open(). This helper will be used in subsequent
patches to support opening the device file during Live Update restore.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 23b229468151..d83e99137e1a 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -20,14 +20,8 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
 	int ret;
 
@@ -46,14 +40,14 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 		goto err_put_registration;
 	}
 
-	filep->private_data = df;
+	file->private_data = df;
 
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
 	 * to the same address space, allowing us to unmap all vmas
 	 * associated to this device using unmap_mapping_range().
 	 */
-	filep->f_mapping = device->inode->i_mapping;
+	file->f_mapping = device->inode->i_mapping;
 
 	return 0;
 
@@ -62,6 +56,18 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	return ret;
 }
 
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return vfio_device_cdev_open(device, file);
+}
+
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-- 
2.56.0.317.g454f8302e1-goog


