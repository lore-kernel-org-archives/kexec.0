Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A87CD4F3F
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwTVELbnzNRdH2phaBPDBaeaYhhwivLmx4DuUtuYrYk=; b=zujLluKyC2WpZrKe757G7G0Pdy
	CCZ5Bct9GUB5e791AEFJSr0cj8pBdXRU99QgkdXuXdqTo5TlZ5Q42Dv8OwFWuvRPdKvOAOUs7LS1f
	qWfwoTVc9Ibhq319rXJDY6N9mKVIlLE0Rqc8whjf6pQ3ujGqDOLMxDUDk/soyC17DYzpeMcU/RGgs
	Yyhoj6T3FxshkcAs3/lJ0dokW+53EmknaAYYx77Yb6PeaKgGpF8heSDpKnfOemT2l3O+2Za7xnl7/
	crYLYoVBmooS1BRJfBZqGT4s3QaOqOFYiRo82SVZ6X9FY15DoAueTYNde9oNYDLNgIB+5Li7PLE3M
	ky1D/Jgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA7-000000008g4-1PBW;
	Tue, 12 May 2026 18:48:59 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA3-000000008cF-371j
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:48:57 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8354503d9acso7272173b3a.1
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611735; x=1779216535; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwTVELbnzNRdH2phaBPDBaeaYhhwivLmx4DuUtuYrYk=;
        b=JPINcdsVf//nWv5Fje5W3COS0u9hcNvy9l6uH+OWQBnR8dtvuGyxrq7uREP9YoO8F5
         PNtrvAZHQ2f+G62cz9hznOz7wN2CxY0+J5hVJSgUa8zem2I6N4/Q9zZCb1k1Pw0PsqBA
         Lak+wEt/Y4UQKXrYGahTegRMXknebnmFEP9WN764spMQI8cNKIjpv75hGVY9/SMc4556
         Y7sdA5k/W+94QWjsqoAAtLzkONii8v9RzltAb7dA0rG0nofDl2eDgyrnLxOSr4y3YEhx
         f6uWyGPr4tTIWGnTk4cqIfehDCo1mtr3y0RFBKyJxQjo0Jw9EQspN55XXoaMh24sGA04
         AtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611735; x=1779216535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwTVELbnzNRdH2phaBPDBaeaYhhwivLmx4DuUtuYrYk=;
        b=XkBv3GXBD6UU0ozNt+SARDVo1nEzl6TCjilZl2OLQmr17PhEZzhnNOmFKxnEQxql/E
         cNQECIgxQ/QS6kVBPOVUotijiE4SI2MpwVWhb/vgHp9Lgym4nnrJNRbhDAcGaT9KvyVe
         NRZkKiMfIh7aqTDCvzUogiddMBgkcTrjvv9R+08S2CMaHME3t2GbyFu2Ez6PIxzvfhvc
         CukFVjTsSfuSUB1mtzgOCVz8Qu6yy/wXXmzAo0WtRy8UX0cvaYT38v1Ibp95kHjNurhB
         9UgTAWnlqM8uHIqGv9X9ilvCIIl0necCAXzDhxEkxHjxdjSeoOTLuiSkA24S7+OeSkQW
         ri4w==
X-Gm-Message-State: AOJu0YyX1fHtgVYT+atGU3q2k/6KNEonsrtE/1Iw2pP6Pb9aroh0noRT
	s0A4dLS3dt2rrqJxIpB7ykp9h/Wthrac6loDcxLWxvzNsRgu/e5ikaLQwX5S57q7AyjNcsdzI4w
	bfJcKI82RkI3vrKPoHR4zTUlxJEs63/YCdBGrqzQeRasi+W47+2d3Qjzs/2mSoDbMFVhwJQpbA7
	0kP5JHNL6mdISvk6zWDhMcnUdaw43MTZTyuQtek3BeDWtKixYT2H0=
X-Received: from pfbfw6.prod.google.com ([2002:a05:6a00:61c6:b0:83e:c864:caf2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e83:b0:835:405a:7e62 with SMTP id d2e1a72fcca58-83eebe71c57mr4745750b3a.33.1778611734335;
 Tue, 12 May 2026 11:48:54 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:39 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-5-dmatlack@google.com>
Subject: [PATCH v5 04/11] PCI: liveupdate: Document driver binding responsibilities
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
X-CRM114-CacheID: sfid-20260512_114855_779169_1EEAB7F5 
X-CRM114-Status: GOOD (  13.04  )
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
index f14396dd1477..d77e64906a25 100644
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
2.54.0.563.g4f69b47b94-goog


