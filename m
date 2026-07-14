Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE5AC44501
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tEd+0Hxb+fZMWIajq41a/8wnr7549OLbqTKKS2EBeVQ=; b=mtqdl/cynLm3ojdqjpC/Lv9uFX
	Y62iEAAEunEvw9JHRzmMgzX0aj6tJuacwwd4lW0SJyLnFOjL7uW9BQv/O3rGsufgzvyO7rjpqsvOT
	hePgPOWGnTtrLDqfOc73MHYw9jGJPazdqaQCf7EyP0DdobDW68tomO4drRFD/zDZQXey+R7mZ6WUQ
	9iaT4czWy/+Sz8lnqVh1N1zyaCtS+GAcw6lNZtTH6s2eWEFU3477m8LS0/adWx+/GoT0jhGCkgLE4
	33o5jtZbHYZCfDBZWC4vL2chDYRbEB6a5tAz1vVq6qttj/iUXYGjVB3wnCn8flXlkH9ZHzMh1S5yZ
	OV/dPgYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqw-0000000CUCH-45rf;
	Tue, 14 Jul 2026 15:15:22 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjequ-0000000CU8L-0bO2
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:21 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-84a4d8fd6deso1478617b3a.3
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042118; x=1784646918; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEd+0Hxb+fZMWIajq41a/8wnr7549OLbqTKKS2EBeVQ=;
        b=U3rUWTsbWt8FlYQGNHEGv/zPsNnI432JkgjG5XcoWw/Xu18trl3jp2X0n+99onS6CD
         R5QBCpFvazaLM39GOgpKdMcI/TVB1+g6YFX1o1LhJ0eAfkywpVX9gQ9zPfYi1OdpdyGs
         8rG2NmwrM2ybMk+tz8H98MhtmKyknJGdmGVBg0F+1N22mzzXa18SK04PhGSGJVVgAfoj
         HTxhdE2sPE/bYnNesEmLr2z+EO0JHuqwHn61sWrq+Qx4oru9yzeq84827n4NQxbj12/I
         4sIAY2QnaQL1iQuU7ItWjquBC9NkOrQZkHSmLqcwrqw/0QJs3dkTKbj/ChCdTAbEcDPa
         J3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042118; x=1784646918;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEd+0Hxb+fZMWIajq41a/8wnr7549OLbqTKKS2EBeVQ=;
        b=BecwvgRJ3bRd9au+5DBPuFwhhU3JCj/85TsBRgrv6HcfVTKewe5G/niWkKaVtp5gm2
         Q9eCasSSLh3utwmQ1+Q5YnFDPwvBwltG7d3Oe8RmFS4MeRroaGx7iECdll8jgE4gstDM
         ywuXZsZpPpOLRyFWsqWOq9avMKeGHrLHyhZyIjroPMtnT8bD5E7SBfBKMfvu7lUoDbff
         aS1Nd57DBGziJNGLkm094ExQ5AgSmlZumYmH1gJ8+0cPx7mZf6bmzOlapTRzpCKbZ3hQ
         zZSzkqSCypNhr2or//oouZxoGrirJNE4qED6ivQuoQVghbkO1YSETgKkigMPnS+Y6oq+
         33dg==
X-Gm-Message-State: AOJu0Yzs3RV7uVgre8HRUL/LDDoT2ThPiGUIP5ktJjlxXix5TDY3G8xl
	HQWCcJ+dPzRIO0e98FaynRUkoXjNnOyL0XMR5ME+aKT4PRBOnvw6JX6BMJDLO9j0SyQUy8WyRxJ
	KWSnRtSRbHN9aIsJwl8mT19a/HQt5BX4NkJ7ThMopAQ++x6HPnv2kgyh7gyAuSTlRvjFV335qiB
	liX9sncbHnKnNV8BOZ1vXDzBq0pPGHRuM3zmMNhoC+Gdro2Q==
X-Received: from pfblh20.prod.google.com ([2002:a05:6a00:7114:b0:847:86de:a817])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d9e:b0:848:7459:5f62
 with SMTP id d2e1a72fcca58-848897d2bbcmr12462324b3a.44.1784042117867; Tue, 14
 Jul 2026 08:15:17 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:53 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-9-vipinsh@google.com>
Subject: [PATCH v5 08/20] vfio: Refactor vfio_device_fops_cdev_open()
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_081520_216499_7041CA7E 
X-CRM114-Status: GOOD (  13.90  )
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

Refactor vfio_device_fops_cdev_open() to use a static helper
vfio_device_cdev_open(). This helper will be used in subsequent
patches to support opening the device file during Live Update restore.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 54abf312cf04..2231423fe56d 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -16,14 +16,8 @@ void vfio_init_device_cdev(struct vfio_device *device)
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
 
@@ -37,14 +31,14 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
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
 
@@ -53,6 +47,18 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
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
2.55.0.795.g602f6c329a-goog


