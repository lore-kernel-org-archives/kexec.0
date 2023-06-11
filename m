Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E6AC7EE23
	for <kexec@archiver.kernel.org>; Sun, 11 Jun 2023 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cVFuwUOo2vek1AjsNUZENow/WZFah3ZDbD31q0eAzyo=; b=my5tuJ9yk8H4oL
	G9Oz3OIJscf2VdBMeBd9nftMICEIetRwLpmMbu4kDXqJD9DPK0G275NWr6GT5H8PrPw9d5n8EllSN
	fCFPH2qCIwmViIjyzlDpSOe9HJaw/53h6G44onpA3rXV5gjWcVdvbKIALQqbxAKErZTonSYyKgHF6
	CShwVWFcCcSRONiWGfQFqODxkv4XNB3jJIOK50Z5qHBKqBDYdzxuVBfumIMaHBdPV6anKqDf3ZDiu
	0xRtP4FDpP6+j+D6+v9BaUqcMhUQ04avwYd6ORsrT4xjsLFgQKdBnTAku1qG9AnaI5DGPSHYvuNWk
	qFQ/Z8pasa4+/NAGwQIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8M6g-0017sn-1j;
	Sun, 11 Jun 2023 14:31:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8M6c-0017sF-1n;
	Sun, 11 Jun 2023 14:31:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 82EC361005;
	Sun, 11 Jun 2023 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82045C433D2;
	Sun, 11 Jun 2023 14:31:39 +0000 (UTC)
Date: Sun, 11 Jun 2023 15:31:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	horms@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour
 of crashkernel=,high
Message-ID: <ZIXayAr6r1tnFQ5i@arm.com>
References: <20230515060259.830662-1-bhe@redhat.com>
 <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
 <ZIW6y9IK+pqMSfoc@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZIW6y9IK+pqMSfoc@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230611_073146_661171_E1977ED1 
X-CRM114-Status: GOOD (  23.31  )
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

On Sun, Jun 11, 2023 at 08:15:07PM +0800, Baoquan He wrote:
> On 06/09/23 at 08:30pm, Catalin Marinas wrote:
> > On Mon, 15 May 2023 14:02:57 +0800, Baoquan He wrote:
> > > In v5 patch, Catalin helped review and acked the patch. However, an
> > > uninitialized local varilable is warned out by static checker when Will
> > > tried to merge the patch. And Will complained the code flow in
> > > reserve_crashkernel() is hard to follow, required to refactor. While
> > > when I tried to do the refactory, I feel it's not easy, the existing
> > > several cases causes that.
> > > 
> > > [...]
> > 
> > Applied to arm64 (for-next/kdump).
> > 
> > I reworte some of the paragraphs in the documentation patch, removed
> > some sentences to make it easier to read (some details were pretty
> > obvious). Please have a look, if you think I missed something important,
> > just send a patch on top. Thanks.
> > 
> > [1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
> >       https://git.kernel.org/arm64/c/6c4dcaddbd36
> > [2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
> >       https://git.kernel.org/arm64/c/03dc0e05407f
> 
> Could you help add below code change into the document patch commit? I
> forgot adding it and got warning report from lkp test robot.
> 
> https://lore.kernel.org/oe-kbuild-all/202306110549.ynH2Juok-lkp@intel.com/
> 
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index ae21f8118830..dcfebddb6088 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -25,6 +25,7 @@ ARM64 Architecture
>      sve
>      tagged-address-abi
>      tagged-pointers
> +    kdump

I've seen the warning as well. Please send a patch fixing this as I try
to avoid rebasing. Also we keep this part in alphabetical order.

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
