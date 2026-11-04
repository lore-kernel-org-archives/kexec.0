Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80CC606A33C
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pZg3DOPJ;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=c5jAQldw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gNw6+e49
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LaiQAira6LJea59JkTCLBB0qD9u3ETiU1WU+A3oJQUE=; b=pZg3DOPJRZJERZ
	3eNqu5zU6GK7nKmPjKGJdq0VyrLeOFoy/YRNGtj8SDWqgUb4xFUo46263CowKUBqTiiSfY6BxPsd0
	0oz21mF6M1nw6XLghfhEg9H4lS0fmCOr84Ie0ssGk6AUWQjVE+B0FmuasrTSzITHy1eoOHJ4/KwKK
	93hZHb9gemFewZf783x8GY1fxOuwJxHmMrKNecF3LacaRDtzebWCxji7qFycQxoeMaqEo4Q8czDzj
	WHOWV4J3Los4Ym9up6uXY3V2u5RVXYAlaIeBkvVYZyN4zkOPxTpBKURKT71C4A9eCjBkQ1C7Qd5eO
	U4YbnYnT7X170uyHLYgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdrY-00000005ypp-1QPd;
	Wed, 04 Nov 2026 16:29:24 +0000
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdrV-00000005yoy-0W7J
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:29:22 +0000
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6DAF7A0111
	for <kexec@lists.infradead.org>; Wed,  4 Nov 2026 11:29:19 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 04 Nov 2026 11:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793809754;
	 x=1793896154; bh=LaiQAira6LJea59JkTCLBB0qD9u3ETiU1WU+A3oJQUE=; b=
	c5jAQldwwgfNnO5PGIb2SVCvwCRVrFn0AlzKunbwhvs1uypMH3RhKhsfp6lsD7vh
	2bqcD+fRJ6Ro3ct1cv8aIHCwflXsZFuf6ieUiT03qy5NBel1NZmPUPzPK0IzAzRh
	RiwW8q+X7tly4os1ahAaRhabUajpsrZPek80Los65hailxoxHZDO1CubmR5wOZFV
	vdsHaH9jdnVw6SmQCiFZRsBnuJFKnnsV4/egmTrrmUJYPXp3YupKcXYdBvyDb98Z
	n3oNyIvmA945r0eraN7VFXYuvbAwhHGwMf08fEJpOzuBSomjhk1Wd6ZzYhBuOuPA
	Dq848O8cOxZdxov4Hx0X/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793809754; x=
	1793896154; bh=LaiQAira6LJea59JkTCLBB0qD9u3ETiU1WU+A3oJQUE=; b=g
	Nw6+e49H9+mGLS37jkQ9yV2KqwmOO0TtosTC9yMm3VJQvCxVnyBB1P/fKSrz0S5X
	19DAs/+K2r1is0sDqBvE7ef/xFLwloc4lJCd+mJvaG4G7bCjX808ntks3lIk6ROc
	cJ+IlCuQd+SOZN5EyxA/thcnWtLLGPuaNmorrUUj3OTK0hWCWwexkm62WE/CZw9u
	lI21eAp88Zd/5XWnnLV3MLHwk3QtPPEtSmRmsE+e/LmGBpgvArx1lNs1yDPBd06o
	vUxRdl1VN2SMGnh4cChp/LFjH+B8rbgYFfWrUChSH3xou4PZ3BAtzvZBjHPZCIOn
	NxiSAVVXwewsxMfxezD1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793809754; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm2:rsa-sha256:KS6OEY5cRTEpPERfD32chI8kKbQsU5A1Fv5zlX/57xIBimI
	iQ374RaVc+1Gr3aSxcuhuvMKzkbdiyvrFJMdPg2o5j+1u979shTFadv4DwuwVrfL
	+lOd64e23qkJB/1XJPc9mCi852Hh626ZxIf5Em92MZ7N0bLMfEI9sQ3uiBG1RWKu
	Q8FEpV2tnfMaZuclfWumilnHA9tHjdif2eq+pPKhXBRmvZqUbipnT9YaZQi/sv4L
	nTXObwSFVpABrjSNy81aeDOsuGDoUO0JV/iJz54Wa4gHEwM1GRMfhPuWemyZjRW3
	KQ/FuaCSFwFClYtty+l/A5XAtn+wj7nw2A/WCpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EL3Gd2i3YhMp0vFuwH/WrQYooSA5VSKcuTfRIbM04wM=:LaiQAira6LJea59JkTCLBB0qD9u3ETiU1WU+A3oJQUE=;
X-ME-Sender: <xms:Vl3ranwSd_CykXkfKt_DisDilg4d5ENtLvR5s923aJuWzflU5eJaxA>
    <xme:Vl3raqEaLcs3p0xIklBe_kdOatnAVtJBGfzdGDeXfP-4l2039sFGhGyJj6LSkF8Ar
    2hbuMLLOjdHgZVIybpvYYx09UOO7Zb-Wved_JG7Sv2wsBzAtihg_es>
X-ME-Proxy-Cause: dmFkZTFH3IypNSuXYh3Kd74bqwW9a3lD7bkOwTRBwylmNrIwAT/Vx39h5sxOyk8YBaSEZz
    xzvHXAYiNUdZ462ifvJfTSJqf91mHwxbEpFrPXMj1SHnj4aDidHBfYvmdBRdhvh0/PF8qX
    +FGCYX+gKEh7CGDLNwxbtVgwqJruBNp8XHMf+TMZGOQne8JrvnwZCetPfQkOD5+EGGoMVB
    i5t9gZhjOBTBFO3jzM8Vekg6mA6KqIVFvH06ObjWAQ81Jf3Ti57IDye2cEHmj7kEXzUqyA
    /4QFAKLHp3mu+XBx8EG5H5mAbNWXF4jgXOdqGLBP4+Wv/YNfC1572fnWbAFvBi43/YU5NM
    7IIUxNxdMAWVIpotu+ptvwKET/+uHDJd71bv8K0TDpMF7vB/gyGDH1Rq5PKPMlYahzd6Jb
    u0CDbP6TmvPeo92Q3pkO2fYYBFLcS69KkVaI8LXslUr+jvc+dJcvZ7P5LRrVsgrbtcNq0Y
    700mxh+Zf7ZTNCsLuo6G5Uc5HTPFtCd24BG6Z1RMx1XI4arIvyWVRvPHj3nBjWEjgwBw7t
    1nF1eR86yNI65ea9glVmwA+tAdRWS5n4iwRaurZurrVmqqsATLEtljzUfKkQCWuL2O8Kro
    qef1ZgLBCxyqSnae30OfExhtiQHgC7DUjo7i8BECYPzKdp4Cfomn1bTx5hng
X-ME-Proxy: <xmx:WF3ravNYn0pPMBtNVZ2bgjPadk6SgfgsM1kYdJ-IZ2KlPBkEu4C1QA>
    <xmx:WF3ranWahz3oPRDUywFK761jpK9YNubOerF7kYQCFpjlvNFlXgH8eA>
    <xmx:WF3ranzyz6N30adHDEAyUTUYxaqtaXtG_VMEf99hlyORLZgnTCmvaw>
    <xmx:WF3rau9oMC-j4FQHSfUNHyNNuvuvWuQ11Qj3eJHgHLLBTfQVHHZo4Q>
    <xmx:Wl3rakdMjb9ALM8TzZT31cm7vg5FWCxysTNlakVIHZfPzQ9xYXHB_LWq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 848EE32A0093; Wed,  4 Nov 2026 11:29:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgP3mv5Dxly7
Date: Wed, 04 Nov 2026 17:28:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <blum@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Alexander Graf" <graf@amazon.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Changyuan Lyu" <changyuanl@google.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Message-Id: <be6ee9f8-ae2b-437c-aa04-0390954f9adc@app.fastmail.com>
In-Reply-To: <20261104162352.140836-3-blum@kernel.org>
References: <20261104162352.140836-3-blum@kernel.org>
Subject: Re: [PATCH v2] kho: Remove redundant 0x prefixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_082921_207260_FCA4A527 
X-CRM114-Status: UNSURE (   7.84  )
X-CRM114-Notice: Please train this message.
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

On Wed, Nov 4, 2026, at 17:23, Thorsten Blum wrote:
> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefixes to avoid printing 0x0x.
>
> Use phys_addr_t for size to match the expected type.
>
> Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

