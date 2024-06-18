Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F06C27C4F
	for <kexec@archiver.kernel.org>; Tue, 18 Jun 2024 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=96ijnd3/Z7DK4tEA6g+CbosWLs3XacUOvhtB1PGptH0=; b=vy9G7posiQE+Cw
	8JerWpyJCOUZ2LG4dx6RSINpT9N6Fzjhrmri/XG+SLWD+GrYpzGsulBKHWY537VgFt61A4ygQZDEf
	kEvLwY3N+RPWC9SSgk5TqMgJY9RUWaR7V+hYA+XO6C/WmOcDsaODCRcr1lH7QGsVch7XQyfcMTxiI
	cDlcv0RNhQlEfXD936n+1FMPG4VILrERarjOCTOzFE4KsllXX538bifUGFHE/4L7hpKmedkNT8Xrs
	6Zh90OvCnc886cbZcjR9eBd7ePJnIPQScY2VR9pRuhQdTfquMZGIe8S4HtYdHoMR19dLV5kvlZiU7
	7GtRtde0AGX9TGkG5zdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbkm-0000000FryC-2bwm;
	Tue, 18 Jun 2024 16:32:16 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbkj-0000000Frxf-2Laj
	for kexec@lists.infradead.org;
	Tue, 18 Jun 2024 16:32:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8DE3CCE1B74;
	Tue, 18 Jun 2024 16:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0424C3277B;
	Tue, 18 Jun 2024 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718728330;
	bh=gIY3ghgie+DBccuAqoXmyKE5Cg84LzWrcsHox3WNK6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Av8fgrkI9pKFRy8S5L8D9AWorx+3RUX25aiBlsnX8ZmpURySprpwYSRxvbk+kO9hL
	 NP2OcJeUUMjWaWkOAEB77Gmd2BU1HY1YsV1/6WAwL9RXP/WmAtukfW1mTq0gEQZahx
	 2dR9B/3Dh/XDd/qeSlvo407j22C3KgqAdlJ5kke8vjp/c92All2WtgHQYH8RccKiyh
	 eIIn4ZuYBl7wO9XNchqcQbmnoHRDE3B2+dUxlXXrslr3B9FpbC0Jgfl13Y2U5JvQ34
	 Gk6BlCtCRclZ7LgAeZEW6D/WH4cy1kAhU0mZ6QvU+/NS8GyFCqU5zLAyM8jC9uY/3m
	 3muo+ys+hg6XA==
Date: Tue, 18 Jun 2024 17:32:07 +0100
From: Simon Horman <horms@kernel.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] x86-linux-setup.c: Use POSIX basename API
Message-ID: <20240618163207.GS8447@kernel.org>
References: <20240516043505.4048330-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516043505.4048330-1-raj.khem@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_093213_798708_5BD9F8F7 
X-CRM114-Status: UNSURE (   8.47  )
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

On Wed, May 15, 2024 at 09:35:05PM -0700, Khem Raj wrote:
> Musl C library only supports POSIX basename function. while glibc has
> both GNU extention as well as POSIX basename implemented. Switch to
> using posix version, so it can work across musl and glibc
> 
> basename prototype has been removed from string.h from latest musl [1]
> compilers e.g. clang-18/GCC-14 flags the absense of prototype as error.
> therefore include libgen.h for providing it.
> 
> [1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
> 
> Upstream-Status: Pending
> Signed-off-by: Khem Raj <raj.khem@gmail.com>

Sorry for missing this one.
Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
