Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AB4C982E1
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9IxdwpsNG1RvdTFOh7VCNlg1Z6K9O4n/2FHxAEnlFE=; b=04lYIgvdPHCffqdG68nAQGBNq/
	lnlx6690SpC07/JuVmygtPGO1fn6doiTHHSAyEsarK5BzyG1SPHziJJzTPg9bBsYtfI38InkSL64G
	+Qasw+fsSA8rzcTeB2qX0mf/BFFwEiis/yIYtndwQFSmUaL/FwNww12y/D5YRz9qxWwZEkOh682QH
	HpzE7ih9R8KdRXBQW3gj9Jd1fsSt39JAsYr8CUZcsx8vAVB7O9Oml3IGrLeJyX1MnfQW7kgLHANRt
	xJUi56Cv/f1Up7HCEBp4sd8eq6JZfln75kHhKSBrA+hIY269PCsNRCZ5GDI4pxYVAND8zL1qqs0i9
	6eH2RcOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erb-0000000FTbI-1DYz;
	Fri, 18 Sep 2026 20:07:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erW-0000000FTSj-0YbZ
	for kexec@bombadil.infradead.org;
	Fri, 18 Sep 2026 20:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P9IxdwpsNG1RvdTFOh7VCNlg1Z6K9O4n/2FHxAEnlFE=; b=jZ3yGBLfTdhcuoJtJJ/UhD6UEG
	UDOGqTizuJYLGMjeBp+y9Iy7l27/R4t8IXpNXx4LFQevVKg0sfg0XnNJLpKsMhktE8cQfqF1tvPjK
	YiWjG18MxMIdSRD6REiDfFJ9G9bq8JHL5ZzRQPkYsF5uHXizDf/GG0Z5jm4d/kh+nHMLIeEa38pxn
	DI/CY9kBcKFmm0VQx/d+6WHrulGBWafJ21zNbwo2p8ZNXDBYTQJD9hVIxcaailZykT+65vukwe8cs
	ou0vovZJbQFbmBu3Ep3suUvfkZcqyEeouWuL9nN85LoAdRq4Kxcpxt2t+Iniwbc2KAApxPwsKx2V/
	AnSjjMJg==;
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7erT-0000000AUCb-19wG
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:07:08 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc1a439db36so995465a12.2
        for <kexec@lists.infradead.org>; Fri, 18 Sep 2026 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762024; x=1790366824; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9IxdwpsNG1RvdTFOh7VCNlg1Z6K9O4n/2FHxAEnlFE=;
        b=fchLJyck4sPbmTLJlwZI6UUjw1Q3n5ABu2UX5CnkfJNlrqWsyVP3lpH5EAF7ZwE92q
         e+WO+fED7N8NHox3YGlB4UxQQaz7BXDms361SPwgPpsinQiuhdjGr/w9LKy2OwsEISmL
         tdovuJ9YFSD0fV0tRsiDpU5BP2tlfSGuqKwI5jtb+zE1P3q47LDnMBMB88nXf6F/3WB3
         h1N1latm4yIfeO/BujLyxsn5z9X/JvQftT207/39onmGWDXaQjROCc0SCS6sAXBKaYw6
         SneVEhPIPgTi6wrsHmIF9p4Q9DBpMoF5Ki1mGZn+r22/LN6lteTmfl6bgPBJXxPLMbXp
         0NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762024; x=1790366824;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9IxdwpsNG1RvdTFOh7VCNlg1Z6K9O4n/2FHxAEnlFE=;
        b=hUdzp9WdwleKfJt25ZzZ5LInlKGsDissHGNjchIadtTOIrHcdo6gQlO/LH95etLVfy
         ABL0SNNbKrQgCTmyJcU74garNuANfx/5chYgbefTvkF66qAyfcaLJqs4co+mZ7cBDXU9
         HCZER+Evxwwn+giGjf+XVvYLbnMGIwWH9ZMyeHz6t1Ikx31VKerAfwmVqJ2O1qXmIaNR
         x38HBgGeK45HmBSMDMF+BUZ2IHLhahTxo4kb6hTdctGwgaMMAW9ARjdcElgep2x72dbI
         e4tvMeycIppJHjYLnxr5LB8i0XoLE3MbBQJOCvYtYms5p8NHx5hhQQmXTpCwuPLhwfTE
         InKg==
X-Gm-Message-State: AFuF++ndCgD81NItSUMIBT+qnZhfEhq79/nJjXzESQAQ8EvO0xyXWZQb
	MDsw1qYT0C//UlS178dzvumTL5DII/ybyN5ZgGcCDQDftF754Jqyb2ulCxZ9wOCg0dkW4+tLvDL
	IAHfa71Ah9RUQF+dVt2n1e4Y/Yo7aazdA5QrVwtrQIHkQOwV2aVIkYwTFrI7HzmjfFPLzONy9b7
	jRhkiQcJOoXliEj4bbAT0EajD1o6iPo3PUbeEpM177YgTbxF1Yif4=
X-Received: from pgbeh14.prod.google.com ([2002:a05:6a02:256e:b0:cc4:b44e:9200])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6083:b0:3dd:64fa:5520 with SMTP id adf61e73a8af0-3dd8c4287dbmr7496380637.9.1789762024286;
 Fri, 18 Sep 2026 13:07:04 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:39 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-14-dmatlack@google.com>
Subject: [PATCH v9 13/13] Documentation: PCI: Add documentation for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_210707_387758_B0D96C0C 
X-CRM114-Status: GOOD (  14.35  )
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

Add documentation files for the PCI subsystem's participation in Live
Update.

These documentation files are generated from the kernel-doc comments in
the PCI Live Update source code. They describe the File-Lifecycle-Bound
(FLB) API, the device tracking API, and the specific policies applied to
preserved devices (such as bus number inheritance and bus mastering
preservation).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 38 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..23fb737ac969 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   liveupdate
diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
new file mode 100644
index 000000000000..96b1d7f5df3a
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+Driver API
+==========
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :export:
+
+Internal API
+============
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :internal:
+
+Live Update ABI
+===============
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :internal:
+
+See Also
+========
+
+ * :doc:`/core-api/liveupdate`
+ * :doc:`/core-api/kho/index`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index b3c689e633c1..2bce2644eba2 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -74,3 +74,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 3eacaa98775c..5d1b58271989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21055,6 +21055,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.55.0.1082.g2b9226bbc0-goog


