Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00344C44508
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 06:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GVatgkJkgt1f7n14CxE5fSjwzfbGzAqCHxfBSSq8xw=; b=bYAPLIJiy/JJ893DySpkWLBVEy
	XSzM+l5qBjnGAICHv0vAM8NMVWjMAELMflJ71+uDDYDmLObYAOZZk5aMjum1EuGVVP5jrE/OZE9w1
	ROMsprgxViQg6ZwUifaHtCRPrEmVeVg7ERoXkkcg+lSg0hJOe8oE9qHsOSS5eh8InwZFNzji9MOPa
	ArSSihE1EzgTKP7nPMNhlJbWZ+lj1+W80AearVwPGLcGPybr5+jVijLHktUwyki/zeB6iCamPGvzO
	cCeU+OhPhOdwH05kgNZszB6uoyTj+bqQiNCcy+HOab7BRu1Ax4qly+sl570usjOm0LirZ8z9wp1W9
	IvhfeaXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjsuZ-0000000Drgf-1XQ6;
	Wed, 15 Jul 2026 06:16:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjsuX-0000000DrgJ-0Ytw
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 06:16:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D15EC40553;
	Wed, 15 Jul 2026 06:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE6C1F000E9;
	Wed, 15 Jul 2026 06:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784096160;
	bh=1GVatgkJkgt1f7n14CxE5fSjwzfbGzAqCHxfBSSq8xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E/r6OHEbwq4pdqs8b1RF+NnQK3qU4esSIWQ6dr6wAgOVVon4f2sVQgIfZUvPYQm6g
	 8hHZSzTJrHAb3a4B8bZvYjyh7yIXXvf/Pk6hZmjTiUWj1OaRmd5uf1mF5uDtg0FDTU
	 dbjahm8oevNsb8i5z1FdGWStz54H+cZWCwbSPtpGIrGB+qpkwRnKFYXpGr/lD0iguD
	 zIRkHTRey0NWbmqwqQP2lIzjF3l8oVpW/HyfI5qP8ju/P/hw/AdX2I1XPC5mozS65F
	 8mY+o8a0MXFRKfaUXDiOWufLShLVCcwwV+bn7/bdnlTCwa28hb+XFQ1jSFQUioLQWX
	 1/NY4J/80Tf/A==
Date: Wed, 15 Jul 2026 09:15:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, tarunsahu@google.com,
	skhawaja@google.com, shuah@kernel.org, dmatlack@google.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Make liveupdate selftests library
Message-ID: <alclmQIb8D1td-sw@kernel.org>
References: <20260612214512.464146-1-vipinsh@google.com>
 <ajLtfkuMP4DEGlqe@kernel.org>
 <20260617190754.GC2704872.vipinsh@google.com>
 <CAHVum0dL+p-j1EwQf69p87MU1s8Er9RsOaMMbprFnmNeEdS6-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVum0dL+p-j1EwQf69p87MU1s8Er9RsOaMMbprFnmNeEdS6-g@mail.gmail.com>
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

Hi Vipin,

On Mon, Jul 13, 2026 at 09:49:51AM -0700, Vipin Sharma wrote:
> On Wed, Jun 17, 2026 at 12:08 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > On Fri, Jun 12, 2026 at 02:45:10PM -0700, Vipin Sharma wrote:
> > > > Hello,
> > > >
> > > > This is v3 series of refactoring liveupdate selftests as a library. It
> > > > exposes common liveupdate ioctls as a library which can be used by other
> > > > selftests like VFIO and IOMMU.
> > >
> > > Let's revisit this after -rc1 is out.
> > > I don't think there would a need to change anything, it's just the matter
> > > of applying the patches to the right base :)
> >
> > Sounds good, thank you!
> > >
> > > > Currently, there are no users of this change but it is being used in
> > > > VFIO and iommu liveupdate series.
> > >
> 
> Hi Mike,
> 
> Let me know if you are still planning to take it as is or if you would
> like me to rebase on the latest liveupdate repo.

Rebasing on the latest liveupdate repo would be great, thanks!
 
> Thanks
> Vipin

-- 
Sincerely yours,
Mike.

