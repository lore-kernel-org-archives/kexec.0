Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vl7ZV-0005do-6o
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 01:36:14 +0000
Date: Tue, 26 Nov 2013 09:35:20 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 00/12 v4] kexec kernel efi runtime support v	v4]
 efi: export more efi table variable to sysfs
Message-ID: <20131126013520.GA3706@dhcp-16-126.nay.redhat.com>
References: <20131125085630.417850406@dhcp-16-126.nay.redhat.com>
 <5293BF8B.20203@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5293BF8B.20203@zytor.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, vgoyal@redhat.com

T24gMTEvMjUvMTMgYXQgMDE6MjJwbSwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4gT24gMTEvMjUv
MjAxMyAxMjo1NiBBTSwgZHlvdW5nQHJlZGhhdC5jb20gd3JvdGU6Cj4gPiAKPiA+IEZvciBlZmkg
cnVudGltZSBtYXBwaW5nIEkgYWRkIGEgbmV3IGRpcmVjdG9yeSAvc3lzL2Zpcm13YXJlL2VmaS8K
PiA+IHJ1bnRpbWUtbWFwLyBsaWtlIGJlbG93Cj4gPiBbZGF2ZUBkYXJrc3RhciB+XSQgdHJlZSAv
c3lzL2Zpcm13YXJlL2VmaS9ydW50aW1lLW1hcC8KPiA+IC9zeXMvZmlybXdhcmUvZWZpL3J1bnRp
bWUtbWFwLwo+ID4gw6LigJ3Fk8Oi4oCd4oKsw6LigJ3igqwgMAo+ID4gw6LigJ3igJogICDDouKA
ncWTw6LigJ3igqzDouKAneKCrCBhdHRyaWJ1dGUKPiA+IMOi4oCd4oCaICAgw6LigJ3Fk8Oi4oCd
4oKsw6LigJ3igqwgbnVtX3BhZ2VzCj4gPiDDouKAneKAmiAgIMOi4oCdxZPDouKAneKCrMOi4oCd
4oKsIHBoeXNfYWRkcgo+ID4gw6LigJ3igJogICDDouKAncWTw6LigJ3igqzDouKAneKCrCB0eXBl
Cj4gPiDDouKAneKAmiAgIMOi4oCd4oCdw6LigJ3igqzDouKAneKCrCB2aXJ0X2FkZHIKPiA+IMOi
4oCdxZPDouKAneKCrMOi4oCd4oKsIDEKPiA+IMOi4oCd4oCaICAgw6LigJ3Fk8Oi4oCd4oKsw6Li
gJ3igqwgYXR0cmlidXRlCj4gPiDDouKAneKAmiAgIMOi4oCdxZPDouKAneKCrMOi4oCd4oKsIG51
bV9wYWdlcwo+ID4gw6LigJ3igJogICDDouKAncWTw6LigJ3igqzDouKAneKCrCBwaHlzX2FkZHIK
PiA+IMOi4oCd4oCaICAgw6LigJ3Fk8Oi4oCd4oKsw6LigJ3igqwgdHlwZQo+ID4gw6LigJ3igJog
ICDDouKAneKAncOi4oCd4oKsw6LigJ3igqwgdmlydF9hZGRyCj4gPiBbc25pcF0KPiA+ICAKPiAK
PiBUaGVzZSBwYXRjaGVzIGNhbWUgdGhyb3VnaCBzZXZlcmVseSBjb3JydXB0ZWQsIHRoZSBhYm92
ZSBpcyB0eXBpY2FsLi4uCgpIaSwgUGV0ZXIKCldpbGwgcmVzZW5kIHRoZW0gdG9kYXkgYWdhaW4u
CgotLQpUaGFua3MKRGF2ZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
