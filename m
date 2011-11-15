Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQJLr-0000MR-D1
 for kexec@lists.infradead.org; Tue, 15 Nov 2011 13:47:03 +0000
Received: by iapp10 with SMTP id p10so10563961iap.36
 for <kexec@lists.infradead.org>; Tue, 15 Nov 2011 05:47:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EC21F67.10905@redhat.com>
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau> <4EC21F67.10905@redhat.com>
Date: Tue, 15 Nov 2011 21:47:02 +0800
Message-ID: <CAM_iQpUCE5fB0KGcmmXkpqVnasqpx0cSt01qhXO1CNVRJcSWeA@mail.gmail.com>
Subject: Re: Crash during vmcore_init
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: tj@kernel.org, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

T24gVHVlLCBOb3YgMTUsIDIwMTEgYXQgNDoxNCBQTSwgRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+PiBPbiBNb24sIDIwMTEtMTEtMTQgYXQgMTM6MzkgKzAwMDAsIFdBTkcg
Q29uZyB3cm90ZToKPj4+IE9uIFR1ZSwgMTEgT2N0IDIwMTEgMTY6Mzk6MDUgLTA3MDAsIFRpbSBI
YXJ0cmljayB3cm90ZToKPj4+Cj4+Pj4gS2V4ZWMsCj4+Pj4KPj4+PiBJIGhhdmUgYmVlbiBleHBl
cmllbmNpbmcgdGhlIGNyYXNoIGJlbG93IG9uIFVidW50dSAxMC4wNCBydW5uaW5nCj4+Pj4gMi42
LjMyLTM0LXNlcnZlciBhbmQgMi42LjM4LTgtc2VydmVyIGFzIHRoZSBjcmFzaGtlcm5lbCBvbiBY
ODZfNjQuIFRoZQo+Pj4+IHRvb2xzIGFyZToKPj4+Pgo+Pj4+IGtleGVjLXRvb2xzIDE6Mi4wLjIt
MXVidW50dTMKPj4+PiBtYWtlZHVtcGZpbGUgwqAgwqAgwqAgwqAxLjMuNy0yCj4+Pj4ga2R1bXAt
dG9vbHMgMS4zLjctMgo+Pj4+Cj4+Pj4gSSB3b3VsZCBiZSBpbnRlcmVzdGVkIHRvIGtub3cgaWYg
dGhpcyBpcyBhIGtub3duIHByb2JsZW0gYW5kIGlmIHNvCj4+Pj4gd2hldGhlciBvciBub3QgdGhl
cmUgaXMgYSBwYXRjaCBpbiB0aGUgcGlwZWxpbmUgdG8gY29ycmVjdCB0aGUgcHJvYmxlbS4KPj4+
Pgo+Pj4+IEkgd2lsbCBiZSBoYXBweSB0byBwcm92aWRlIGFueSBvdGhlciBkZXRhaWxzIHRoYXQg
YXJlIHJlcXVpcmVkIGluY2x1ZGluZwo+Pj4+IGRlYnVnIGJ1aWxkcyBpZiBuZWNlc3NhcnkuCj4+
PiAuLi4uCj4+Pj4KPj4+PiBbIMKgIMKgMS4zMjIxMDBdIGlvcmVtYXA6IGludmFsaWQgcGh5c2lj
YWwgYWRkcmVzcyBkYjc0MDAwMDAwMDAwMDAwIFsKPgo+Cj4gU2VhcmNoaW5nIGRiNzQwMDAwMDAw
MDAwMDAgZ290IHNldmVyYWwgc2ltaWxhciBjYXNlcyBvZiB0aGlzLCBhbGwgYXJlCj4gYWJvdXQg
cGVyIGNwdSBpbnZhbGlkIGNyYXNoX25vdGVzIGFkZHJlc3MsIGlzIHRoaXMgb25lIG1vcmU/Cj4K
CldoeSBpdCBpcyBwZXIgY3B1IGNyYXNoX25vdGU/CgpJIGJldCBUaW0gaXMgdXNpbmcgaTM4NiBt
YWNoaW5lLCBhbmQgb24gaTM4NiB3ZSBoYXZlLAoKa2V4ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14
ODYuYwoKc3RhdGljIGludCBnZXRfY3Jhc2hfbm90ZXMoaW50IGNwdSwgdWludDY0X3QgKmFkZHIs
IHVpbnQ2NF90ICpsZW4pCnsKICAgICAgICBjaGFyIGNyYXNoX25vdGVzW1BBVEhfTUFYXTsKICAg
ICAgICBjaGFyIGxpbmVbTUFYX0xJTkVdOwogICAgICAgIEZJTEUgKmZwOwogICAgICAgIHVuc2ln
bmVkIGxvbmcgdmFkZHI7CiAgICAgICAgaW50IGNvdW50OwoKICAgICAgICBzcHJpbnRmKGNyYXNo
X25vdGVzLCAiL3N5cy9rZXJuZWwvY3Jhc2hfbm90ZXMiKTsKICAgICAgICBmcCA9IGZvcGVuKGNy
YXNoX25vdGVzLCAiciIpOwogICAgICAgIGlmIChmcCkgewogICAgICAgICAgICAgICA8Li4uPgog
ICAgICAgIH0gZWxzZQogICAgICAgICAgICAgICAgcmV0dXJuIGdldF9jcmFzaF9ub3Rlc19wZXJf
Y3B1KGNwdSwgYWRkciwgbGVuKTsKfQoKQXMgbG9uZyBhcyB3ZSBoYXZlIC5ub3RlcyBzZWN0aW9u
LCAvc3lzL2tlcm5lbC9jcmFzaF9ub3RlcyBleGlzdHMuClNvIEkgc2VlIG5vIHJlYXNvbiB0aGF0
IGlzIHBlciBjcHUgbm90ZXMgc3R1ZmYuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
