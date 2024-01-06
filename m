Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDFFC46CD2
	for <kexec@archiver.kernel.org>; Sat,  6 Jan 2024 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZF9PEbY4u/zYwCNb1z/vxClx5NKKcA3jgXa7JS7Msvs=; b=UuNpEQc1S68lpx
	BEy9TaANaxpN7AXeKfB1LWfn02UPlP5R1ES0U6dW0XujAzkO0iURJlEJqCMPnWj191xjf+5B+st1+
	am1vulOn4V2EspWQ7g7H2drCUUXqoI5lEQjcigH9CYMOgozaq1B1Oo9bCfXHfqnUL+N/Ldcbzpktw
	m3R24DnYzN+Vl2na1n1D67tKxatlhZjFOtnbp1s+oaixU559ElF4WfLXaywbZDJpWFwiysKw0yWs1
	MUucRI+GbSUu66FZZ7+pdY7c0VBlLJJAMBVMHltRL+nGge0Sga/DjT2YUZZrlj/PGxvKSj7Vx6BB+
	XhzsgRGy0MRC8ZJ/PxKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMG5J-0022A1-1x;
	Sat, 06 Jan 2024 23:28:09 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMG5F-00229c-27
	for kexec@lists.infradead.org;
	Sat, 06 Jan 2024 23:28:08 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3bbd1fab171so691935b6e.1
        for <kexec@lists.infradead.org>; Sat, 06 Jan 2024 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704583684; x=1705188484; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9JaYs/iBuW3+vvOlsyG26SMcgbIMGOxrh4TLTzxUyo=;
        b=Q9p6igoP78hDdnUKqsEHH+m0sVSp0tu3VENeydah+AQdocHRUgHAIpkZgdXENk2bOk
         2uYoe5Mo5C419sr6ZrOA3reI9HOrOvj39oLkjp2vYzG6/d0bbeBbRQWgG3+l7xLes7lu
         Qc2emuv71k2CA0ZxIPRARe9NLbb+93FO3HXNvu+TxVTEbz/CA3+XAjhJl5dndaNzvGE2
         Jpj2Coidr1WiMk0PmlRqxDOrca/rSHwIfkeEJ2IZuiPP5e4YeAhTca2A6eTkcHcoKBJj
         9mIMVunRr1Ohhiu2Ku17x+bt7HooCkfo6S1ACUFY61ukquUpbNxKQ71w3xbK2JjXIc84
         F2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704583684; x=1705188484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9JaYs/iBuW3+vvOlsyG26SMcgbIMGOxrh4TLTzxUyo=;
        b=E8mhXpWJ8vVgK7bHbA11CvxN++t4fr3tHT9cjGhAgZWbkCQ8XWEXX/5zzfA98Gw/cQ
         fce3anySWzYpRyv3Qbjh6dOzB3nFBg53MrEuOiuJH+60NB+1o1lNVh12bcrQfBigJ1jb
         2UT4oZQjv44+8YneLznos6SfnXazRk9medSr3cJgaU+RbdecVO8HybQaMXzSbiD4lU+4
         viOvvLer0HTnK+8Ja5Ooe01RBYM7cnCagDRieqc2ac5atVLp6Vi0tSme4q2COwcH1aCj
         lA45PW1huxGMcDGCRLfKdrhbLESAYNMmU4IxSRD+UMaFwmgq5irYc4CYEmkYAP49p0+1
         sOrQ==
X-Gm-Message-State: AOJu0Yzb0WtN3e/WueBBkZC9xcx7OZYszZwLvZ1Pi5+tt9gYyYzKSsbU
	3V3YTvciMkNWS/hBQcu9atVSoShyMHfHP22hFDNBEhgzQjtO
X-Google-Smtp-Source: AGHT+IE8SjipfKR+0SQZ9dpU9mjuiSISCRe1xTExjHHcaZCgkam8SzLVmGJ2K6giadt5HwjBOBvSvjl3a5cJdDtmNdE=
X-Received: by 2002:a54:440a:0:b0:3bb:be11:c1a6 with SMTP id
 k10-20020a54440a000000b003bbbe11c1a6mr1078693oiw.104.1704583683794; Sat, 06
 Jan 2024 15:28:03 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
 <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
 <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com> <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
In-Reply-To: <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 6 Jan 2024 18:27:52 -0500
Message-ID: <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240106_152806_544243_A3F27D72 
X-CRM114-Status: GOOD (  35.27  )
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

T24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgOTowN+KAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgMjAyMy0xMS0yOCBhdCAyMDowNiAtMDUwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+IE9uIFR1ZSwgTm92IDI4LCAyMDIzIGF0IDc6MDnigK9BTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCAyMDIzLTEx
LTI3IGF0IDE3OjE2IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgTm92
IDI3LCAyMDIzIGF0IDEyOjA44oCvUE0gTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQsIDIwMjMtMTEtMjIgYXQgMDk6MjIgLTA1MDAsIFBhdWwg
TW9vcmUgd3JvdGU6CgouLi4KCj4gPiA+ID4gPiBCZWZvcmUgZGVmaW5pbmcgYSBuZXcgY3JpdGlj
YWwtZGF0YSByZWNvcmQsIHdlIG5lZWQgdG8gZGVjaWRlIHdoZXRoZXIKPiA+ID4gPiA+IGl0IGlz
IHJlYWxseSBuZWNlc3Nhcnkgb3IgaWYgaXQgaXMgcmVkdW5kYW50LiAgSWYgd2UgZGVmaW5lIGEg
bmV3Cj4gPiA+ID4gPiAiY3JpdGljYWwtZGF0YSIgcmVjb3JkLCBjYW4gaXQgYmUgZGVmaW5lZCBz
dWNoIHRoYXQgaXQgZG9lc24ndCByZXF1aXJlCj4gPiA+ID4gPiBwYXVzaW5nIGV4dGVuZGluZyB0
aGUgbWVhc3VyZW1lbnQgbGlzdD8gIEZvciBleGFtcGxlLCBhIG5ldyBzaW1wbGUKPiA+ID4gPiA+
IHZpc3VhbCBjcml0aWNhbC1kYXRhIHJlY29yZCBjb3VsZCBjb250YWluIHRoZSBudW1iZXIgb2Yg
cmVjb3JkcyAoZS5nLgo+ID4gPiA+ID4gPHNlY3VyaXR5ZnM+L2ltYS9ydW50aW1lX21lYXN1cmVt
ZW50c19jb3VudCkgdXAgdG8gdGhhdCBwb2ludC4KPiA+ID4gPgo+ID4gPiA+IFdoYXQgaWYgdGhl
IHNuYXBzaG90X2FnZ3JlZ2F0ZSB3YXMgYSBoYXNoIG9mIHRoZSBtZWFzdXJlbWVudCBsb2cKPiA+
ID4gPiBzdGFydGluZyB3aXRoIGVpdGhlciB0aGUgYm9vdF9hZ2dyZWdhdGUgb3IgdGhlIGxhdGVz
dAo+ID4gPiA+IHNuYXBzaG90X2FnZ3JlZ2F0ZSBhbmQgZW5kaW5nIG9uIHRoZSByZWNvcmQgYmVm
b3JlIHRoZSBuZXcKPiA+ID4gPiBzbmFwc2hvdF9hZ2dyZWdhdGU/ICBUaGUgcGVyZm9ybWFuY2Ug
aW1wYWN0IGF0IHNuYXBzaG90IHRpbWUgc2hvdWxkIGJlCj4gPiA+ID4gbWluaW1hbCBhcyB0aGUg
aGFzaCBjYW4gYmUgaW5jcmVtZW50YWxseSB1cGRhdGVkIGFzIG5ldyByZWNvcmRzIGFyZQo+ID4g
PiA+IGFkZGVkIHRvIHRoZSBtZWFzdXJlbWVudCBsaXN0LiAgV2hpbGUgdGhlIGhhc2ggd291bGRu
J3QgY2FwdHVyZSB0aGUKPiA+ID4gPiBUUE0gc3RhdGUsIGl0IHdvdWxkIGFsbG93IHNvbWUgY3J1
ZGUgdmVyaWZpY2F0aW9uIHdoZW4gcmVhc3NlbWJsaW5nCj4gPiA+ID4gdGhlIGxvZy4gIElmIG9u
ZSBjb3VsZCBiZWFyIHRoZSBjb3N0IG9mIGEgVFBNIHNpZ25pbmcgb3BlcmF0aW9uLCB0aGUKPiA+
ID4gPiBsb2cgZGlnZXN0IGNvdWxkIGJlIHNpZ25lZCBieSB0aGUgVFBNLgo+ID4gPgo+ID4gPiBP
dGhlciBjcml0aWNhbCBkYXRhIGlzIGNhbGN1bGF0ZWQsIGJlZm9yZSBjYWxsaW5nCj4gPiA+IGlt
YV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoKSwgd2hpY2ggYWRkcyB0aGUgcmVjb3JkIHRvIHRoZSBt
ZWFzdXJlbWVudAo+ID4gPiBsaXN0IGFuZCBleHRlbmRzIHRoZSBUUE0gUENSLgo+ID4gPgo+ID4g
PiBTaWduaW5nIHRoZSBoYXNoIHNob3VsZG4ndCBiZSBhbiBpc3N1ZSBpZiBpdCBiZWhhdmVzIGxp
a2Ugb3RoZXIKPiA+ID4gY3JpdGljYWwgZGF0YS4KPiA+ID4KPiA+ID4gSW4gYWRkaXRpb24gdG8g
dGhlIGhhc2gsIGNvbnNpZGVyIGluY2x1ZGluZyBvdGhlciBpbmZvcm1hdGlvbiBpbiB0aGUKPiA+
ID4gbmV3IGNyaXRpY2FsIGRhdGEgcmVjb3JkIChlLmcuIHRvdGFsIG51bWJlciBvZiBtZWFzdXJl
bWVudCByZWNvcmRzLCB0aGUKPiA+ID4gbnVtYmVyIG9mIG1lYXN1cmVtZW50cyBpbmNsdWRlZCBp
biB0aGUgaGFzaCwgdGhlIG51bWJlciBvZiB0aW1lcyB0aGUKPiA+ID4gbWVhc3VyZW1lbnQgbGlz
dCB3YXMgdHJpbW1lZCwgZXRjKS4KPiA+Cj4gPiBJdCB3b3VsZCBiZSBuaWNlIGlmIHlvdSBjb3Vs
ZCBwcm92aWRlIGFuIGV4cGxpY2l0IGxpc3Qgb2Ygd2hhdCB5b3UKPiA+IHdvdWxkIHdhbnQgaGFz
aGVkIGludG8gYSBzbmFwc2hvdF9hZ2dyZWdhdGUgcmVjb3JkOyB0aGUgYWJvdmUgaXMKPiA+IGNs
b3NlLCBidXQgaXQgaXMgc3RpbGwgYSBsaXR0bGUgaGFuZC13YXZ5LiAgSSdtIGp1c3QgdHJ5aW5n
IHRvIHJlZHVjZQo+ID4gdGhlIGJhY2stbi1mb3J0aCA6KQo+Cj4gV2hhdCBpcyBiZWluZyBkZWZp
bmVkIGhlcmUgaXMgdGhlIGZpcnN0IElNQSBjcml0aWNhbC1kYXRhIHJlY29yZCwgd2hpY2gKPiBy
ZWFsbHkgcmVxdWlyZXMgc29tZSB0aG91Z2h0LgoKTXkgdGhpbmtpbmcgaGFzIGFsd2F5cyBiZWVu
IHRoYXQgdGFraW5nIGEgaGFzaCBvZiB0aGUgY3VycmVudAptZWFzdXJlbWVudCBsb2cgdXAgdG8g
dGhlIHNuYXBzaG90IHBvaW50IHdvdWxkIGJlIGEgbmljZQpzbmFwc2hvdF9hZ2dyZWdhdGUgbWVh
c3VyZW1lbnQsIGJ1dCBJJ20gbm90IGhlYXZpbHkgaW52ZXN0ZWQgaW4gdGhhdC4KVG8gbWUgaXQg
aXMgbW9yZSBpbXBvcnRhbnQgdGhhdCB3ZSBmaW5kIHNvbWV0aGluZyB3ZSBjYW4gYWxsIGFncmVl
IG9uLApwZXJoYXBzIHJlbHVjdGFudGx5LCBzbyB3ZSBjYW4gbW92ZSBmb3J3YXJkIHdpdGggYSBz
b2x1dGlvbi4KCj4gRm9yIGVhc2Ugb2YgcmV2aWV3LCB0aGlzIG5ldyBjcml0aWNhbC0KPiBkYXRh
IHJlY29yZCBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCBzZXQgZnJvbSB0cmltbWluZyB0aGUK
PiBtZWFzdXJlbWVudCBsaXN0LgoKSSBzZWUgdGhlIHR3byBhcyBsaW5rZWQsIGJ1dCBpZiB5b3Ug
cHJlZmVyIHRoZW0gYXMgc2VwYXJhdGUgdGhlbiBzbyBiZQppdC4gIE9uY2UgYWdhaW4sIHRoZSBp
bXBvcnRhbnQgcGFydCBpcyB0byBtb3ZlIGZvcndhcmQgd2l0aCBhCnNvbHV0aW9uLCBJJ20gbm90
IG92ZXJseSBib3RoZXJlZCBpZiBpdCBhcnJpdmVzIGluIG11bHRpcGxlIHBpZWNlcwppbnN0ZWFk
IG9mIG9uZS4KCj4gQXMgSSdtIHN1cmUgeW91J3JlIGF3YXJlLCBTRWxpbnV4IGRlZmluZXMgdHdv
IGNyaXRpY2FsLWRhdGEgcmVjb3Jkcy4KPiBGcm9tIHNlY3VyaXR5L3NlbGludXgvaW1hLmM6Cj4K
PiAgICAgICAgIGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoInNlbGludXgiLCAic2VsaW51eC1z
dGF0ZSIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRlX3N0ciwgc3Ry
bGVuKHN0YXRlX3N0ciksIGZhbHNlLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBOVUxMLCAwKTsKPgo+ICAgICAgICAgaW1hX21lYXN1cmVfY3JpdGljYWxfZGF0YSgic2VsaW51
eCIsICJzZWxpbnV4LXBvbGljeS1oYXNoIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcG9saWN5LCBwb2xpY3lfbGVuLCB0cnVlLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBOVUxMLCAwKTsKClllcCwgYnV0IHRoZXJlIGlzIGZhciBtb3JlIHRvIHRoaXMg
dGhhbiBTRUxpbnV4LgoKLS0gCnBhdWwtbW9vcmUuY29tCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
