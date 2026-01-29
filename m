Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A83FD73E8D
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uE4aM7+RnwFNy7PeqMvvBM9KOovOI9GoqBkQFV8UcGE=; b=0sio5AW2hbHWWtmTlYCTqnnDPj
	NinLyWWkSfc11aqX2nhLBX5aDXXmo1hh44KQ/cjZ8nzcEWgS4Y2AVBkE8ipUeChjP9kZX2UWNUS1L
	9bLbds9ULuH+tJuiP66ECYIMBDGVfoH2aH7cPRHrl1M50GNVk3kFtgKGZOFmxzfsI9p01eWM6nXZ4
	PTRGUbpMO9dpuROxGYgHBARqfQPf5hqoAl0Kv2BVtCp/gYq+WX95K+eyCYdtxnJR/bzwj4z/0g6D2
	5ulakI2oTyNQwi77wu0LsuzdiNodPPqymueyQZtWrfbk1Ao3m92qcf9E07nT5gilIOqjzWxmqcsdE
	5Zw6Mong==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZX2-00000000foC-0lo3;
	Thu, 29 Jan 2026 21:26:28 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWp-00000000fYm-2jU6
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:26:18 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso3265139a91.1
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721972; x=1770326772; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uE4aM7+RnwFNy7PeqMvvBM9KOovOI9GoqBkQFV8UcGE=;
        b=4ZsFOO00mSSC0r1axFgPD0PMD3d3piWv5Drib5o2Z8bfYJht3aQO/djtbVRrrxgUX+
         EIyCi9zPkZasvmm1LWysjCpJp70NAVc062VthOqPRMwi2ffIn0KWAe7q4fgjoUlhaKXu
         ka5hf8HLsh3xmUzKfh0oPiigvqsK/elJYF6KRyMLAJebDsNbrUzMFM5n15E3JyaAq3za
         FygruOjetoTK07PjIWhVyFSW+5nBRteotUsS1u70bbyQ09ywT4Sx9moLk+gl3d/1Q1bN
         3eM3nmajR4mysv6TD7B2Z90VwzbHxopwEwXrfuz8cKSAzQPsd7pR7KjJsXOjsAfIQY0B
         Dz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721972; x=1770326772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uE4aM7+RnwFNy7PeqMvvBM9KOovOI9GoqBkQFV8UcGE=;
        b=f5jNqYpDXRIrcJqxKT1DuCztukvgO9fQIa2nQEUHjtukclCwjAXdmRkOH6JuhXlMfb
         MKTRGIwteSqUNvVL8P8pNEPRb0jEOHBgDAvkXrTnlkz/jL5qDme7qpcTEcYXzm7YpT1L
         Eu7xqFU7UOCmp6pvKsw7Rw3tyWi03Cqmn+3JCrBtfIZCUOS8kqbs+dV46ZzTmnan788z
         ZwJiLIhLe3tMvXTYlEmQ1qAR+H3kXhzD2OI0nWBr65RVK1gNPaxt5QmEwkmpxtMGftCs
         vpvIWBVaXgzgu+q2Ra9a+f/WkVYv5usgvU8I98z7SlKsSG4LWRndQ9+AiXm/jL87OpkV
         xHvg==
X-Forwarded-Encrypted: i=1; AJvYcCXjlTynn/ArtOHhpBNcVRAAs7+UAPXqMiUKMenxy/0AStoKG9pO1xfxiCTpdyM+7ScBjgbSZA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBepw23iHYU0Oe7JGbAwnUt6PFTOxGsscgedvzfMubsae8CYt6
	4L8hpi6ZMO6AcFwuzCT7FW9Zu8cE/LLTK4l8UTe0Zcu85CQlrHp/ajReDubTq0a4BNS0tM+RqrT
	N2FeavgaBZLsDJA==
X-Received: from pjbok5.prod.google.com ([2002:a17:90b:1d45:b0:34e:795d:fe31])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:388c:b0:34a:8c77:d386 with SMTP id 98e67ed59e1d1-3543b2fbdccmr728738a91.9.1769721972187;
 Thu, 29 Jan 2026 13:26:12 -0800 (PST)
Date: Thu, 29 Jan 2026 21:25:08 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-22-dmatlack@google.com>
Subject: [PATCH v2 21/22] vfio: selftests: Verify that opening VFIO device
 fails during Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132615_885051_15B9A855 
X-CRM114-Status: GOOD (  12.89  )
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

Verify that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was
preserved across a Live Update. When a device file is preserve across a
Live Update, the file must be retrieved from /dev/liveupdate, not from
VFIO directly.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 15b3e3af91d1..65c48196e44e 100644
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
+		vfio_pci_group_setup(device);
+		vfio_pci_iommu_setup(device);
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
2.53.0.rc1.225.gd81095ad13-goog


