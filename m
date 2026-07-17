Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3287C44515
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 23:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1uFYFSRoCsiTT7zcdwujRzQUpLdsx92sk9iYHDH24xs=; b=izblnsXsN+KH46PQEDTnhoQgJV
	zbWB21fwm4pHlChjsIc4MU3EV0E3V4F9To/4P9nunN/rt/jO9BCR/dTKgC9r2Sd+Au3w+mPP8+4ex
	lFn3CW/UoLS1c/G60K6vGSSmVH2QXaSK3YKpWxo8lDHTFwPgK713RuvGIMUUgKEWOm+h7e5uNBZgC
	/Tsao5/wWnf0WpS5ZHvx2HGXOnZUjuVLq+85YKR5NwZ2DpHdELdyRVBWNb0h+aCORDdsi4aO8wgOU
	tF1Y7v9vbrwzuGmu34FAEeVBMTi/2MSXhnRp/mjLs4lDR/4gOxrFZcz/X2ll+hEXdt8pzLnS+nC3d
	59GjOI4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks0A-00000003OwZ-09OL;
	Fri, 17 Jul 2026 23:29:54 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wks07-00000003Ow6-33Zn
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 23:29:52 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8efcef23d21so82659286d6.2
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784330990; x=1784935790; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1uFYFSRoCsiTT7zcdwujRzQUpLdsx92sk9iYHDH24xs=;
        b=cW6jjfitsbsA2KZIpuj9WWYr6J9jQuEMqrJbiwQxUR9kCr5aPzOOK2DzyfBqmogpMC
         QVhUgsUruP0v2R0xAYZ5hcWprARJLzlcGf91INj5Mwel1fVjmOtoZnwdLIPyinpJELIZ
         zs8F0bKZPaniNk2+funLCrMrPepPzEVrxnwcqoy51rzPzdRaGV+S+4D9qhMvlQkOhlRw
         +b/XERK3tsAC94dVzEo93egqOAnHLT81haDsQURpaSFRNYjqLuYoxH0oGGchUdjXbE0J
         ZCoBgZCxiv6T5MxLudMBKgwbK+Qo1xTc7H9WoyasSCg7+L8zCjLAAh+Knox9BK7LC9aD
         HqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330990; x=1784935790;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uFYFSRoCsiTT7zcdwujRzQUpLdsx92sk9iYHDH24xs=;
        b=edmw51PwA8IzcVcTeXCO33JCCknXiUd+8EKSNiK4a5l4ewpAvqAEiLBS0px9Uu89xu
         Ul6sPDJLQ6OLgEfYLuP01rr3Xk383RSbmodPeZWNJ6J1MjFoKPYUPe0o5hT7sweaXgYg
         LIYmfhDl9eyLq7xuSYw96d0SIyLFd+FVkNtxWTi4yGcPOIy84b6iqHYwkGzFXx1l0zvZ
         ghweKQdSSAvVjCeYQsREChEzygHPviB044BxDZk0LnQfR4D2M6ANctYGpq3wD8d9FKZH
         EVvj6jusVmDY7E0/Ufn5oYzcS8hwZDGwW4JxMkMvUvHBns/yogbVibQc0oWZBOAg5hwl
         VoiQ==
X-Gm-Message-State: AOJu0YxYzRmM11kGw61pw8PUadQKD/kwrlGTXQ0wXXw96bsGWpAH6hes
	6IqI38iPu0BESbQwlMaWZhwGfw7a6HLwkLTjAcO1EbBEOPM3Vwlkb4L9py0Yk8hSQGhQ2Y/FKEZ
	6bXgE
X-Gm-Gg: AfdE7cm5UokaFt7gbEjELMN1xqVlIq3TkkIrruOm1ztXRR2weVPlKFQn5EY+pkXqFhP
	uSHoBvRFkvTjOwuzUK56sSmPjnQ/bTr53oWvxe8IJsWl/Cn74vTyQ49Hb1HcBM0OX5SkCAZanLL
	T5/oyANqIh/EhwWz3P6N3xwSGcKc41wBzKh8Qt+29FYKIzZDW7J6V3ACIM1IXOg4KWLH6ntFZk4
	+bj1yuPfPhaDuD0CzEZTRL9SG3KjwwykTLF2v0tPVo+W2FHFocELZJQC9cDb1inckL3BgzeWybB
	N0tBrBoo30gjfDXKZAJXopr9Pf9f0+fajVGfYnn4gFSRVLI95id2szgJJxz638oA7ngGpdv9nja
	K9ZmLHMQdajpoIKuY3XexyhQM3QP9N388UeEmgK8aED/E/6lKH126BtjwUCMCE0v99US+/8YnAt
	lLqCuxlBGDD5n6YzwOgP425B31JqLSa7aN9yu7klxZasEzJ2MCQw==
X-Received: by 2002:a05:6214:5c49:b0:8fb:81c5:7997 with SMTP id 6a1803df08f44-9077850e2c1mr54008216d6.31.1784330990189;
        Fri, 17 Jul 2026 16:29:50 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907787298b9sm28260406d6.48.2026.07.17.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:29:49 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding
 Enable on preserved bridges
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
In-Reply-To: <20260710212616.1351130-10-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-10-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:29:45 +0000
Message-Id: <178433098576.189683.2364970585754668266.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=6J2VFoOheObNIbZ6/cGmHoej1PdGKGdAP4cvYQKgG9k=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWrrshWLAQfvPS4hCFjntJqjX0KdHUleGb+svS
 eNoqDsCDGKJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq67AAKCRC7dyhM23N6
 3n6BD/93+EXV7xpXf2NVyjjavXthNzeAZsOjnEaI/9CTjGZpZezuLCaFWFkZbkDaJEae3J38p4g
 juh65pYyMlwdowYBLYitqy4Ier6vbyyxoTsXaj3h/5m7FYus2rP1L70rvxqIWUKVDa7ae4mcHP8
 jx4t1Y7WnDY7cDIIBbDBOVWz/TUe4B/nhCyh923/V+f3mvMwSMrkjpeg0snqGfcXX1/MgSHzSXx
 JxlP4a0WAMxKCYZJErzZ2J4BDcRpMPVf0Wogx/PmJlJ44HAR0obpH/l7e/l8mlIfJyTBnC0BOcd
 CRxdwB4gQwt8tYXq6ojekcZQGo5tkLGjVU/FRP9nzKbGUoIwwajPcQw2k9Wy0QrUHOHr0YepxNa
 PDOxIex+hWFFkDdyz0K+A6aSa1S8Wbkc78gHQcx++rNOheuVA4I1tNb2mW0+CmOfdK2W+Xq7qzU
 8H4RB21Ijq3rJnHjvcfH9Y7rNyN0XbXdraIJKmVcg3iQiykYkN033FyDlHK3Xxs7+VkXpfehQU7
 HVwPoEC6LyiXUZuPvqNPlP9IBcUFEKJtHRGZQvO84eyZvv0IyG2a4olE3gptNO3xeHXM5rLoij7
 +UQOk3YJ0MWvmomRHmA6P0cgqW7ejMNyEJU2GfTch92NagNbGdNLnxWPd3YVdcov/hPE9GI6NTE
 y4FR9mOBy865agA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_162951_785229_56F3F1C7 
X-CRM114-Status: GOOD (  10.65  )
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

On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a95bfe5eff77..74a11e520f0d 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> +	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);

unsigned int    ari_enabled:1;

Sashiko asks a valid question, what protects other bits in this word 
during modication?  At a very list a comment is needed.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

