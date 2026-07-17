Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBCEC44520
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AgfKPfkfc4jyNoAXQ924zrK3vmVWU/VwnFCFChfwVj0=; b=Nc8QVDPhvV5UWGhZZPx9L5YGEj
	HQS+jKW3yqX8BTuGqIUlndARzC/y6JTme/eA40bxlVs5aszJV7u7bASViN0vj7W89Qs5KwObDYhGa
	Uc1piWuoo0kKgfhHAkWUeKdKXBlFL7Yo30fwWh3xmemzVoTL0gva2TCztgXKPIh8MLjYBQxvO/BAF
	Wdy7ex9VeeCFuTVkDWp0xvTUYM/LvbZRuYUqLTB5OplLa+FcZVRjxNliCzp7kOmUxI+4xPqYvUxi9
	vOrdKz2atrc1VYm8u7pDz9tDmeRc3J6orgB507vXyrjA5znd7nBwEonXy4MubTs+i7WfZaCGgbPjj
	JLK9wpNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqOe-00000003IRO-0H59;
	Fri, 17 Jul 2026 21:47:04 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqOb-00000003IQt-0WgT
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 21:47:02 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-52192509869so6833811cf.1
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784324819; x=1784929619; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AgfKPfkfc4jyNoAXQ924zrK3vmVWU/VwnFCFChfwVj0=;
        b=Pe7O1t+zcvrPNHjXQDvNN234+tUeYJ9rTd182NV1Ozs2JENXeT2BZMxpA8tcN09aZS
         B3OD2u0kPw+/YTVEIWRusCY1+MlgTmGX948lf4LmzBDhXdJtm9kZKO6yyEAtvnU+F9Ui
         DTlfa5oAslpAWC6ZSZ/5BYuwgXpIY3ftGAk2UT+TXlnj2gKs7FHsVeWOd/GOgzu3QNCZ
         mr7VlpFSpUFb5p/lcTTWSFUGr64YPKfbwto0Kk3dFd1CNjCiulEG6mz+m9diH2s9Tb78
         G8QzL2cj6Wp3UiCaZSV/BdXlgRhaTd4bs0VqUQ93R+d7iWWN2xM9K2fyxvrdVAe6pw+/
         Yp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784324819; x=1784929619;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgfKPfkfc4jyNoAXQ924zrK3vmVWU/VwnFCFChfwVj0=;
        b=PDPPSBO5Hi3aktZirhh/INJf27s+JUpGembRHXWwu23ZckFY1DXODulQu6GWSoTyAA
         TdNl11Ubd3KTQ2BVWYcVdVFuIWhaM4Qc1J7Crm3PVljKsghsfeNzQi6WntRD3FsLkdCf
         LnwQzVv5s4W9ppmaUz6EaXdtcKma19njgmq1/gVJ6noKTWbTSlIFxPl8Wgf2AZFJLGDx
         RnL4T+g6uyuEeVBSGS5wXQ2P+SLTUGY+5YOt+uMWmlpz0y62kTKmkNuOHQDNdB/S6OR6
         ndoo3pCAwIInpeUK55m3SEHYpCKilwHUQHuX5IcUmFMnhD1YJeDBtOMoWe5pTH/4WGOz
         eyRg==
X-Gm-Message-State: AOJu0YyTgS3UCpi9zy17fZok2RVfeZrZIuNl/fgT+v1B3qeCrd7m96jn
	ocrWR/8oMu3k/ckWi3fno0tn4uGa2nU0pu47FXIwoESPzLi5B1h2V5VqlAEGOwclDNhQOX898UM
	varzy
X-Gm-Gg: AfdE7ckjMdJh0JXk78QpD60I5bBHDTwRVqNALk0OIovVnWPRiDdNS5L3yYJMdyyWAuf
	LgV5dpdUhmaFdCAK+5hTxE6hgGg09soOtIR/1Taa6SZqffDfm1VXzAeiHoG7oCAkxDC3z3ycZic
	Ctrj0CCPlTEFxNCN2cJ3ubL7H6g7/NEkBgmsLluvGNtwhAKbepo17DoFChVP0J1E2HZIy8K1cfa
	t7oPtdBfcHDXAiGnN7QTCGsiqZA1QxpZUZrTYBw6nFX7Vbf9oNtS9Wu5AT0UgYHbgmavtKQAIuB
	q4nP51wGP6KgZbm4b7XjzFoq/92i9M+/QeMzHPQS451C0wf4wsM20SaMun4dwqw1kUtPHjL2Ypb
	obeminWekvQTZJXvkTqcP4EJDe5SBbMqxkc3lPGDYrb/TZXA7ggiBa9z2N1WQ83xiOemZVoZ+3g
	voYFLNY9PdbNfYbnFqQQqJP5CcRBcp57/SRiD0GgmprFWwQT8aAQ==
X-Received: by 2002:ac8:5acc:0:b0:51a:8c97:fb93 with SMTP id d75a77b69052e-5213fc54d44mr43814441cf.60.1784324819586;
        Fri, 17 Jul 2026 14:46:59 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214c5cc8d5sm21955091cf.6.2026.07.17.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:46:59 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-4-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
Date: Fri, 17 Jul 2026 21:46:52 +0000
Message-Id: <178432481253.189683.3297727348836286619.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=ahWVhQAgslIBwnfpmx5X48jHe/0a44QV3IQwRfGz+iU=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqLRRsSwqC6u4RSv76ETLMmVCyhdUsVHiqEBy
 IzSCQuBMK+JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqi0QAKCRC7dyhM23N6
 3vK4D/4oivNUuZbxrdZZJAOMVjLNn7oaWYDk2Y4dxn2IVLciov4pX+4V8SBAYA4KhEpyZKQ2mzg
 B03dHNIKdFOpoPbLkuTRk9ZGugmK2ChP6tAHjBDG3RkOkva5OLSR6JBKmrLBG2GEATEY/EOLIZ6
 eY/PqU+3F+O6j7iFegvOLxHq4AGPuXSVacvDtCjafit/axJj9LIZ8kF409sq6qgcKO5JKSa8Jea
 R0CHNLN/rrFF9+PoaDcZ3B9yBydtITA6U5LOFg19G95jV2FYfsILSxxBbZrxUBXAadtzCS2F9wc
 ojlbkyeQfKGhVsMnUf0jafSZJy8tlQ5ygLO7zUxGMxHU0yDSH9+T6zwkWpBoVu1DzV6CaJNE61t
 UznWIUm+HsrUwRRGxWKvQ4wAZb7dT86JZoYl//i+SFOHLjV+15QOw7niAqqrMwWfQasB4V2Hxwt
 eXCZu13O9+xov9pJgVNEtvYTQmPpi6xZlCFh5C0RT0QzDoNbZ/WnJZuT0M8/c8BHxvB3E/domK/
 fmKpXprZCKUC0ZMdFx+RiHls3kZs/ypakbVXPUHyzfXsnIT6DxIFfXMfg5kTylkBxQPg2GwLoaZ
 CRH5LGmNRRTuTgY1EFBAo8as9+ZfD4j3ydB1vBG6faS20lFZ3r8fycLqRoy2hUgcnWVKGbkEtVC
 YOLWzX1kCSM2bCw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_144701_185061_F8129C67 
X-CRM114-Status: GOOD (  13.76  )
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

On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 03075ce06ac9..df6a02240aa4 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> [ ... skip 76 lines ... ]
> +	/*
> +	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> +	 * that dev->liveupdate.incoming cannot get freed while the PCI core
> +	 * has a pointer to it. It's better to leak the incoming FLB than do a
> +	 * use-after-free if driver does not call pci_liveupdate_finish().
> +	 */

I am confused by this. Each preserved PCI device must have an associated 
FD preserved with it via LUO. I.e., vfiofd would need to be preserved. If 
the vfiofd was not reclaimed, and finish is not possible, that vfiofd 
would still be owned by LUO, and therefore PCI FLB refcount would stay 
positive.

However, if finish is possible, and this is the last vfiofd that is 
finished, FLB will be freed as soon as the reference count reaches zero, 
which I would think is the expected behavior.

What is the point of holding a reference here, instead of only for the 
duration of FLB access, i.e. to make sure we are accessing a valid data?

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

