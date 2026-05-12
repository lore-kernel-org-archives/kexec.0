Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F6CD4F41
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uszo/pEOiCKzj7JLqUzd1dVCJweWOYTEHSWoFKhDRKY=; b=Y1XeAwqMYqBf4dwlq49P5duSZu
	ipSZ56/fdpvfx7t29wQwhX86wrZUiu+S1MbxwiMO7PRu/73z4BdllhI3uGxUdeCGCBk8h1xap1yHa
	Pr8KG65zC0AANAszedd3avq01zyHAFbB9/wF2jz7QzxTeexDzVC0Ti4GYuB2jtfc8HOnoXcuvyotp
	6fGU5H1izzj0KQ6NH9cG19Mv8s2EYdMr05k50oire9Kb9XcKDMfUOZg6SlStC+p40DW9p59zmwQ3M
	DT5ZGpsw6Gu5K3k1K+Mp0yqDB5tIbUR0bp5BqdXCIwyl8Xh+fluWOZYWekYHN0BKjuUvxb6YPK7wt
	AsQeVQag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsAD-000000008o1-0WsU;
	Tue, 12 May 2026 18:49:05 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsAA-000000008iu-3Q3W
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:49:04 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso3865813b3a.3
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611741; x=1779216541; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uszo/pEOiCKzj7JLqUzd1dVCJweWOYTEHSWoFKhDRKY=;
        b=T812jb6qmrRm3dkO0dtuzVZsn2CsnRqZQ4+4oJtcvtGElHMit40Vw67DbJfsjeDHYb
         H9hZ0iJEBVJKyWt9uAMUwVJCn0iOFbBlavZk5Y0A84yy5IN9UQ/gkAv2W0d6zKdBoDRW
         GjvMzaJeodcWFqVNzGGQ1qvD1job43Jv7V2PXecf5u02opmZS0G9jSO5hyzmVGua7rVV
         Aa3HmH9Psk3uYHYEGE238/2u1abWwRRgtd5IH7aTPJct/yLmVywLOFbxlmrfbR2lH8cd
         ZeQcSOz/V4cVGh6sFwIIz8S+0lqu/53SXiAM6WdZPPrst/dLHD4WVQoIpOe9YyUhIwGN
         zssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611741; x=1779216541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uszo/pEOiCKzj7JLqUzd1dVCJweWOYTEHSWoFKhDRKY=;
        b=TwVzk1iz+R0VSCsO1OYSqGQhtvjjUR2A9EKv/ai5PU5n2BXCYl0/oowzm8E8L4emgY
         kGN0HV8awXXRzmmE9MNvNvD2WAC/G1dmDDwG81qjTmPk94AU6Zax674IPLUEgvuvOURD
         JP2FVeZ/Kyo+f5Bz9pTrLB72dKWMfzVVGJ1Q0Jvd1djzT9ZOensYp9KRK5rAE8r/xgD6
         83B+7SJeg8C29shJFdeXyNb41s9DEN0tU9hcpB+oLb9whsJTDhQ3A0D4gM4qzDvHsrAy
         nlOzOO2Hscr+BXDR9vPmyDHKeLM0c6fw429XD/U1HXb0O4FZGpWgq/tZKG8PBtEStk/g
         I3Hw==
X-Gm-Message-State: AOJu0YyZHy5rcXNIRXifXu0GVg8TKc6ht1fYwcdUxHNpij6KgniKM+qh
	jH4d0wuyIdMoWbquqPrLWXWS8sPO1VtIfAnVwaDhH0T1Zx5HS1K5ZuWhNFKxSDwIw+w/NLwGzfU
	0adce1n+1dEzKXpbEmIGViozA/wRllu0DY7yeZeCRVhEBtxySLXSriiuBITDMfNCWqB363tdg5y
	2wE94w/6IuvFWHz3R0ZUz8dX/ftBQUU4+cJI3U8zFfohlFWjCXPuo=
X-Received: from pfll21.prod.google.com ([2002:a05:6a00:1595:b0:82f:93e5:c64c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88d6:0:b0:835:3f51:730e with SMTP id d2e1a72fcca58-83a5b8d9aa3mr27781326b3a.13.1778611740692;
 Tue, 12 May 2026 11:49:00 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:46 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-12-dmatlack@google.com>
Subject: [PATCH v5 11/11] Documentation: PCI: Add documentation for Live Update
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
X-CRM114-CacheID: sfid-20260512_114902_889101_146F9DBF 
X-CRM114-Status: GOOD (  15.05  )
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
index 5a292d0f3706..d56a7760978a 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -70,3 +70,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e262c0ceb43..6f0b0ebf67cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20536,6 +20536,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.54.0.563.g4f69b47b94-goog


