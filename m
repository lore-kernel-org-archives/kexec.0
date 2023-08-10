Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5BCC001B0
	for <kexec@archiver.kernel.org>; Thu, 10 Aug 2023 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VNIu3vA8RvfmXW9M1sf0lSkOwgxl+j08vqBNt6UTr7Y=; b=tq03C9FlAmclpq
	2GNTwIISsOGPZRn4n6oRK3mX7rvGgFfDUl22So1NZO51BQZ0lT9VnhSjXouzKQ4jMkVfL4Wa3Ewto
	ITS0w1RwuDg0yoOHzw682WsF8e6j40eNZKzNWkx1qUudykjTyzyr93y0xux4nZLCPJAl51Z7pUo/L
	HeKdymGl4fq3wcLr01MkNLPYarpyUoGlWVTdnrNE1C2CY1pKzdQJUVWRlDHN2VC9UWI//qm1TAlet
	47Gxgn/EMbmAAZKoL3zGmwV6pAkYAyXfqRyHgSpMT0YnmWXXd1sYB3nZGldRPZl0jaEtVn2VXYE6s
	Wa39JCEQ2q2ar9rctFIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4WD-007YVQ-37;
	Thu, 10 Aug 2023 12:11:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU4WA-007YTx-0F
	for kexec@lists.infradead.org;
	Thu, 10 Aug 2023 12:11:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 871AE64E38;
	Thu, 10 Aug 2023 12:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF3AC433C8;
	Thu, 10 Aug 2023 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691669512;
	bh=BZkxd87xhJTFgPiO4ysqyllB5xF1mA/lPNQ3hSa7zmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emqL3Eo3cEzohBDRXIQL2OiaDwqarxSMspMcyaJhACwxExk3/4S9cEjvXYowHW2LM
	 XZtwCZoKZ/g0HnNllGna4K67ICcpiGzIbY9TgQbwA+pghfcaFO4Vs+MlMuyPGn/wop
	 X5r2SfF96eS50+0JHtzuL8iln/CzO9wB+squUd0RzfZQqaJi5bT0v70hc5fimLpjiF
	 k5MZrJIzIFafZlRuMC4wwju/qwe3S9nrHSwApGvs/1VdnIL13dOdOWK4Rv7eWRNM7Y
	 hdSqcS7WPW5Q68zg8MabUCJAuOAJCBv/drHSoz8dy/dHHUvodMLqv8oyL0i/AAHbXS
	 eEEEtr9spMI5w==
Date: Thu, 10 Aug 2023 14:11:47 +0200
From: Simon Horman <horms@kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Pingfan Liu <piliu@redhat.com>,
	kexec@lists.infradead.org, ardb@kernel.org, jeremy.linton@arm.com
Subject: Re: [PATCHv7 1/5] kexec/arm64: Simplify the code for zImage
Message-ID: <ZNTUA/+Q2BVkhxHU@vergenet.net>
References: <20230803024152.11663-1-piliu@redhat.com>
 <20230803024152.11663-2-piliu@redhat.com>
 <ZNDv7L3lWXZxrmWT@vergenet.net>
 <CALu+AoS-Df2zrAAHnjHnjc-tZPqGfnme2O-xj28Qofg5JdaR9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoS-Df2zrAAHnjHnjc-tZPqGfnme2O-xj28Qofg5JdaR9Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_051154_154009_4DB16DC9 
X-CRM114-Status: GOOD (  21.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Aug 07, 2023 at 09:26:49PM +0800, Dave Young wrote:
> On Mon, 7 Aug 2023 at 21:23, Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Aug 03, 2023 at 10:41:48AM +0800, Pingfan Liu wrote:
> > > Inside zimage_probe(), it uncompresses the kernel and performs some
> > > check, similar to image_probe(). Taking a close look, the uncompressing
> > > has already executed before the image probe is called. What is missing
> > > here is to provide a fd, pointing to an uncompressed kernel image.
> > >
> > > This patch creates a memfd based on the result produced by
> > > slurp_decompress_file(), and finally simplify the logical of the probe
> > > for aarch64.
> > >
> > > The credit goes to the Dave Young, who contributes the original code.
> > >
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > Co-authored-by: Dave Young <dyoung@redhat.com>
> >
> > Dave, could I get a Signed-off-by line from you?
> > Likewise for patch 2/5.
> 
> I Simon, sounds good to me, thanks!

Thanks, could your respond to the two patches with the following?

Signed-off by: <<your details go here>>

> 
> >
> > I think simply replying to the relevant emails should be sufficient.
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
