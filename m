Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470FBC001DE
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z4BtcF7JHEW9cNEg8lYAQaJoKhSHtrHV6pufxNnCFk0=; b=CgR6iHOpwk60hQ
	qFFFyuxxREn7k/9KmdwAvLryf+s5X/vcGmVOf/TFH8BfzgV3QgxF4Z+nml/eO6dSzC6jgn4ykFIJd
	5vmqRqTJCTCg4i1rWHCQuNNSdX9VUPeOp2pfsV3JZoAv6ThY/RVj3kPulcXEyEzXvsNR3FPKzsrif
	XMubxjGqya2b1E41dCAKiF+i/NRRVPSlt3K7bFtOs951fomHx2QZkmgqABXFzxyFqvUElXL1f2OGM
	q9IFsSOXY0CFRzcRXLL7l1XRFXI1BcybRbGDSwjzxaK3enJBSrm/i/tVzPjZMw1t3eY6836Fyoiuk
	FlPbsJ/go8uRJeDC8oXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUG2L-008z2N-2c;
	Fri, 11 Aug 2023 00:29:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUG2H-008z1O-35
	for kexec@lists.infradead.org;
	Fri, 11 Aug 2023 00:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691713786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DN5IZkA2f/rYjDvMD7mHx04ckTZe8e8MrKMWCEjgSDs=;
	b=PvQwveRqMOOS4XRTBEYxC2Kr+lOPv4Q+5AkhwCMRMRaCwrAwQXaNCUCjCuxdJIyZO7kmov
	nEzFbIEmxBwYTCnsCOM1mZGIF2a6ZAQVnqn0Dvh+volxsrIrLhaxfXyH3jR+nl2sqpQYdA
	3NakUVz1VB+Uh4XKAwA4HTiuBG08pmU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-ehSyu4rrMWKWESBlBNGuHw-1; Thu, 10 Aug 2023 20:29:44 -0400
X-MC-Unique: ehSyu4rrMWKWESBlBNGuHw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3490bc0115aso3302735ab.1
        for <kexec@lists.infradead.org>; Thu, 10 Aug 2023 17:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691713783; x=1692318583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DN5IZkA2f/rYjDvMD7mHx04ckTZe8e8MrKMWCEjgSDs=;
        b=AuMV5ZSEX+wXjgMuHlH71cMdKqyaKwq3lcvciMo5+dW3I0jmdWhnd+LW4JKFmVSBPy
         y5X7EUFPctEn/7xU5cbkOVX4nBZarVLNzVWiPtSpGrUV+XBg7JnhUHrV8sL2tLtuYC5U
         Gxv/sN6IRUiEWrDTZ6KeLVaaYlZ7FjI4Nf/MagC4OuS5EiHmLwWBZE6P4KytfOYEa9af
         EKhGQbmwcUV68EdbQ1POhaHgh106+7mzJrKH8j5zdCq/PtFitRw1xWcoF6Lky3WmHivz
         f6d9DabW3y8QC0V1BqODzJNG7uyjZtA5F59zu5WogIsRVQOq1aUJ4FQfJaCs7ds0W3dx
         P4CA==
X-Gm-Message-State: AOJu0Yz6oUwSswItvF9LP33ah7W0UnTaoVI3go/EOapBcB8ATLtxKFIa
	IYeyxF6DlmWJ9VOiNZZpI+1YtXUdv5F/0PR6xND721AOf8DWz4ZeN0JhC8Bm2y87jtyGjKDbQ/Y
	waSS0lUS8HEJq0PFvMsTS6lmb1NzUqEF4VG6P
X-Received: by 2002:a92:60a:0:b0:349:67b0:6045 with SMTP id x10-20020a92060a000000b0034967b06045mr302135ilg.3.1691713783661;
        Thu, 10 Aug 2023 17:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLMDJaZ74ktwft+rtwTcTi0lgHj6MASDSIUhwh9k7Ci7zJtw3dLvD9ccRNnzTzdgNUAsiL45Grev4AOHjiKRM=
X-Received: by 2002:a92:60a:0:b0:349:67b0:6045 with SMTP id
 x10-20020a92060a000000b0034967b06045mr302121ilg.3.1691713783395; Thu, 10 Aug
 2023 17:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230803024152.11663-1-piliu@redhat.com> <20230803024152.11663-2-piliu@redhat.com>
 <ZNDv7L3lWXZxrmWT@vergenet.net> <CALu+AoS-Df2zrAAHnjHnjc-tZPqGfnme2O-xj28Qofg5JdaR9Q@mail.gmail.com>
 <ZNTUA/+Q2BVkhxHU@vergenet.net>
In-Reply-To: <ZNTUA/+Q2BVkhxHU@vergenet.net>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 11 Aug 2023 08:31:44 +0800
Message-ID: <CALu+AoQNCAb=tm-naV=8jr6yaT3wTyobQBr0t-2aWb2pyCbkpw@mail.gmail.com>
Subject: Re: [PATCHv7 1/5] kexec/arm64: Simplify the code for zImage
To: Simon Horman <horms@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_172950_087225_4AA6ECD7 
X-CRM114-Status: GOOD (  21.99  )
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

On Thu, 10 Aug 2023 at 20:11, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Aug 07, 2023 at 09:26:49PM +0800, Dave Young wrote:
> > On Mon, 7 Aug 2023 at 21:23, Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Thu, Aug 03, 2023 at 10:41:48AM +0800, Pingfan Liu wrote:
> > > > Inside zimage_probe(), it uncompresses the kernel and performs some
> > > > check, similar to image_probe(). Taking a close look, the uncompressing
> > > > has already executed before the image probe is called. What is missing
> > > > here is to provide a fd, pointing to an uncompressed kernel image.
> > > >
> > > > This patch creates a memfd based on the result produced by
> > > > slurp_decompress_file(), and finally simplify the logical of the probe
> > > > for aarch64.
> > > >
> > > > The credit goes to the Dave Young, who contributes the original code.
> > > >
> > > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > > Co-authored-by: Dave Young <dyoung@redhat.com>
> > >
> > > Dave, could I get a Signed-off-by line from you?
> > > Likewise for patch 2/5.
> >
> > I Simon, sounds good to me, thanks!
>
> Thanks, could your respond to the two patches with the following?
>
> Signed-off by: <<your details go here>>

Sure, please feel free to add:

Signed-off-by: Dave Young <dyoung@redhat.com>

>
> >
> > >
> > > I think simply replying to the relevant emails should be sufficient.
> > >
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > >
> >
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
