Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310E8C44501
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y55nI1Ok7fM+U8y9cIFWgGXKnToo2A+uyePQEWytnVE=; b=TbTyAGOx5ihUccEQmlTvq7/6Fr
	/PVXJcG/lO2GORh/VBVfxQpE3Car3AjGQ18PJ5qM9dRS1C76NYzMRMpRRbtTe5BD2wOVV4yjL8tgh
	tkP0D8viwPJ+liNQ4WuLvYW/GqJYJZlE5hTidubRdNFUF7W3+4SB2R8MfnQW00B9XSrYlwU2/T6ij
	TZ0AM6tvu1svt7MdR+thO8WlzBaxS7wA3yQ7WMFE4Y6Dbvc96sFt3SETgmgSqypB7bfEjqleFElOL
	75VLgy8Gw8WXQ27nRmeLbg1+Kf5Alc15m5gw+h3RjjwtgNob1AiHAWoTKT85rZW3d5fbTKMvOarBy
	h9MPOIWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjGjg-00000009PPg-0mWt;
	Mon, 13 Jul 2026 13:30:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjGje-00000009PPJ-2lH4
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 13:30:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 32434407F7;
	Mon, 13 Jul 2026 13:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13F81F000E9;
	Mon, 13 Jul 2026 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949414;
	bh=y55nI1Ok7fM+U8y9cIFWgGXKnToo2A+uyePQEWytnVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q5iUkvZYqzjlyItBZSQs72cXBEFcBC6KauNPN4HaVAXqDyVYB7tuRnW/mEh3pKo6V
	 Kt6AOxKbG9WUHR+epF5/U97YkpkB452SpIB6HQU3PVgmqlQ1NZSl0/2MRydlLhBGzW
	 41dJnT3F7lHEgwLb/4E0dPTRvd4AXULvqZ3gp93nvs+jX2MmIGwFcnN9rUpLLHIng7
	 oRGcpJGaPD1/btt0cDsll+Ylyyay3qlvg1BtQW5XLLcnMiud+NNedHt+qdDBmzNgaF
	 8cjGJiIHQ5pChSfr3+1oJ2Y3v/tVXhzkb98cZ0yOYvhqfZ++dzZzIQkH3t2zOFf4K7
	 G+N0e0uhg+57Q==
Date: Mon, 13 Jul 2026 16:30:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Dave Young <ruirui.yang@linux.dev>, Coiby Xu <coxu@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guangshuo Li <lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] crash_dump: release keyring reference at the correct
 time
Message-ID: <alToXtwJ3Jg0rZu8@kernel.org>
References: <20260704112509.3717884-1-lgs201920130244@gmail.com>
 <178392639372.255896.15219634537212682820.b4-ty@b4>
 <2vxz7bmzkqot.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz7bmzkqot.fsf@kernel.org>
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

On Mon, Jul 13, 2026 at 02:41:06PM +0200, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Mon, Jul 13 2026, Mike Rapoport wrote:
> 
> > On Sat, 04 Jul 2026 19:25:09 +0800, Guangshuo Li wrote:
> >> crash_dump: release keyring reference at the correct time
> >
> > Applied to kexec-fixes branch of liveupdate/linux.git tree, thanks!
> >
> > [1/1] crash_dump: release keyring reference at the correct time
> >       commit: ada2e5a44e99113e08ad9b7b71396c6c572204da
> >
> > tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
> > branch: kexec-fixes
> 
> For me kexec-fixes points to v7.2-rc1 still. Did you forget to push?


Yep, thanks for the reminder.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

