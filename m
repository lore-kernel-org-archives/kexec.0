Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A18FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oU9QFXFcPvDnOm50j3Pr9oOfENDvi06AH/MQcGw529s=; b=Gh4PI/FPRCZd8xta3IOfkDp08P
	lXS6Nl4rg2foDB+mllSVnxYy7kHI7XTU6vyfH0T6Lq+vNgw2KptZy5swpYsq/wBAFMo88EE9leRb+
	MYyGW1tyLAYoHdEtlIGdsglT767hD43Yg+Ox7WEN2wxsm/qf+8lpmN9F20O8RcwxnBsERuB4bw0qp
	vbOHJ5+rKGKSTI4jPTGZ3bYbtXQ6n/4LS+EuzijlmctGoiJ0XM4qKYT15zu2ePm72mazFgahksZbt
	ihoyOPFcFFTAY2JHeIz4nUI3dopPnlpC/kqDDdR3qfVoCpiMlBkirAS0oSAMbqM/mTh4d/18VCBNi
	Ge+tMqjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI5qU-00000003l56-3reQ;
	Wed, 29 Apr 2026 14:24:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI5qT-00000003l4s-0yzD
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 14:24:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4392260139;
	Wed, 29 Apr 2026 14:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA85C19425;
	Wed, 29 Apr 2026 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472696;
	bh=aCaYorBUSCF6eWCfONlb1C+1m2mXwLSU1/j5XLbpFYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jp9dPk3MOO+POyRPioFKm05l2fptu95ogwNuQm9g78vurqPNdFM+sJUhiBcUJ8tkd
	 wvPGOxSftrc5G2i+yHJaP/prNYYB1cmZGe3lY5S0ZqOG+sPjQ+LZzz5aKwwZ0pGDtg
	 qLMAzqmfCleA1b/q2FmLg3pHQrzamRwCm5FEuJIprZ8w907bcrsaoufQGgcUVUW/UL
	 cKEq47JXfnO5Kw51LsM6/alYX3PcWaxjr48iUAt9YyUE6NLSHcJAzjC9A+xp4LfEzN
	 1IdTssoGKiDtR1zCyLgeL1Jq4eKjptOwHqFUu46BJZ4GXpFR4+l/IdARlvrDB6+Rcy
	 T6mprKJI2BU2g==
From: Pratyush Yadav <pratyush@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org,  linux-mm@kvack.org,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] liveupdate: reject
 LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
In-Reply-To: <20260423234753.3873095-2-luca.boccassi@gmail.com> (luca
	boccassi's message of "Fri, 24 Apr 2026 00:44:20 +0100")
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
	<20260423234753.3873095-2-luca.boccassi@gmail.com>
Date: Wed, 29 Apr 2026 16:24:52 +0200
Message-ID: <2vxza4ul4zez.fsf@kernel.org>
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

On Fri, Apr 24 2026, luca.boccassi@gmail.com wrote:

> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> A session name must not be an empty string, and must not exceed the
> maximum size define in the uapi header, including null termination.
>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Cc: stable?

[...]

-- 
Regards,
Pratyush Yadav

