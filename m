Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87650C5DF7D
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdBGGRg8n21wLsq1Rr/9aeWOWntBAs5V69fUplLxRqk=; b=sDISMDTOpUtVKj/vo7icUl2RoY
	rZqfV73o4akHk/4d/K4+y5/UzGaRt2YpF29p0H9YxdzuNb6v2CDq+mLd48phbpLYX/fWnKmNPuHOg
	/6CCr0N9F1L+8FyKnZPIsSI0v+/se5FaQO9kUsUcoIJ9+dN5OsfQ6xUzGTG21KH71D/dl/M2wGGET
	Cd3IlA6YR+5w83P4gyBA4ymWKQGa7wJYa3oKA70jHmtZuaMmemQCu/pCpOAiUQgKbEoERGQhIgasf
	rFowCpcqJa4QR/FdKkF1myKxTs3Q7whx3R1qCDAf35DbInfUBCFAPyCZMlD0/vPCHejlphqRJ+nKJ
	8ynMzrHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPrW-0000000DUmH-24X7;
	Fri, 21 Aug 2026 14:04:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPrV-0000000DUlp-2o1b
	for kexec@bombadil.infradead.org;
	Fri, 21 Aug 2026 14:04:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SdBGGRg8n21wLsq1Rr/9aeWOWntBAs5V69fUplLxRqk=; b=lUWczovfKUzf26Ikot7kJ1nGGM
	b5Lsu00SDn2/cJ4AGSZ2WvnohfKViQftWBMtGe55LBVpHWZZgkGrk2HECXUipgTBZRwlZVMg45/fW
	wXfpZ5QWyR+iuUAeHYMX3h84CtqmUBu48GMN40mMXfD0h9mzHCetKOXAv8QBzZNP34/+wtBtpj5pG
	wRpxM53igX1NOpMo1VX7QdmPwSJKKk3VzxdeCc35FG0CucxE4M5TezY1m17gxitJlp03yLqCcGAY7
	lCQKYVpK06dLegNMQjsuGXznMyHUl9Kggp3B4tyyIlRSL9kb8DcPmrV0lzRxV7TZHW9ZXPATIaS+P
	MsRydCZw==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wxPrS-00000003one-3RY3
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SdBGGRg8n21wLsq1Rr/9aeWOWntBAs5V69fUplLxRqk=; b=T7sUuy381KVuQSt4ma4ewlJSTw
	e7l+OZDvXvcr8tEVVR9NJzHPlp2E5/WOGVam1eErJmCrIbBUSvoPajkqNgUanMiTlPkV6F6weqzsV
	UEPbfwuT9WOknpJvCqZSimfzcRZ+IM+6zQBfKHVV6CtFir+a2vmC0D5jhn8vp90zRMxqKdMenoKdW
	KDfG9PHMmg30GcbAW9e1gnuNmqWM5Bvx31mfdSwRPY406L1w5tISz5D68wGxzvQpdq1Mc2pDrOIfv
	gSdhdgyS1EDWs7VYqYGtri5BH1maCKBTVXMTkVfBUISBT5CACU3iLX0u9XD5FAAWn9JGN0EqV7EJy
	tJy0+N5g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxPrE-00BOLF-0L;
	Fri, 21 Aug 2026 14:04:32 +0000
Date: Fri, 21 Aug 2026 07:04:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/6] efi: add the LINUX_EFI_POISONED_MEMORY
 configuration table
Message-ID: <aohavv-xpcNkDP48@gmail.com>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-2-5743791e48e6@debian.org>
 <aog7bwfMVpSy9LcY@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aog7bwfMVpSy9LcY@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_150447_032495_0A54FF0D 
X-CRM114-Status: GOOD (  14.18  )
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

On Fri, Aug 21, 2026 at 12:51:34PM +0100, Kiryl Shutsemau wrote:
> On Fri, Aug 21, 2026 at 03:06:02AM -0700, Breno Leitao wrote:
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 29e0729299f5b..69c0dc02bc112 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -263,6 +263,16 @@ config EFI_COCO_SECRET
> >  	  virt/coco/efi_secret module to access the secrets, which in turn
> >  	  allows userspace programs to access the injected secrets.
> >  
> > +config EFI_POISONED_MEMORY
> > +	bool "Carry hardware-poisoned pages across kexec"
> > +	depends on EFI_STUB && MEMORY_FAILURE && 64BIT
> > +	help
> > +	  Record page frames that are hardware-poisoned while this kernel runs
> > +	  into an EFI configuration table, and honor that table early on the
> > +	  next kernel so a kexec does not hand known-bad RAM back out.
> > +
> > +	  If unsure, say N.
> > +
> 
> Do we want to make it conditional? Maybe just for everyone with EFI_STUB
> && MEMORY_FAILURE?
> 
> Where 64BIT limitation comes from?

That simplifies a bit the maths for memory operations, and 
make them more digestible.

Do we really care about it on non 64 bits platform?

