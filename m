Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D667ACD4F26
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EarkyJBnDqnFqSO5fYETAhufrAjwPx1wYCTrBDOh/fE=; b=he4pReQqAt80EOyDtE7ICPw9Nv
	FVK8S7YYv0GTzQmrLQ/2xxeZLhJ04oxu756COIxcdmaKaxugsItkqAgRvnGzlVqLatFyvynAFJTkz
	Pt2Sae5Hlr62/pvEzqhsmtYxC9LaHgKFaAypSUfuv7XLH9axwywmiTm2IYqIep5Yf1a0ZXgclDTJG
	Nxt5xhjBoSnKqAiRcybdT81ThZvrJVpD9oq4HnZzCgcHNsWHitk49gAlRLa1rL0zvxPLz6eelISFx
	FU6nrerA+a1jpqk/UyjssvyCtJ7wP4C47vLT9L1EUzNu4i4QxKS2nl22eV0CnWqmuxAB325qBQM8V
	FG01q57w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wby3c-000000063sj-1YNV;
	Tue, 23 Jun 2026 10:08:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wby3b-000000063sb-0LFm
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 10:08:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2117D601F5;
	Tue, 23 Jun 2026 10:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600C91F000E9;
	Tue, 23 Jun 2026 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782209317;
	bh=EarkyJBnDqnFqSO5fYETAhufrAjwPx1wYCTrBDOh/fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hL8dPLl2eSFhMWTGjZ58D9t0L2fZD36v4cEpXmeX2vod1MEQmC7X8hrlRv0Smn/Oh
	 YJ7IK/mRmly7OCs+bJIQSS1HPFID+F5LJKbQ57m5dt9ZW/5NpNSQ4l5Szb1LSn6qw5
	 YJ52BgdHnrD+fKe5ZH37Gme6yEIj9PavF2ydwXFd0OFfGu2ButLzrPmFj4HvfJwAGc
	 +uIn++yZEfbNM7UC6FYTz0/U+AppBVDLh1hVwEbomtV/AcBx5HQv5xbOo5VmijMA/w
	 esMRBseeCQGVHTI+etOiDQSP2BFqrZQvKu5yfamQovWe5a3Fv8l+ocBeSVVf7lzxuf
	 AJj63/YCOy+ow==
Date: Tue, 23 Jun 2026 13:08:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v4 2/2] luo: Update serialized data to use KHOSER_PTR
Message-ID: <ajpbHkuWiGQrUec8@kernel.org>
References: <20260622225736.2961438-1-tarunsahu@google.com>
 <20260622225736.2961438-3-tarunsahu@google.com>
 <178220761164.162773.6384380547612711985.b4-review@b4>
 <9huzpl1h37hj.fsf@tarunix.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9huzpl1h37hj.fsf@tarunix.c.googlers.com>
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

On Tue, Jun 23, 2026 at 09:56:40AM +0000, tarunsahu@google.com wrote:
> Mike Rapoport <rppt@kernel.org> writes:
> 
> > On Mon, 22 Jun 2026 22:57:36 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> >> Convert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
> >> This series also takes care of resolving the bug with memfd of using
> >> phys_to_virt before checking the args->serialized_data value.
> >
> > For easier backporting the memfd fix should be a standalone commit that
> > comes first in the series.
> >
> > Other than that
> 
> It will break compilation for individual patch. For example, memfd_luo
> changes are hard coded dependent on the args->serialized_data
> conversion to KHOSER_PTR?
> 
> Maybe I did not understand, Could you please explain what you mean?

Sorry I wasn't clear. 
If people think it's important to have the memfd_luo fix in 7.1, the fix
should be the first patch in the series and shouldn't use KHOSER pointers.
 
> >
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >
> > -- 
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.

