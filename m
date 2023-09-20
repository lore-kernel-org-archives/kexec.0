Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF6CE79D1
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BpYBH076OAX7QJYJKA33f1tZBKkiT0dvX6Rti6naw2A=; b=bIIfpqxUJwQIn9
	zPUHM0FSUnR6pVIlvl6x39mQ1HLj0Sd28ecdPiG/RbR5BE+3aEAMEo24HmvuBpspN+8TaNvwUsJgW
	pLAHJDgd+CA2Mi4LXklE0SVvq0c57FatO9yVUUeF0Gqz97OzJozwRApgrqjItbnWpwI1GHb5kZu84
	qNrKGND3o+Afb1kLoOroBQZ/JRzEuDJABZHmkb5TNqVP/ivb6WE+qtAAO4BTy1kD6G8unWmHLeZKK
	Pbe5mMQdPwTZCudg8d3PQy2DW2KDwyKr8RBFKyyqcYNXA44ukhbD+AfZ5FVrQV+qX2MefhAhJCC+8
	M61s/h9REY4POVyv+Nxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qixYb-003DpX-2I;
	Wed, 20 Sep 2023 13:47:57 +0000
Received: from mailgate.ics.forth.gr ([139.91.1.2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qixYY-003Dnl-0M
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 13:47:56 +0000
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 38KDlfPn000763
	for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 16:47:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1695217655; x=1697809655;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oE2252B+1mmPgkTCaXztz24WTRCCmixWoElDpTKxQHU=;
	b=QHS50J3elqxa5eDJW+55dYhAdrFO8jfBIPshxjfQkkUM/tv5S5X0aJErcNph5+dJ
	WQqUSoFGkeHsjJ3QiGGME0XSWa8bkM7PBQR4DgTNX5YGrXJtwPAUbh/XCSAI6N0K
	mhw4asrsFUvls/wl0Yj/K5843P7ik0Xonh1R+wq9SribBRP7Bj4ItLZmLSbPhGVj
	OLSL8r/RbDT5LeQkPdVLmuBQa6IEVKhGQIOwCPVu/8w3EdKEe3Ggu1AwKsyx8PuF
	3PE67v1CQfG+lJyoi86316YCnQWKHJ9r3wahJzLYC4+yEu4sw39ZyIv+P5gEpRN8
	KCuEhG4hqKugqT5nqrO4jQ==;
X-AuditID: 8b5b014d-a23ec70000002178-32-650af7f748ce
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 03.EE.08568.7F7FA056; Wed, 20 Sep 2023 16:47:35 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <40052b6b-f8a3-d876-59cd-ec0f3be92d81@ics.forth.gr>
Date: Wed, 20 Sep 2023 16:47:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
Content-Language: el-GR
To: Song Shuai <songshuaishuai@tinylab.org>, lizhengyu3@huawei.com,
        liaochang1@huawei.com, xianting.tian@linux.alibaba.com,
        guoren@kernel.org, horms@kernel.org, horms@verge.net.au,
        huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com
Cc: kexec@lists.infradead.org
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsXSHT1dWff7d65Ug7/TjS1e7G1ksXjUf4LN
	onnrV0aLK98XslrsPv2VyeLao7OsFtd/Blp8/3OHxWJ/x0I2i6/b5jI7cHlMfPuRxWPnrLvs
	Hi1H3rJ6bFrVyeax86Glx+Yl9R57ek+zesz5+Y0lgCOKyyYlNSezLLVI3y6BK6Nj3QHWgvO8
	FfN+X2dtYHzJ1cXIwSEhYCKx/llMFyMXh5DAUUaJJ/vfs3UxcgLFLSU2f3rJAmLzCthLzHrQ
	wARiswioSqxaeQ4qLihxcuYTMFtUIFribf96sBphoN5TEw8zgtjMAuISR87/ZgZZICLwj1Hi
	2uJ1LBAJWYllm3aALRMScJR4++4CWJxNQFNi/qWDYDangJPE8hlToerNJLq2dkENlZdo3jqb
	eQKjwCwkd8xCsm8WkpZZSFoWMLKsYhRILDPWy0wu1kvLLyrJ0Esv2sQIjhVG3x2Mtze/1TvE
	yMTBeIhRgoNZSYQ3+RNXqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeE7YLkoUE0hNLUrNTUwtS
	i2CyTBycUg1Ms0o19K/2nkvX/WQq5fpYh0E8sOwUV/0RoyLp7TcX5HzU7JTm7fvXcsbNYebK
	mCln3BZI1R3O6T/5oyDrwYvN1Txrr/9ZFO/i7iRbf/nFKY91V3ON6+uaC56YHzI6ly++P9Kw
	S32eZEuqjF6lz07pjT9XnPmQFi23XnbGhJKLB2f5bmXrEzvKZDJjk9v2df/PZxblMLVM5N4i
	q7Q7I2hr5HS+l61HbG3Lnxp6ue82edW7LnjDQobVp+znyy43SPPzlloevDs+v+VPa7vp9Alb
	3bS/PJi4ZG/idnPlYO/6O0tMTDUaZn0zK7Z5aOASeW75HO7y8/OZMyOqH7MbThFRrFWqbeFy
	OrBwiXuzbb4SS3FGoqEWc1FxIgB/n3vMBAMAAA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_064754_570398_F37CED78 
X-CRM114-Status: GOOD (  17.34  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gOS8xNS8yMyAwNjo1MCwgU29uZyBTaHVhaSB3cm90ZToKPiBIaSwKPiAKPiBUaGlzIHNlcmll
cyBpcyBjcmVhdGVkIHRvIGltcHJvdmUgUklTQy1WIHBvcnQgb2Yga2V4ZWMtdG9vbHMsCj4gYW5k
IGlzIGJhc2VkIG9uIHRoZSBob3Jtcy9rZXhlYy10b29sczpidWlsZC10ZXN0LXJpc2N2LXYyIGJy
YW5jaC4KPiAKPiBGb3IgeW91ciBjb252ZW5pZW5jZSwgaGVyZSBpcyBteSBHaXRodWIgYnJhbmNo
IGZvciBrZXhlYy10b29sczoKPiBodHRwczovL2dpdGh1Yi5jb20vc3VnYXJmaWxsZXQva2V4ZWMt
dG9vbHMvY29tbWl0cy9ydi1JbWFnZQo+IAo+IFRoZSBmaXJzdCBmb3VyIHBhdGNoZXMgZml4ZXMg
c29tZSBidWlsZCBvciBydW50aW1lIGlzc3VlczoKPiAKPiAgICBSSVNDLVY6IFVzZSBsaW51eCx1
c2FibGUtbWVtb3J5LXJhbmdlIGZvciBjcmFzaCBrZXJuZWwKPiAgICBSSVNDLVY6IEZpeCB0aGUg
dW5kZWNsYXJlZCDigJhFTV9SSVNDVuKAmSBidWlsZCBmYWlsdXJlCj4gICAgUklTQy1WOiBHZXQg
bWVtb3J5IHJhbmdlcyBmcm9tIGlvbWVtCj4gICAgUklTQy1WOiBDb3JyZWN0IHRoZSB1c2FnZSBv
ZiBjb21tYW5kIGxpbmUgb3B0aW9uCj4gCj4gVGhlIGxhc3QgdGhyZWUgcGF0Y2hlcyBlbmFibGUg
dGhlIGtleGVjX2ZpbGVfbG9hZCBzeXNjYWxsIHRvIGxvYWQKPiB2bWxpbnV4IGFuZCBzdXBwb3J0
IGxvYWRpbmcgSW1hZ2UgYmluYXJ5IGZpbGUgZm9yIHR3byBzeXNjYWxscy4KPiAKPiAgICBSSVND
LVY6IEVuYWJsZSBrZXhlX2ZpbGVfbG9hZAo+ICAgIFJJU0MtVjogU2VwYXJhdGUgZWxmX3Jpc2N2
X2ZpbmRfcGJhc2Ugb3V0Cj4gICAgUklTQy1WOiBTdXBwb3J0IGxvYWRpbmcgSW1hZ2UgYmluYXJ5
IGZpbGUKPiAKCkEgZmV3IHllYXJzIGJhY2sgSSBkaWQgdGhlIGluaXRpYWwgd29yayBmb3Iga2V4
ZWMgb24gcmlzY3YsIGFuZCB0aGUgaWRlYSAKd2FzIHRvIHdvcmsgb24gdGhlIGtleGVjLXRvb2xz
IHJlcG8gb24gcmlzY3YgZ2l0aHViOgoKaHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2LWNvbGxhYi9r
ZXhlYy10b29scy90cmVlL3Jpc2N2CgphbmQgdGhlbiB3aGVuIHdlIGhhdmUgc29tZXRoaW5nIGlu
IGEgZ29vZCBzaGFwZSwgdG8gcHVzaCBvdXIgd29yayAKdXBzdHJlYW0uIFBlb3BsZSBrZWVwIHNl
bmRpbmcgcGF0Y2hlcyB0byB0aGUga2V4ZWMgbWFpbGluZyBsaXN0ICh0aGUgCnJpc2N2IHBvcnQg
b2Yga2V4ZWMtdG9vbHMgaXMgbm90IHVwc3RyZWFtIHNvIHRoaXMgcGF0Y2ggc2VyaWVzIHdvbid0
IAphcHBseSksIGluc3RlYWQgb2YgcHVsbCByZXF1ZXN0cyB0byB0aGUgYWJvdmUgcmVwby4KCllv
dSBoYXZlIGFuIFggc2V0IG9mIHVwZGF0ZXMsIHNvbWUgb3RoZXIgcGVvcGxlIGhhdmUgcG9zdGVk
IGFub3RoZXIgc2V0IApvZiBmaXhlcyAoZS5nLiBJIHJlbWVtdmVyIGEgZml4IGZvciBpbml0cmFt
ZnMvaW5pdHJkKSwgcGxlYXNlIGxldCdzIHdvcmsgCm9uIHRoZSBnaXRodWIgcmVwbywgZ2V0IHNv
bWV0aGluZyB0aGF0IGxvb2tzIG9rIGFuZCB0aGVuIHB1c2ggb3VyIHdvcmsgCnVwc3RyZWFtLiBJ
ZiB5b3Ugd2FudCBhY2Nlc3MgdG8gdGhlIGdpdGh1YiByZXBvIGluc3RlYWQgb2YgZG9pbmcgcHVs
bCAKcmVxdWVzdHMgZXRjIGxldCBtZSBrbm93LgoKSSdtIHNvcnJ5IEkgZGlkbid0IGhhdmUgdGhl
IHRpbWUgdG8gd29yayBvbiB0aGlzIGZ1cnRoZXIuCgpSZWdhcmRzLApOaWNrCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
