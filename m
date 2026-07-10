Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1BCC44501
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGoZNXB/ZYxw+GyFT2bV+z2qLaGl3Mol8FyZ542tK3Y=; b=P8g/mVuQN7gIPlwAjOMp4e/1ZS
	Anc+KKJYqJ3BLNAHHBp9AaE3dm6mvqO21h7oFBQMxSvHXVjY2KyZNVOTiEaVoHUao17l8+rR5SxM0
	ZJxikSOqMSjdyBlwgFyeitq6UMqI0Wbw/MC2Kpwp26ZAwfsAwiDyG36dUiciTepbXpqkt6aGhXfgw
	pLhe+VRbRA4Ce1e1B9PkF2P+eGP7X19X//b5o6IwmJjHx2cd+uPUMWSlq1N7fDn2yWPBnjUF/zeHs
	Yzm9kd068035f6r5JvF/cFRSK0GxSkjqoVF5tlL93DA3pGpwm+FjvwlYLojLUTDdMeiZjMUniFTeA
	ajYfmXxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjw-00000005pQz-0HH3;
	Fri, 10 Jul 2026 21:26:32 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjs-00000005pMw-3bou
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:30 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso1406488a12.3
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718787; x=1784323587; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGoZNXB/ZYxw+GyFT2bV+z2qLaGl3Mol8FyZ542tK3Y=;
        b=f4A11yGTrOUInj6koGrK4Gw7uoq4CoBwe30fGgMw3aWPYhg6ZEwluOfvuLX/VtFrxu
         5ydIBPx9TX67jNfDwc1/C1IY9SNQiWcrGlZX/mvtpY5a32eFg7ZZ2icJt6P0gXNwWNYj
         i/CM3Ls9a9fgEYmc7dnjhIfJdnxezm/415Ps10+RJdTetnekI2gPXlcuwG5TrHDqaS7g
         GwLwPTXx2512vi9rjf4wgCCgxozyE9jSRfKnueCbNxqeXMzBxwPUZ9Ja1kKyUwXM8aC7
         0t/apbXEOgGTjHb/Su/w9Rs8XhApdD6Q/2ACxcWzcDvEpyaE7nqkHp6R/NweMlH9UzXO
         Deog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718787; x=1784323587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGoZNXB/ZYxw+GyFT2bV+z2qLaGl3Mol8FyZ542tK3Y=;
        b=lQnQhMkppcfSMA5tbC1rDuORQcsZZhAgLuXRE0R1RWdedDkYYYwa9k1ltR244QE/K8
         Z2gglnOm4mNHR+fEFZj6xUWiK0Z47qGN9fomZgw7F6y2RuzRpP92Qbyfg9KK0O90ofT8
         SIXNn6X+S3kpv/IUixYvhNr2DXwCpBTx49fVgV2l8cIiIhKtwnXXkCSqhGhRhgDNZQ0s
         oBr10MlN6hZC0jj/YjsWTKYnQhrDC4yl9qdFHtX9G4IHhCLtYm3a4ul68b8vf2mQ+PKM
         tiwHbSWsU0a+h2dpYTiIHuo+f6hCJT286r5xT3EcLvxefsQL2CVOtKJF10ODdHOTdZVT
         cQQg==
X-Gm-Message-State: AOJu0YynJ02o1mLLxGcu4bEL1us90Aqd0xP0QaR4dkmfNsGJ1q8ujCYZ
	Js1GRxPruqvlX/DRn9KNhLJFgx/rpARqQcDlzgWtp4Jnu99AhYcnsYu2GFwxxpHrP4YOmZ3DvBI
	N1KdRxJhayroRuLYooj16a7Htz1Pi1YKYY9B4GyWJesuOeOjjnZ7qJorrM/bTGh2rRIYNTZHDRx
	9ugW6o8TXpkWRWvC1cBDXL1iTHU+IZzP1v5aPh9rNBsG4pfYGGVfI=
X-Received: from pghx9.prod.google.com ([2002:a63:f709:0:b0:c85:c772:c6a5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4304:b0:3bf:bde7:d671 with SMTP id adf61e73a8af0-3c11060a6cbmr641192637.20.1783718786556;
 Fri, 10 Jul 2026 14:26:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:07 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-5-dmatlack@google.com>
Subject: [PATCH v7 04/12] PCI: liveupdate: Document driver binding responsibilities
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
X-CRM114-CacheID: sfid-20260710_142628_897178_2F2740AD 
X-CRM114-Status: GOOD (  12.56  )
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
index df6a02240aa4..a067632e70d1 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -70,6 +70,22 @@
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
+ * bound to driver B in the incoming kernel. This may change in the future.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
-- 
2.55.0.795.g602f6c329a-goog


