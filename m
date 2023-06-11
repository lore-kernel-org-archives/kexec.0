Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81980C7EE29
	for <kexec@archiver.kernel.org>; Sun, 11 Jun 2023 00:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1L7LQjdMEtGq604ozcIRyFmixHGta5tzUpWgwOqOS2w=; b=Yx1PBIzilYyRMR
	6TeqtFZyyRhdL3b+cY6auL3E3UqYjHUVG0AY71m/KLdIrJpvWd4jMeD2Cj7EWKbJE9whQk9VE7mcb
	8PosYvsIYqj/d7MJ41BdZ2Qx0tFxT0vYXJpSVGOZrogi8rPf+fZZjZNRL3GZPfhhfjMbfTqrwrko3
	HwRWrfr1NoY5V4qRmuwdObRGH4gZIl6k0laYgQArexYRbN/mJy0oCrT1XEJNLPGrAvi3BNYCnCLoU
	/pGeFJKu4oaUa/WRzlLUkG3oYyg47GS2Dk6O8OuMfVVnl4+aSZvw7bmKLdtbgocS6HJ8ajC0bUz6D
	zdPQCOqCjlUA1k0/3kRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q893z-00HKsS-2p;
	Sun, 11 Jun 2023 00:36:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q893u-00HKqH-1y
	for kexec@lists.infradead.org;
	Sun, 11 Jun 2023 00:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686443764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x89zI7MJ/ts8FOURhFSOQ5PbYCpR9HHm1ievjVbGHuc=;
	b=Q7cFU0egNWI3xpM7Ntfbvwz7I0TL0rbeyTtHBol5oFI21ZvC5GvinwOIgn59Z93pRfVfgR
	+zZdXs2a+O+EDiijkpY0BgTwrE3zfLUxqBUuWWP9J4rRwEv4NTfl1yixADOJ5ltTIk81i1
	XW/utkr1q7RYrttAg2RFe7li0mPc+sY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-Wf-VQU6rPy6HqqX_SbNZbg-1; Sat, 10 Jun 2023 20:35:59 -0400
X-MC-Unique: Wf-VQU6rPy6HqqX_SbNZbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EAE1811E78;
	Sun, 11 Jun 2023 00:35:58 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E738140E956;
	Sun, 11 Jun 2023 00:35:56 +0000 (UTC)
Date: Sun, 11 Jun 2023 08:35:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	horms@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour
 of crashkernel=,high
Message-ID: <ZIUW6Ho8Wfz5XoZV@MiWiFi-R3L-srv>
References: <20230515060259.830662-1-bhe@redhat.com>
 <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_173606_856041_4C0EA181 
X-CRM114-Status: GOOD (  16.39  )
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

On 06/09/23 at 08:30pm, Catalin Marinas wrote:
> On Mon, 15 May 2023 14:02:57 +0800, Baoquan He wrote:
> > In v5 patch, Catalin helped review and acked the patch. However, an
> > uninitialized local varilable is warned out by static checker when Will
> > tried to merge the patch. And Will complained the code flow in
> > reserve_crashkernel() is hard to follow, required to refactor. While
> > when I tried to do the refactory, I feel it's not easy, the existing
> > several cases causes that.
> > 
> > [...]
> 
> Applied to arm64 (for-next/kdump).
> 
> I reworte some of the paragraphs in the documentation patch, removed
> some sentences to make it easier to read (some details were pretty
> obvious). Please have a look, if you think I missed something important,
> just send a patch on top. Thanks.
> 
> [1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
>       https://git.kernel.org/arm64/c/6c4dcaddbd36
> [2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
>       https://git.kernel.org/arm64/c/03dc0e05407f

Thanks a lot, Catalin. The rewriting looks great!


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
