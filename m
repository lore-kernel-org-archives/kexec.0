Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC85C5321D
	for <kexec@archiver.kernel.org>; Mon, 26 Aug 2024 05:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jKX60J60+Cb1YyOTf6BPr7jdNeFUGA3kxnej/m1xFGs=; b=qjqdIxkHLp1uy6
	jxz7W4X3BRxc5sHVFCR/nNzhMZcbpnk1A8pTvOGHUUHlZ257+fGhtQrRiuiIdJ2/MScg6cvLpYL6G
	mNP7D1NI2U0JxVkaQNezAFgK1m/owZuMpRpo7Go++a/OlP8GNFnfoL1n7bNSDjEh5fZ3GAKjmJjGx
	TrUGIQcR4/iRfUiHhkknfT8UbDA3Ab8uYdZ/U/+OUct+t2CphN9+VsbxWeEFcZh8wBFl3tTU2Lrx8
	gyfkFIusNU7s73Esgjdr8LKkDEGYkiqr6tbTISoZp8KuNnx+ZwCPKwaUPstVULg2eurrgUddf0EVJ
	+BnQOy2VW6Ed5TGRSWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siSRo-00000005txg-2o48;
	Mon, 26 Aug 2024 05:39:24 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siSRl-00000005tsZ-3768
	for kexec@lists.infradead.org;
	Mon, 26 Aug 2024 05:39:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LfT86w0DD1Bxg2yTlCdTPH77SKbVGJZWodC7UbCGiEE=; t=1724650761; x=1725255561; 
	b=lgPZFx+v+wmopOAciUPCv9wuBGj8UKVlzg+i7BMs0sg68fspFmbsZRsCIyeABlBKLEmWj9oq/2I
	xwuSAsWdAn4vkDhWjakO75P8Vx2mjNc+DxNecEpzylbphLpfZ6VvS73nJch3Wo7V7qT35NoH78pYQ
	6SO2bNn+131RCIM9Y932jPPqhB7CvQk+sUumwHuMPSfG1yaXCNSbgZc5Nv9ppEEWLv331ncpbJHZP
	79m+3Wgv6HXrpOJAKGtTVbBkX5/4bf6FKlsl1RFiyaAX3p/7+Num6/5oBxa8wFiQh6luQ83/Kq2ky
	ap7slG8PEh65rCKBHSmfu4Lmp+VDG+VD4myA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1siSRK-00000003X59-0z93; Mon, 26 Aug 2024 07:38:54 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1siSRJ-00000002r7f-46hv; Mon, 26 Aug 2024 07:38:54 +0200
Message-ID: <c1fd73a3941c54e58420d7555524cd6baeebfb96.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven
	 <geert@linux-m68k.org>, Dave Vasilevsky <dave@vasilevsky.ca>
Cc: bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
  kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Reimar
 =?ISO-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Date: Mon, 26 Aug 2024 07:38:53 +0200
In-Reply-To: <87frqsghws.fsf@mail.lhotse>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
	 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
	 <87frqsghws.fsf@mail.lhotse>
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.191
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_223921_957368_A2DF2A92 
X-CRM114-Status: UNSURE (   9.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Michael,

On Mon, 2024-08-26 at 12:02 +1000, Michael Ellerman wrote:
> > What is so special about CRASH_DUMP, that it should be enabled by
> > default?
>  
> The reality is that essentially all distros enable it. Because they
> don't want to manage separate kernel / crash-kernel packages.
> 
> So IMHO having it enabled by default in upstream does make sense,
> because it more closely matches what distros/users actually run.

Well, at least Debian did not enable it by default as otherwise we wouldn't
have noticed this change downstream.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
