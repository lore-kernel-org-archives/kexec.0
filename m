Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vl3cp-0006y3-Vs
 for kexec@lists.infradead.org; Mon, 25 Nov 2013 21:23:24 +0000
Message-ID: <5293BF8B.20203@zytor.com>
Date: Mon, 25 Nov 2013 13:22:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 00/12 v4] kexec kernel efi runtime support v	v4] efi:
 export more efi table variable to sysfs
References: <20131125085630.417850406@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20131125085630.417850406@dhcp-16-126.nay.redhat.com>
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
To: dyoung@redhat.com, linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, vgoyal@redhat.com

T24gMTEvMjUvMjAxMyAxMjo1NiBBTSwgZHlvdW5nQHJlZGhhdC5jb20gd3JvdGU6Cj4gCj4gRm9y
IGVmaSBydW50aW1lIG1hcHBpbmcgSSBhZGQgYSBuZXcgZGlyZWN0b3J5IC9zeXMvZmlybXdhcmUv
ZWZpLwo+IHJ1bnRpbWUtbWFwLyBsaWtlIGJlbG93Cj4gW2RhdmVAZGFya3N0YXIgfl0kIHRyZWUg
L3N5cy9maXJtd2FyZS9lZmkvcnVudGltZS1tYXAvCj4gL3N5cy9maXJtd2FyZS9lZmkvcnVudGlt
ZS1tYXAvCj4gw6LigJ3Fk8Oi4oCd4oKsw6LigJ3igqwgMAo+IMOi4oCd4oCaICAgw6LigJ3Fk8Oi
4oCd4oKsw6LigJ3igqwgYXR0cmlidXRlCj4gw6LigJ3igJogICDDouKAncWTw6LigJ3igqzDouKA
neKCrCBudW1fcGFnZXMKPiDDouKAneKAmiAgIMOi4oCdxZPDouKAneKCrMOi4oCd4oKsIHBoeXNf
YWRkcgo+IMOi4oCd4oCaICAgw6LigJ3Fk8Oi4oCd4oKsw6LigJ3igqwgdHlwZQo+IMOi4oCd4oCa
ICAgw6LigJ3igJ3DouKAneKCrMOi4oCd4oKsIHZpcnRfYWRkcgo+IMOi4oCdxZPDouKAneKCrMOi
4oCd4oKsIDEKPiDDouKAneKAmiAgIMOi4oCdxZPDouKAneKCrMOi4oCd4oKsIGF0dHJpYnV0ZQo+
IMOi4oCd4oCaICAgw6LigJ3Fk8Oi4oCd4oKsw6LigJ3igqwgbnVtX3BhZ2VzCj4gw6LigJ3igJog
ICDDouKAncWTw6LigJ3igqzDouKAneKCrCBwaHlzX2FkZHIKPiDDouKAneKAmiAgIMOi4oCdxZPD
ouKAneKCrMOi4oCd4oKsIHR5cGUKPiDDouKAneKAmiAgIMOi4oCd4oCdw6LigJ3igqzDouKAneKC
rCB2aXJ0X2FkZHIKPiBbc25pcF0KPiAgCgpUaGVzZSBwYXRjaGVzIGNhbWUgdGhyb3VnaCBzZXZl
cmVseSBjb3JydXB0ZWQsIHRoZSBhYm92ZSBpcyB0eXBpY2FsLi4uCgkKCS1ocGEKCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
