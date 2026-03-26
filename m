Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C55D106F30F
	for <kexec@archiver.kernel.org>; Thu, 26 Mar 2026 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEjf138xK5eE7YCgAWz9t5p0xv1RKe3kiMDhSCQ84c0=; b=BXrAHA3BXqBcXqVHRbKw5OlUlj
	zKVi1BWAH0+roXz5Jxzn1UsIVa9BfXK5erxP1UlbkVAOUm/l9kZ3qB9yTEs/iJwgt9bgWxN05CcY+
	yFcqx1/epg5ksLe4XshHND4/3tKy+MhW1nTmjqoQDq6rcMMZer10RKW9fzvZC9/rEipmSySbIGdzx
	nm4zYESjYTrttpUcHMokN1FtwjTHXRaA6XfZ6FXCcSkHUFiJZ9EZmdZoO0RKBEF5NP4qcLGGsq4nX
	yKc/FbREcFECJFSR4QmLgEnZ10IlJ2uxh+cPxMTtPGriwOIU6Z94kcZQlM42G4QwwNUpcHDuJP6m+
	2dvmFD2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5grH-000000057wS-2rgF;
	Thu, 26 Mar 2026 09:18:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5grG-000000057wG-3oSz
	for kexec@lists.infradead.org;
	Thu, 26 Mar 2026 09:18:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CBF6A60053;
	Thu, 26 Mar 2026 09:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBECC116C6;
	Thu, 26 Mar 2026 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774516709;
	bh=/bCzqTTRsxypcnV6uFRndogSJYo9EXu8deYZEOzzRE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nInQ7EEofumA+5b/diIf+9MN/nNqLVykcabEDbj3vaX76/0q+EY+rmtMmg89ch+oM
	 IWvB8HR3Gc2nwqvpMfs4W01nwBrRREQ+PImHogdIruFMlC+GtpuaT2eJ8dD4ePc2FN
	 j2MZgTcWdIbnW6Y/JTOd9KX9OJvWLy4Jt5MR4v0yGB6qwLcYlWWKpw4oSqaFLSNy0w
	 Kq332mRxa27usVlk6+Efa/ylcu4QwjX0T3qsHEeNgqwfajNPv5jSZ/3ei5fI7w7aMV
	 VfdUymBgM5/DJiZ2JQ8h0f2chGy14eYhZ98VgmsaYrPj4/zv1QOuwfawGIJ7RiPby7
	 lbFKJQaSpTdGQ==
Date: Thu, 26 Mar 2026 11:18:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: oskar@gerlicz.space
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/5] liveupdate: tighten handover cleanup and session
 lifetime
Message-ID: <acT5354RhFpOm-qU@kernel.org>
References: <20260324212730.65290-1-oskar@gerlicz.space>
 <CA+CK2bCiqCg1Tt0WgP3KszrK96Qahcgfyfige4eUQOkMVyLUqg@mail.gmail.com>
 <7628da0465cd09bfc16bf9353f37045c@gerlicz.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7628da0465cd09bfc16bf9353f37045c@gerlicz.space>
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

Hi Oskar,

On Thu, Mar 26, 2026 at 07:47:03AM +0100, oskar@gerlicz.space wrote:
> On 2026-03-25 14:38, Pasha Tatashin wrote:
> > On Tue, Mar 24, 2026 at 5:29 PM Oskar Gerlicz Kowalczuk
>
> Hi Pasha, thank you for the detailed feedback and for sharing your patches.
> I understand that my previous version was overcomplicated. I will rework the
> series to follow your approach and keep the changes minimal. I plan to send
> an updated version later today.

When you are resending please make sure to avoid deep threading of the
replies so that all patch emails would be In-Reply-To to the cover letter.

> Thanks,
> Oskar Gerlicz-Kowalczuk
> 

-- 
Sincerely yours,
Mike.

