Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B76FDEE52
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cA/8iRDD7lhVYHGAuqnc3aBzPoZ7lUU2DgL4E3vJPEc=; b=cTOrgbPCZ1v73HjtAfZ+Pe355E
	HsMcAIhH40+lZGjuRRom7xx5mddlXktYCrRK+AO8cMjqI8dfKUmrApWamwof6g9EvfAKHPly3citn
	AYQQXO2+f/RIQsvkCwOX9IVIYNsU0nVD0NX9I3nyANBm7UTIo1xPfGBpP8F6KRdfXIJUH23cItav6
	Z8Yl5FEGWD/dsn0JWwqhzkw4bOfONMHoH6jJJTmO+nrUh4a08C+NjP7VYzQmNZMjfgEdvypnkMMxd
	V6WYrg8ynrfGTxWOKq+mqXQq9BsjoqTyGi/N73s/IJdu26Wh0Li1nLhKn5ISUvwKwIhExXxhp9PPI
	mkH4AEHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WD-0000000CL5s-2raK;
	Thu, 23 Apr 2026 21:23:29 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WC-0000000CL4K-0ADu
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:29 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b7a77b8ec9so10515375ad.3
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979407; x=1777584207; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/8iRDD7lhVYHGAuqnc3aBzPoZ7lUU2DgL4E3vJPEc=;
        b=IvCORh1LWbTEXO0nGAcN5z2ol12/IHe1rvunRLdiG3IHyGLbM8L/UluQ+ttXhTv4d+
         djpQAvYJJPAB4cxTovVe0xd7285uFqOQYbrQRW0eqyfJo6mAHNM8YZjHrzMgd6enZb01
         G6xHoRkr3RO5317QMKx/xo5oIsxsD0Fv4rFkO87MYIvXhWs7ow34X8h1dyh/mWf3P4ts
         dcouaLeo5/ukV0f8Kangm9mR6/DCRUI1ultxrsiHA6AVxgLgII+qPH1VlZ8c4dbhhEWV
         6T4SQrGxhda6xMDII466839Ffd+NQcOL9V8HG274VlhOiOM0fiODYWWLVDabOeDfee7l
         lP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979407; x=1777584207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/8iRDD7lhVYHGAuqnc3aBzPoZ7lUU2DgL4E3vJPEc=;
        b=aaR3y1wipKlfs7b0eJ8j45ZGiAB4MtT4ixrxCBUQVBwvej0ooXKctJVVSPLEbKmEHE
         8M3497eLjC/uKCeKEvtrzz/4f9KuXL1TNWealIuckJmlDdSXS/GN6yJGlbzOV0AEScgH
         x8xmWKgz+CxdQ+uyFn47+E/g4uzZW2m1TmYyR++kKBul8fczl9oKNvMSqkdcPnf5mYhx
         u2vZbMvZkqkeIuvRMRjvgAk+fsmba1D+usxDfjB95GsdQ5L9Yaih9dlmtGNlQnksh31x
         QB88CQkQq3SQTCD6SKq/3MJ/HaIA/F51chu4od9uSwBANrzbr7yPPYyiJOAMtUJZNMf7
         U70Q==
X-Forwarded-Encrypted: i=1; AFNElJ86m8woPIxZe+tGX8eM/DaZj3/tjPxB9FOj6xNUNApRofOAmhRXvy0+EYi1mY5SKtO5ruutfw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBXzUkTt7eMsu1pi3SUbL1G+DgmktYDF1tf5eQ2eyh908driyn
	bezVThJqFmGz0KJZNUl/nDDZ4uJ9mwgEV3pW99692b4OmAkoiFGb1B+fg+TRqCieSeo01gNaT9u
	nHqKkE88PON6gsQ==
X-Received: from pgjm19.prod.google.com ([2002:a63:fd53:0:b0:c79:7f30:5d18])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3399:b0:398:7982:21df with SMTP id adf61e73a8af0-3a08d687673mr31625673637.9.1776979406884;
 Thu, 23 Apr 2026 14:23:26 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:08 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-5-dmatlack@google.com>
Subject: [PATCH v4 04/11] PCI: liveupdate: Document driver binding responsibilities
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_142328_099719_30924F83 
X-CRM114-Status: GOOD (  12.32  )
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

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users. Note that this is only a description
of the current division of responsibilities. These can change in the
future if we decide.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e616cecc37c8..c0a30d16d9b8 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -77,6 +77,22 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
+ * does not release a device between pci_liveupdate_preserve() and
+ * pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, it is the driver's responsibility to ensure that it
+ * does not release a preserved device between probe() and
+ * pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. i.e. The PCI core does not protect against a
+ * device getting preserved by driver A in the outgoing kernel and then getting
+ * bound to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


