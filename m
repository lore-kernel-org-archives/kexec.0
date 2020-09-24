Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410053.outbound.protection.outlook.com
 ([40.107.141.53] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLG87-00060W-Vk
 for kexec@lists.infradead.org; Thu, 24 Sep 2020 01:33:05 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 1/1] kdump: append uts_namespace.name offset to VMCOREINFO
Date: Thu, 24 Sep 2020 01:32:54 +0000
Message-ID: <OSBPR01MB1991B5F6E08778A2F766E21ADD390@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200918080439.235190-1-egorenar@linux.ibm.com>
 <OSBPR01MB1991B0822ACE45077105DD46DD380@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <20200923060012.GA5347@dhcp-128-65.nay.redhat.com>
 <20200923060440.GA5442@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200923060440.GA5442@dhcp-128-65.nay.redhat.com>
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
To: "dyoung@redhat.com" <dyoung@redhat.com>, Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gT24gMDkvMjMvMjAgYXQgMDI6MDBwbSwgRGF2
ZSBZb3VuZyB3cm90ZToNCj4gPiBIaSBLYXp1LA0KPiA+IE9uIDA5LzIzLzIwIGF0IDA0OjM3YW0s
IEhBR0lPIEtBWlVISVRPKOiQqeWwviDkuIDku4EpIHdyb3RlOg0KPiA+ID4gSGkgRGF2ZSwNCj4g
PiA+DQo+ID4gPiBzb3JyeSB0byBib3RoZXIgeW91LiAgV2UgbmVlZCB0aGlzIGtlcm5lbCBwYXRj
aCB0byBmaXggYSBtYWtlZHVtcGZpbGUgaXNzdWUNCj4gPiA+IHdpdGggdGhlIGN1cnJlbnQgbGlu
dXgtbmV4dC4gIFNob3VsZCB3ZSBzZW5kIHRoaXMgdG8gdGhlIGFkZHJlc3NlcyBiZWxvdywgcmln
aHQ/DQo+ID4gPiBJJ20gbm90IHN1cmUgd2hldGhlciB0aGV5IGFyZSBlbm91Z2guDQo+ID4NCj4g
PiBJdCBpcyBnb29kLCBidXQgSSBzdWdnZXN0IGFsc28gY2MgRXJpYzoNCj4gPiAiRXJpYyBXLiBC
aWVkZXJtYW4iIDxlYmllZGVybUB4bWlzc2lvbi5jb20+DQo+IA0KPiBBbmQgYWxzbyBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPiBzaW5jZSB1c3VhbGx5IEFuZHJldw0K
PiB0YWtlcyB0aGVtLg0KDQpEYXZlLCB0aGFuayB5b3UgZm9yIHRoZSBjb21tZW50cy4NCg0KQWxl
eCwgY291bGQgeW91IHJlc2VuZCBpdCBhY2NvcmRpbmcgdG8gRGF2ZSdzIGNvbW1lbnRzPw0KDQo+
IEJUVywgdGhlIC1uZXh0IGNvbW1pdCBsb2cgc2hvdWxkIG1lbnRpb24gd2hpY2ggYnJhbmNoIHRo
ZSBjb21taXQgc3RheXMsIGFuZCBpdA0KPiB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIHRoZSBvcmln
aW5hbCBkaXNjdXNzaW9uIGxpbmsgZWcuIHRoZSBwYXRjaCBsaW5rIG9uDQo+IGxvcmUua2VybmVs
Lm9yZw0KDQppdCBzZWVtcyB0aGUgYnJhbmNoIGluIHdoaWNoIHRoZSBjb21taXQgdGhhdCBjaGFu
Z2VkIHN0cnVjdCB1dHNfbmFtZXNwYWNlDQpzdGF5cyBpcyAncGlkZmQtZml4ZXMvZml4ZXMnLg0K
DQpjb21taXQgNjcyMjhkZmZiZGFmMDg4ZDkzYzc1NjQ1Yjg5NTNkMTU0NzlhYjliYQ0KTWVyZ2U6
IGFiOGNkNjMzMWRhZiBiZGE0YzYwZDAyZTkNCkF1dGhvcjogU3RlcGhlbiBSb3Rod2VsbCA8c2Zy
QGNhbmIuYXV1Zy5vcmcuYXU+DQpEYXRlOiAgIFRodSBBdWcgMjAgMDg6NTY6MjYgMjAyMCArMTAw
MA0KDQogICAgTWVyZ2UgcmVtb3RlLXRyYWNraW5nIGJyYW5jaCAncGlkZmQtZml4ZXMvZml4ZXMn
IGludG8gbWFzdGVyDQoNCkl0IG1pZ2h0IGJlIGJldHRlciB0byBjYyBDaHJpc3RpYW4gQnJhdW5l
ciA8Y2hyaXN0aWFuLmJyYXVuZXJAdWJ1bnR1LmNvbT4NCmFzIHdlbGwsIHRoZSBicmFuY2gncyBt
YWludGFpbmVyIGp1c3QgaW4gY2FzZS4NCg0KVGhhbmtzLA0KS2F6dQ0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
