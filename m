Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F9DCD6E44
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCxXOOp/yUx121CEZTpw8nvD7NIGGxkDJrApCRJtPic=; b=WvcSmvYgM/D8B8CWc2dbvgqzqC
	CyttF7ryX3Dpw8kOWepf8Ld1v8lFXdDuE7dJ162ZkYuugHzAaiBs0Phaa29eQ6adUXTBOeoHHny/R
	HOl7kM4PKmVTV1epMBSAVSIrKlquYsaOTLpD5DKlwM7YDo74q1tpV1SZPM4kXaFFtK4n6Hy2KgJw1
	r71YE5vhlWM+MbGjWUyhl4Fs6DPRKyQgUV7En4IZWHAphX5O4JPs/OBV6oZMQNTGRwZvMuEY207h+
	vlbYwDwmySAauuwXK/x13QRbmV5fcEW6Ze1AlYckXz4cXToqCPWueXnwaZwPtyOV5m/qk2V+hqUfz
	He/XqvTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSbcj-00000005q7B-2ZZb;
	Thu, 28 May 2026 14:22:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSbch-00000005q6r-1Do3
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 14:22:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BA0056022B;
	Thu, 28 May 2026 14:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DB31F000E9;
	Thu, 28 May 2026 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978130;
	bh=fCxXOOp/yUx121CEZTpw8nvD7NIGGxkDJrApCRJtPic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BTAXXti27ObzHO7JJa82WJQDIFybIQl3Ih24/PYynO1I33Ne3ZjCd+aUCVfpDsLus
	 GNvMVLrmFqWare3t3JHiVxvl8XWnCf5b+Bs/7GcgmFIRcWHUJHOgT/5H+lRJo4ae03
	 vz7ut9HtWRsPzGmxWNTHExiWalQzyDC15RQUklKAkXGuD4wClFs52mm/rrmCc0cW26
	 ghettlNwW+FRoRKqBwwxYXzApjqyun5nzWoeXGk/gX6GpYcnf9LM3ygCqrnsD916CR
	 hg+ioPTRsTqtHDoYCkwkblT1/0j8k/WZ+SoSbJBNDUzggRqamwR38/sqGcy+78f0O1
	 kuEutGDK3jdxQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org,  linux-mm@kvack.org,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liveupdate: document current compatibility status
In-Reply-To: <20260527153725.1770394-1-luca.boccassi@gmail.com> (luca
	boccassi's message of "Wed, 27 May 2026 16:37:12 +0100")
References: <20260527153725.1770394-1-luca.boccassi@gmail.com>
Date: Thu, 28 May 2026 16:22:07 +0200
Message-ID: <2vxzqzmv3980.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, May 27 2026, luca.boccassi@gmail.com wrote:

> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> We currently do not guarantee compatibility due to ongoing
> development, so mention this explicitly in the user-facing
> documentation.
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

