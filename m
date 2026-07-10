Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A834C44509
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INpd5qJ/nDERayrqFlF9TRfffxREvDfF4kxC1qPOhOg=; b=sskxxkHoy56UJ/hFjSVXKSinY6
	c6Lhy0VqUf05a8ge5yxQ9hWphdRMiHP4MST14v32/mVhdV6oHCF73RyZFC7PFlw7OS2oO8qoIuiFA
	v73e2aYaVN2ViC9OSuMAoB+xDup4c+dAq/6Y+4/N0O4kfY67ept/HHb+HguhnTvkw7OKWwdgQFrCX
	+cYgGQahJ6wYaSMxJnB18Px5+lM+6lC0BXl1b6hxNZ9PzbdzqipNGiNxfc1sNgy6FHGlFKiKKKrHu
	WnN8N8fXm0mJmFugGd2kn5rXgb2RJmWWt2Su24k1FFcxn0FG1Dkq7i7GHWg/x0/rCUaHfXvwlFZYk
	8LncOG6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIk1-00000005pZd-1bza;
	Fri, 10 Jul 2026 21:26:37 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjz-00000005pUJ-03bW
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:36 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso2552049a12.3
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718793; x=1784323593; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INpd5qJ/nDERayrqFlF9TRfffxREvDfF4kxC1qPOhOg=;
        b=KDJbana6kUSFebuvSgr+iL3u1/EXEklbnPRn9wmI5IoXGkRP/JFCS/0ebxz4vnLVGW
         aNL3L9JLdb/Xe9ggd4JRTuNb4y2//ymhzWZAcoqfjC4E9jzJ0xb0PzhqtX3tF/80J0dX
         PqX8LhhDkkwxeYLk0lZm7r9+bL5kQViwgEzD/7USOFaWuuTzn9vN4FhaFrTvSx1QmOty
         FLNkD41RZx99EjTFPWVDQ1VHo49+wXVwS/0BG7M3m8J+Yd2hEksERcqIaD+in13EO+Vi
         c6tOohfnzcqa8XRXEs3+mAzSOd0Z1CgRHokrGBVczoz+sTs3x8PD3lvF0vCjX0TMiZjG
         DJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718793; x=1784323593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INpd5qJ/nDERayrqFlF9TRfffxREvDfF4kxC1qPOhOg=;
        b=Xr8OaKRO48aj70lzB3M7sRM+5ilLyV/kvngOSV+HZmXUx1Zr1sQ0h/TUPV1TDdrCGi
         GPfgF7Ws4xYRdpXHctdkfzt+5LZeKHBl3fhcKr9q0euoVw+iGSz0R1M9HrCwHrRdaqQ8
         953xslD9PBsRJkydA7PnPFXd9t0woq4dvq86AtWpQHDCMQeF5rYSfAr/Eqe/sYF16WQg
         ne6SfwVbNYD4XaDuw+L9J6Lprc7NpAst5RAs03HOMxe9DRcIPrp5EQeMibOgRSVtEPy4
         7sYkF29TXm/NRQVeh/VwOJcsjxAHMoZiB0oOC7UHJYp6k31JrpKDLLyhMwC2nI1QplGe
         eT8Q==
X-Gm-Message-State: AOJu0YzuMbtaiJo+CXGBcJZZjaxHZp/coi2D1nDLMsfp+fgzrFRfb9jA
	9Ph6ZvyZWImFEnQMuv42CHkog6ASKqhTWkVAJUtj9a3N2JpjgzlBa8b0p8uZSELS8tlgAgsak5A
	PUK5c8r6ghdp7vJ2Cf9SNINBfIbHcMAZZgaPmfJJiW8JokI/D1aP87J8Jq3bhTQVbeJCf598N6U
	CDe/wE01DDhp+vAEkfkjMvhNyWreh0KamCnrCw7IkozD29Fts4qOA=
X-Received: from pgnh4.prod.google.com ([2002:a63:3844:0:b0:c99:aff5:7085])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:e293:b0:3c0:9c18:d5a2 with SMTP id adf61e73a8af0-3c110f61b7emr693546637.63.1783718792786;
 Fri, 10 Jul 2026 14:26:32 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:15 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-13-dmatlack@google.com>
Subject: [PATCH v7 12/12] Documentation: PCI: Add documentation for Live Update
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
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_142635_059836_B834C78A 
X-CRM114-Status: GOOD (  14.07  )
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

These documentation files are generated from the kernel-doc comments
in the PCI Live Update source code. They describe the File-Lifecycle
Bound (FLB) API, the device tracking API, and the specific policies
applied to preserved devices (such as bus number inheritance and bus
mastering preservation).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 29 +++++++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 32 insertions(+)
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
index 000000000000..eba55f8a92ae
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,29 @@
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
index 08a724b860dc..347c435ca404 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20833,6 +20833,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.55.0.795.g602f6c329a-goog


