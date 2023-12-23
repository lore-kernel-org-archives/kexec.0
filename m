Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1A3C3DA6E
	for <kexec@archiver.kernel.org>; Sat, 23 Dec 2023 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QsSDIRyOe83mUDPEodyxBHySKD1N1Ik1wEmZqGBoQY=; b=43/2PPvSEJ63E8
	Qu9J0vAfKIOvobMyCaXdomYK7kUwa58y7nu5R1gvdcs2VuBOMk1IAQjg9Y9E3CmG1muGezxq7N/h5
	P+EgS6ro6JjRPWx9PFTwcuVCIZRb3e06Hxa9kkiI+9fyToDrOPsMO4EqcyEtmMVL0Yt8wntlIi1R8
	c5fvTdjg8/xUCLY/dhboUKEMMNF7Pb2Ci4PC8C+QRT3aDEfRU45YFFpybRPyE/w7ZYppiVd4CRnwD
	ayI67OpQxX8wZJew7rRrKdPHdAXCcJvXnpFbr9696Hjzmw6T8GTqSgEbpjhKnnGfzDBfVSbfVjaKI
	hETqe7CxIUSfh3ujIM8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rH2kd-0080w8-0N;
	Sat, 23 Dec 2023 14:13:15 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rH2ka-0080vb-1e;
	Sat, 23 Dec 2023 14:13:14 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33666fb9318so2447549f8f.2;
        Sat, 23 Dec 2023 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703340789; x=1703945589; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx/fXV+EcHbqpmmSYcyDXOeCutL7EPAM7xBLrv4uEvE=;
        b=MkSsl84Zk7C6iVcdREULHJb1XTCnJ5D5w5JVZ30kzyDVBOGEH/7aGHGbrNuNYv4BdG
         B3yYSduIAF25JwXV1MWQeN1giGlnko7/xZ+IK2nbX1QOjPGp3moGzO5GM0EA78eJ8Y5M
         1xd/dj/bqDHJPMWPvCcGaoBWWhDcYIGU1rcqrC2Z1YeegmrssSfG949mi0kYiRQjkOY4
         I9QZQE701N2QPHWHuKkhTIdfcx/n5SXpEhUq4UxzyQ6yLwpnc5GMaM5gFvVsJ19DN8Jg
         bwlJGNV9+mjrKJmxIQ+eCglLOQ6zhmSgxYXsnbnKG1vIgKmajl0QoSiEWI4xTOKmneGF
         9YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340789; x=1703945589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx/fXV+EcHbqpmmSYcyDXOeCutL7EPAM7xBLrv4uEvE=;
        b=Z4kbBmB6IR3GXQ2rcItixOKCzWB+V0Lkzo6n3Xylyj8AAt7RiyMv47UYqUIHsPBmfl
         N+yAX5sicfirbxAfF9Br7dKtmfK7q6fc0fRu3WuE1arWl3Ms2xPQdXAxe2YPHvfQZlKd
         ZembnzanPajjfr+hvIfIx0rKCPOTge/uUZeKwt4ZIL+fEapXCBIEhtEavQEsGgJp1Tm3
         rONM7bHgxxFc2UIIU4g7pbT08gfv0QyWj4Jmfxm/0t1kUpaXktNWM/bZ8CfCx3PXSCQl
         KBfBo2cI7VIWIZJLKPbVstiR4gKK4KXZia+C6a1gM+p0vdeMa5SCAVPDzkjm2Mp1JRAw
         uNZQ==
X-Gm-Message-State: AOJu0YywHrF7jyhnZlHkyTZIxh019o2Lojtf8NsVZSGLQN4TjSa7UFBa
	0Vr0/CUrowSva+YCBKvLMV3xlb0dHzMN9mNv/pI=
X-Google-Smtp-Source: AGHT+IGKownDA4mfkro4cu5rzFhqLlgkNKQlWWqXk9ocl5lvBdywEBVaC92dZcqf5TAFfjHMIEkpunJcbQsrPBeKmYk=
X-Received: by 2002:a05:6000:1148:b0:333:5d14:458 with SMTP id
 d8-20020a056000114800b003335d140458mr1535005wrx.86.1703340789237; Sat, 23 Dec
 2023 06:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20231221130930.32634-1-ruipengqi7@gmail.com> <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
In-Reply-To: <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
From: ruipeng qi <ruipengqi7@gmail.com>
Date: Sat, 23 Dec 2023 22:12:57 +0800
Message-ID: <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org, 
	mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org, 
	arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org, 
	maninder1.s@samsung.com, michael.christie@oracle.com, samitolvanen@google.com, 
	linux-arm-kernel@lists.infradead.org, qiruipeng@lixiang.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_061312_550805_37E96D91 
X-CRM114-Status: GOOD (  14.14  )
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

T24gRnJpLCBEZWMgMjIsIDIwMjMgYXQgMTI6MjXigK9BTSBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpCkBsaW5hcm8ub3JnPiB3cm90ZToKPiA+IE9zZHVtcCBpcyBhIG5l
dyBjcmFzaCBkdW1waW5nIHNvbHV0aW9uIGFpbWluZyBhdCBzcGVjaWZpYyBlbWJlZGRlZAo+ID4g
ZGV2aWNlcyB3aXRoaW4gYXV0b21vdGl2ZSBvciBJbmR1c3RyaWFsLgo+ID4gIC0gbGltaXRlZCBt
ZW1vcnkuCj4gPiAgLSByZWJvb3QgYXMgc29vbiBhcyBwb3NzaWJsZSB3aGVuIHN5c3RlbSBmYXVs
dC4KPgo+IE5BSywgc29ycnksIHdvcmsgd2l0aCBRdWFsY29tbSBtaW5pZHVtcCBzZXJpZXMgdG8g
aW5jb3Jwb3JhdGUgYWxsIHlvdXIKPiBuZWVkcyB0aGVyZS4KClNvcnJ5LCBJIGRpZG4ndCBleHBs
YWluIGl0IHByb3Blcmx5LiBXaWxsIGFkZCBtb3JlIGRlc2NyaXB0aW9ucyBpbiB0aGUKbmV4dCB2
ZXJzaW9uLiBPc2R1bXAgaXMgYSB0b3RhbGx5IGRpZmZlcmVudCBtaW5kdW1wLCB3aGljaCBhaW1z
IGF0CmhlbHBpbmcgdG8gc29sdmUga2VybmVsIGlzc3VlcyBhcyBlYXN5IGFzIGtkdW1wL2tleGVj
L2NyYXNoLCBidXQKd2l0aCBsaXR0bGUgY29zdHMuCgpGb3Igc29tZXRoaW5nIGxpa2UgUHN0b3Jl
LCB5b3UgY2FuIGdldCB3aGVyZSB0aGUgaXNzdWUgb2NjdXJzLiBZb3UgY2FuCmZpZ3VyZSBvdXQg
dGhlIHByb2JsZW0gaWYgaXQgaXMgZWFzeSwgYnV0IHNvbWV0aW1lcyB5b3UgY2FuJ3QuIEZvciBl
eGFtcGxlOgoKPDQ+WyAgICA1LjMxMTQzMV0gIHRhc2tfYmxvY2tzX29uX3J0X211dGV4KzB4MjM0
LzB4MzgwCjw0PlsgICAgNS4zMTYxNjZdICBydF9zcGluX2xvY2tfc2xvd2xvY2tfbG9ja2VkKzB4
Y2MvMHgyYjAKPDQ+WyAgICA1LjMyMTI1N10gIHJ0X3NwaW5fbG9ja19zbG93bG9jaysweDVjLzB4
OTAKPDQ+WyAgICA1LjMyNTYzM10gIHJ0X3NwaW5fbG9jaysweDYwLzB4NzQKPDQ+WyAgICA1LjMy
OTIwN10gIHJlZmlsbF9zdG9jaysweDU4LzB4MjMwCgpZb3UgY2FuIGZpbmQgd2hlcmUgdGhlIGlz
c3VlIG9jY3Vycy4Kc3RhdGljIGlubGluZSBzdHJ1Y3QgcnRfbXV0ZXhfd2FpdGVyICpydF9tdXRl
eF90b3Bfd2FpdGVyKHN0cnVjdCBydF9tdXRleCAqbG9jaykKIHsKICBzdHJ1Y3QgcmJfbm9kZSAq
bGVmdG1vc3QgPSByYl9maXJzdF9jYWNoZWQoJmxvY2stPndhaXRlcnMpOwogIHN0cnVjdCBydF9t
dXRleF93YWl0ZXIgKncgPSBOVUxMOwogIGlmIChsZWZ0bW9zdCkgewogICAgdyA9IHJiX2VudHJ5
KGxlZnRtb3N0LCBzdHJ1Y3QgcnRfbXV0ZXhfd2FpdGVyLCB0cmVlX2VudHJ5KTsKICAgIEJVR19P
Tih3LT5sb2NrICE9IGxvY2spOwoKQnV0IHlvdSBkb24ndCBrbm93IHdoeSB3LT5sb2NrIGFuZCBs
b2NrIGFyZSBkaWZmZXJlbnQsIGFuZCB3aG8gaXMgd3JvbmcuCgpRY29tIG1pbmlkdW1wIGNhbiBk
dW1wIHNvbWUgbG9ncyBsaWtlIGRtc2csIHNvbWUgc3RhdHVzIGxpa2UgSVJRIG9yClJ1biBxdWV1
ZS4gVGhpcyBjYW4gaGVscCB0byBsZWFybiBzb21lIGluZm9ybWF0aW9uIHdoZW4gdGhlIGlzc3Vl
IG9jY3VycywKd2hpY2ggd2lsbCBoZWxwIHRvIGZpbmQgb3V0IHRoZSByb290IGNhdXNlLiBCdXQg
d2hhdCBpdCBkdW1wcyBhcmUgbGltaXRlZCwgaXQKZG9lc24ndCBkdW1wIHcgYW5kIGxvY2sgaWYg
dGhleSBhcmUgbm90IGxvY2FsIGRhdGEuCgpGb3Igb3NkdW1wLCBpdCBkdW1wcyBvYmplY3RzIHN0
b3JlZCBpbiBzbGFiLCBkYXRhcyBpbiBic3MsIGRhdGEgc2VnbWVudHMsCnNvbWUgZGF0YSBhbGxv
Y2VkIHdpdGggbWVtYmxvY2ssIGRhdGEgc3RvcmVkIGluIGxvY2FsIHN0YWNrLCBhbmQgc28gb24u
CkluIGEgd29yZCwgaXQgZHVtcHMgYWxtb3N0IGFsbCBvZiB0aGUga2V5IGRhdGEgaW4gdGhlIGtl
cm5lbC4gQmVzaWRlcywgeW91CmNhbiB1c2UgdGhlIGNyYXNoIHRvb2wgdG8gYW5hbHl6ZSB0aGUg
ZHVtcCBmaWxlLgoKSW4gYSB3b3JkLCBJIHRoaW5rIHRoaXMgdG9hbCBkaWZmZXJlbnQgbWluaWR1
bXAgc2hvdWxkIGhhdmUgaXRzIG93biBwbGFjZSBpbgp0aGUga2VybmVsIHdvcmxkLiBMb29raW5n
IGZvcndhcmQgdG8geW91ciBzdWdnZXN0aW9ucyEKCkJlc3QgUmVnYXJkcwpSdWlwZW5nCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
