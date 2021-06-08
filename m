Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqY3i-007Qp9-Ut
 for kexec@lists.infradead.org; Tue, 08 Jun 2021 09:30:08 +0000
Received: by mail-il1-f200.google.com with SMTP id
 z6-20020a92cd060000b02901eb52fdfd60so5542205iln.14
 for <kexec@lists.infradead.org>; Tue, 08 Jun 2021 02:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210608031508.12447-1-piliu@redhat.com>
 <TYYPR01MB67773DBBBFD1E8511E2A82F8DD379@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <CAF+s44QENeo24ijWGv7WhjddYat7HLQ7Wh4YdZ7B+o9F60i0uQ@mail.gmail.com>
 <TYYPR01MB6777BB462602AEAB26EE85A3DD379@TYYPR01MB6777.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB6777BB462602AEAB26EE85A3DD379@TYYPR01MB6777.jpnprd01.prod.outlook.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 8 Jun 2021 17:29:52 +0800
Message-ID: <CAF+s44S6ABNZPK3XgjrukJ7VHZzKMNRUWrAnzXCMjHOTaoM-mQ@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile/arm64: get SECTIONS_SIZE_BITS from sysfs
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

T24gVHVlLCBKdW4gOCwgMjAyMSBhdCAzOjE3IFBNIEhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4
gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6Cj4KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+ID4gT24gVHVlLCBKdW4gOCwgMjAyMSBhdCAyOjA3IFBNIEhBR0lPIEtBWlVISVRP
KOiQqeWwvuOAgOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+ID4gT24gYXJtNjQsIG1lbW9yeSBzZWN0
aW9uIHNpemUgY2hhbmdlcyBkdWUgdG8gdGhlIGtlcm5lbCBjb21taXQKPiA+ID4gPiBmMGIxM2Vl
MjMyNDEgKCJhcm02NC9zcGFyc2VtZW06IHJlZHVjZSBTRUNUSU9OX1NJWkVfQklUUyIpCj4gPiA+
ID4KPiA+ID4gPiBUbyB0YWNrbGUgdGhlIGNvbXBhdGliaWxpdHksIGl0IGlzIHNhZmUgdG8gcmVh
ZCB0aGlzIGluZm8gZnJvbSBzeXNmcwo+ID4gPiA+ICIvc3lzL2RldmljZXMvc3lzdGVtL21lbW9y
eS9ibG9ja19zaXplX2J5dGVzIgo+ID4gPgo+ID4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaCwgYnV0
IHRoZSBwbGFjZSB3aGVyZSB3ZSBzaG91bGQgcHV0L2dldCBzdWNoCj4gPiA+IG5lY2Vzc2FyeSBp
bmZvcm1hdGlvbiBmaXJzdCBpcyB2bWNvcmVpbmZvLCB3aGljaCBleGlzdHMgZm9yIHRoYXQuCj4g
PiA+IENhbiB3ZSBhZGQgYW4gZW50cnkgZm9yIHRoZSBTRUNUSU9OU19TSVpFX0JJVFMgdGhlcmU/
Cj4gPiA+Cj4gPiBPSywgSSB3aWxsIHNlbmQgYSBwYXRjaCB0byBrZXJuZWwgZm9yIGl0Lgo+Cj4g
RldJVywgbXkgZXhwZWN0YXRpb24gaXMgdGhhdCBpdCB3aWxsIGJlIGFkZGVkIHRvIGtlcm5lbC9j
cmFzaF9jb3JlLmMsIGkuZS4KPiBub3Qgb25seSBmb3IgYXJtNjQsIGJlY2F1c2Ugc29tZSBhcmNo
aXRlY3R1cmVzIGxpa2UgYXJtIGFuZCBtaXBzIGFsc28gaGF2ZQo+IG11bHRpcGxlIHZhbHVlcyBs
aWtlIGFybTY0IGFuZCB0aGF0IHdpbGwgaGVscCB1c2UgbWFrZWR1bXBmaWxlLCBhbmQgYWxzbwo+
IHdpbGwgbWFrZSBpdCBhZGFwdGFibGUgdG8gZnV0dXJlIGNoYW5nZXMgb24gYWxsIGFyY2hpdGVj
dHVyZXMuCj4KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uIEkgaGF2ZSBjb21wb3NlZCBvbmUg
YW5kIHJ1biBzb21lIHRlc3Qgbm93LgoKV2lsbCBjYyB5b3Ugd2hlbiBzZW5kaW5nIGl0LgoKVGhh
bmtzLApQaW5nZmFuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
