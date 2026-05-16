Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB6CD4F21
	for <kexec@archiver.kernel.org>; Sat, 16 May 2026 06:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMWN5x9HDweBHTWqub8cOMnSL0hVe7z+jiQtlb1v9fs=; b=0/w+ObWmSXd2g9Sou5xubygwjW
	eWhwwd4E9gXgooqawr8UuBzKNz6evNa0q9439uDrD6xjpXDA6EUywSKddXXpRgGjnEObW5AwBmwv7
	XP3rCwQ3TP4COJMH/emBXzdeLY5uXo7RaU/Gf0EvKwl5vgT8DSPoj4Pt65i9vrb759Le/c1yi/yYv
	pELJwYCBUHoBfa5nkVoHMD0N/kQuBB8S83YQayN11QNbDFUNDExCUOammSoaqo4lQVluyVgMKAirn
	CHnH7mOm0sMPQmB6WLtKt1SycO4VJDtMoRl1gcm5Jzo0dP4IHuRe+TBJWP5l0Z1NZiPm2AM+ynvta
	JxGUjlsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO8WW-0000000AH3W-3B4e;
	Sat, 16 May 2026 06:29:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO8WV-0000000AH3G-2KvW
	for kexec@lists.infradead.org;
	Sat, 16 May 2026 06:29:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9883560138;
	Sat, 16 May 2026 06:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A321AC19425;
	Sat, 16 May 2026 06:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778912958;
	bh=ZR5pqbdOhcWFPqqwmv82cPJPye/uvugLSCbv0N6QbM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwi8CWz1w5ulb9PLUPbHTEbs7y/Vl34wzfo8Pk5rUkyASU1oH1tNbT4rLipp1CFD+
	 TiRaqXn6F7l932ffIUus35HrPUrYo46R4gXuactMgmhQFXLmmdFpfCp8QGB1Fa4S4/
	 /Rhb5r7+d5erAUBioXwR1gmQ8n4UX8fLxqLWxWI8bZcBglSQsMqpPesGE8NuJ4K/I8
	 sHZ69prfFbUPzBHJ2huJxsbU3Qvhl+U+kA1Lbq+Y89xOmI0YgZ0fQpywauBhpOZ52M
	 KTBmFV7gwhlJsR43/4aadxCi6KUWs6ypjY9J7+Jc94r/Y9zO6JvA4N782iX0r3SQrX
	 lf0KanB+MQDHA==
Date: Sat, 16 May 2026 09:29:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pratyush@kernel.org, akpm@linux-foundation.org, graf@amazon.com,
	guodongtai@kylinos.cn, jasonmiu@google.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, liukexin@kylinos.cn, pasha.tatashin@soleen.com,
	ran.xiaokai@zte.com.cn
Subject: Re: [PATCH 1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
Message-ID: <aggOtl4HUcph3VSF@kernel.org>
References: <2vxzcxz2dybi.fsf@kernel.org>
 <20260513150718.182224-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513150718.182224-1-dongtai.guo@linux.dev>
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

On Wed, May 13, 2026 at 11:07:18PM +0800, George Guo wrote:
> Sorry for the late reply.
> 
> On Mon, May 11 2026, Pratyush Yadav wrote:
> 
> > As of now, we only support KHO on x86 and arm64. Are you working on
> > supporting it for LoongArch? What is your use case?
> 
> Yes, we are adding KHO support for LoongArch (16KB page size). The
> LoongArch patches are being prepared separately. This fix is a
> prerequisite.

I massaged the changelog and reapplied this to the liveupdate tree:

https://git.kernel.org/liveupdate/c/d13dfb48dfa3

-- 
Sincerely yours,
Mike.

