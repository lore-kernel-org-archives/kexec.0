Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEACC4450A
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tk/1w3UkNj58XSSYbOe8ncPxmDwQIUvhVdPzzBUFHPI=; b=yFvDYqmkBdU5twsi+KYQJiBJeB
	1VPuh+M9DWsytrpufi5zC+gZnnVyXQpBWA6virfmC8tZItxFwU8ABot23OZd05DGD0JPmtPOotQ9N
	fJwDwXFTU2IP19qByaLdAXSjKzeJ7mjrExkwLOO138mG6LqiB/n03E4oetFHJDnTO8cGt7RmQPPe/
	+O+maHMhrbZXK0SoCni1SP5ozwMYqHCLTt5VuUy3TTZbu6/WnAogsbugO9ZV4zFgUzAyqD/vSUbUm
	sdhggW8WJgvCdDEXYaqHSwdV/hOCEui/benI66LqJfLH461AUuvbcyRBO0ylStgpmQQQFEt8XBC0K
	qIpjcGDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjerB-0000000CUcg-488H;
	Tue, 14 Jul 2026 15:15:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjerA-0000000CUZk-2yht
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tk/1w3UkNj58XSSYbOe8ncPxmDwQIUvhVdPzzBUFHPI=; b=knZ5Y91pQ0dbZwHDx/+M53M3Su
	i05g0lg/iD4+5YY2kLYqiG07aEUAnOv9i4c7FF+VEw4ndE7dtUUhXsBWy5IFTHLzLMnQIH3oooZ+p
	ze2CDg6cp/UJwzBz5QPt+aLiYhxcwo9TyVwGRqPXteAmfa3XjdjfKiKuqbckMritBMjQzafQgkSYJ
	GxMBCcU+rOyellnUIKTQZ468Pt/8FYUkB4UQW4thzRM0NeX2ouuBLUf/L4lF5XK9yFVbAtzzEi+Yb
	PigCuL1vyqR0bDu2ptgWHbJuBF+cM/ia0wCtiuNXSklULwRXy5iaDs43PFU0n+VBabzDcyYF7tWgB
	y0Ki9YnQ==;
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjer6-0000000Cd8E-3jFb
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:35 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8488ac68185so6844323b3a.2
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042130; x=1784646930; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tk/1w3UkNj58XSSYbOe8ncPxmDwQIUvhVdPzzBUFHPI=;
        b=IB4XYnUeSlWLqj9kH0jo6M4E4A0qeylBAIWVDrBYI2X97VkdCJNaZo6nUyeruueqwa
         SG1dZVxS7uzF79018BqPa5ci+BJpkKM5SLmFK0/S2qMce/iGnE8PzZqnMnss8Aangxcj
         lg8gFgIMnSHbPrejym6Cpmf/RUVYieVkfq8SHg6EzfI0Xs0yTdzkyU44ulKeJLnHBi7D
         j/2iSPU/5ptBpl2Kqm+IV0ZvPBva6RGaXCiuIlSvnUsb+R3jHbBbXKO5wiWQJcN6SMZc
         ZY/KyDlmlJEOe6yPndUqvQddEExPL5AsRCAiduttP2VjNj7TYOQ82PO7FKUvZoVeINaf
         /bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042130; x=1784646930;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tk/1w3UkNj58XSSYbOe8ncPxmDwQIUvhVdPzzBUFHPI=;
        b=DDUtJbtabF45kUrjZ5NIEcnaFzIDHL5ejtRt5OpU0YwY+V2r/Iz/nCZTpi55HOaEIG
         49glJ5lzi8ubovuat5rdfYbC5AlbUaq2sAjDRx+9xJ0H15xDR543n7PH+bf/C8Impbbg
         LQY4Dz3XIJOUHTLaaVfIIVmYu+4mAE3QCTB5EAvpvfoHafKOuG9Wo+tahivtanHNHkTc
         7HWPvU4qCmj7P9r+EZ4pI4v+mSjfqdRc0wSprZLviZGHHIp37SdFRlsLcX54fHK6FcM4
         Z6z+D+h5sLUztgZel3jadU7301VP21WQ83HA0W7H/biiG+Nek+k6hJRayZW9QTgv85zO
         ymTg==
X-Gm-Message-State: AOJu0YzYIGyg8jTyuW4Qyg821qhZLJDyeBsFPC8p51ZCaHjDjIN9VZwG
	f4x+tXuzffpiRHf7UxPn5sdXgDKKXsLvQUqp9iMclGIULm7/xmHRS8ttrgEmOQEGqLbgNguhiy0
	WeJf2DD6f0Rjf+MwRjjD4dOXkFOIQhFGKjufeEPp2bxuoYvfhFUKp/NZFP0ff7D7em5jh+/2w//
	PpEyuDoWpA8gfnlrfm078C8oGQzEXP4MZ49zrPGesk4Dl8UQ==
X-Received: from pfet14.prod.google.com ([2002:aa7:938e:0:b0:84a:1163:2ad0])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c88:b0:847:83bd:6676
 with SMTP id d2e1a72fcca58-8488963aa37mr12799379b3a.17.1784042129679; Tue, 14
 Jul 2026 08:15:29 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:04 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-20-vipinsh@google.com>
Subject: [PATCH v5 19/20] vfio: selftests: Verify that opening VFIO device
 fails during Live Update
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
X-CRM114-CacheID: sfid-20260714_161533_080743_D6FACC7D 
X-CRM114-Status: GOOD (  11.71  )
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

From: David Matlack <dmatlack@google.com>

Verify that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was
preserved across a Live Update. When a device file is preserved across a
Live Update, the file must be retrieved from /dev/liveupdate, not from
VFIO directly.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 15b3e3af91d1..ec3fe8f19502 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -36,6 +36,42 @@ static void before_kexec(int luo_fd)
 	daemonize_and_wait();
 }
 
+static void check_open_vfio_device_fails(void)
+{
+	const char *cdev_path = vfio_pci_get_cdev_path(device_bdf);
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int ret, i;
+
+	printf("Checking open(%s) fails\n", cdev_path);
+	ret = open(cdev_path, O_RDWR);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EBUSY);
+	free((void *)cdev_path);
+
+	for (i = 0; i < nr_iommu_modes; i++) {
+		if (!iommu_modes[i].container_path)
+			continue;
+
+		iommu = iommu_init(iommu_modes[i].name);
+
+		device = vfio_pci_device_alloc(device_bdf, iommu);
+		vfio_pci_group_setup(device, device_bdf);
+		vfio_container_set_iommu(device);
+
+		printf("Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, \"%s\") fails (%s)\n",
+		       device_bdf, iommu_modes[i].name);
+
+		ret = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, device->bdf);
+		VFIO_ASSERT_EQ(ret, -1);
+		VFIO_ASSERT_EQ(errno, EBUSY);
+
+		close(device->group_fd);
+		free(device);
+		iommu_cleanup(iommu);
+	}
+}
+
 static void after_kexec(int luo_fd, int state_session_fd)
 {
 	struct vfio_pci_device *device;
@@ -44,6 +80,8 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	int device_fd;
 	int stage;
 
+	check_open_vfio_device_fails();
+
 	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
 	VFIO_ASSERT_EQ(stage, 2);
 
-- 
2.55.0.795.g602f6c329a-goog


