Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F33CCFA1A
	for <kexec@archiver.kernel.org>; Tue, 11 Nov 2025 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YbfoW4FusG0fMg0vzSwpYZqdO9J6D1921sMzomHWarI=; b=Cawbmo8eclvwFomm2H/H61e3fV
	yCgvPcrAr6d04abk/Wx0sbjeQhbFjIGaKjG55P4X6OYeZcJxq7KUru1VWQxbl06lwqGYuej9mpRyU
	GajLlt3a6jQiAaehN1tc26RVZYg1adKbh8j6RE9UIHZY/nvHJiA+3oyIZYJtCa+OshEaK2kV1uIt+
	nSw48bQamIgNa0sPItezmV+I4uCGBZoeDNJsLTsMjtnijRbsFyWHr3CUB9sPgsK/c9hfB9df6pw5V
	nbG3cHpnDrurPJ+BDC2xeSiDPmtq3W+qQbGvR5DPxp4LaqrSa9vFnD9cFZHI/gchL9wLmwh+Y0XIz
	3QuD5cDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoaT-00000007FkY-14uh;
	Tue, 11 Nov 2025 13:39:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoaR-00000007Fk5-2yD6
	for kexec@lists.infradead.org;
	Tue, 11 Nov 2025 13:39:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C3C1E4198A;
	Tue, 11 Nov 2025 13:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7EBC16AAE;
	Tue, 11 Nov 2025 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762868346;
	bh=wejCjjZmabYzoXepvMTC7JiV8b2MvZtIZQZww7RPGpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uu99aoJg4UPNnbkWf0GpfQZ9XcyB3nP/cYeyAJHpl2ehlbbRuiEmkx8WuK4FLIzWI
	 h/49rfhFPDXFZCrmb84iNSgYcAsYsZCukBavHIh7V0/cR3UZ7REoP83x5NgLDVMxf4
	 dRddq2jvvsmFiFqwOGrl2NbvmsCH70LhSl0BCkeezt/8rU96ndR0JtPgpWtks4h3m8
	 9T/TLN2TyEg+AMozXi/r/4DjKl6AijhwcOhogey83HDQ2VSB87xnoMPGw0BVWRI+xO
	 LKQ7VhNM6ZNZDNM/ITPdudiHKlrM5lPgzV05O3E0ExoYHWhlPfCsoecAiVqVGdLoE4
	 NdkJUZVrOGsdA==
Date: Tue, 11 Nov 2025 13:39:03 +0000
From: Simon Horman <horms@kernel.org>
To: Mason Rocha <mrocha@turretllc.us>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools 2/2] kexec/ifdown.c: Hide error if sockets
 are disabled
Message-ID: <aRM8dwyYJSYdsqri@horms.kernel.org>
References: <20251022020703.14200-2-mrocha@turretllc.us>
 <20251022020703.14200-4-mrocha@turretllc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022020703.14200-4-mrocha@turretllc.us>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_053907_784299_671917B2 
X-CRM114-Status: GOOD (  17.11  )
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

On Tue, Oct 21, 2025 at 09:07:04PM -0500, Mason Rocha wrote:
> Prevents the message "Function not implemented" from being logged when
> a system with networking support disabled, as there couldn't possibly be
> any interfaces to bring down to the point where we need to make sure the
> user knows that the interfaces were not brought down.
> 
> Signed-off-by: Mason Rocha <mrocha@turretllc.us>
> ---
>  kexec/ifdown.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/ifdown.c b/kexec/ifdown.c
> index 6a60bcb..e6ea0ae 100644
> --- a/kexec/ifdown.c
> +++ b/kexec/ifdown.c
> @@ -32,8 +32,10 @@ int ifdown(void)
>  	int fd, shaper;
>  
>  	if ((fd = socket(AF_NETLINK, SOCK_DGRAM, 0)) < 0) {
> -		fprintf(stderr, "ifdown: ");
> -		perror("socket");
> +		if(errno != ENOSYS) {

nit: I'd prefer a space between 'if' and '('

     I added one when applying this series.

> +			fprintf(stderr, "ifdown: ");
> +			perror("socket");
> +		}
>  		goto error;
>  	}
>  
> -- 
> 2.51.0
> 

