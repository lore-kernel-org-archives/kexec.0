Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X7wm5-0004aK-Nv
 for kexec@lists.infradead.org; Fri, 18 Jul 2014 01:15:50 +0000
From: Kenichi Oomichi <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH 0/2] PPC64: Add virtual to physical address translation
 support for vmalloc region
Date: Fri, 18 Jul 2014 01:14:13 +0000
Message-ID: <663E0F2C6F9EEA4AAD1DEEBD89158AAE01077D76@BPXM06GP.gisp.nec.co.jp>
References: <20140717141827.8955.95825.stgit@localhost.localdomain>
In-Reply-To: <20140717141827.8955.95825.stgit@localhost.localdomain>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

TEdUTS4NCg0KVGhhbmtzIEhhcmkuDQoNClRoYW5rcw0KS2VuJ2ljaGkgT2htaWNoaQ0KDQotLS0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXJpIEJhdGhpbmkgW21h
aWx0bzpoYmF0aGluaUBsaW51eC52bmV0LmlibS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDE3LCAyMDE0IDExOjE5IFBNDQo+IFRvOiBLZXhlYy1tbDsgVGFjaGliYW5hIE1hc2FraSjmqZgg
5q2j5qi5KTsgS3VtYWdhaSBBdHN1c2hpKOeGiuiwtyDnr6Tlj7IpOyBPb21pY2hpIEtlbmljaGko
5aSn6YGTIOaGsuS4gCkNCj4gQ2M6IE1haGVzaCBKIFNhbGdhb25rYXINCj4gU3ViamVjdDogW1BB
VENIIDAvMl0gUFBDNjQ6IEFkZCB2aXJ0dWFsIHRvIHBoeXNpY2FsIGFkZHJlc3MgdHJhbnNsYXRp
b24gc3VwcG9ydCBmb3Igdm1hbGxvYyByZWdpb24NCj4gDQo+IEluIG1ha2VkdW1wZmlsZSB0b29s
LCBjdXJyZW50bHkgdGhlcmUgaXMgbm8gc3VwcG9ydCBmb3IgdmlydHVhbCB0byBwaHlzaWNhbA0K
PiBhZGRyZXNzIHRyYW5zbGF0aW9uIG9mIHZtYWxsb2MgcmVnaW9uICBvbiBQUEM2NCBhcmNoaXRl
Y3R1cmUuIFRoZXNlIHBhdGNoZXMNCj4gYWRkIHRoaXMgc3VwcG9ydC4gIFRoZSBwYXRjaGVzIGhh
dmUgYmVlbiB0ZXN0ZWQgYnkgIGVyYXNpbmcgZGF0YSBpbiB2bWFsbG9jDQo+IHJlZ2lvbiwgdmVy
ZnlpbmcgZm9yIGVyYXNlaW5mbyBpbiB0aGUgcmVzdWx0YW50IEVMRiBkdW1wIGFuZCB2ZXJpZml5
aW5nIHRoZQ0KPiByZXN1bHRhbnQgRUxGIGR1bXAgZm9yIHNhbml0eSB1c2luZyBjcmFzaCB1dGls
aXR5LiBBbHNvLCB0ZXN0ZWQgdGhlIHBhdGNoZXMNCj4gc3VjY2Vzc2Z1bGx5IHdpdGggZXBwaWMg
c2NyaXB0cy4NCj4gDQo+IC0tLQ0KPiANCj4gSGFyaSBCYXRoaW5pICgyKToNCj4gICAgICAgbWFr
ZWR1bXBmaWxlOiBJbml0aWFsaXplIGZvciB2bWFsbG9jIGFkZHJlc3MgdHJhbnNsYXRpb24gc3Vw
cG9ydCBpbiBQUEM2NCBhcmNoDQo+ICAgICAgIG1ha2VkdW1wZmlsZTogdnRvcCBhZGRyZXNzIHRy
YW5zbGF0aW9uIHN1cHBvcnQgZm9yIHZtYWxsb2MgcmVnaW9uIGluIFBQQzY0IGFyY2gNCj4gDQo+
IA0KPiAgYXJjaC9wcGM2NC5jICAgfCAgMTU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ICBtYWtlZHVtcGZpbGUuYyB8ICAgIDcgKysr
DQo+ICBtYWtlZHVtcGZpbGUuaCB8ICAgODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIzMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IC0tDQo+IC0gSGFyaQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
