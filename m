Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C69CA0ED3
	for <kexec@archiver.kernel.org>; Mon,  2 Sep 2024 05:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5nyJUaocCJXX8lgD8wHpqTR3v5WX6E5WvIMCviHBRxg=; b=BHrWQgMGyXMmQB
	Cm0B3orHyAH6FC/uX0/nMAWEHdoKXC3vZBCafABbeUxEVprBPRcpr5uWbqAwwsUuT0c3NTyFPquHg
	ISBVQL8we5G++2N+wC3Qu7M9zi/9b9HAPpzIZIDZZxm4281D9kCrgAdBvpFl1gihKTmZmdTb5FKcZ
	BgfUl42WGTkXG4Uio4kzHXjSILHsTnEjEiTD5iPhVt+sEYemEq9jbLXnN3NtTSHunjZvEJuXBI5Ci
	RQqgdGjyUSt83cUFhAAHB5mCckDOjUSg0v1aIzCRTFLrYYhJNVDXMciBrRPZIssoNzs+YBnWSTvPf
	fsDXCB9Hh5vgy1knTRYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skzo5-0000000D3Es-3mBw;
	Mon, 02 Sep 2024 05:40:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skzo2-0000000D3E9-2TIF
	for kexec@lists.infradead.org;
	Mon, 02 Sep 2024 05:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725255648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRnSBt/Y5eceLh55m3HnCPqU2nMHi0V+SDsqesK2W8g=;
	b=Z1BGIaIko5z4AUI8ZajwACHv+vrR32TIBRc1L89DhZw5zosjd/ngRraIffnAuDzm0quXFA
	wL8Jma6M8jwN6DdoTeQ60uVYubP03eo4jNXqTE8AcodJAEM9nqbEYSacrOpUQZo9C5GhMx
	XrHMoiaB7JuUhJ3iUGa6EKufRLySnR8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Od1M_VsvMLqCska3zy_PuA-1; Mon, 02 Sep 2024 01:40:44 -0400
X-MC-Unique: Od1M_VsvMLqCska3zy_PuA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c36310588fso16635496d6.1
        for <kexec@lists.infradead.org>; Sun, 01 Sep 2024 22:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255644; x=1725860444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRnSBt/Y5eceLh55m3HnCPqU2nMHi0V+SDsqesK2W8g=;
        b=bc1WjRcue2MpbVre3BBEsYjUrqO0SVE+GehIk/b2KMBHT4H81hghEVXUtXLDmHYRGi
         5eI7rkUPib2s9VpqCrx96T2kAyuQ7LOtjUWNSN9VIY/m7MXGULfh02Nq6QvICG5bm4MM
         plJqNjxOQ+3Vh/u5AXBxH0UwReX3ImMXVo+ZN+li8gvCEfyAVMZR9KEnIi33UK0eDYXh
         OYOoygldmTFrk804NCiZ5A80fxxaYUeQyZUUAaleaPmqLmslsVQy5r3M9nEYwLn2PlJh
         W6K28G6YEx+/TXSwE+LhF6xxRWUxmV7XLCNPW4yUndH/3EfyQKFk15gFcZjFOXBEpk23
         z9iA==
X-Forwarded-Encrypted: i=1; AJvYcCXo2ZfB6J/1xA+bycORYXWSWCC/mAOMF94xCVyIzfcGX8K0Nac1OIYVwkUIWUiTkg3+d4Kx0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgDK/HYiZn3tSY2QL4GduUdXj4TcrsTX+L6o++WvBV6LmUXl9B
	33N4cy+D4qPU0839Ooiyy8LdQYr/1WlJFKqMDvviIfbrGye0EJIiKGERbvqK8IvAkdSnFey8skb
	fA0yK0CR/BNB8k/DbJ4zVVwjc4dzAWZkunyGYsBX5hXbX+9Qosxy8gA7DuIlEIOPoQrS2uFiRsP
	TmkugigmnEMoAe1b+w3O2HknD4LtB2On/m
X-Received: by 2002:a05:6214:412:b0:6bd:738c:842e with SMTP id 6a1803df08f44-6c33f33ba2dmr247844986d6.7.1725255644361;
        Sun, 01 Sep 2024 22:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLG3n6qFXQd6j9fD3rpLTzswKzCAwE4mH3nVuq4KI5nupSC1ibIcr0+CQALAep1tMuUKdJQcZNOkRaJG2tSkY=
X-Received: by 2002:a05:6214:412:b0:6bd:738c:842e with SMTP id
 6a1803df08f44-6c33f33ba2dmr247844836d6.7.1725255643983; Sun, 01 Sep 2024
 22:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
In-Reply-To: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 2 Sep 2024 13:40:33 +0800
Message-ID: <CAF+s44QWjyswV3Huh5AWJzDwRCjvdjjEX2WDPaie9KrH0QOxOg@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240901_224050_734453_13666158 
X-CRM114-Status: GOOD (  42.53  )
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

T24gVGh1LCBBdWcgMjksIDIwMjQgYXQgMTowOOKAr0FNIEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtl
cm5lbC5vcmc+IHdyb3RlOgo+ClsuLi5dCgpIaSBBcmQsCgpUaGFua3MgZm9yIHNoYXJpbmcgeW91
ciBpbnNpZ2h0IGFuZCB0aG91Z2h0cy4KCj4KPiBUaGFua3MgZm9yIHB1dHRpbmcgdGhpcyBSRkMg
dG9nZXRoZXIuIFRoaXMgaXMgdXNlZnVsIHdvcmssIGFuZCBnaXZlcwo+IHVzIGZvb2QgZm9yIHRo
b3VnaHQgYW5kIGRpc2N1c3Npb24uCj4KPiBUaGVyZSBhcmUgYSBmZXcgcHJvYmxlbXMgdGhhdCBi
ZWNvbWUgYXBwYXJlbnQgd2hlbiBnb2luZyB0aHJvdWdoIHRoZXNlIGNoYW5nZXMuCj4KPiAxLiBJ
bXBsZW1lbnRpbmcgVUVGSSBlbnRpcmVseSBpcyBpbnRyYWN0YWJsZSwgYW5kIHVubmVjZXNzYXJ5
Lgo+IEltcGxlbWVudGluZyB0aGUgc3Vic2V0IG9mIFVFRkkgdGhhdCBpcyBhY3R1YWxseSBuZWVk
ZWQgdG8gYm9vdCBMaW51eAo+ICppcyogdHJhY3RhYmxlLCB0aG91Z2gsIGJ1dCB3ZSBuZWVkIHRv
IHdvcmsgdG9nZXRoZXIgdG8gd3JpdGUgdGhpcwo+IGRvd24gc29tZXdoZXJlLgo+ICAgLSB0aGUg
RUZJIHN0dWIgbmVlZHMgdGhlIGJvb3Qgc2VydmljZXMgZm9yIHRoZSBFRkkgbWVtb3J5IG1hcCBh
bmQKPiB0aGUgYWxsb2NhdGlvbiByb3V0aW5lcwo+ICAgLSBHUlVCIG5lZWRzIGJsb2NrIEkvTwo+
ICAgLSBzeXN0ZW1kLXN0dWIvVUtJIG5lZWRzIGZpbGUgSS9PIHRvIGxvb2sgZm9yIHNpZGVjYXJz
Cj4gICAtIGV0YyBldGMKPgo+IEkgaW1wbGVtZW50ZWQgYSBSdXN0ICdlZmlsb2FkZXInIGNyYXRl
IGEgd2hpbGUgYWdvIHRoYXQgZW5jYXBzdWxhdGVzCj4gbW9zdCBvZiB0aGlzIChpdCBjYW4gYm9v
dCBMaW51eC9hcm02NCBvbiBRRU1VIGFuZCBib290IHg4NiB2aWEgR1JVQiBpbgo+IHVzZXIgc3Bh
Y2UgKiopLiBBZGRpbmcgZmlsZSBJL08gdG8gdGhpcyBzaG91bGQgYmUgc3RyYWlnaHQtZm9yd2Fy
ZCAtCj4gYXMgTGVubmFydCBwb2ludHMgb3V0LCB3ZSBvbmx5IG5lZWQgdGhlIHByb3RvY29sLCBp
dCBkb2Vzbid0IG5lZWQgdG8KPiBiZSBiYWNrZWQgYnkgYW4gYWN0dWFsIGZpbGUgc3lzdGVtLCBp
dCBqdXN0IG5lZWRzIHRvIGJlIGFibGUgdG8gZXhwb3NlCj4gb3RoZXIgZmlsZXMgaW4gdGhlIHJp
Z2h0IHdheS4KPgo+IDIuIFJ1bm5pbmcgdGhlIFVFRkkgZW11bGF0b3Igb24gYmFyZSBtZXRhbCBp
cyBub3QgZ29pbmcgdG8gc2NhbGUuCj4gQ2xvbmluZyBVQVJUIGRyaXZlciBjb2RlIGFuZCBNTVUg
Y29kZSBldGMgaXMgYSBjYW4gb2Ygd29ybXMgdGhhdCB5b3UKPiB3YW50IHRvIGxlYXZlIGNsb3Nl
ZC4gQW5kIGFzIExlbm5hcnQgcG9pbnRzIG91dCwgdGhlcmUgaXMgb3RoZXIKCkFzIGZvciBNTVUg
Y29kZSwgaWYgdGhlIDFzdCBrZXJuZWwgZG9lcyBub3QgdHVybiBpdCBvZmYsIGl0IGNhbiBiZQpl
bGltaW5hdGVkIGZyb20gdGhlIGVtdWxhdG9yIGNvZGUsIHdoaWNoIHNob3VsZCBub3QgYmUgaGFy
ZCB0bwppbXBsZW1lbnQgb24gYXJtNjQuIEFuZCBhbHJlYWR5IGRvbmUgaW4geDg2LgoKPiBoYXJk
d2FyZSAoVFBNKSB0aGF0IG5lZWRzIHRvIGJlIGFjY2Vzc2libGUgYXMgd2VsbC4gUHJvdmlkaW5n
IGEKPiBzZXBhcmF0ZSBzZXQgb2YgZHJpdmVycyBmb3IgYWxsIGhhcmR3YXJlIHRoYXQgdGhlIEVG
SSBlbXVsYXRvciBtYXkKPiBuZWVkIHRvIGFjY2VzcyBpcyBub3QgYSB0cmFjdGFibGUgcHJvYmxl
bSBlaXRoZXIuCj4KPiBUaGUgZml4IGZvciB0aGlzLCBhcyBJIHNlZSBpdCwgaXMgdG8gcnVuIHRo
ZSBFRkkgZW11bGF0b3IgaW4gdXNlcgo+IHNwYWNlLCB0byB0aGUgcG9pbnQgd2hlcmUgdGhlIHBh
eWxvYWQgY2FsbHMgRXhpdEJvb3RTZXJ2aWNlcygpLiBUaGlzCj4gd2lsbCBhbGxvdyBhbGwgSS9P
IGFuZCBtZW1vcnkgcHJvdG9jb2wgdG8gYmUgaW1wbGVtZW50ZWQgdHJpdmlhbGx5LAo+IHVzaW5n
IEMgbGlicmFyeSByb3V0aW5lcy4gSSBoYXZlIGEgY3J1ZGUgcHJvdG90eXBlKiogb2YgdGhpcyBy
dW5uaW5nCgpZZXMsIHRoYXQgaXMgYSBkZWZpbml0ZWx5IHByb21pc2luZyBtZXRob2QsIEJ5IHRo
aXMgd2F5LCB3ZSBjYW4gaGFuZGxlCmRldmljZSBvcGVyYXRpb25zIG1vcmUgZWxlZ2FudGx5LiBJ
biBmYWN0LCBJIHVzZWQgaXQgdG8gZGV2ZWxvcCBhbmQKZGVidWcgcGFydCBvZiBteSBlbXVsYXRv
ciBzZXJ2aWNlIGNvZGUuCgpCdXQgd2hlbiBkZWJ1Z2dpbmcgeDg2IGVmaS1zdHViLCBJIGVuY291
bnRlciBzb21lIHByb2JsZW0gd2l0aCB0aGUKcHJpdmlsZWdlZCBpbnN0cnVjdGlvbiwgd2hpY2gg
Y2F1c2VzIHNlZ21lbnQgZmF1bHQuIEl0IG9yaWdpbmF0ZXMgZnJvbQprYXNscl9nZXRfcmFuZG9t
X2xvbmcoKS4gIEkgdGhpbmsgaXQgY2FuIGJlIHdvcmtlZCBhcm91bmQgYnkgZW11bGF0aW5nCnRo
ZSBpbnN0cnVjdGlvbiBpZiB0aGUgaW5zdHJ1Y3Rpb24gcmVhZHMgdGhlIHN5c3RlbSBzdGF0ZS4g
QnV0IGlmIHRoZQppbnN0cnVjdGlvbiB0cmllcyB0byB1cGRhdGUgc3lzdGVtIHN0YXRlLCBpdCBj
YW4gbm90IGJlIGZpeGVkIHNpbmNlCnRoZSBzeXN0ZW0gaXMgc3RpbGwgb3duZWQgYnkgdGhlIGtl
cm5lbCBpbnN0ZWFkIG9mIG93bmVkIGJ5IHRoZQplbXVsYXRvciBleGNsdXNpdmVseS4KClNvIGhl
cmUgd2UgbmVlZCBhbm90aGVyIGFncmVlbWVudCBvbiB0aGUgc3R1YidzIGJlaGF2aW9yIGJlZm9y
ZQpFeGl0Qm9vdFNlcnZpY2VzKCkuCgo+IHRvIHRoZSBwb2ludCB3aGVyZSBFeGl0Qm9vdFNlcnZp
Y2VzKCkgaXMgY2FsbGVkIChhbmQgdGhlbiBpdCBjcmFzaGVzKS4KPiBUaGUgdHJpY2t5IHlldCBp
bnRlcmVzdGluZyBiaXQgaGVyZSBpcyBob3cgd2UgbWlncmF0ZSBhIGNodW5rIG9mIHVzZXIKPiBz
cGFjZSBtZW1vcnkgdG8gdGhlIGJhcmUgbWV0YWwgY29udGV4dCB0aGF0IHdpbGwgYmUgY3JlYXRl
ZCBieSB0aGUKPiBrZXhlYyBzeXNjYWxsIGxhdGVyIChpbiB3aGljaCB0aGUgY2FsbCB0byBFeGl0
Qm9vdFNlcnZpY2VzKCkgd291bGQKPiByZXR1cm4gYW5kIHByb2NlZWQgd2l0aCB0aGUgYm9vdCku
IEJ1dCB0aGUgcHJpbmNpcGxlIGlzIHJhdGhlcgo+IHN0cmFpZ2h0LWZvcndhcmQsIGFuZCB3b3Vs
ZCBwZXJtaXQgdXMsIGUuZy4sIHRvIGtleGVjIGFuIE9TIGluc3RhbGxlcgo+IHRvby4KPgo+IDMu
IFdlIG5lZWQgdG8gZmlndXJlIG91dCBob3cgdG8gc3VwcG9ydCBUUE0gYW5kIFBDUnMgaW4gdGhl
IGNvbnRleHQgb2YKPiBrZXhlYy4gVGhpcyBpcyBhIGZ1bmRhbWVudGFsIGlzc3VlIHdpdGggdmVy
aWZpZWQgYm9vdCwgZ2l2ZW4gdGhhdCB0aGUKPiBrZXhlYyBQQ1Igc3RhdGUgaXMgbmVjZXNzYXJp
bHkgZGlmZmVyZW50IGZyb20gdGhlIGJvb3Qgc3RhdGUsIGFuZCBzbwo+IHdlIGNhbm5vdCByZXVz
ZSB0aGUgVFBNIGRpcmVjdGx5IGlmIHdlIHdhbnQgdG8gcHJldGVuZCB0aGF0IHdlIGFyZQo+IGRv
aW5nIGFuIG9yZGluYXJ5IGJvb3QgaW4ga2V4ZWMuIFRoZSBhbHRlcm5hdGl2ZSBpcyB0byBsZWF2
ZSB0aGUgVFBNCgpIZXJlLCBJIG1pc3MgdGhlIGJpZyBwaWN0dXJlLiBDb3VsZCB5b3UgZW5saWdo
dGVuIG1lIG1vcmUgYWJvdXQgdGhpcz8KQXMgSSB0aG91Z2h0LCB0aGUgbGludXgga2VybmVsIHdp
bGwgbm90IGxvY2sgaXRzZWxmIGRvd24gb250byBhCnNwZWNpZmljIGZpcm13YXJlLiBTbyB0aGUg
dHJ1c3QgaXMgb25lIGRpcmVjdGlvbiwgaS5lLiBmcm9tIGJvb3Rsb2FkZXIKdG8ga2VybmVsLiBJ
biBVS0kgY2FzZSwgc3lzdGVtZC1zdHViIHRha2VzIHRoZSBtZWFzdXJlbWVudCBhbmQgZXh0ZW5k
cwp0aGUgUENSIDExLzEyLzEzIGFzIGluCmh0dHBzOi8vdWFwaS1ncm91cC5vcmcvc3BlY2lmaWNh
dGlvbnMvc3BlY3MvbGludXhfdHBtX3Bjcl9yZWdpc3RyeS8KCkxhdGVyIHN5c3RlbWQtcGNybG9j
ayBhcHByYWlzZXMgdGhlIHZhbHVlIGluIHRob3NlIHJlZ2lzdGVycy4gSWYgdGhlCnNlY3Rpb25z
IGluIFVLSSBhcmUgaW50YWN0LCB0aGUga2V4ZWMgcmVib290IHdpbGwgZ28gc21vb3RobHkuCgoK
PiBpbiBhIHN0YXRlIHdoZXJlIHRoZSBrZXhlYyBrZXJuZWwgY2FuIGFjY2VzcyBpdHMgc2VhbGVk
IHNlY3JldHMsIGFuZAo+IG1vY2sgdXAgdGhlIFRDRzIgRUZJIHByb3RvY29scyB1c2luZyBhIHNo
aW0gdGhhdCBzaXRzIGJldHdlZW4gdGhlIFRQTQo+IGhhcmR3YXJlIChhcyB0aGUgcmVhbCBUQ0cy
IHByb3RvY29scyB3aWxsIGJlIGxvbmcgZ29uZSkgYW5kIHRoZSBFRkkKPiBwYXlsb2FkLiBCdXQg
YXMgSSBzYWlkLCB0aGlzIGlzIGEgZnVuZGFtZW50YWwgaXNzdWUsIGFzIHRoZSBhYmlsaXR5IHRv
Cj4gcHJldGVuZCB0aGF0IGEga2V4ZWMgYm9vdCBpcyBhIHByaXN0aW5lIGJvb3Qgd291bGQgbWVh
biB0aGF0IHZlcmlmaWVkCj4gYm9vdCBpcyBicm9rZW4uCj4KPgo+IEFzIGZ1dHVyZSB3b3JrLCBJ
J2QgbGlrZSB0byBwcm9wb3NlIHRvIGNvbGxhYm9yYXRlIG9uIHNvbWUgYWxpZ25tZW50Cj4gcmVn
YXJkaW5nIGEgVUVGSSBiYXNlbGluZSBmb3IgTGludXgsIGkuZS4sIHRoZSBwYXJ0cyB0aGF0IHdl
IGFjdHVhbGx5Cj4gbmVlZCB0byBib290IExpbnV4Lgo+CgpEbyB5b3UgbWVhbiB0aGF0IHVzZXIg
c3BhY2UgY29kZSBhbmQga2VybmVsIGNvZGU/IEFuZCBJIHRoaW5rIGZvciB0aGUKdXNlciBzcGFj
ZSBjb2RlLCBpdCBzaG91bGQgYmUgYmV0dGVyIHRvIGludGVncmF0ZSB0aGUgY29kZSBpbgprZXhl
Yy10b29scyBzbyB0aGF0IHdlIGhhdmUgYSB1bmlmb3JtIGludGVyZmFjZSBmb3Iga2V4ZWMgYm9v
dC4KCkxvb2tpbmcgZm9yd2FyZCB0byB0aGUgY29sbGFib3JhdGlvbiB0byBtYWtlIGtleGVjIGFi
bGUgdG8gYm9vdCBVS0kgc29vbi4KCgpUaGFua3MsCgpQaW5nZmFuCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
