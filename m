Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1834CC53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jcNE6apqn+AHojLUlXt2w6cBeAI0PrY+z/kXQXeICZk=; b=myFZkHXUT3JbaISOu2EpUyv1t3
	Vjc0br01M7+lg+FdnRe/vjR/56/K49lq3qG+T/63bjzL6DmkBW1IaX/SL8RKeIf547kzk8lQVZoOF
	F0vLnSGUcb5tLY9PvvpG1eV2ulX0f/W9UZ+SXKrarIS3rmYqliIPwobbBisNhmvaz9XKP/GIFjA//
	Z5Zd2y8ap1nBZB/Y0fig7AjaZuYQyMjl0r6xGAmufZmDFBJmRiqj4VX2n4Ch2K62fFSLZzworUazc
	hP0bdN2cPDENuaB7jfVUxJBHVTt1xjAT3rD6qtRo56g+3VBeVrKLC9LHSDytZrTKOp/I6QUhXcT5b
	3OkyQOVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0S-00000006O0X-39aM;
	Tue, 28 Jul 2026 22:10:36 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0N-00000006NvS-46Bi
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 22:10:33 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2cacd6d37edso4493725ad.0
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276631; x=1785881431; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcNE6apqn+AHojLUlXt2w6cBeAI0PrY+z/kXQXeICZk=;
        b=mWyapJLEolihVYZ+VC4MZiRaSoeLJx1VQX2nAJMwaVL68SUzk2guzUzenLdzj5WX96
         20uI+mrPhBdC1qSG7mBXTHIyW6/NLWE7WSaP6G0xrIWjN1Df4AhbNaU93VMumtRL0+RU
         YzPqW5gd96bv4AiyVC3T11/xJJ1aznVW5EKOStFgQOoSNPnKrTG528q9f3Xw7bag9OVe
         CwJGbPsRJ+3ArB9HFONttoon/ZKu6TTzO+wjCTdbAPNqGXcaH6nCY2F14oTvQulqwABe
         axU1JKU9v3Sodw8XBOCAZSXbvsHglAWyL1ZL9RpEuemVi2XmJioJbzUNfVuo5mlSmeBz
         Mpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276631; x=1785881431;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcNE6apqn+AHojLUlXt2w6cBeAI0PrY+z/kXQXeICZk=;
        b=LSKQbyFDs+3j4RBkWSJ/HizbDZt8o0IqkYP46Z7ZN9d5kHud3PtgHzv75/5A20S9cj
         rMbYBPv6kIqH40xbiDXYzxVSdiaS+sJilsqoSUOPXWg0a6/206pXdydJ01fCjx8H61mW
         DGF6LdLFM1jFo3z+qCZluTl1ImLaZ3/Xb9SQ8wFTeGNualjwI87WPcqPEp36WXbMx8UG
         Oj3M20d7ZqdtMSJarAquEoHzDFz0GryKdJvKlsUcerNovXzfIiHUxlPQjGHTmcS72umx
         TtYGayBb22pS6NYa7JEepsBZvkdmlQf4XILpqb1hBxfC3XNnONAgquAzkSwquOrD6H9R
         EWxw==
X-Gm-Message-State: AOJu0YzO/gt0UNWkAwnsyTcAim+pMyPmZAMlYjsk9po8Pdhlms26QzTy
	UFGl3P4WdNc3NBHi19uwJ5iLHNteR18ZLUvniH0qU/bbEqGXde7G7rIjZyVPBglFMJi8SAZLx0P
	Gbm1tsglWX25hUhKq0rtchFnn9Tx6/0AqbaT208C/flqaV6WVlWDyXRPvul0FHZB/nTIYgXaybu
	1D4IVLgLA4Blsb6hhYW8+elyovv+7hopQNin8B1NfjLcdn64BHIKI=
X-Received: from plrp16.prod.google.com ([2002:a17:902:b090:b0:2cc:9345:c60a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b90:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d015b145a4mr51662475ad.4.1785276630984;
 Tue, 28 Jul 2026 15:10:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:06 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-13-dmatlack@google.com>
Subject: [PATCH v8 12/12] Documentation: PCI: Add documentation for Live Update
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
X-CRM114-CacheID: sfid-20260728_151032_025306_AB4EDA95 
X-CRM114-Status: GOOD (  14.91  )
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
2.55.0.487.gaf234c4eb3-goog


