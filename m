Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE8C001DB
	for <kexec@archiver.kernel.org>; Mon,  7 Aug 2023 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sHmAcPXbgeFzT0csycFnmXFMCLPeE7OAUCyY62PiZqc=; b=zlLpvtYVIslJMi
	VB6UKXpJe7rA5S2I8dZxg6vr+fcikm0hDlrEG3hy7n/n+SBLcPYcUfaXnnNrQayQt3bt8eXXeNDml
	QoWb71KkiIXMK1D/8xVjNG4thLRQaj3YgVYlw9IHobDxsnsnQ8xmDinAC9skW3TcirWNvy6B+zdnc
	18ySbo8KZRLVa4ZXqankNiiy9uqXvjyEsVK/NlEQcKrmkZ/2BfxJSibwYETbv/ZtyxG/vawWul+8w
	dKBK8OiBRDDl2AmkqZQlofsY51WA/uaF08A/1IBywlgIR8y2d3tR3mzPWANOoYpX/ppY9IGONDLe8
	kLtMtYtJ/9Ej0/X9XqWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT0EP-00HNdz-0P;
	Mon, 07 Aug 2023 13:25:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT0EC-00HNTS-2d
	for kexec@lists.infradead.org;
	Mon, 07 Aug 2023 13:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691414695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPKMYVZSRQ486lvxIB6qf4WtXlBzmwylQaAyPXd/rrk=;
	b=IGIIadxNh+B4imthT430Q8ev/BsgQCCL3c0kCbeWysheK2d5tDxKM723Fg+e9Q0HxM0LIZ
	pnVvu5+teQX6G/c93QLgEVODN2FDgI75/dSuNVjB9dfUJllIAysV4TnY4CYJ0DflcOUtyi
	nT6VZgIX09XYPDmS+mM+P+BKNOykYBs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-tszIV5ZsPoulnZZ_r3DRoA-1; Mon, 07 Aug 2023 09:24:53 -0400
X-MC-Unique: tszIV5ZsPoulnZZ_r3DRoA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3490a7d499bso7268315ab.0
        for <kexec@lists.infradead.org>; Mon, 07 Aug 2023 06:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414693; x=1692019493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPKMYVZSRQ486lvxIB6qf4WtXlBzmwylQaAyPXd/rrk=;
        b=SZnefX96HP8XOxKTX5d24H9V9A6xpGsrWj916UDy7w1JPcpyH14yo9m3iB9U/tOLqy
         91qWvIIP5WgmE2ip8a7KePpVnnevmOTCsHU/1ttNrPOg+Ax8U+E2KNtlePRjQN5JnLBg
         mPg107s15Hsw5Mu0tpJMwkUMgKA4UV2nQ1BKYKPpeEzqgRsUtlYhHtosBTHhDW+m4Fr4
         4IfO2+GVzQGYBI2RZLwuHflvfFKyxaZSPubzoc66vMFvUgagIMBaO2bnwE6Q6By2Fd2K
         acNo3jg3Gw3msHk1z1uqHTzBmJhS4h2WTON5q4hStOun5ROMt7jJrDyF2QrwA28IjHH3
         c0Ew==
X-Gm-Message-State: AOJu0YxALqbj10r5veCnJwQYlW2OJH59CxxnM08hSU0SKnyFuGZ01Rz4
	fwjw+2SOaie9gLYTmnBGES2Nfcwjf5CKOIXHsErroIIHaHTLrYzYuZSAk866tAv7NX167B8dou1
	OABmLmJ3D2Sz8LVcp5+zmZBuq6MOfqNlayJyG
X-Received: by 2002:a92:2802:0:b0:349:7518:4877 with SMTP id l2-20020a922802000000b0034975184877mr520750ilf.0.1691414692798;
        Mon, 07 Aug 2023 06:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr4NxoX3Zwn5aiVqcRQMLm59gwaXwCy6Ox8JLmKJbbkVDLRp3kys6o0a3PYcDzCzxPTBgNLaCcS4NZ8mMxFB8=
X-Received: by 2002:a92:2802:0:b0:349:7518:4877 with SMTP id
 l2-20020a922802000000b0034975184877mr520735ilf.0.1691414692563; Mon, 07 Aug
 2023 06:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230803024152.11663-1-piliu@redhat.com> <20230803024152.11663-2-piliu@redhat.com>
 <ZNDv7L3lWXZxrmWT@vergenet.net>
In-Reply-To: <ZNDv7L3lWXZxrmWT@vergenet.net>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 7 Aug 2023 21:26:49 +0800
Message-ID: <CALu+AoS-Df2zrAAHnjHnjc-tZPqGfnme2O-xj28Qofg5JdaR9Q@mail.gmail.com>
Subject: Re: [PATCHv7 1/5] kexec/arm64: Simplify the code for zImage
To: Simon Horman <horms@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_062456_952181_7D93321B 
X-CRM114-Status: GOOD (  18.15  )
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

On Mon, 7 Aug 2023 at 21:23, Simon Horman <horms@kernel.org> wrote:
>
> On Thu, Aug 03, 2023 at 10:41:48AM +0800, Pingfan Liu wrote:
> > Inside zimage_probe(), it uncompresses the kernel and performs some
> > check, similar to image_probe(). Taking a close look, the uncompressing
> > has already executed before the image probe is called. What is missing
> > here is to provide a fd, pointing to an uncompressed kernel image.
> >
> > This patch creates a memfd based on the result produced by
> > slurp_decompress_file(), and finally simplify the logical of the probe
> > for aarch64.
> >
> > The credit goes to the Dave Young, who contributes the original code.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Co-authored-by: Dave Young <dyoung@redhat.com>
>
> Dave, could I get a Signed-off-by line from you?
> Likewise for patch 2/5.

I Simon, sounds good to me, thanks!

>
> I think simply replying to the relevant emails should be sufficient.
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
