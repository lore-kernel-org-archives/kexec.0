Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E3606A33A
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eg/Nu4k5;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=D2uHCZkC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=68DxHpqqFot2faCcIPu2QwkdA4mxu3avVweYehLM7Ug=; b=eg/Nu4k5ZLaDDY2DjhYaKMwPDd
	W2bq/iQ14CGf+NPztCDBzmZ7pcqSgN/KnwIzGNKfa+nt9mkkGlG7wz98PRFAJjMmgE7by83nlRkrD
	c55XLkKLay+vsHI38YZu1HQ8uuL6f7mmxdOl8KDwq8vGlmLIZKe2yN2a0rPAIhYjz57ID61yXb/bL
	qMKjISdwFR/iXJFCI/PuhFkeioq7PSG2YlLtIep0aa7+S4hyB2PeMyaY8E4TMFTfOhecrq6LnndcX
	NP4sm3ohsZPBEhYmS+M0Kx+2xSSpgbdmWlRDdc99emW4feWwOK+sGh4Tol2x+RxQwe7o4+0XYESLS
	3RYX3M3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSTMs-0000000H6Po-03l9;
	Sun, 15 Nov 2026 06:05:34 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSTMp-0000000H6PV-0VZV
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 06:05:32 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3056067eec.1
        for <kexec@lists.infradead.org>; Sat, 14 Nov 2026 22:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794722730; x=1795327530; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=68DxHpqqFot2faCcIPu2QwkdA4mxu3avVweYehLM7Ug=;
        b=D2uHCZkCT3Bi80Gu5onLyIOrJYUokvzjmsDdh/WwgKVafBbJzZOcNQ/bfoUGASmhpO
         Zyr0zzzew98eohEP8//fK6SAlJ1dUhi9CGVoGF3U6C0IcFMuvwRd8BqSfsPzG3WcnnQr
         iDrnZcVBqx65KfBdHZLT/9uIIPKK60Za+V8a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794722730; x=1795327530;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68DxHpqqFot2faCcIPu2QwkdA4mxu3avVweYehLM7Ug=;
        b=AzOlTx01wyK873EIwhGcMbaukcHolzEA7si1E20Hf9GQtjHBzUINlxPt/E3kMpQtV0
         DhWNYJZZJjOrf3jTgFLC1j/JT5vfqh8EQeXR2Ji9CJx9EGsF0FwXA9no+d/ncUAdbDmu
         8HRI7HLlPVUKq/mc6ORmn259F/kfDWF3vFuOM7rSBJPTUyXYM/azsmYsJlfu9vjh6/YK
         j6VCyxW5Ap4nUgXk7ZCMdf/6z7P7CZ4JipMN76GYHPLjFIbzukXF6wLe+zyb/jdzeb02
         uKjIeEsXrl4pU23EPW1yDxEWLrUanbkLijIRjutMn/vZ85G+V7rCSyTnSgskgPn94kh3
         fz4g==
X-Forwarded-Encrypted: i=1; AL+hErFve7mIYZbO/QHIk9c//hd/GtucFgbQRJ5ti9MKkUMiDmmpg3ZU02wNtrs5/lYXVwPvSc3QNg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+76EU1JONsK56wFQ3+eXAxKxlT5+5l7jgMSW8X8x/CvXg53OsZ
	KJmH7gaaZRd7FV3OrIiqLy2+LBZ8Jm7Y4iqSmIXpCpWea0BKiEJwyQFwHHczAzDKLJxBZ2UeNLN
	TZN29PV74Vsxy
X-Gm-Gg: AYBFou3zRlhn9fYCD3QZ41EenZAswF53qKOo6U6KbjhxjXpst/Pw6kQzd0KG8Te9sQt
	AnYIQIn59HBJNLlEje1CPsgSTUI6ihtCzdmtYaRPNKT6Z1sF5mhOhzEtuFHTQLKxPWiVggqC1tI
	GTufJG5ChMoFdlFt6n+Tw2d8KdoX9KqqRNEknAJefldvxXcDTF3dmbKh/VghNgs5McTw7HjoIex
	NalZ1SOn7vzTnrpLqb3/EdVHktKPtznRJugUXBTc/RHxcec2+hbOCYAafe+wHMZM4OyebgE/tYy
	FZv6gfYxez0xLNeQBdBReMrDEgkhsLduVHldY/c/FPe6CAGM+e+0NK9zZXSjJV1VH65sCN+96DZ
	jyv1bVfxg2U7OLD9Dj4DINoVPgFasp8b7hUEutRCYGzd8zv7PR3XvMf3n5smJbFUlUwonbIem3A
	+UJck2ySLhMgHqbsA8iyl66y0unBfnYG2FMuamkqTmNx9J2YljVfor6/Mm6Ggg2owAq0K/ssb3f
	ZBFOAx72AQqQSiyiSEuIA8RvWy7+qeIFxN8Ybe0DQIVrhxmusWyRxgnSf5yxeRdKWuSoSoM9zKf
	7ECXdUEybk2kK73zMMgYRM7gPf60Af9jSu9cLNa9nkU1Yl3++FF3WTur89QfE4ZHg5mpFPvhsuy
	/Zf8dNjDjE7xnIB9zlp4luOYflrovyUw7uath07JXAJLa7HanqMQaDbXShiqGNZ5DiYH5GulhxJ
	BxozCmcbTaexuIRNOPstKN190/LePy19OxyDdKXvNHs36I2RVqYo8BeLnhuzmbCW/A
X-Received: by 2002:a05:693c:68ca:b0:369:f05d:6c5c with SMTP id 5a478bee46e88-37967410b8cmr6726925eec.28.1794722729913;
        Sat, 14 Nov 2026 22:05:29 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm19790083eec.4.2026.11.14.22.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:05:28 -0800 (PST)
Date: Sat, 14 Nov 2026 22:05:25 -0800
From: Chris Down <chris@chrisdown.name>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] liveupdate: luo_file: allow keeping private_data
	from retrieve until finish
In-Reply-To: <20261110175855.2437084-2-pratyush@kernel.org>
References: <20261110175855.2437084-1-pratyush@kernel.org>
	<20261110175855.2437084-2-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114220525.cdf6ca6e7fc4cc0a@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_220531_178096_C972856E 
X-CRM114-Status: UNSURE (   5.67  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: 1.2 (+)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pratyush,

I've tested this together with 2/2 across a kexec and it works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris

