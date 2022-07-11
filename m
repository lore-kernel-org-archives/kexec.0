Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798DDC433EF
	for <kexec@archiver.kernel.org>; Mon, 11 Jul 2022 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xyu4LKy9naNMxW3ytkp787QFVuQjl2mDXyjuTptoKH0=; b=l6x4LjLOEwMFpl
	psXv7/FJG+ueUWUyzJWdbtRsgvQMZ8UO8KsSz58+EAPAjw2fwr7LnvsZT5CQ1nyi7QI25XShoNHHI
	K06iYQo32V5rKvuQo7VFMSIu2y7P3jWcy2IdZCHficUatTQCd28G9WJVG8Dw7jTtnEfns/2vBMVEL
	wrx9YkL1oeeGPusKMi+VdhJO6wfyh6/Oxc8WeGXAkGLGRwNBtf5xy/OxM1aTwBvAmq5MeqY0nM628
	ASPAROO2bv7uXMPgnxUEchCwPR0xqYAmwMGUxMj65/ICUmnyvlFmmCBi73w7aYqoL07eRP3uyC+mQ
	RKgviBE7Vjbsu2zJxRgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAvXR-002vtB-Q7; Mon, 11 Jul 2022 15:41:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAvXO-002vle-2Z
	for kexec@lists.infradead.org; Mon, 11 Jul 2022 15:41:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id D362FCE13B0;
	Mon, 11 Jul 2022 15:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C0FC341CE;
	Mon, 11 Jul 2022 15:41:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="m9q67LKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1657554080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JWQpNCT+1rOX2bMYTOFYgsKk+Ew78LIky7evDnR9kE=;
	b=m9q67LKDXN7TSuqfcxSjTw3bjam8OKu4w/M9Am9B9h2LLad3JdMNm5DaYY3s7Iamx6oIn/
	+LyIuDTjm4PDewBmHiX/lcDdGLB8Q5qEPbNbpPByWFWC5nSvkf54aKMqFr/pwCI+zC/0CU
	KmMhq8wPMf+K1jiP+sKovxh0efzYkxo=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 39e9e96a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
	Mon, 11 Jul 2022 15:41:19 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kexec-tools] i386: pass rng seed via setup_data
Date: Mon, 11 Jul 2022 17:41:10 +0200
Message-Id: <20220711154110.156015-1-Jason@zx2c4.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_084130_307594_F1D7CE16 
X-CRM114-Status: GOOD (  13.33  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

TGludXgg4omlNS4yMCBleHBlY3RzIGEgUk5HIHNlZWQgdmlhIHNldHVwX2RhdGEgYXMgb2YgdGhl
IHVwc3RyZWFtIGNvbW1pdAppbiB0aGUgbGluayBiZWxvdy4gVGhhdCBjb21taXQgYWRqdXN0cyBr
ZXhlY19maWxlX2xvYWQgdG8gcGFzcwpTRVRVUF9STkdfU0VFRC4ga2V4ZWMtdG9vbHMgc2hvdWxk
IGZvbGxvdyBzdWl0ZSwgc28gYWRkIG1vcmUgb3IgbGVzcyB0aGUKc2FtZSBjb2RlIGhlcmUuCgpM
aW5rOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3RpcC90aXAvYy82OGI4ZTk3MTNjOApTaWduZWQt
b2ZmLWJ5OiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4KLS0tCiBrZXhlYy9h
cmNoL2kzODYveDg2LWxpbnV4LXNldHVwLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2tleGVjL2Fy
Y2gvaTM4Ni94ODYtbGludXgtc2V0dXAuYyBiL2tleGVjL2FyY2gvaTM4Ni94ODYtbGludXgtc2V0
dXAuYwppbmRleCBhYjU0YTRhLi4xNDI2M2IwIDEwMDY0NAotLS0gYS9rZXhlYy9hcmNoL2kzODYv
eDg2LWxpbnV4LXNldHVwLmMKKysrIGIva2V4ZWMvYXJjaC9pMzg2L3g4Ni1saW51eC1zZXR1cC5j
CkBAIC0yNCw2ICsyNCw3IEBACiAjaW5jbHVkZSA8bGltaXRzLmg+CiAjaW5jbHVkZSA8c3lzL3R5
cGVzLmg+CiAjaW5jbHVkZSA8c3lzL3N0YXQuaD4KKyNpbmNsdWRlIDxzeXMvcmFuZG9tLmg+CiAj
aW5jbHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KICNpbmNsdWRlIDxsaW51
eC9mYi5oPgpAQCAtNTQ0LDYgKzU0NSw3IEBAIHN0cnVjdCBzZXR1cF9kYXRhIHsKICNkZWZpbmUg
U0VUVVBfRFRCCTIKICNkZWZpbmUgU0VUVVBfUENJCTMKICNkZWZpbmUgU0VUVVBfRUZJCTQKKyNk
ZWZpbmUgU0VUVVBfUk5HX1NFRUQJOQogCXVpbnQzMl90IGxlbjsKIAl1aW50OF90IGRhdGFbMF07
CiB9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOwpAQCAtODI0LDYgKzgyNiwyNiBAQCBzdGF0aWMg
dm9pZCBzZXR1cF9lODIwKHN0cnVjdCBrZXhlY19pbmZvICppbmZvLCBzdHJ1Y3QgeDg2X2xpbnV4
X3BhcmFtX2hlYWRlciAqcgogCX0KIH0KIAorc3RhdGljIHZvaWQgc2V0dXBfcm5nX3NlZWQoc3Ry
dWN0IGtleGVjX2luZm8gKmluZm8sCisJCQkgICBzdHJ1Y3QgeDg2X2xpbnV4X3BhcmFtX2hlYWRl
ciAqcmVhbF9tb2RlKQoreworCXN0cnVjdCB7CisJCXN0cnVjdCBzZXR1cF9kYXRhIGhlYWRlcjsK
KwkJdWludDhfdCBybmdfc2VlZFszMl07CisJfSAqc2Q7CisKKwlzZCA9IHhtYWxsb2Moc2l6ZW9m
KCpzZCkpOworCXNkLT5oZWFkZXIubmV4dCA9IDA7CisJc2QtPmhlYWRlci5sZW4gPSBzaXplb2Yo
c2QtPnJuZ19zZWVkKTsKKwlzZC0+aGVhZGVyLnR5cGUgPSBTRVRVUF9STkdfU0VFRDsKKworCWlm
IChnZXRyYW5kb20oc2QtPnJuZ19zZWVkLCBzaXplb2Yoc2QtPnJuZ19zZWVkKSwgR1JORF9OT05C
TE9DSykgIT0KKwkgICAgc2l6ZW9mKHNkLT5ybmdfc2VlZCkpCisJCXJldHVybjsgLyogTm90IGlu
aXRpYWxpemVkLCBzbyBkb24ndCBwYXNzIGEgc2VlZC4gKi8KKworCWFkZF9zZXR1cF9kYXRhKGlu
Zm8sIHJlYWxfbW9kZSwgJnNkLT5oZWFkZXIpOworfQorCiBzdGF0aWMgaW50CiBnZXRfZWZpX21l
bV9kZXNjX3ZlcnNpb24oc3RydWN0IHg4Nl9saW51eF9wYXJhbV9oZWFkZXIgKnJlYWxfbW9kZSkK
IHsKQEAgLTkyMyw2ICs5NDUsOSBAQCB2b2lkIHNldHVwX2xpbnV4X3N5c3RlbV9wYXJhbWV0ZXJz
KHN0cnVjdCBrZXhlY19pbmZvICppbmZvLAogCiAJc2V0dXBfZTgyMChpbmZvLCByZWFsX21vZGUp
OwogCisJLyogcGFzcyBSTkcgc2VlZCAqLworCXNldHVwX3JuZ19zZWVkKGluZm8sIHJlYWxfbW9k
ZSk7CisKIAkvKiBmaWxsIHRoZSBFREQgaW5mb3JtYXRpb24gKi8KIAlzZXR1cF9lZGRfaW5mbyhy
ZWFsX21vZGUpOwogCi0tIAoyLjM1LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
