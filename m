Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g56MG-0002Hc-R6
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 09:43:54 +0000
Received: by mail-wr1-f42.google.com with SMTP id u12-v6so26245636wrr.4
 for <kexec@lists.infradead.org>; Wed, 26 Sep 2018 02:43:21 -0700 (PDT)
Received: from t-5.eu (p57AB938E.dip0.t-ipconnect.de. [87.171.147.142])
 by smtp.gmail.com with ESMTPSA id f18-v6sm4149400wrw.32.2018.09.26.02.43.18
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Sep 2018 02:43:18 -0700 (PDT)
Received: from t-5.eu (localhost [127.0.0.1])
 by t-5.eu (Postfix) with ESMTP id AD255167A4E
 for <kexec@lists.infradead.org>; Wed, 26 Sep 2018 11:43:17 +0200 (CEST)
MIME-Version: 1.0
Date: Wed, 26 Sep 2018 11:43:17 +0200
From: =?UTF-8?Q?J=C3=BCrgen_Herrmann?= <t-5@t-5.eu>
Subject: Re: cannot get kdump to work, kexec stops in load_segments()
In-Reply-To: <73ee47d5aea541566c89ff264c2d39ed@t-5.eu>
References: <73ee47d5aea541566c89ff264c2d39ed@t-5.eu>
Message-ID: <e10057f18c5c50faa4e10238c8ad1547@t-5.eu>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

QW0gMjAuOS4yMDE4IDE5OjUyLCBzY2hyaWViIErDvHJnZW4gSGVycm1hbm46Cj4gSGVsbG8hCj4g
Cj4gSSBhbSB0cnlpbmcgdG8gZGVidWcgYSBoYW5nIGluIGJ0cmZzLXNlbmQ6IEkgdGFsa2VkIHRv
IHRoZSBndXlzIG9uIHRoZQo+IGxpbnV4LWJ0cmZzCj4gbWFpbGluZyBsaXN0IGFuZCB0aGV5IG5l
ZWQgYSBrZHVtcCBvZiB0aGUgc3RhdGUgd2hlbiB0aGUgaGFuZyBoYXBwZW5zLgo+IAo+IEkgYWxy
ZWFkeSBzZXQgdXAga2R1bXA6Cj4gJCBrZHVtcC1jb25maWcgc2hvdwo+IERVTVBfTU9ERTogICAg
ICAgIGtkdW1wCj4gVVNFX0tEVU1QOiAgICAgICAgMQo+IEtEVU1QX1NZU0NUTDogICAgIGtlcm5l
bC5wYW5pY19vbl9vb3BzPTEKPiBLRFVNUF9DT1JFRElSOiAgICAvdmFyL2NyYXNoCj4gY3Jhc2hr
ZXJuZWwgYWRkcjogMHgyNDAwMDAwMAo+ICAgIC92bWxpbnV6OiBzeW1ib2xpYyBsaW5rIHRvIGJv
b3Qvdm1saW51ei00LjE1LjAtMzQtZ2VuZXJpYwo+IGtkdW1wIGluaXRyZDoKPiAgICAvaW5pdHJk
LmltZzogc3ltYm9saWMgbGluayB0byBib290L2luaXRyZC5pbWctNC4xNS4wLTM0LWdlbmVyaWMK
PiBjdXJyZW50IHN0YXRlOiAgICByZWFkeSB0byBrZHVtcAo+IAo+IGtleGVjIGNvbW1hbmQ6Cj4g
ICAvc2Jpbi9rZXhlYyAtcCAtZCAtLWNvbW1hbmQtbGluZT0iQk9PVF9JTUFHRT0vdm1saW51ei00
LjE4LjYKPiByb290PVVVSUQ9YTkxNGMxNDEtNzJiZi00NDhiLTg0N2YtZDY0ZWU4MmQ4YjdiIHJv
IHJvb3RmbGFncz1zdWJ2b2w9QAo+IHF1aWV0IHNwbGFzaCB2dC5oYW5kb2ZmPTEgbnJfY3B1cz0x
IHN5c3RlbWQudW5pdD1rZHVtcC10b29scy5zZXJ2aWNlCj4gaXJxcG9sbCBub3VzYiBhdGFfcGlp
eC5wcmVmZXJfbXNfaHlwZXJ2PTAiIC0taW5pdHJkPS9pbml0cmQuaW1nCj4gL3ZtbGludXoKPiAK
PiBLZXJuZWwgdmVyc2lvbiBpcyA0LjE4LjYgZnJvbSBrZXJuZWwub3JnCj4gCj4gQ1BVOiBJbnRl
bChSKSBDb3JlKFRNKSBpNS04MjUwVSBDUFUgQCAxLjYwR0h6Cj4gCj4gSSBkaWQgYSBsaXR0bGUg
ZGlnZ2luZyBpbiB0aGUga2VybmVsIGNvZGUgd2l0aCBwcmludGsoKSBzdGF0ZW1lbnRzIGFuZAo+
IHRoZSBleGVjdXRpb24gc3RvcHMgaW4gYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQu
YyBpbiBmdW5jdGlvbgo+IGxvYWRfc2VnbWVudHMoKS4gVGhlIGxhc3QgcHJpbnRrIEkgc2VlIGlz
IGJlZm9yZSB0aGUgY2FsbCBvZiAKPiBsb2FkX3NlZ21lbnRzKCkuCj4gCj4gQSBzY3JlZW5zaG90
IG9mIHRoZSAidGVzdC1jcmFzaCIgY2FuIGJlIHNlZW4gaGVyZToKPiBodHRwczovL3QtNS5ldS9v
d25jbG91ZC9pbmRleC5waHAvcy9XQ3hvTnVTcW5LVmc2SjcKPiAKPiBXaGF0IGVsc2UgZG8gSSBu
ZWVkIHRvIHByb3ZpZGUgaW4gdGVybXMgb2YgaW5mb3JtYXRpb24/Cj4gCj4gQmVzdCByZWdhcmRz
LAo+IErDvHJnZW4KCkFueWJvZHk/PwoKLS0gCkrDvHJnZW4gSGVycm1hbm4KaHR0cHM6Ly90LTUu
ZXUKQUxiZXJ0c3RyYcOfZSAyCjk0MzI3IEJvZ2VuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
