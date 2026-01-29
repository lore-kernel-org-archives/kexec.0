Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13AAD73E8D
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVUDzL5NEoLRiR0kq4rtjTLHEzT2c4a+QSQgWmkEpoo=; b=rngDOO1OXTKYpcheIR5vi+PAbv
	mjDn5J/9UoAXuejyvCGVjPJinwGAe1W8gKZlcWJEIl8txr53uTZqjE6pFJSqGEfofLou4sWBFtnuV
	SxlwCcjiw18MGHAMDqk9kPijOjW329dyTzFhz25bAEIkCP1y0JafOq8LF0mw/VP3ZxulaV8K9gNNm
	4XQZXzHvzHHgBa+vA6FceMDSrY1x7597exNI6YQndG9D5HbcKGKW18p19OrAg7rwlds6aDnRgSTnG
	N1KKjd4JWIrHeg7YbYjUXtkJKyOUIZDuyj7mC4fuCkas3LEhDQKRlmkDaoHBOhii8UPPczuLKQl+t
	X4LK5FAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWb-00000000fNs-3uXN;
	Thu, 29 Jan 2026 21:26:01 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWR-00000000fGm-2o2T
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:57 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2a8c54bbe46so18764905ad.2
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721950; x=1770326750; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVUDzL5NEoLRiR0kq4rtjTLHEzT2c4a+QSQgWmkEpoo=;
        b=WiEjQ3BZ1XeKa4DLxg6SNrDVg1fxG5MzRlaqHi3dM5fac5QNSEhwv2lxKWjY/u4NHo
         opVqo85H1v76lMlKNu+2T4oWKMUs2zlUg7kzZegu5JftdACaP0M3sDtMQcKxuBP4EMTH
         0cpv807q31WVo5WPHZX9meTMZ+rJL5CVF2NXf+TLeQSuKc9GqNxIOa5VUxb8b+KXDDNZ
         djh9HV8T2RV9kQJoUV9sybpgyUdaRjpbVOEkPzRLX0ahYRgoAhog98Zpkao4jCRatIcT
         gioORqNPtzU738b3Vsj/bZ+0jk7J76D0Hod8ERAE21Kl9tuRliDFtQLfTAMUMWhiW+b5
         PJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721950; x=1770326750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVUDzL5NEoLRiR0kq4rtjTLHEzT2c4a+QSQgWmkEpoo=;
        b=weqn218e3Md+/tzL9uCN8ZLQTS3P9erJZWIwVqkOpukKGQ1mwXGH1QwAWMWMbauAIH
         jlA04ynh8uYJwmRdN4wgU/eACAbee1PU3NUdpj2x/IrIUJCqzHbjkUIsDHJZFg/xnqU0
         WoBUJkMaTH7XTF1Jw20Mm6zs61Ct1bbCJLO471AOdEwzmRmKCwFQD2R2R/KZ9HKZMaJz
         xzxJbHlYzrTo8NYnelPRwai4yLdRAA3u1OJKzdh4lyUxr6ArPObhdt7JtYOLQdg70cAw
         qs0kjFgKeDq3CvOieMuDa9E6exDjW0yW/YKxgEGLDJPKw7sj7373n6LXUwpZzZof18y9
         nWdA==
X-Forwarded-Encrypted: i=1; AJvYcCUdHtiq4Yjd8YXKryglINcmqk4hjGQZorDeP+TO4dvU/MDA/jZI7J9TFR6biObH6GIp0TWmXw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRZpI/PfrymEkJoPzGOcFPvZpMxMEz0tuKNSkcbSLOO6RyaAQN
	eaRxO74/8YlbBJZODki+h65aLZPbMWX1YA31FtG6zdczmkgEQarxWkVGXts6FVCmiCoXelRsP9K
	kdL/A9TjNVHmh3A==
X-Received: from pllm10.prod.google.com ([2002:a17:902:768a:b0:2a0:a0e0:a9c3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:124c:b0:2a1:3ade:c351 with SMTP id d9443c01a7336-2a8d959a4bamr5657375ad.2.1769721949051;
 Thu, 29 Jan 2026 13:25:49 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:54 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-8-dmatlack@google.com>
Subject: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
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
X-CRM114-CacheID: sfid-20260129_132551_710366_6B135156 
X-CRM114-Status: GOOD (  16.81  )
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

Notify the PCI subsystem about devices vfio-pci is preserving across
Live Update by registering the vfio-pci liveupdate file handler with the
PCI subsystem's FLB handler.

Notably this will ensure that devices preserved through vfio-pci will
have their PCI bus numbers preserved across Live Update, allowing VFIO
to use BDF as a key to identify the device across the Live Update and
(in the future) allow the device to continue DMA operations across
the Live Update.

This also enables VFIO to detect that a device was preserved before
userspace first retrieves the file from it, which will be used in
subsequent commits.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 7f4117181fd0..ad915352303f 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -53,6 +53,8 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	if (IS_ERR(ser))
 		return PTR_ERR(ser);
 
+	pci_liveupdate_outgoing_preserve(pdev);
+
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
 
@@ -62,6 +64,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 }
 
@@ -171,6 +176,9 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_incoming_finish(to_pci_dev(device->dev));
 	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
@@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
 
 int __init vfio_pci_liveupdate_init(void)
 {
+	int ret;
+
 	if (!liveupdate_enabled())
 		return 0;
 
-	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	if (ret)
+		return ret;
+
+	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+	return ret;
 }
 
 void vfio_pci_liveupdate_cleanup(void)
@@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
 	if (!liveupdate_enabled())
 		return;
 
+	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));
 	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
 }
-- 
2.53.0.rc1.225.gd81095ad13-goog


