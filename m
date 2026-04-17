Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69126F99C63
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 21:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QIFmiMDTeP/Oqc+nqvJkfeXsIdepM88Xx6p9HfnIkCU=; b=0qvQ5hI7b2qTJU+n7UFVgHYdr1
	TAnAETtf1FMJDdHNNFbwJCSEfHX10el9xBMsFt/x5klBfPS6Wwr7Ys5XngY1aP0xzIlyJXnqYtzmc
	4hIwnMFjHNQzr7Cm89eXeW9nh4McggbGNn8T8Lq+Ym8JOEMT4UmpkeFSPVRTaPQYuB4udGd5jKFci
	z0qj+9YNzjnBEjLMPVjGKJTRsTHglZN7327rz4iFG2cIBtBePJ97kv8fqZjQDgrS0P7sjL8EIm8En
	XpiiCGP4rLuEb5wmRyZT2DgjuzB2HoAZjJDkdk7OgE/hJNvWT9ckZI/ctRY80XXDGoXrU06VZ/qNY
	ZVzcIOpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqMn-00000004TKo-2cO9;
	Fri, 17 Apr 2026 21:04:45 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqMk-00000004TKR-1z6S
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 21:04:43 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-8d933da14f0so115914285a.2
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776459881; x=1777064681; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIFmiMDTeP/Oqc+nqvJkfeXsIdepM88Xx6p9HfnIkCU=;
        b=Ts0tu4oxkjeCgspiGm+dlaf+xI4XCDafAUvvNA2eS+wCYK7FH/Sy3i4AeOx+2p4QqI
         pSjxoHhnluNvH7AZFG37o4/Dd8sk/UpUt9LKijPDdUJ0nh8BuCYDqcAo95bk/81WrHm4
         dW82cVZt1RQS9Q6iVDdJAqe+/MTFDCL2KDWnvu59nRx9lXmZGrqyu00IQZ6FzHsWvDvj
         2ZWd4XGoKLRsefwNJXAUYPrKh+IAx4b9l4ZB3BUMMa3loQL1nVjYH0NEYXBGQfngySBa
         VdtWuon8Gm93quQd4rELoR3O6E1U32ia8rGkWECCpN/St8ADgGLmCW0+9cDXskgN5diL
         D9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776459881; x=1777064681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIFmiMDTeP/Oqc+nqvJkfeXsIdepM88Xx6p9HfnIkCU=;
        b=WB4/VkmE+cOJhSvrGzlcC9zryRG3YHI0ZH/MO12UUTeQvXDbs/TVQKuAThN18h3hK1
         UawPbbSeWVsZwcqrDlvDq7g3o/6HkMVz6o66xscKZtlOrRYKooqANX2L4J9I+Ixfr7X1
         gPAu4jI2XUWCypPP5ZCkqM0xWlktkbhxX0nf7bjYI5IOfNVkNH3XEpBJtWRA36G5Z3vH
         W8H2ZhCvgH7dGr5Jvem5oOckP43C+R3iH6LdvW9RQ31HHopLn/N5rrGjOQArb2Jh449Y
         jSPHxh8TbR2uC/rWvuMItKZVT30ETEdzj83hHQuDG8FCrL6mPMtw26xhHbVDgMMgR3w0
         zR5w==
X-Gm-Message-State: AOJu0YwSanHMmTp4DcDExYGWcRBZ+KqFfDl2LLk6m1REZpZIsvJ0y9fa
	M+dCvTwSef71lPOqNPVVgEEyh6n9NzyEv093snwvJvbFHSmavy8arqxQ5YEfO145U20=
X-Gm-Gg: AeBDieuZTSr/Z7aojI1CsonJhdp2FHUyLM4r2YfmdWsutm6xWniKO+DbopxaPRSL2hf
	UWJ5AF6x8HcDgUASd8haZWkXA4/PIxJoQj1oKQYSOwf9b4fNegebTNLKisc9QoKzQ19pR9rBTGn
	PI6fZePk28QHDTqcjAzMuo8STbWTUi6TUwstqfxR+fytC/wJoyRi9QpsDhq+ILFPGq/XBJnwNjz
	EjSK0IarR+4PsVJnoJQYkAbXsieVMMFVgliZ4bHiJ+8rrxs77LWhSZ2RwL626x23/wZ09zbfKqJ
	1djsnKqwhT9u0cZ8J61O1x+p5ZQBEawu/p1Oc2NpZ9bSuC3sWisGsnf/vhxwS/R+YbBdrVvfTwl
	5aE0v7E/VbSyQqUGIhkEO1GuVnTcCh2mbqPFn9dVUYBrtKvIIRaRAmcmhh0pU8M4Rls6r0uL5l/
	ATSWuFGDWVfWV0SRIJBlUFw/y8zXn0ZT2ygEgxFDS82SPrBmaOcBsqpICIVyZu
X-Received: by 2002:a05:620a:4513:b0:8cd:9665:9eff with SMTP id af79cd13be357-8e78f730674mr667672085a.21.1776459880758;
        Fri, 17 Apr 2026 14:04:40 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm189183185a.19.2026.04.17.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:04:40 -0700 (PDT)
Date: Fri, 17 Apr 2026 21:04:38 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <qwxxff3i65vsnzyaklovxp6ldc26ni6wnrfd2mne7oktdybqan@35hjg7obfrf5>
References: <20260417205810.1831923-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417205810.1831923-1-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_140442_533297_20BA0807 
X-CRM114-Status: GOOD (  10.61  )
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

On 04-17 21:57, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> In userspace when managing LUO sessions we want to be able to identify
> a FD as a LUO session, in order to be able to do the special handling
> that they require in order to function as intended on kexec.
> 
> Currently this requires scraping procfs and doing string matching on
> the prefix of the dname, which is not an ideal interface.
> 
> Add a singleton inode type with a magic value, so that we can
> programmatically identify a fd as a LUO session via fstat().
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

