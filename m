Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9E7C7EE23
	for <kexec@archiver.kernel.org>; Sun, 11 Jun 2023 23:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7i5lvxA1UPlINxS8/g6Tc0V2gbnJQZOC/IIz8xsCTNU=; b=q0rLmCHW0vA7HE
	b+Z+kpb5nAT6OhCXCQJIocYlTG8XWh+D6B3l13n9KNSUy2IoW7nk+EGEqpdKrs1df3+U3U0Roc8cq
	oQgy7z/qQqwDw/wwh9ljYRx19fu5N5TrEbOPacLhViMVRTopxnOJylVp9w9RoeQ9mFT2mVhG9R8EP
	1RQFLT/iGM4c7v4gRCpjsQYEOIlMmCUO7tMwF+dspBs07IWr5kG2jTQGTLEHNXKxPUQobBg2DKKl3
	GIGR3RS5VdrzYBJReohT47Z5jn9Sv0YBqFk8k4P+oTQTaOPPIN2sRaXg/GjBDsiK2QenCqkbmhRbQ
	07wawqzvCr9+CDwxMp+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8U8o-001wCU-2N;
	Sun, 11 Jun 2023 23:06:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8U8m-001wB8-0u
	for kexec@lists.infradead.org;
	Sun, 11 Jun 2023 23:06:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686524791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjgfXYOFN5jYOOlMUW18ina9zsTbph6o7zvLiTOdS/k=;
	b=bAdrLoGKvXQIZDJoRJxiJ7nijXTp7wxfAaKAsu1zrtdHPgfuwsxjNVUCwm5o13St75Bl62
	JK/A5GA1eUmNx2v3dvXx663TMEjE7mLZDZS6SExP4dVR+MPa1dcRiziRGaZ5CBZ2wiAAEN
	SxOZ8TDfP7ZAyQougXiTAwD3aUy/0sU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-aVl3TWueNKSnFTzX2a4T2w-1; Sun, 11 Jun 2023 19:06:29 -0400
X-MC-Unique: aVl3TWueNKSnFTzX2a4T2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BF168032FE;
	Sun, 11 Jun 2023 23:06:29 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B90240AE1E9;
	Sun, 11 Jun 2023 23:06:28 +0000 (UTC)
Date: Mon, 12 Jun 2023 07:06:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	horms@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour
 of crashkernel=,high
Message-ID: <ZIZTcEjdJOqXanJS@MiWiFi-R3L-srv>
References: <20230515060259.830662-1-bhe@redhat.com>
 <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
 <ZIW6y9IK+pqMSfoc@MiWiFi-R3L-srv>
 <ZIXayAr6r1tnFQ5i@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZIXayAr6r1tnFQ5i@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230611_160632_386492_432356B2 
X-CRM114-Status: GOOD (  25.16  )
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

On 06/11/23 at 03:31pm, Catalin Marinas wrote:
> On Sun, Jun 11, 2023 at 08:15:07PM +0800, Baoquan He wrote:
> > On 06/09/23 at 08:30pm, Catalin Marinas wrote:
> > > On Mon, 15 May 2023 14:02:57 +0800, Baoquan He wrote:
> > > > In v5 patch, Catalin helped review and acked the patch. However, an
> > > > uninitialized local varilable is warned out by static checker when Will
> > > > tried to merge the patch. And Will complained the code flow in
> > > > reserve_crashkernel() is hard to follow, required to refactor. While
> > > > when I tried to do the refactory, I feel it's not easy, the existing
> > > > several cases causes that.
> > > > 
> > > > [...]
> > > 
> > > Applied to arm64 (for-next/kdump).
> > > 
> > > I reworte some of the paragraphs in the documentation patch, removed
> > > some sentences to make it easier to read (some details were pretty
> > > obvious). Please have a look, if you think I missed something important,
> > > just send a patch on top. Thanks.
> > > 
> > > [1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
> > >       https://git.kernel.org/arm64/c/6c4dcaddbd36
> > > [2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
> > >       https://git.kernel.org/arm64/c/03dc0e05407f
> > 
> > Could you help add below code change into the document patch commit? I
> > forgot adding it and got warning report from lkp test robot.
> > 
> > https://lore.kernel.org/oe-kbuild-all/202306110549.ynH2Juok-lkp@intel.com/
> > 
> > diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> > index ae21f8118830..dcfebddb6088 100644
> > --- a/Documentation/arm64/index.rst
> > +++ b/Documentation/arm64/index.rst
> > @@ -25,6 +25,7 @@ ARM64 Architecture
> >      sve
> >      tagged-address-abi
> >      tagged-pointers
> > +    kdump
> 
> I've seen the warning as well. Please send a patch fixing this as I try
> to avoid rebasing. Also we keep this part in alphabetical order.

Has sent a patch to fix that, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
