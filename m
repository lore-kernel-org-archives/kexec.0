Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247B7C87FDB
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDsjR207hfpsaWUHS9KSTpKCqXr2Odiy8s+8w4yXsg8=; b=rgKgSKjRD4XoXflUdsvvggfsEw
	KqygO6t2KPMGj4zw6ks110tYTN3bYI666Y0TQh9KaT9yqSiCYrs9cWmZinSEANpc7WviHFT9c5PHu
	3BgS4iE7DRkBk47ZLAPv8I9GB6WgQRanF6iAJpq1pQZeYpELtxS3beHIoGjjB4nymvJwh8s3QQqql
	UTmCsntI4wWsjFPHEtbEd46nWkho+Nd6Pe39VL2vyHDrF2H1+4LTzMP84twDk3R0117J+WPYBjYVH
	EbkE9bb755Jh1ziCpCfMX2JaDoQv6vNr+m4Bl4P8QxDLeY8gVaBwEtG0mmUFgVbYDKx8y+ZGgwzmA
	Ig5/YdDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSCc-00000007l6Y-0g0P;
	Mon, 11 Aug 2025 13:04:38 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSAf-00000007kli-1GtU;
	Mon, 11 Aug 2025 13:02:38 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754917355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDsjR207hfpsaWUHS9KSTpKCqXr2Odiy8s+8w4yXsg8=;
	b=h3erkPJ4NkDW+BeSWj3jOZn/ZGUa4FEE9JuMubh7GmQO/xSdORO43i1f2TGCAx7LclvCel
	9dlSMuUFY1QEn6HT3DcCzjXgedPje7ukbnrfz61ShpqJVfIv45A6MRiZdGhCro8cLvyp6D
	Nns5bSv3fC6yDw2+7GfgiiDOnD4QOkCWkSCWfXmFs9kOynD/sBGXLh64QuaDLRatM/IFCs
	xtH/6BUwyJD/fGxHkR50P0Qm0rMTLo9DrbReKCHoMP+DJPKdd3e4OuA1G3zYSVGyhxCeO2
	o9KXEo2+RT/leeWR8ggjPvrIawD5MGG+Y9ALD+MuiZEIFFqWOQwgp9jisrAToQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754917355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDsjR207hfpsaWUHS9KSTpKCqXr2Odiy8s+8w4yXsg8=;
	b=y4Y+tgr88v/UurMktQIBqQoWuoT9Dxmn7FMhhA7sXmj2EIPKrfjmO3mlZzeAu9UuKEfCF7
	lPXqfFmyhCf4qkCw==
To: Coiby Xu <coxu@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 kexec@lists.infradead.org
Subject: Re: [Regression] kdump fails to get DHCP address unless booting
 with pci=nomsi or without nr_cpus=1
In-Reply-To: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
Date: Mon, 11 Aug 2025 15:02:33 +0200
Message-ID: <87bjom8106.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_060237_480640_1BF0EEE8 
X-CRM114-Status: UNSURE (   9.11  )
X-CRM114-Notice: Please train this message.
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

On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
> Recently I met an issue that on certain virtual machines, the kdump
> kernel fails to get DHCP IP address most of times starting from
> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>
>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>      # Provide MSI parent infrastructure
>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>      # Prepare for PCI MSI/MSIX
>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]

There were follow up fixes on this, so isolating this one is not really
conclusive.

Is the problem still there on v6.16 and v6.17-rc1?

Thanks,

        tglx

