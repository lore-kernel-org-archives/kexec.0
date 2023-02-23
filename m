Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C33C61DA4
	for <kexec@archiver.kernel.org>; Thu, 23 Feb 2023 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IhWkbTxuX0OR4KBQXU+FdNf2wEKtgeHPNv04wU6wI14=; b=Omeh25S70gs2jW
	zVe4bMxNJWlfZwWZn5fnwQegOhc3SQ8Hdfez6smJrXW1K8ekKfyMMDeaRFmhHgC+ucy1ErurLPZdy
	Na3AdvXUxuShkR79VeTkrfLGfCtS0sg0HlubOHyXEQ9Gl8RRjof+eWXFUeCEA69k6P9HNjbLXYgn4
	aOdTYgYA80IWLATapxTosGaHh31K20fW99DUKI35n+SCeuvQGdPl7dVwy2RCMtey6CeuVUUr5JEG+
	4pJekeBCBG7+1rNBaMIV8VaNlIy/FxY8MWZUo8KhX3sZ30zqcRhKigtN5j6iUsq9Oab4Z45X0ZR4c
	8LLk9rnDEr4wOtuPPsnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVArM-00GJrI-Lo; Thu, 23 Feb 2023 12:38:04 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVArI-00GJpx-Cv
	for kexec@lists.infradead.org; Thu, 23 Feb 2023 12:38:01 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 30DDC20090;
	Thu, 23 Feb 2023 12:37:22 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id C6A249402BD; Thu, 23 Feb 2023 13:37:21 +0100 (CET)
Date: Thu, 23 Feb 2023 13:37:21 +0100
From: Simon Horman <horms@kernel.org>
To: Julian Winkler <julian.winkler1@web.de>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v2] x86: add devicetree support
Message-ID: <Y/deAeEqAsgvDg1W@vergenet.net>
References: <20230223060107.23029-1-julian.winkler1@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230223060107.23029-1-julian.winkler1@web.de>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_043800_617755_1AB18338 
X-CRM114-Status: UNSURE (   9.79  )
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

On Thu, Feb 23, 2023 at 07:01:07AM +0100, Julian Winkler wrote:
> Since linux kernel has dropped support for simple firmware interface
> (SFI), the only way of boot newer versions on intel MID platform is
> using devicetree
> 
> Signed-off-by: Julian Winkler <julian.winkler1@web.de>
> ---
> V2: added Signed-off-by to commit message

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
