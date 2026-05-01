Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2C5FF885A
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LsYmmPW4HC1jOtOwpgcXJSncU6zAKjTVlj4fTdxM7g=; b=gys2UrHDp5TKW0bzwNiRYwUtWr
	drp1rFJBrelDNTAjuEVh+jqXVdHdqXoq+bsN6yIr6obB5G1UP8T21MLU8njKMVSYPy7DMyhM1eKqP
	7PUS1zVVIJSbEsZo6BeUH7uBhb9Sx1VV9sq9nhGWGubrgBFjMdOnL7ovzCl3vF8sE/b1fgX/sIAQ/
	DCyMrHczSw0XAyEpMFLOKGOD/OV6GWJDY9b+LPlk11dMjIHBTjvVH3L76HjmYzuQYNQf/+1Kqok6L
	Rlv9f6uduHjujSf03xiFXya7rB3GDVj7z1zVrFgxpIXcVNv0+dYzZ18V08NHEIh0n94Ctu2OkQigC
	GbKS+3PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkqn-00000006Zzs-2pDX;
	Fri, 01 May 2026 10:12:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkql-00000006ZzX-1P1s
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 10:12:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 25D92439FF;
	Fri,  1 May 2026 10:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86218C2BCB4;
	Fri,  1 May 2026 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777630318;
	bh=8LsYmmPW4HC1jOtOwpgcXJSncU6zAKjTVlj4fTdxM7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npK9hDSH5xIFQtWSlLX113XQF534nSdD1bHdAFCX9kwpST3gzRHXAS64ciFIcoTxs
	 TZLLyFxMnsNwoQH6B9SuS+7rhRxp3w7Jfr+FZIcXIfw+yWPMhyN1cP4gY4QfSPvXTe
	 d61UjMXhMCTuia0poMZsUsGi5q2Gv6UKp1C4cOUg=
Date: Fri, 1 May 2026 12:11:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/5] kexec: handover: add helper to check preserved
 page ranges
Message-ID: <2026050114-glazing-bankbook-28bc@gregkh>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501094637.38650-2-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501094637.38650-2-crisjacobmaamor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_031159_394349_CB58B815 
X-CRM114-Status: UNSURE (   5.89  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, May 01, 2026 at 05:46:33PM +0800, Cris Jacob Maamor wrote:
> Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>

For obvious reasons, we can't take patches without any changelog text
(nor do you want us to.)

And when a pathc is "RFC", what specific comments are you asking for?
Why don't you feel this is good enough to take now?

thanks,

greg k-h

