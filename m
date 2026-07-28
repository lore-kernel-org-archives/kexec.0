Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C395C54F51
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5wUi9z17xOtf3gvL/6/TpX7uS9U+gRCHP4vdmTrFsk=; b=GcpBotSXENqpWcYV+6Zc/yXs5H
	YTVlNmIeLhHkw2NPjNggWz5CmgjZFOjfuxNy4ymt8M91eWJSuxZz3gUPcabkfGmDvktvov0fZ0HrB
	mgJ8W7uBMHUvA1z8CyQgW4tUwsjo8ykilV130nedqrpP6miYxyXAeUNym0zwZqqXpTFUBOYvt52F1
	HyW3jSczzzBrBGa94CDLQ/hqOHrO0wH1r3OSnqlE2WBJpKA4cZjG9zIt3kSoe9tDNMkZsxnv/KLUh
	dU04teGRwjjGeHPpvjWU63KguTTdS14yl9yY8tysIiPIHmpi88S4IoGf2boSYMG5fefr8BLkkZ9Rl
	q8VIPV9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0P-00000006Nwk-420s;
	Tue, 28 Jul 2026 22:10:34 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0I-00000006Npe-0qPL
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 22:10:28 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2cee1ec30f2so4203665ad.3
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276624; x=1785881424; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5wUi9z17xOtf3gvL/6/TpX7uS9U+gRCHP4vdmTrFsk=;
        b=MkzbFiOg0TGDnlQPFpFX9A/VOee2yU1VKankrWOxeaI1Mr6w/culEl/2O8+W4Lb3Sh
         CaH/9t8pbE1em8yjF1wenY5RyQnIR3Y7pwWi7a87+Y2sYFOnUlaUA1emZf1gJZN+Y2BX
         UYTkEzkENPbtTHySW+Re+RgTCfs7b+E+xU3+q6xx7yf8VkT5X1uYnNGhjWXJ/AhGOSqb
         Ny5+0GONnwkZ9CPdqY1N07MNhLhIlTFjrm0zRoEDbzVDzQEj8Z0wpyQdNALdx9QeAr5e
         pIFLr3iBjGHju8hQwuKNfZrarcAJrKG8EEHh6LoT/veuw6baQ5J5lwDPrLybFe24E0gN
         w9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276624; x=1785881424;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5wUi9z17xOtf3gvL/6/TpX7uS9U+gRCHP4vdmTrFsk=;
        b=ZsM35AI4jyUg5mV3qR/B0IfG/UVrxW3nuisk+H4SsAZV9SCubmNBZtAo/ftJ48R0Q1
         adwhnmw9nOT+nxWYEtK4Posb8IRFyGif406lpsKh+sQ9bBca97ZmdIE65uAzEF9Do4Aa
         wtVEK29AjF+G3k5vZjwMvoI49q8MIe8YvSKWK+GQcGSsbbfl65d86C8zLbKLHiE03/OS
         XVz6cwmCKiVWiFTtyf3w2SP8rjx/zb9YwBOW7p4wAXO5iYNucafRhIgqLoGA16Z43ohA
         EcMPKiYjzMbM6TVuso4sf3InsgMMQ3epomcDeiTLanEJtJ0psoUlQ6hlVM0MfGjgmWzd
         owoA==
X-Gm-Message-State: AOJu0YwJyeabh8IDbtbs6vS1+qse6KfYHXp3PJTdaYdMw+KL3zGuyPRE
	zRiTUjl2NxX75MVaJRG4yFTvFE5zI3Fa44k5G0JRvvVKOjdB7ltZ40WKf502I6bwBXviO9qsklk
	TB8YqVaAoAJ2Avte1w2jUQ3VuoR3UHoXsH50Xs6OdoEqzLepej4jscqsxH6uG5JIq8Iy55kD/ag
	k9zZJXASpLMNggYxGP59V5beHY0ZKziOO8cwNmLi3s6GHiC3LvqHk=
X-Received: from plsc18.prod.google.com ([2002:a17:902:b692:b0:2ca:f412:48ad])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f0d:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d015abe547mr50357375ad.10.1785276624113;
 Tue, 28 Jul 2026 15:10:24 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:09:58 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-5-dmatlack@google.com>
Subject: [PATCH v8 04/12] PCI: liveupdate: Document driver binding responsibilities
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
X-CRM114-CacheID: sfid-20260728_151026_268565_7DDCDFE4 
X-CRM114-Status: GOOD (  13.28  )
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

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 5ce5f8b36902..0f7a018ddc66 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -71,6 +71,22 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *  * The device cannot be behind a PCI-to-PCI bridge.
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
+ * bound to driver B in the incoming kernel. This may change in the future.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.55.0.487.gaf234c4eb3-goog


