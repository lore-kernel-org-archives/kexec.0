Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC3C982DD
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDTO4eHKdMRuuk9UsFB+WlCX7AwxRYK2xSqBvBKhZIs=; b=ThAe9APLHklAFQkKERQeiYd0No
	P/beZ5SOrjZUSxbiXj/sNGZnOL9zF11dpt6j0ubutttFrFrJF6PREnaD1yzAIWz3R9KhgeWzQ3kJ8
	FmWsKYbdEroDF03pMyr1KajhK5niKNjip1rU0zID1+TnNYiT7ELQWIWbgnfVSlrtswoXPAQepOdOo
	tIhpTcjc0I2BAhmOONiGI/P401jX0S83y69t9QTdP1Se2+FsldQ/KD2ojUg6Rk6hy712D3Avb+nNk
	Nwq3gyeG2qopPJCw40jz9yUaPatSD7VCWqNwYxora1FX5Pi4zt4GT1/NJvdvC/aoJxrMH7Rob4oqm
	0BE4T+Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erV-0000000FTSl-37iJ;
	Fri, 18 Sep 2026 20:07:09 +0000
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7erN-0000000FTKf-35iw
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:07:03 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2ce7dff6253so24319845ad.1
        for <kexec@lists.infradead.org>; Fri, 18 Sep 2026 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762018; x=1790366818; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VDTO4eHKdMRuuk9UsFB+WlCX7AwxRYK2xSqBvBKhZIs=;
        b=bo4jHzTnoT+RCktF97LBdEV9trYIqDqz4lwaNH4o2K7Z4gR7gf9/OTQevBCF85bH/y
         dBKfCJd41BYw2S1IK0s6yk7rZsr4iNPOO9SRxOfqkzLZEjaqo3259JqOkpfYf6zx/bcs
         OO65VxrRvrzJ2qXp/7boTQ3X4uu7tpbURf8vNjhJ6HRjlzN6WowiGWKUBhJnscwKNANP
         HRl5ZXebXt4xaRkCAZZ6oHCUm7SiUe8rLBa7ubcpbMye6EP6PwgQlIz9XDff1zPUCn9z
         E9Tsz/6ZOHFgj5Hg0kMOeiEyBuFSC1zlBAUdE7NxUwAjo2ljXYL71+/0hKwtktgezVJ5
         7yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762018; x=1790366818;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDTO4eHKdMRuuk9UsFB+WlCX7AwxRYK2xSqBvBKhZIs=;
        b=a/7p0LTkjPA0go+xK0igPAHTZ+/rH1db24fPTz6b5jWUmn4FWSalNsb/3LVLpdWJte
         CtZe8mLGgceKpa6mqb8m0OL+yWHDvK7yqXrSQlR1emt+bl+uCSBbFZeGbpLqyM6ryrgz
         FDiKApObBWUqJqn6EqgrLFJL4HPqfwV2nsxNkIx+uUXlP5qwsvJ4hA9moH12L/SQk9ra
         sY7npkBaoaZIE/GuuEqeU8yA4mTo3rqRi6TEO9UAfSW04ENuVzCfjFCN3vwgPQuSQiAJ
         EMPkLabbpeOiFW/XECU8iQTdvUC3TH7hwo52KRRueySTvgip2fLKJopiei+7Slo64EPd
         OdVA==
X-Gm-Message-State: AFuF++mibf0B9fi5/XKSzzMsXNXTjBXn90HuZl+ZcMPeSGdjRpy/W1gB
	G2gYHAlHZHYI6YkqvcLcGiJz+2kDg3DZNEj+CVR5UrQLhKmgQ8tnzs2vepF5iGooGaNFBR+pmT5
	Ikb31u+n7o+4fx2BWORw5IVZv8VSXVquP0XbpKOn7szSwM3Src/fAEh8xDFcD8iXWfNCTKt+S+i
	SFlX7aTsVzl3VSOoAYFOjALLo8hcscjt681HZEoC6X2hs+TvSgbOs=
X-Received: from plmk4.prod.google.com ([2002:a17:903:1804:b0:2dd:be98:5b81])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef48:b0:2cf:7db9:e13e with SMTP id d9443c01a7336-2ddb20fe772mr43004845ad.3.1789762017240;
 Fri, 18 Sep 2026 13:06:57 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:30 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-5-dmatlack@google.com>
Subject: [PATCH v9 04/13] PCI: liveupdate: Document driver binding responsibilities
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
X-CRM114-CacheID: sfid-20260918_130701_785499_D30397A3 
X-CRM114-Status: GOOD (  12.21  )
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
 drivers/pci/liveupdate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 00776260ad6f..ec8db86ed66d 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -123,6 +123,20 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *  * The device cannot be behind a PCI-to-PCI bridge.
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, the driver must ensure that it does not release a
+ * device between pci_liveupdate_preserve() and pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, the driver must ensure that it does not release a
+ * preserved device between probe() and pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. The PCI core does not protect against a device
+ * getting preserved by driver A in the outgoing kernel and then getting bound
+ * to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.55.0.1082.g2b9226bbc0-goog


