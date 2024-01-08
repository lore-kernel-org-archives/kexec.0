Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCFEC47074
	for <kexec@archiver.kernel.org>; Mon,  8 Jan 2024 02:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H+cBWaq+payjWBGufc8l0O2bJYtOYjemgRWKEJXuyGQ=; b=NRP+X58z22/AQo
	weFAjZ3Mb/MzEuVsb6/xlX1ITZMOCSfv+sF3QgOUqLRjxUzyUA/hEEeCNyithr3N2TPH4t594q+0J
	UHdSq830MUVOv/6XIRoS/zW0ecaMQpUGTXu4vu1yBroq08BRvXAeoJuf9LZzW7vzHkyPs18/BfKOr
	kt1CSl0TmjFOsib4e4R0UWgFUx50V6GDtiExqdTVQqm4NLsGWkmE+DhWUXV/T3Udi+J7M2OxJjtmm
	jdEbbmd1wX3yf5ldtwNenErlGsgoP6RlmrYbTV3VHvC7NSn4eq2TF+Qpln8Sn8wPixcERHXC2HjsJ
	fKTkmGFyTc2Oe7zr6KMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMfqk-003sDF-1O;
	Mon, 08 Jan 2024 02:58:50 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMfqg-003sCp-2f
	for kexec@lists.infradead.org;
	Mon, 08 Jan 2024 02:58:49 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6808c3938afso15183026d6.1
        for <kexec@lists.infradead.org>; Sun, 07 Jan 2024 18:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704682724; x=1705287524; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlIIC5u/eTGl34/V75N+OsotTMr0HSydl9c69RMzHn0=;
        b=CUhBPA2ySlYdOWK7NLl/Pu3SzI+bAjJuOraPgaP1BX5gtIVkznxTLt3hCzHhJhqk3o
         ahJn/fTZDPAKxSuDfzSDFD+S6JTR/wwGcGTeRg8QhXdUEcPf9JshJi/Ho/xoFgDWekkQ
         559B2cIiH7/132T1yI1wpNO13YvCMNoxFgp6EP7DJgsQzR09b/SWghYUo3vOXZDGrs32
         0XpEdOag/nNQZAlmnicHERlRuOty5Nk/TFWK26PJxoCdDaKO0biTy3y1qTPmnMrVEkjj
         S26yXQ0rozWVvJvfTypXd9S84MzgfsECG04AUfvGABT5diE7Lngn0xGxnc5HOASv9bYY
         mIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704682724; x=1705287524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlIIC5u/eTGl34/V75N+OsotTMr0HSydl9c69RMzHn0=;
        b=skDALX4DmAypOzI7OsBrLJXQJ8H5NwrUi+QeK3aqPj0G6PS1DgRFOZACHIER0/Qihz
         sKtn3rZjk/Jw5JZbWsoje+hLKqQdsBKjKw3kZNTIg8gwuTNfRpH+1ZjqgRtzjLbRejWc
         CtPMsG7xyRtiGu1GtE29M4B2IJfmCGT8cdqtFjBSinlrTddNskNPjseN/5Nmdy6bDePZ
         HSCKSdwwV3zdo9wbazlIlUzwPUbC21nPJK22xUkKXpV8IIm8aZc+a4ZABISkiD7oL2NQ
         YY+O3qjSTPG3mq2Qhdc6lgfiOvaVPYI7fw9l0B4aw99fw/s3mHi4vkrWhWbPdv3Kbg7U
         f/tg==
X-Gm-Message-State: AOJu0Yw3jBqMg7YnPXoxe+TMW1A53Px0GoEKIcLqOB03LIIVOcv7L9qF
	gES64tIHLBqqS01EMSzuLwnnj2MLiMZs0g909y2UwjlIa1Sq
X-Google-Smtp-Source: AGHT+IGACtAKjaMoPGc2k72C9NOma3jMrbB56JAYTw6ZeHqXVo0kVYSoHxnrmj+UtkF+odAAWzpMyPA6aAiB4Bhd9dQ=
X-Received: by 2002:a05:6214:401:b0:680:b79f:736e with SMTP id
 z1-20020a056214040100b00680b79f736emr4710723qvx.125.1704682724585; Sun, 07
 Jan 2024 18:58:44 -0800 (PST)
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
 <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
 <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
 <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com> <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
In-Reply-To: <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Jan 2024 21:58:33 -0500
Message-ID: <CAHC9VhRYLLtdOD1GTtigTrgsALdBqUikiNhdBNSaLYxD1iN8bw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240107_185847_360950_0BCC128E 
X-CRM114-Status: GOOD (  46.38  )
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

T24gU3VuLCBKYW4gNywgMjAyNCBhdCA3OjU54oCvQU0gTWltaSBab2hhciA8em9oYXJAbGludXgu
aWJtLmNvbT4gd3JvdGU6Cj4gT24gU2F0LCAyMDI0LTAxLTA2IGF0IDE4OjI3IC0wNTAwLCBQYXVs
IE1vb3JlIHdyb3RlOgo+ID4gT24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgOTowN+KAr1BNIE1pbWkg
Wm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4gPiBPbiBUdWUsIDIwMjMtMTEt
MjggYXQgMjA6MDYgLTA1MDAsIFBhdWwgTW9vcmUgd3JvdGU6Cj4gPiA+ID4gT24gVHVlLCBOb3Yg
MjgsIDIwMjMgYXQgNzowOeKAr0FNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdy
b3RlOgo+ID4gPiA+ID4gT24gTW9uLCAyMDIzLTExLTI3IGF0IDE3OjE2IC0wNTAwLCBQYXVsIE1v
b3JlIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIE5vdiAyNywgMjAyMyBhdCAxMjowOOKAr1BN
IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9u
IFdlZCwgMjAyMy0xMS0yMiBhdCAwOToyMiAtMDUwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+Cj4g
PiAuLi4KPiA+Cj4gPiA+ID4gPiA+ID4gQmVmb3JlIGRlZmluaW5nIGEgbmV3IGNyaXRpY2FsLWRh
dGEgcmVjb3JkLCB3ZSBuZWVkIHRvIGRlY2lkZSB3aGV0aGVyCj4gPiA+ID4gPiA+ID4gaXQgaXMg
cmVhbGx5IG5lY2Vzc2FyeSBvciBpZiBpdCBpcyByZWR1bmRhbnQuICBJZiB3ZSBkZWZpbmUgYSBu
ZXcKPiA+ID4gPiA+ID4gPiAiY3JpdGljYWwtZGF0YSIgcmVjb3JkLCBjYW4gaXQgYmUgZGVmaW5l
ZCBzdWNoIHRoYXQgaXQgZG9lc24ndCByZXF1aXJlCj4gPiA+ID4gPiA+ID4gcGF1c2luZyBleHRl
bmRpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3Q/ICBGb3IgZXhhbXBsZSwgYSBuZXcgc2ltcGxlCj4g
PiA+ID4gPiA+ID4gdmlzdWFsIGNyaXRpY2FsLWRhdGEgcmVjb3JkIGNvdWxkIGNvbnRhaW4gdGhl
IG51bWJlciBvZiByZWNvcmRzIChlLmcuCj4gPiA+ID4gPiA+ID4gPHNlY3VyaXR5ZnM+L2ltYS9y
dW50aW1lX21lYXN1cmVtZW50c19jb3VudCkgdXAgdG8gdGhhdCBwb2ludC4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gV2hhdCBpZiB0aGUgc25hcHNob3RfYWdncmVnYXRlIHdhcyBhIGhhc2ggb2Yg
dGhlIG1lYXN1cmVtZW50IGxvZwo+ID4gPiA+ID4gPiBzdGFydGluZyB3aXRoIGVpdGhlciB0aGUg
Ym9vdF9hZ2dyZWdhdGUgb3IgdGhlIGxhdGVzdAo+ID4gPiA+ID4gPiBzbmFwc2hvdF9hZ2dyZWdh
dGUgYW5kIGVuZGluZyBvbiB0aGUgcmVjb3JkIGJlZm9yZSB0aGUgbmV3Cj4gPiA+ID4gPiA+IHNu
YXBzaG90X2FnZ3JlZ2F0ZT8gIFRoZSBwZXJmb3JtYW5jZSBpbXBhY3QgYXQgc25hcHNob3QgdGlt
ZSBzaG91bGQgYmUKPiA+ID4gPiA+ID4gbWluaW1hbCBhcyB0aGUgaGFzaCBjYW4gYmUgaW5jcmVt
ZW50YWxseSB1cGRhdGVkIGFzIG5ldyByZWNvcmRzIGFyZQo+ID4gPiA+ID4gPiBhZGRlZCB0byB0
aGUgbWVhc3VyZW1lbnQgbGlzdC4gIFdoaWxlIHRoZSBoYXNoIHdvdWxkbid0IGNhcHR1cmUgdGhl
Cj4gPiA+ID4gPiA+IFRQTSBzdGF0ZSwgaXQgd291bGQgYWxsb3cgc29tZSBjcnVkZSB2ZXJpZmlj
YXRpb24gd2hlbiByZWFzc2VtYmxpbmcKPiA+ID4gPiA+ID4gdGhlIGxvZy4gIElmIG9uZSBjb3Vs
ZCBiZWFyIHRoZSBjb3N0IG9mIGEgVFBNIHNpZ25pbmcgb3BlcmF0aW9uLCB0aGUKPiA+ID4gPiA+
ID4gbG9nIGRpZ2VzdCBjb3VsZCBiZSBzaWduZWQgYnkgdGhlIFRQTS4KPiA+ID4gPiA+Cj4gPiA+
ID4gPiBPdGhlciBjcml0aWNhbCBkYXRhIGlzIGNhbGN1bGF0ZWQsIGJlZm9yZSBjYWxsaW5nCj4g
PiA+ID4gPiBpbWFfbWVhc3VyZV9jcml0aWNhbF9kYXRhKCksIHdoaWNoIGFkZHMgdGhlIHJlY29y
ZCB0byB0aGUgbWVhc3VyZW1lbnQKPiA+ID4gPiA+IGxpc3QgYW5kIGV4dGVuZHMgdGhlIFRQTSBQ
Q1IuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmluZyB0aGUgaGFzaCBzaG91bGRuJ3QgYmUgYW4g
aXNzdWUgaWYgaXQgYmVoYXZlcyBsaWtlIG90aGVyCj4gPiA+ID4gPiBjcml0aWNhbCBkYXRhLgo+
ID4gPiA+ID4KPiA+ID4gPiA+IEluIGFkZGl0aW9uIHRvIHRoZSBoYXNoLCBjb25zaWRlciBpbmNs
dWRpbmcgb3RoZXIgaW5mb3JtYXRpb24gaW4gdGhlCj4gPiA+ID4gPiBuZXcgY3JpdGljYWwgZGF0
YSByZWNvcmQgKGUuZy4gdG90YWwgbnVtYmVyIG9mIG1lYXN1cmVtZW50IHJlY29yZHMsIHRoZQo+
ID4gPiA+ID4gbnVtYmVyIG9mIG1lYXN1cmVtZW50cyBpbmNsdWRlZCBpbiB0aGUgaGFzaCwgdGhl
IG51bWJlciBvZiB0aW1lcyB0aGUKPiA+ID4gPiA+IG1lYXN1cmVtZW50IGxpc3Qgd2FzIHRyaW1t
ZWQsIGV0YykuCj4gPiA+ID4KPiA+ID4gPiBJdCB3b3VsZCBiZSBuaWNlIGlmIHlvdSBjb3VsZCBw
cm92aWRlIGFuIGV4cGxpY2l0IGxpc3Qgb2Ygd2hhdCB5b3UKPiA+ID4gPiB3b3VsZCB3YW50IGhh
c2hlZCBpbnRvIGEgc25hcHNob3RfYWdncmVnYXRlIHJlY29yZDsgdGhlIGFib3ZlIGlzCj4gPiA+
ID4gY2xvc2UsIGJ1dCBpdCBpcyBzdGlsbCBhIGxpdHRsZSBoYW5kLXdhdnkuICBJJ20ganVzdCB0
cnlpbmcgdG8gcmVkdWNlCj4gPiA+ID4gdGhlIGJhY2stbi1mb3J0aCA6KQo+ID4gPgo+ID4gPiBX
aGF0IGlzIGJlaW5nIGRlZmluZWQgaGVyZSBpcyB0aGUgZmlyc3QgSU1BIGNyaXRpY2FsLWRhdGEg
cmVjb3JkLCB3aGljaAo+ID4gPiByZWFsbHkgcmVxdWlyZXMgc29tZSB0aG91Z2h0Lgo+ID4KPiA+
IE15IHRoaW5raW5nIGhhcyBhbHdheXMgYmVlbiB0aGF0IHRha2luZyBhIGhhc2ggb2YgdGhlIGN1
cnJlbnQKPiA+IG1lYXN1cmVtZW50IGxvZyB1cCB0byB0aGUgc25hcHNob3QgcG9pbnQgd291bGQg
YmUgYSBuaWNlCj4gPiBzbmFwc2hvdF9hZ2dyZWdhdGUgbWVhc3VyZW1lbnQsIGJ1dCBJJ20gbm90
IGhlYXZpbHkgaW52ZXN0ZWQgaW4gdGhhdC4KPiA+IFRvIG1lIGl0IGlzIG1vcmUgaW1wb3J0YW50
IHRoYXQgd2UgZmluZCBzb21ldGhpbmcgd2UgY2FuIGFsbCBhZ3JlZSBvbiwKPiA+IHBlcmhhcHMg
cmVsdWN0YW50bHksIHNvIHdlIGNhbiBtb3ZlIGZvcndhcmQgd2l0aCBhIHNvbHV0aW9uLgo+ID4K
PiA+ID4gRm9yIGVhc2Ugb2YgcmV2aWV3LCB0aGlzIG5ldyBjcml0aWNhbC0KPiA+ID4gZGF0YSBy
ZWNvcmQgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggc2V0IGZyb20gdHJpbW1pbmcgdGhlCj4g
PiA+IG1lYXN1cmVtZW50IGxpc3QuCj4gPgo+ID4gSSBzZWUgdGhlIHR3byBhcyBsaW5rZWQsIGJ1
dCBpZiB5b3UgcHJlZmVyIHRoZW0gYXMgc2VwYXJhdGUgdGhlbiBzbyBiZQo+ID4gaXQuICBPbmNl
IGFnYWluLCB0aGUgaW1wb3J0YW50IHBhcnQgaXMgdG8gbW92ZSBmb3J3YXJkIHdpdGggYQo+ID4g
c29sdXRpb24sIEknbSBub3Qgb3Zlcmx5IGJvdGhlcmVkIGlmIGl0IGFycml2ZXMgaW4gbXVsdGlw
bGUgcGllY2VzCj4gPiBpbnN0ZWFkIG9mIG9uZS4KPgo+IFRyaW1taW5nIHRoZSBJTUEgbWVhc3Vy
ZW1lbnQgbGlzdCBjb3VsZCBiZSB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggdGhlIG5ldyBJTUEK
PiBjcml0aWNhbCBkYXRhIHJlY29yZCBvciBpbmRlcGVuZGVudGx5LiAgQm90aCBvcHRpb25zIHNo
b3VsZCBiZSBzdXBwb3J0ZWQuCj4KPiAxLiB0cmltIE4gbnVtYmVyIG9mIHJlY29yZHMgZnJvbSB0
aGUgaGVhZCBvZiB0aGUgaW4ga2VybmVsIElNQSBtZWFzdXJlbWVudCBsaXN0Cj4gMi4gaW50ZXJt
aXR0ZW50bHkgaW5jbHVkZSB0aGUgbmV3IElNQSBjcml0aWNhbCBkYXRhIHJlY29yZCBiYXNlZCBv
biBzb21lIHRyaWdnZXIKPiAzLiB0cmltIHRoZSBtZWFzdXJlbWVudCBsaXN0IHVwIHRvIHRoZSAo
Zmlyc3QvbGFzdC9OdGgpIElNQSBjcml0aWNhbCBkYXRhIHJlY29yZAo+Cj4gU2luY2UgdGhlIHR3
byBmZWF0dXJlcyBjb3VsZCBiZSB1c2VkIGluZGVwZW5kZW50bHkgb2YgZWFjaCBvdGhlciwgdGhl
cmUgaXMgbm8KPiByZWFzb24gdG8gdXBzdHJlYW0gdGhlbSBhcyBhIHNpbmdsZSBwYXRjaCBzZXQu
ICBJdCBqdXN0IG1ha2VzIGl0IGhhcmRlciB0bwo+IHJldmlldy4KCkkgZG9uJ3Qgc2VlIG11Y2gg
cG9pbnQgaW4gcmVjb3JkaW5nIGEgc25hcHNob3QgYWdncmVnYXRlIGlmIHlvdSBhcmVuJ3QKZG9p
bmcgYSBzbmFwc2hvdCwgYnV0IGl0J3Mgbm90IGhhcm1mdWwgaW4gYW55IHdheSwgc28gc3VyZSwg
Z28gZm9yIGl0LgpMaWtlIEkgc2FpZCBlYXJsaWVyLCBhcyBsb25nIGFzIHRoZSBmdW5jdGlvbmFs
aXR5IGlzIHRoZXJlLCBJIGRvbid0CnRoaW5rIGFueW9uZSBjYXJlcyB0b28gbXVjaCBob3cgaXQg
Z2V0cyBpbnRvIHRoZSBrZXJuZWwgKGFsdGhvdWdoClR1c2hhciBhbmQgU3VzaCBzaG91bGQgY29t
bWVudCBmcm9tIHRoZSBwZXJzcGVjdGl2ZSkuCgo+ID4gPiBBcyBJJ20gc3VyZSB5b3UncmUgYXdh
cmUsIFNFbGludXggZGVmaW5lcyB0d28gY3JpdGljYWwtZGF0YSByZWNvcmRzLgo+ID4gPiBGcm9t
IHNlY3VyaXR5L3NlbGludXgvaW1hLmM6Cj4gPiA+Cj4gPiA+ICAgICAgICAgaW1hX21lYXN1cmVf
Y3JpdGljYWxfZGF0YSgic2VsaW51eCIsICJzZWxpbnV4LXN0YXRlIiwKPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRlX3N0ciwgc3RybGVuKHN0YXRlX3N0ciksIGZh
bHNlLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgMCk7Cj4g
PiA+Cj4gPiA+ICAgICAgICAgaW1hX21lYXN1cmVfY3JpdGljYWxfZGF0YSgic2VsaW51eCIsICJz
ZWxpbnV4LXBvbGljeS1oYXNoIiwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBvbGljeSwgcG9saWN5X2xlbiwgdHJ1ZSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE5VTEwsIDApOwo+ID4KPiA+IFllcCwgYnV0IHRoZXJlIGlzIGZhciBtb3Jl
IHRvIHRoaXMgdGhhbiBTRUxpbnV4Lgo+Cj4gT25seSBpZiB5b3UgY29uZmxhdGUgdGhlIHR3byBm
ZWF0dXJlcy4KCklmIHRoYXQgaXMgYSBjbGV2ZXIgcmV0b3J0LCB5b3UnbGwgbmVlZCB0byBlbGFi
b3JhdGUgYSBiaXQgYXMgaXQKZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgdG8gbWUuICBUaGUgSU1B
IG1lYXN1cmVtZW50IGxvZyBzbmFwc2hvdCBpcwppbmRlcGVuZGVudCBmcm9tIFNFTGludXg7IHRo
ZSBvbmx5IGNvbm5lY3Rpb24gaXMgdGhhdCB5ZXMsIElNQSBkb2VzCm1lYXN1cmUgU0VMaW51eCAi
dGhpbmdzIiBidXQgdGhhdCBpcyBubyBkaWZmZXJlbnQgZnJvbSBhbnkgb3RoZXIKc3lzdGVtIGF0
dHJpYnV0ZSB0aGF0IGlzIG1lYXN1cmVkIGJ5IElNQS4KCi0tIApwYXVsLW1vb3JlLmNvbQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
