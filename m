Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F050CC43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i8x4rQZI3wGrMps1gx7J+LUAbzJ5YVpPGmgWVMyrcn0=; b=QpmzIgw2VmOmBwWSakQ9EBI1l0
	T+rJR25MeROsuOxfSoLiYhKrDLD5YR5Q+if5LcsXknMCNVvkN5PvMQzP7jC2FIyXEiu4zMHyYATLS
	6oHo8GZUUKHeh8ngIDEsa7fqO8M2j7p9jETNzFwqSWfVguE2lU39G18Miativ1F5Fc4MYo6zAr7xa
	YVKD6kye8OaSvUSQVVsOqW3aar7YfeHbPaULxpuAjtlC7Qq16OF3yiAMyn0mgVjxPeNsK+bofssUC
	rTf6h0kFizYYQCFSX9pYtdL6X88oQ79RreeBs3cfenQLnwE64aOSBcuEcEQLR4m9vDDCFhMT/0cFa
	A+9NVNBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLch-00000005BmE-04dP;
	Thu, 02 Jul 2026 17:54:51 +0000
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com ([34.218.115.239])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLcb-00000005BlU-3yCf
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014885; x=1814550885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i8x4rQZI3wGrMps1gx7J+LUAbzJ5YVpPGmgWVMyrcn0=;
  b=JXJMV4zuudWyIXjpk4IOdenaGfmuUgFd1EjkwUB0woy2IVHEgAK3C9bR
   Cjllfzva0pNLhr56kPCATlpJqksYyq3Ks46VyTkrv9Mx7SZhEoAbTHC4Y
   zevZB1MnEwlZZvD8Z3gfhaGI+KOGqEhrWt4sMZf96IxZjcnDd/b25bsD4
   eGxQ5HgCQDCqTxwVTGj95l2PdlkKy4g9rFmm7cgZW6XFi4D4oQ0EeOhEn
   FSv5O6zWAJ7QyjTtiV5p5CrIlrnUwuNKr2HNjrM0wTwXTn0MyKwGk13be
   dQbXGTD/EHnbOxgzXbbRD5QYs+xy/naoNNmqTzy6E/obeSULYJdRiKXpq
   A==;
X-CSE-ConnectionGUID: sfChYbsLR7+K9S+0iXxigw==
X-CSE-MsgGUID: eL0Sbib7Rj2GDrU/NWV6oA==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22744903"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:54:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15888]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.93:2525] with esmtp (Farcaster)
 id 1c94e942-37ba-4e7a-870c-87f2133b068d; Thu, 2 Jul 2026 17:54:39 +0000 (UTC)
X-Farcaster-Flow-ID: 1c94e942-37ba-4e7a-870c-87f2133b068d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:54:39 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:54:36 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo
	<tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, "David
 Matlack" <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 11/14] vfio: opt vfio-dev and VFIO group devices into sysfs_lazy
Date: Thu, 2 Jul 2026 19:51:11 +0200
Message-ID: <20260702175114.24659-7-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702175114.24659-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
 <20260702175114.24659-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_105446_035652_BE977216 
X-CRM114-Status: GOOD (  12.93  )
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

Call device_set_sysfs_lazy() on vfio_device->device (vfio-dev/) and
on the VFIO group's struct device (vfio/<group>/) before device_add().
With opt-in, vfio-dev directories materialise their attribute_groups
(vfio_dev_groups + drvdata->ops->dev_groups) on first access via the
sysfs lookup path instead of eagerly at device_add(). The VFIO
group device's flat attrs follow the same deferral.

Removes the eager creation cost on platforms with thousands of VFs
assigned to VFIO containers. No userspace ABI change.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: linux-api@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/vfio/group.c     | 5 +++++
 drivers/vfio/vfio_main.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df3..aa7e0033b96e8 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -533,6 +533,11 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
 	group->dev.devt = MKDEV(MAJOR(vfio.group_devt), minor);
 	group->dev.class = &vfio_class;
 	group->dev.release = vfio_group_release;
+	/* Defer per-device attrs to first kernfs access; userspace reads via ioctl. */
+	if (device_set_sysfs_lazy(&group->dev)) {
+		put_device(&group->dev);
+		return ERR_PTR(-ENOMEM);
+	}
 	cdev_init(&group->cdev, &vfio_group_fops);
 	group->cdev.owner = THIS_MODULE;
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6222376ab6ab5..ab90279c44bd0 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -306,6 +306,11 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 			goto out_uninit;
 	}
 
+	/* Allocated before device_initialize() so out_uninit unwind frees it. */
+	ret = device_set_sysfs_lazy(&device->device);
+	if (ret)
+		goto out_uninit;
+
 	device_initialize(&device->device);
 	device->device.release = vfio_device_release;
 	device->device.class = &vfio_device_class;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


