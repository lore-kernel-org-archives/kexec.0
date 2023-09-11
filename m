Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1882CA0ECB
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 23:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PvYTIvXxPhs/jES+QyuyW5sQrFSsntzVRHWE8qqQXXE=; b=rCtAYrNqrhF4yK
	pRyfMSxfPJGhIe1nYM7g8JI6MG7oCqzD7XI8xTdYnWushB0Xc4cGfszEo0KreSIqOYqIdqPBziZrD
	8LwcHUUcUGjLY/eoyDGC22GQBMsoD6YOGNuHAUGBuXNesnogJuIXse9XkDAQhf+seqdT57c3dgNEH
	rwI06NzKxCA9rD2dI1oc6B/6BeUCYjeX3AY6KRevNKKcbt2nRube2BmP8IOEWKPCNn9UUrJdZlcVN
	7qrMcp8yanL3+QdIAPBvuQsWn0rMR4qaJxERyI8KcI6XH9Vy9fmXHkZKkUIsz553up+YJGMXxLIG1
	9+oMs64dfHX6/dUsjgMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfqD9-001bfX-1F;
	Mon, 11 Sep 2023 23:20:55 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfqD6-001bem-39
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 23:20:54 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a64619d8fbso633479466b.0
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694474448; x=1695079248; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJwIMS70R7O4xotSYAbycvkE7LIixxz2BRpxlkaoOuQ=;
        b=KO7DedvKyzShGENDS+mTsouH9DTYzEjaWyCU/nyq4rxLtrdD4HNs86XeXLUl8XpFtO
         15rSttcC9iwoOnzaa87XeqkVnVxywg1oCXd2XKLwkrFmvA8iJewxjlb1h1VR4oK6kzV5
         pM0MOsK+UnKVijzWE0GQ1DSnAar/JgF+XjvRio0oDKLmfg46dDqjCdi5P4ATgrBln/Og
         r3vst67eApdiJ6QIsGe6r1TCs+p+3yb1EXWe/suq5JbnklDff8jeCgQO0wJiN0Ke3jTt
         QhJFDKGTWR4acnp+O9A8l3YVIU5lpPJWGpu/a8TS9Km4mTFJ2A8kbjp1ZgPrSXn0wVTp
         T3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474448; x=1695079248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJwIMS70R7O4xotSYAbycvkE7LIixxz2BRpxlkaoOuQ=;
        b=Vf18qfrwYsNNDmVb4S1YzQoY7IcEZiqRPOtNFG9mBKio913OL3OMMIGGNgfbOpCEpi
         dVKnRNR1kHJdWHFc3ydrVZXnlk2+acE42yvAtSxD/u3HR+jXTRZOgVD6WND+Ib3m4Fzl
         eZDIjPO+wVgNf25mB7QaDePYJXkroKYQGdc3/+Ci0LVUjOSt91ngEm9eA/nuY1hAmmvo
         /ujxtwAZYrRU8RT6Z/rWqHR0+8tKnKTE2hsJqX4nsfoYwfpaZGfmJOK9G2UJrAf7li6S
         gmnKdK2bT4F1AbntN6mSEHhX8KMqlSP86g8HjhYong3vsl9r7cMmJ8L7YtChYexxTnGG
         rUew==
X-Gm-Message-State: AOJu0YzfcqAcWH+1ldVR6Gs8eLPqfixpvPld5Ttilhj5dSTdhuyMD0Uu
	nk3kOj4WhWxDTFc5NUoh0U25OQT++8xzPa+Ox8w=
X-Google-Smtp-Source: AGHT+IFf2hqEyBFntRVpYOdqr6T6TV+V1ehJ8cSgQpPXcwsMJ4j+xNm6xYRtTw0/JaZaMQZr0SNrgfCVx6jkQoSCZXk=
X-Received: by 2002:a17:906:1d9:b0:9a5:a44a:86f3 with SMTP id
 25-20020a17090601d900b009a5a44a86f3mr9128275ejj.25.1694474448340; Mon, 11 Sep
 2023 16:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc> <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
In-Reply-To: <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
From: Neal Gompa <ngompa13@gmail.com>
Date: Mon, 11 Sep 2023 19:20:12 -0400
Message-ID: <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com>
Subject: Re: [systemd-devel] [PATCH 0/1] x86/kexec: UKI support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, x86@kernel.org, 
	kexec@lists.infradead.org, dhowells@redhat.com, keyrings@vger.kernel.org, 
	bluca@debian.org, bhelgaas@google.com, tglx@linutronix.de, 
	akpm@linux-foundation.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_162053_016331_54FE586A 
X-CRM114-Status: GOOD (  16.66  )
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

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNzoxNeKAr1BNIEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gU2F0IFNlcCA5LCAyMDIzIGF0IDc6MTggUE0gRUVT
VCwgSmFuIEhlbmRyaWsgRmFyciB3cm90ZToKPiA+IEhlbGxvLAo+ID4KPiA+IHRoaXMgcGF0Y2gg
aW1wbGVtZW50cyBVS0kgc3VwcG9ydCBmb3Iga2V4ZWNfZmlsZV9sb2FkLiBJdCB3aWxsIHJlcXVp
cmUgc3VwcG9ydAo+ID4gaW4gdGhlIGtleGVjLXRvb2xzIHVzZXJzcGFjZSB1dGlsaXR5LiBGb3Ig
dGVzdGluZyBwdXJwb3NlcyB0aGUgZm9sbG93aW5nIGNhbiBiZSB1c2VkOgo+ID4gaHR0cHM6Ly9n
aXRodWIuY29tL0N5ZG94L2tleGVjLXRlc3QvCj4gPgo+ID4gVGhlcmUgaGFzIGJlZW4gZGlzY3Vz
c2lvbiBvbiB0aGlzIHRvcGljIGluIGFuIGlzc3VlIG9uIEdpdEh1YiB0aGF0IGlzIGxpbmtlZCBi
ZWxvdwo+ID4gZm9yIHJlZmVyZW5jZS4KPiA+Cj4gPgo+ID4gU29tZSBsaW5rczoKPiA+IC0gUmVs
YXRlZCBkaXNjdXNzaW9uOiBodHRwczovL2dpdGh1Yi5jb20vc3lzdGVtZC9zeXN0ZW1kL2lzc3Vl
cy8yODUzOAo+ID4gLSBEb2N1bWVudGF0aW9uIG9mIFVLSXM6IGh0dHBzOi8vdWFwaS1ncm91cC5v
cmcvc3BlY2lmaWNhdGlvbnMvc3BlY3MvdW5pZmllZF9rZXJuZWxfaW1hZ2UvCj4gPgo+ID4gSmFu
IEhlbmRyaWsgRmFyciAoMSk6Cj4gPiAgIHg4Ni9rZXhlYzogVUtJIHN1cHBvcnQKPiA+Cj4gPiAg
YXJjaC94ODYvaW5jbHVkZS9hc20va2V4ZWMtdWtpLmggICAgICAgfCAgIDcgKysKPiA+ICBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wYXJzZV9wZWZpbGUuaCAgICB8ICAzMiArKysrKysrCj4gPiAgYXJj
aC94ODYva2VybmVsL01ha2VmaWxlICAgICAgICAgICAgICAgfCAgIDIgKwo+ID4gIGFyY2gveDg2
L2tlcm5lbC9rZXhlYy11a2kuYyAgICAgICAgICAgIHwgMTEzICsrKysrKysrKysrKysrKysrKysr
KysrKysKPiA+ICBhcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jICAgICB8ICAgMiAr
Cj4gPiAgYXJjaC94ODYva2VybmVsL3BhcnNlX3BlZmlsZS5jICAgICAgICAgfCAxMTAgKysrKysr
KysrKysrKysrKysrKysrKysrCj4gPiAgY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9tc2NvZGVfcGFy
c2VyLmMgfCAgIDIgKy0KPiA+ICBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL3ZlcmlmeV9wZWZpbGUu
YyB8IDExMCArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICBjcnlwdG8vYXN5bW1ldHJpY19r
ZXlzL3ZlcmlmeV9wZWZpbGUuaCB8ICAxNiAtLS0tCj4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAyNzgg
aW5zZXJ0aW9ucygrKSwgMTE2IGRlbGV0aW9ucygtKQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy11a2kuaAo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJzZV9wZWZpbGUuaAo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL3g4Ni9rZXJuZWwva2V4ZWMtdWtpLmMKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC94ODYva2VybmVsL3BhcnNlX3BlZmlsZS5jCj4gPgo+ID4gLS0KPiA+IDIuNDAuMQo+Cj4gV2hh
dCB0aGUgaGVjayBpcyBVS0k/CgpVbmlmaWVkIEtlcm5lbCBJbWFnZXMuIE1vcmUgZGV0YWlscyBh
dmFpbGFibGUgaGVyZToKaHR0cHM6Ly91YXBpLWdyb3VwLm9yZy9zcGVjaWZpY2F0aW9ucy9zcGVj
cy91bmlmaWVkX2tlcm5lbF9pbWFnZS8KCkl0J3MgYSB3YXkgb2YgY3JlYXRpbmcgaW5pdHJhbWZz
LXN0eWxlIGltYWdlcyBhcyBmdWxseSBnZW5lcmljLApyZXByb2R1Y2libGUgaW1hZ2VzIHRoYXQg
Y2FuIGJlIGJ1aWx0IHNlcnZlci1zaWRlLgoKSXQgaXMgYSByZXF1aXJlbWVudCBmb3IgY3JlYXRp
bmcgbG9ja2VkIGRvd24gTGludXggZGV2aWNlcyBmb3IKYXBwbGlhbmNlcyB0aGF0IGNhbiBiZSB0
YW1wZXItcmVzaXN0YW50IHRvby4KCgoKCi0tCuecn+Wun+OBr+OBhOOBpOOCguS4gOOBpO+8gS8g
QWx3YXlzLCB0aGVyZSdzIG9ubHkgb25lIHRydXRoIQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
