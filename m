Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAF6C5AC67
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gz0q4Bj/jbKLsxjzDjzW6S4zyUlfaGH8U1N9wJqf3Pk=; b=k08PnNWuKeyFb0bd43MLk12RO5
	fOSxPoiJF4SyeAXr336ZiRutSoutlBR7W+U1rCnbDbyb/Yf5f0YD2ikmvIOEuNmb/tN4q4xDIVi6a
	0D35N1bZQj8gzIGZyJJQZHFva4GQD801/hi9FmINQNC/3ZyIA/uni85psIQiIQMKxEoR/34SmmrLb
	diN1micZ+04l4GJY2+t+M2UoT7rHrMyIZ6Bz5uraTlf+gs6NlwlZhcFYYa3Z4G4wJHzkMBPwCJ+hz
	emjKYcGHVQvkksbBmKJIq8xcrRfSfMUv0IngsEvW0NXr6hdtpvkeiSQoJzupRXLK5o7YyXGaY+AWF
	yW1ukXTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmlq-0000000E7if-1zgw;
	Tue, 11 Aug 2026 13:43:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmlm-0000000E7iL-0zXZ
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 13:43:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 512E8600AD;
	Tue, 11 Aug 2026 13:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F21F000E9;
	Tue, 11 Aug 2026 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786455833;
	bh=Gz0q4Bj/jbKLsxjzDjzW6S4zyUlfaGH8U1N9wJqf3Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3RiJeIYaWN4UnbzDTXg4ul0AsSy6cgnOcwgiqOsY9P1fZUaTPg4F3Wa3okQup8eb
	 pWRp7XGcWRCz4oCSZ8Fy1UUTZ1tYsaUJ3tt4a7UsJrlqJcjJbzoj4EHnW12V3F+ljx
	 M3Ogs68K4RA92eE897opZbff48XNAYuEAKJOY1D43SaGopLzR6R6yNV3+iZQX4uUQF
	 kKNIc1Sq1FqDfzd7Y6eMzVsNS6yeT7hNsLP8rfcuXyQxUXbcSys1w2pKYrjZIDxQA6
	 cJO9Schn6EhfR55koqs93qaKSc9h1hfto6sAdlorjc3T9WBVYOXZ9sc/GhLpQoAMsF
	 QQDjkEJQn3+lA==
Date: Tue, 11 Aug 2026 08:43:52 -0500
From: Rob Herring <robh@kernel.org>
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] of/kexec: fix typo in comment (usable-memory-range)
Message-ID: <20260811134352.GA2054339-robh@kernel.org>
References: <20260731162739.158320-1-linux@jaseg.de>
 <20260731162739.158320-2-linux@jaseg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731162739.158320-2-linux@jaseg.de>
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

On Fri, Jul 31, 2026 at 06:27:36PM +0200, Jan Sebastian Götte wrote:
> Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
> ---
>  drivers/of/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 029903b986cb..36635f6cb900 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -24,7 +24,7 @@
>  
>  /*
>   * Additional space needed for the FDT buffer so that we can add initrd,
> - * bootargs, kaslr-seed, rng-seed, useable-memory-range and elfcorehdr.
> + * bootargs, kaslr-seed, rng-seed, usable-memory-range and elfcorehdr.

If we're going to fix it, really it is "linux,usable-memory-range" and 
"linux,elfcorehdr".

Rob

