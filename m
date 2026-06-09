Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E43CD8CAA
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w6VKUC1VUaetCGs5JJDLFKtb8dO63YSohjJ7JwyYLsY=; b=ZDse786T0mD7zvRMfrUcc/GV8O
	iSyCixPXA08LmC5BR0yDY77gpiuWUYATb6JWHkfBGTmdqKfTxB+52hCUl5M+yL2pHHtwztWQzjiZy
	7o12PDdfOrLytwO+i8CrRDrCXWuvaOh1wqB3CYS3cap3ZeRN5vpK/L72cPUwHboW/iZxdEnlSl99C
	B8f+9CCSOBcfegy7XcypYct/Kk9o7X0lJ8JZV3ipos5JAwt6Die+M2h2Wi6aXcY2Brmnw3LSqpemH
	9pzMimP9fnjCIt1CveLSRK5j09vozI5ZZTvXbTft2JpBH1lpgVAP7HBFElSZDITDKnmcRp5LQfe7O
	GeKy1cYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWy7t-00000005s0M-2gJ6;
	Tue, 09 Jun 2026 15:12:25 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWy7q-00000005s00-0425
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 15:12:23 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2c0b1a48855so523655ad.0
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781017941; x=1781622741; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6VKUC1VUaetCGs5JJDLFKtb8dO63YSohjJ7JwyYLsY=;
        b=d81tRmo7Gg3GI8TlXeOqgx3DOnUk2LPpFXRB7VeKPUsIMwRv3hPCknNKwZ4B8GqtLi
         ufjAmp9HIAzhcAKGAKSKoFuPjHVfA9BUlsnwJ5AoR04ltLc6DKR9sy2BYIsrbgeKaeR9
         1/T/jm8nvZQhO8KAEGEj/26p8miHI68oKY70v5zOW/JJKwZvJFyt4Kk6uDtWKJJXgtdS
         KPXsy/LGOTn6Qkv98nx6L6wNB2JS/Jnxr5DnoPmTm1OqEJ2E6ABZ+RuybZCdaCNv2gRr
         Eyw5s0wwAgRbh+73l4vR/SDgAgNaybY/827irhl5am7QkVI3SlZzvCbK63qE2jvc0Cd7
         wgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017941; x=1781622741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6VKUC1VUaetCGs5JJDLFKtb8dO63YSohjJ7JwyYLsY=;
        b=jH2y2XlS/6VtgY7K74x/e7oQaTazRov5s18HOQWomshQNEG00rd5NVFMWy1vQABGpA
         FS/wxFyUn6KOSIQ3z7QKQcwLJMjguOhZrtPbysKAoQeV7qwJyp9tzb2eA/fv/vImZj2S
         0QYR2Faz1EHWoFENqxT+i03Sx+NO23EkBaNIkf19PQQtkdhHu6HxnlyzKsb8FjjBHRCx
         aquildOj0AKsVCf4nNYGrd+ZTI6Z1ZX4CuqcMxv+M6pCpVq5QUXjk7dI9BQXs9xLRTmy
         QIoDRfTmd9dbiDSS+YPdClFMi/Cvd1da2BzdR0B9IJ0OmSBxxEodUBoHUShXO7q1HGjz
         wyDw==
X-Forwarded-Encrypted: i=1; AFNElJ/+peCjSQolFvEjVqJ5vctR4uUFasQyGNz+SSgETdkdeRzzWv/YhtN6MfiI1nozrLyOtK+zfQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyx79HElm7Q4nN6aj8a3Zjc1s4x5iZ77CNwh84hdUASDtn58mOV
	mc2mbDc4MfRxeioSHQmYhIWcLx9IBOQ6x97ks5W7cPdj0grFm9DMhBm93LboEmgCawy5YK/ONt3
	SRBAv+nsI
X-Gm-Gg: Acq92OHgDc3j/vMpNEj9ttXX1+/cwYq73sJ/s3uch1aZYyLLTRd6Z75uP+t970TFgFN
	DluZb8tBmI0fodyLDVEnZb+ZItEpYC6qvCEHZUsWRHKhPS4Vp9C7GOkF0gE3jBuojSxkiexi2Uq
	knRAoJDxYuYBLLkntSTaLaD3Y1d25wJrPuS1vDMAQpeJtHRAEliE2mbJirHE6s67ese29COqTt2
	x2gLHkwvEY43nRucBsQrWphh6hsTELdGHzKuMBw9k/r92dQn+k60QYlpdF7ea6EmjXum/V5VNiO
	hzSFZwu6R2Ke9SnLxr39lzfsK8PXJzV85tbjAoC2UsXwS+BzFRobX/ZmYDsrEXeb3uAnJaSPAjt
	EICgTE2FJFZIvkK9v1vbLnsWYgf+SusSmE/fvRZcf8piiXJPDgi2C3G7CAFkCQ3WcaZBxBGf/En
	C4orRibLBeWDHB1lkFjtg0TJY93HJFeXPG4irQJT4Z/QStvwIeyd4xiXkYrrToc4+t/X4zDW0=
X-Received: by 2002:a17:903:19ed:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2c1eb942782mr7408845ad.10.1781017940616;
        Tue, 09 Jun 2026 08:12:20 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d40asm208599735ad.64.2026.06.09.08.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:12:20 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:12:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aigtS3UDdhUGp3m0@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aiaeOVomxQZhoM3K@google.com>
 <20260608181640.GO1962447@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608181640.GO1962447@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_081222_279332_A2FC1F80 
X-CRM114-Status: GOOD (  14.36  )
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

On Mon, Jun 08, 2026 at 03:16:40PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 08, 2026 at 10:49:29AM +0000, Pranjal Shrivastava wrote:
> 
> > My point was that a FW exploit can meddle with the bitfields of the
> > ACS_CTRL to spoof and mis-report the ACS flags.
> 
> Devices can also ignore the ACS flags. I don't think this is an area
> where we should be worrying about devices being actively hostile.

I'm wondering what happens if we preserve IOMMU groups across a kexec,
but a switch's ACS capability is dropped or the ACS_RR bit gets cleared?
The incoming kernel assumes that it's the same ACS cap from the old one

Now, the incoming kernel restores the groups assuming they're still 
isolated, but the hardware no longer enforces it, silently allowing DMAs
& breaking isolation? 

Thanks,
Praan

