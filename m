Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C98ECF259D
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 02:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=43D8GPrnsidD8VWIEX4r/tCuDpEE1em0HnlbSrBkjdI=; b=jIcg8aEyfVxPPq
	ga9GLag6J+MvFRTGxw8SZ4A5luC1cG4lJ+w9dkk6d0yrqsnjW2mpb1hXaF8YY0F2tBpNdj7j5hBNf
	CvPeRSmAsAArZGoOUKP+pxpnB1puY1/MrQiYmN9fBlysvzko3q9fyzwyNXSQZXfv7asfycovK9OaG
	3kLtUwxEdXkBKQq7vcqvGANbQw8Q0j94HaPCHefnIpMkGR8PFSkly3rIVkWiKYtHbZcNwrgCYrKra
	r20qK0LvQRkEys+WKWqajJkysfD+f16IFmacKv8566NdaJGfK+UrYHwC1dsoEdJYCHPJq0jr3+Tn8
	fhlT8qhr44h/A4WUQElA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0B3s-00000003ZU7-1B9u;
	Mon, 14 Oct 2024 02:43:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0B3m-00000003ZT9-0X4x
	for kexec@lists.infradead.org;
	Mon, 14 Oct 2024 02:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728873827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvD2HMGNBP36fP87+RdzedrP6rxU/0wtHPTnxRD1PNM=;
	b=X03M5Xy8cLSvIKJtiFZPLrK3P2mWLmZFLr2qen1nrfxtgxG+TwdFyZ4qTydybeJaMp4y7+
	DzxY2ca2gSoG+tu8wBfYMKBzEz+TrZuHjoyupPXUqyqjNaLzBIUd5pUe6Gc/aNvpu+zk3j
	lvPkPwGMnc2H1vW3TUfjqZSaufL9PdQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-GQQWIN81PK6C8q47MFYNJw-1; Sun, 13 Oct 2024 22:43:46 -0400
X-MC-Unique: GQQWIN81PK6C8q47MFYNJw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe50b415eso65671286d6.3
        for <kexec@lists.infradead.org>; Sun, 13 Oct 2024 19:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728873826; x=1729478626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvD2HMGNBP36fP87+RdzedrP6rxU/0wtHPTnxRD1PNM=;
        b=dvlGgVnjrM3qoK6u+inZjqolDrXH4s/XQcoV8OtbYxeVV1wFfaPBMBZm6skpEvN/qu
         uUSOHAmfNbqakVon1IhuYDEMn3MAoYtLSt7cTCqQyTJNT6dBF+tJpBefRYN40DpmMGHA
         RG2RK2k9wPiTlvShmVHSxx3d7Kq0uIphBfQcfxnZ9pjOnLJWULTSWTmP0GRoBjuc1a6F
         Ez9CN0ZAQhBIeiagg5u7UGFrGdPkrQqfwLg/6yUqDo5KNiVCahSFwTC4M9zJc13I+ok2
         jlYSATf1yWgvsce5vJK4CvvOZCTtGe3NdR0cysLPteahtM2G3wDwYMGBEZfeEYnVBxuK
         4nVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW1PLhBdFVaoYLvxyTknzx4W+YZVgB5nVzp8x2LHVZB8OwCHQCKvnEUWCffDdSa8IFxZW9nA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzzrUAdlx7jqF1rpP0LCC3dMqh6hFuWWTCTS1pEISEUHaOjxYrD
	p4Ogx73YzcgF+bKJL0f9WIQ4zc8eGd43L3ftvAmr74soXRIffun2qPuLKuVg0RHBVMZrFQQOnlv
	DSU5Z939ViZ8QN99/g6M9hhQ0EjovwIRvpxDh103yYXNMatdWHnMHMP/vevqNGXqs6Svt6uPc2Z
	TFUX2yr254X5/rRj86mbN8NWsFPTH//cBN
X-Received: by 2002:a05:6214:328d:b0:6cb:4365:3782 with SMTP id 6a1803df08f44-6cbf0044a2fmr132399116d6.15.1728873825894;
        Sun, 13 Oct 2024 19:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHY8SNxwSYUccsD/PibgVVVM0ymD65umgj3FYnhOI12pJTo5T6jVYxuoYAjxl9wyH10uHQwb7V4nia+LRbVk=
X-Received: by 2002:a05:6214:328d:b0:6cb:4365:3782 with SMTP id
 6a1803df08f44-6cbf0044a2fmr132398946d6.15.1728873825614; Sun, 13 Oct 2024
 19:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241008115408.21944-1-piliu@redhat.com> <20241008115408.21944-3-piliu@redhat.com>
 <20241011084406.GB66815@kernel.org> <CAF+s44QMLaQLmm6cst+o2Ssgi2v-SBXcw3hE1kKTFnL7DmoLFg@mail.gmail.com>
In-Reply-To: <CAF+s44QMLaQLmm6cst+o2Ssgi2v-SBXcw3hE1kKTFnL7DmoLFg@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 14 Oct 2024 10:43:34 +0800
Message-ID: <CAF+s44QRNpBrRuJsuVwvZduHTLhEFTtUz3fU5=4YNAn8sbBccw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kexec: Introduce UKI image parser
To: Simon Horman <horms@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Philipp Rudo <prudo@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_194350_262652_958EFD5B 
X-CRM114-Status: GOOD (  25.31  )
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

SGVsbG8gZXZlcnlvbmUsCgpJIGhhdmUgY3JlYXRlZCBWMiBhbmQgbWFrZSBhIFBSOiBodHRwczov
L2dpdGh1Yi5jb20vaG9ybXMva2V4ZWMtdG9vbHMvcHVsbC85CgpEdWUgdG8gdXRpbGl6aW5nIHRo
ZSB3b3JrZmxvdyBpbiBnaXRodWIgdG8gaGF2ZSBzb21lIGJhc2ljIGNoZWNrcwphdXRvbWF0aWNh
bGx5ICwgSSBtaWdyYXRlZCBpdCB0byBnaXRodWIgaW5zdGVhZCBvZiBtYWlsaW5nLWxpc3QuCgpQ
bGVhc2Ugc2hhcmUgeW91ciBvcGluaW9ucy4KCgpUaGFua3MKCk9uIEZyaSwgT2N0IDExLCAyMDI0
IGF0IDc6MTTigK9QTSBQaW5nZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBP
biBGcmksIE9jdCAxMSwgMjAyNCBhdCA0OjQ04oCvUE0gU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUsIE9jdCAwOCwgMjAyNCBhdCAwNzo1NDowMlBN
ICswODAwLCBQaW5nZmFuIExpdSB3cm90ZToKPiA+ID4gQSBVS0kgaW1hZ2UgaXMgYSBQRSBmaWxl
IHRoYXQgY29uc2lzdHMgb2Ygc2V2ZXJhbCBzZWN0aW9ucywgdHlwaWNhbGx5Cj4gPiA+IGluY2x1
ZGluZzogLnRleHQsIC5kYXRhLCAubGludXgsIC5pbml0cmQsIC5jbWRsaW5lLCBhbmQgb3RoZXJz
Lgo+ID4gPgo+ID4gPiBUaGUga2VybmVsIGltYWdlIGlzIHN0b3JlZCBpbiB0aGUgLmxpbnV4IHNl
Y3Rpb24sIHdoaWNoIGlzIG9uZSBvZiB0aGUKPiA+ID4gZm9ybWF0cyBjdXJyZW50bHkgcmVjb2du
aXplZCBieSBrZXhlYy10b29scy4gVGhlcmVmb3JlLCB0aGUgVUtJIHBhcnNlcgo+ID4gPiBjYW4g
YmUgdXNlZCB0byBzdHJpcCBhd2F5IHRoZSBVS0kgbGF5ZXIsIGFsbG93aW5nIHRoZSBvdGhlciBw
YXJzZXIgdG8KPiA+ID4gcHJvY2VzcyB0aGUga2VybmVsIGltYWdlLgo+ID4gPgo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQaW5nZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNvbT4KPiA+ID4gQ2M6IFNpbW9u
IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KPiA+ID4gQ2M6IEVyaWMgQmllZGVybWFuIDxlYmll
ZGVybUB4bWlzc2lvbi5jb20+Cj4gPiA+IENjOiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4K
PiA+ID4gQ2M6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgo+ID4gPiBDYzoga2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwo+ID4gPiAtLS0KPiA+ID4gIGluY2x1ZGUvcGUuaCAgICAgIHwg
MTA0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiAga2V4ZWMv
TWFrZWZpbGUgICAgfCAgIDEgKwo+ID4gPiAga2V4ZWMva2V4ZWMtdWtpLmMgfCAxMjIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiAga2V4ZWMva2V4
ZWMuaCAgICAgfCAgIDQgKysKPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjMxIGluc2VydGlvbnMo
KykKPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3BlLmgKPiA+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBrZXhlYy9rZXhlYy11a2kuYwo+ID4KPiA+IEhpIFBpbmdmYW4gTGl1LAo+ID4K
PiA+IEkgdGhpbmsgeW91IG5lZWQgdG8gc3F1YXNoIHRoZSBmb2xsb3dpbmcgaW50byB0aGlzIHBh
dGNoCj4gPiBzbyB0aGF0IHBlLmggaXMgaW5jbHVkZWQgaW4gZGlzdHJpYnV0aW9uIHRhcmJhbGxz
Lgo+ID4KPiA+IFlvdSBzaG91bGQgYmUgYWJsZSB0byBzZWUgdGhlIHByb2JsZW0gYnkgcnVubmlu
ZzogbWFrZSBkaXN0Y2hlY2suCj4gPgo+Cj4gT2gsIHRoYW5rcy4gSSB3aWxsIGZpeCBpdCBpbiBW
MiBhbmQgIHJlbWVtYmVyIHRvIGRvIHN1Y2ggdGVzdHMgaW4gZnV0dXJlLgo+Cj4gQmVzdCByZWdh
cmRzLAo+Cj4gUGluZ2Zhbgo+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9NYWtlZmlsZSBiL2lu
Y2x1ZGUvTWFrZWZpbGUKPiA+IGluZGV4IGNkODhhMjZiMTQ3Ni4uNmEzZTg1NDFjMzZkIDEwMDY0
NAo+ID4gLS0tIGEvaW5jbHVkZS9NYWtlZmlsZQo+ID4gKysrIGIvaW5jbHVkZS9NYWtlZmlsZQo+
ID4gQEAgLTgsNiArOCw3IEBAIGRpc3QgKz0gaW5jbHVkZS9NYWtlZmlsZSAgICAgICAgICAgICAg
ICBcCj4gPiAgICAgICAgIGluY2x1ZGUveDg2L21iX2hlYWRlci5oICAgICAgICAgXAo+ID4gICAg
ICAgICBpbmNsdWRlL3g4Ni9tdWx0aWJvb3QyLmggICAgICAgIFwKPiA+ICAgICAgICAgaW5jbHVk
ZS9lbGYuaCAgICAgICAgICAgICAgICAgICBcCj4gPiArICAgICAgIGluY2x1ZGUvcGUuaCAgICAg
ICAgICAgICAgICAgICAgXAo+ID4gICAgICAgICBpbmNsdWRlL2ltYWdlLmggICAgICAgICAgICAg
ICAgIFwKPiA+ICAgICAgICAgaW5jbHVkZS91bnVzZWQuaCAgICAgICAgICAgICAgICBcCj4gPiAg
ICAgICAgIGluY2x1ZGUvYm9vdC9saW51eGJpb3NfdGFibGVzLmggXAo+ID4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
