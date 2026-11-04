Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F4606D801
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Oh+Y/9FJ;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=aj2d1zPw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=v6mnL4cj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8e/mss8HflpUPukSo1l7KMk+icGVWWwgbeYpf+2EZ0M=; b=Oh+Y/9FJMnFebQ
	7Skqt79+1Uf06Il7tQ4y2bWt3luR+zkO/6AHe4fmPMqH5uWmAy8IkSKsbjtYSW39w02JWmHaiZOAp
	7AnmsZGI4GL/zs8UKdunrit4O7r6mDg+M4JIGDaGqpPIUH+9+O24vc3QZC3KEVW+IxYO2xGlj529W
	n1aBoqFJWkCV4aiS2K/vCHhzr8s3KCiqc54T/9kHI3aZkruUzRehtC+FSn82i3znXUHKgHZ5TcjmR
	cZMH1gUs1IP+q3SHU0HagLOmP6/GmEGfcoWQ6iWz0OvJdBBqw7k6ZfE70nuuxM1UXezmhoTGJgo9d
	wUNIy2282Kl8+9Li7S/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdeX-00000005ujJ-2Zr3;
	Wed, 04 Nov 2026 16:15:57 +0000
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdeU-00000005uff-0eUE
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:15:55 +0000
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id B64EE1D000C8
	for <kexec@lists.infradead.org>; Wed,  4 Nov 2026 11:15:52 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 04 Nov 2026 11:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793808947;
	 x=1793895347; bh=8e/mss8HflpUPukSo1l7KMk+icGVWWwgbeYpf+2EZ0M=; b=
	aj2d1zPw50QYcIlxC/Bxzi2+vTfvUHUMqEboPUsUsilu739JezLAKnLkiMvxO2fR
	sTbZEV1Z4/SC4JP7xL1iN/EpU6eWjLzTNNGAX5IlZgpQnbpj3XmJi92J/XeeIKRX
	NWRVqO+OED9hC3e7QD6o6vVbYhhzBUPtd6Qh6UEvmiL4c4RJQXEk+U7CbC4OV/gY
	RkhC3z9t5+jUaItWbz/G24RS7PPz3wHhLVSvfeVli4OlrTIabU0PY5SVaWu0aXa1
	XPNZ1DyCvcPhflONNE/QLHG0+fTCr0vvkPnBlDG7dAc/jAs/fU80K4yF38SOoLds
	QRdJL0T9Guz+R6yvhx3oZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793808947; x=
	1793895347; bh=8e/mss8HflpUPukSo1l7KMk+icGVWWwgbeYpf+2EZ0M=; b=v
	6mnL4cjqtKbQWST2Uyr6CLmgnnJXp0XPmBwOnxGlLSdFhHd247WLSSUCSJQC4d3O
	ylEOErFz8S7enBEEiXnjN28tajihe5SuxSKjIQXzlKMS2PobeKpTKFcx9ZRTI7Dg
	40JlkHF48F28sI8idrRf18tkTHx/AOQSXI/hmdKY8PmtSGzXjbeXpU3Yj/xLJtjN
	Kx3o7Nmoq/9iV+6W9XnESQ3lqysJIhEdIQgYCwcPUpdDmu5DrSs+M12rYHmz40HA
	xH5eWSDaTvYuAAtJsDfq4TEPUhA6a4oKmIODJ/sEH0ApW4y6isS28XoIvgddUPtP
	YW5nlhsFWd7bcJdAuJpnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793808947; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm2:rsa-sha256:YUENzHS6vf9h7ewnkKKgSnDaICHv2my+UXGuwLdMcivILEK
	sxZAAqT0Yq/dEriDovemoD8A1E2+BXyda6FZ9kejcQnDGknwKzZa6dpEhI6sHDto
	ulJ3GaUL7OvMU4lCf2UtGGo2ksn1aSK1IwuBBbijkAn2MQulQGIX+42vFSoqHFJW
	SmeJfcTFFUz/g/SrVVq9tfmK6zAxGXasqKhoduFS4xAxM549KuoRVPXY0OdHT/aO
	GBNfT5gaEFptalMt9QqO2eDa4dexDwtrQDpQ+ShCPawKWNP6LQodX1E06X6zCf6C
	NATwSQDL/x5qSpAM6XqZvGJYKPKnVyDxbgU809Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4kPFI1pl94svt6FcJI7GTH40I8NrmwpOCYY09r/CUgI=:XtofUmLNSAlOeC+jHYzUkvhsqx26tdVnYTmf0pcPtXo=;
X-ME-Sender: <xms:MFrrap-1uafiamLHhvCFmcoS4CUnt4Bur8aaBT7rExtfg328FFqatw>
    <xme:MFrraogCYm9ARQueCpMSAm5L6Q8RIRSsoE7aCr_GJnTAoGg5JUuggYEjpjpPl75SN
    LYX6z-dG5QOhFYZngw6ymDok9GRsMc-K5FnkkT9lGFjSzDMFOxLNQg>
X-ME-Proxy-Cause: dmFkZTF81vXp6AjtNjpU9fMobsGT/c5iTkulkiDk5XSLgAmxn4T8gi5LrjTCSom++OOSJp
    S2tulKct1nDA+/4XskQ6V0zYzSSj4jJO9hqiWWuJfTvGas4k/fHo47PZRKoymKbR3PQgML
    2dTuv/53dVjIAqnKBA5IkbPhcmZf/oSRTxjvhPJ2gpIxG2dOBOSW4TxQwj5cWS14Knfquj
    K9ScKr/Bg+CXlr64X+IJQ/qM79dWbgPcAoxxCoq6KU+EVOAJ3N4tLM0yQMk9/hNa07GdMy
    59Nhj+ZBwUTZEH10vlXr+FFQrKeV7DXhD+xT3yKq3v5vVzj0mvPVmURRtfEXBOPWMN0trS
    ZF//I2WkPtCi3Qulh/5asCXoNTc8gRzqwkvujCOTyY4xORAFUMw9P7mPEzXCMXnkqK0Z4q
    sMNGUvmi1qFFW2M8afJio7TiobOd5/m2b1aeUZvufIiruyVNPVhqsmgPSHrvO1HJIT46AZ
    w8d1RK6CVYTkmH6sLW6UjCZOeuVxd9/XJpxR9NzVNguu2q8fUuTFZdL9Hm05FpqLTIJ1Y7
    460Kp475z4B+lqotzzthqkfj1zOo5Hy1QzvhJd1iSPwX6GXApUFZB4jxMs7o/iQsxHpDgO
    pXQ/gfnLMc3iEdzdm4nXUOTfdJNfkpc0PCQBJotvn/hoCGUO6nVGhHbTDu0Q
X-ME-Proxy: <xmx:MlrrapJ6W8L3Jsa2QGHNLYu_3Q5gPZkIcv347ZF-LLTQXzh1U0ilIg>
    <xmx:MlrrarLTrGTisFewbQlMo6yPl5XT83csYL-j1jODSVOOa-UmGOLy3Q>
    <xmx:Mlrrash3oDteop0DiCdnKUwlJ5SKHiqdKA8rzfP3tjhWNB6HjrTwrw>
    <xmx:MlrratPAwi1z_dXfsxwU0dawiR3Btr_9Hts7mrM1VN24OcWAyUHYvQ>
    <xmx:M1rrao3geqTf4E020kt9bow0G8d85W2NCqAnl3n-W2SlxB3ti3ygPajU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5CB9832A0093; Wed,  4 Nov 2026 11:15:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsZFqsyIu97-
Date: Wed, 04 Nov 2026 17:15:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <blum@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Alexander Graf" <graf@amazon.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Changyuan Lyu" <changyuanl@google.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Message-Id: <6c67f712-fcdf-4d80-b212-5847ba57283d@app.fastmail.com>
In-Reply-To: <20261104160931.137174-3-blum@kernel.org>
References: <20261104160931.137174-3-blum@kernel.org>
Subject: Re: [PATCH] kho: Remove redundant 0x prefixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_081554_645051_565DE1CB 
X-CRM114-Status: GOOD (  10.04  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026, at 17:09, Thorsten Blum wrote:
> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefixes to avoid printing 0x0x.
>
> Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Hi Thorsten,

The change looks correct, but I see another problem in the same line:

>  		if (err) {
> -			pr_warn("failed to mark the bootmem region 0x%pa+0x%pa: %pe",
> +			pr_warn("failed to mark the bootmem region %pa+%pa: %pe",
>  				&area->addr, &size, ERR_PTR(err));

'size' is a 'u64', not a phys_addr_t, so the pr_warn will print the wrong
on some platforms. Can you change this to use 0x%llx instead, or change
the type of the temporary variable to phys_addr_t instead?

     Arnd

