Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C81CD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVXPrAHp/BWzZQhw02rB+3vghjeNf6PQdvQ4HyaXKb8=; b=ZPx4OGxbyRRDc1tGQ3UtwX8Ala
	GyzGMWKjhBKTs8CGdGBokdX4w4ktXiNgsmKQ+fz8xLW2E9se71l0MWFb7AiZ2sfGC2GNyY4PcDXMb
	3PpjKK2TbTUS/yLJrqpI5eohxiqcrGMLKkHTe8vI9ZThTSERZ7yiB0UerC8h/yacGSwU9ym9rdb66
	p2Ipi5jY6u/FQzbFysf5ZxAHkPYSOTVpLSOm66uUjp96bgP2cvqVeKmEuZOHnb9zPTpnXqItMGoMc
	QeKjXdxGD9TMOxy1lNVZuFSIrWxIC0AR94CwT12hx+IYe6CJ2yBrAYDqOjt4u3p5ZEPy1ARm7hR6b
	yKznXeHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY0E7-0000000AoRl-0Dn3;
	Fri, 12 Jun 2026 11:39:07 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY0E4-0000000AoRN-1BPc
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 11:39:05 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-8cce22e029cso25522176d6.0
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781264343; x=1781869143; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVXPrAHp/BWzZQhw02rB+3vghjeNf6PQdvQ4HyaXKb8=;
        b=EQ9hdQ2dDONanY4nuOcQJDYYWRPUKIhjtXGja9B9DpdL2bybxhBROVODuBLnLH0Iaj
         nL519x5KR+kfearyMGcLgYNyo9647Ctram5uvnAqVseVqGzrlKTctdGoBGP86y46ziFz
         W7QNt3AHVdp9qUJuJ073KH9C3kvtwctKqnYmMPXqileSJ4pbu/hSZRbTD5cowm1pfuoj
         Evpralzrk67xZ+vG1Hcha9cZd6ajswfeugsnC+LNs0GeA2uxBFZSgwuY4WEHx2DtZA5I
         +D4xywWMECAQAItgremvLxqIS0lCbTUakJDa8MGkHxUg8htRPko45RqkxhMuek7E8Tb4
         ykZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264343; x=1781869143;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVXPrAHp/BWzZQhw02rB+3vghjeNf6PQdvQ4HyaXKb8=;
        b=OUfHe7zDgczD8927f4dM0oEwC/Fn0yUcVEaNHUc7qTkLbXz8OmuFN6xuboKrAygJKd
         Gkwe4i17044pmYW0BbaL7ASCY26FSLJwZN+Rv15/xybVoZTV/BdmVHNoR2BfaIVdK02e
         QUC7YCvcntCwt0VqI8OZu9wth4tCKnUWQnXkkBtlyJh/b6pWtiSwSQmTUFGWeVs9Bqwo
         ujNU39jrvLglkV3wys+MVwB1HUw8U1Z5sup//ULl2RXEi2RnTlDSS1jN6KtAABF6HxvA
         BafTFMFuag2xQ9JLGi48OiiJ887yVvczjE0vC/FRJ+aGWlZdDFYurlKXOR09kgSfpgOF
         4V1g==
X-Gm-Message-State: AOJu0Yz18+xf1H+Vr67L7Uaurg3Ot9fLSaJ2dEaHYqJGksDOR6Z3ozPD
	1zORop1BImHqJzZhg9Zd9bIGX/Y1V1tu88uUddsdFPnEds6U9heLfjitzEJ2EFWSvk0=
X-Gm-Gg: Acq92OHrO9IJ7GjeC0Ezx1ttCvzd9jWYouaRJZyPLJpIQtkIFOhf6gCuL8wSk09Mwve
	ocVvluXoLsB1D5O4EPoxhn3oo4WkB/OD9wH21HFsOEYYnsE4pWzt5FBEwp+/7+oLVtIGSwTzSop
	Th7eciBoPLG/L/rmMZcXiQRizT296TSevhaLTPYMbMPzHzzPjJgYJe6sEAmz/V4qCgEO+YLG94B
	JSCVsJpDrGJ+BNF2nM/W8If8rrHNgjjqbJb8WOHRAYJqru+C4xk8Jr7TfLku7HKPtMHKsHKTtY3
	pGh0+Jj6F3ZAh9SopI6NeTVsWuXUc7RyJguHOE4ZRMQJnq1T0w03g4WJbUMt5zim3J1uV93Rv+m
	C4XlG1lKhHWNK6sLZDQwnA4ziJqdmfAkQ3gL9cmpu31hErZkeUvngWPDgSwKLAUyGNKXx2oynvd
	NiLTd1liQUMMdayJDV8o4gI5d4PDL96MrffxWN03Q+Rk9zUnfuYh6Qqet5hWuOGSjItstu4mQ=
X-Received: by 2002:a05:620a:7e2:b0:915:9931:3a3e with SMTP id af79cd13be357-91619f0170dmr269313085a.27.1781264342749;
        Fri, 12 Jun 2026 04:39:02 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a073548sm182029585a.46.2026.06.12.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:39:02 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI
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
In-Reply-To: <20260522202410.3104264-3-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-3-dmatlack@google.com>
Date: Fri, 12 Jun 2026 11:38:56 +0000
Message-Id: <178126433616.1046400.532221910811070690.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=SX18arNH/qTxpgMw9xFDkGTsTcvB1jVfOazjLslA7NI=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK+/U8DWh12WkUIvLfnzgjF1Th+7JSF+r0l0bC
 ujbcT2VfT+JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaivv1AAKCRC7dyhM23N6
 3vNZD/0XZYuESCSVn19lFpaRZQiMEVxnc34vt0lwHhNqw9psTA8JmMZy5/0xcACkCF6DDLvnBIb
 rPj7XNZFS2EWttEzuKEWmy1wSAzAN+xBV8sv3ggddpviYBAOEYw2v2gNMD2W0nkZvmJxMEYROTz
 bd4Mk82xVHxraSEw4zTpmZiYjjTQXXWvUdUothtsU70yKAR9q7dlxiZHKm8xNM8hKggyyM09vZ6
 AjZN6fA8YA8oHuHgoc4Df3aeZLh91hm9lCKoC3R0kISiHmo96sILH7Pezp+wCiIJNib4pOK5Nwt
 Tm+wJRfpBQeRJzpD4M9wva96f+p9RJUfjfsy4L9CLjgD8KqF1dCLwjlgsh0KGjutoOOlUxHFWMs
 9wd1nVjmbaTJuk4JJF0s9e+17XKlD98vGhPSYUwaZXSXC3KRhxU9tZkUpBkPNiVKzWEBcVZCcQh
 hFVrmlTqixTLle2wMo9MpJIngoeniVvSZpmvnTUXaBGvP4pKuF/jDQTK16DI0vEe9WA6tIBqiK4
 6ZlYtNJipb/KJg7a9YHxB1jSCaO2lSsBPzs7pzkUruWpddbrUjeCGn27IflPmg5p3xf8yv6AWZ8
 R7zHIuQkdX1emMkBhhYohsL03LMG+Xk5QwOCWbAAUqTUXNyMwhtGdfvUgn8ntjx2PLYs02/yNJG
 Pf1CsA12jXbPL8g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_043904_356929_434DB749 
X-CRM114-Status: GOOD (  13.98  )
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

On Fri, 22 May 2026 20:24:00 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 737e7b9366db..065d5af822f7 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -115,6 +150,138 @@ static struct liveupdate_flb pci_liveupdate_flb = {
> [ ... skip 59 lines ... ]
> +		dev_ser->bdf = pci_dev_id(dev);
> +		dev_ser->refcount = 1;
> +
> +		dev->liveupdate.outgoing = dev_ser;
> +		return 0;
> +	}

This loop is compatible with KHO block iterators, as mentioned in the 
previous email. It should be straightforward to convert to them.

>
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> index 6ebcf817fff4..85def616703d 100644
> --- a/include/linux/kho/abi/pci.h
> +++ b/include/linux/kho/abi/pci.h
> @@ -23,19 +23,22 @@
> [ ... skip 16 lines ... ]
>   */
>  struct pci_dev_ser {
>  	u32 domain;
>  	u16 bdf;
> -	u16 padding;
> +	u16 refcount;

Just add refcount to the previous patch, to reduce changes to your own 
code.

Otherwise looks good

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

