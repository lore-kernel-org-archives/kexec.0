Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aixzp-0006BC-LV
 for kexec@lists.infradead.org; Thu, 24 Mar 2016 05:39:51 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v4] Improve the performance of --num-threads -d 31
From: Minfei Huang <mhuang@redhat.com>
In-Reply-To: <56F37AEA.3050306@cn.fujitsu.com>
Date: Thu, 24 Mar 2016 01:39:20 -0400 (EDT)
Message-Id: <08A608F7-3686-4857-8889-B0F9F0380D38@redhat.com>
References: <1457483231-2092-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160315063430.GA12981@dhcp-128-25.nay.redhat.com>
 <56EB6C06.30205@cn.fujitsu.com>
 <20160318041622.GB29025@dhcp-128-25.nay.redhat.com>
 <56EB96B8.7010103@cn.fujitsu.com> <56F37AEA.3050306@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "=?GB2312?Q? Zhou,
 _Wenjian/=D6=DC=CE=C4=BD=A3 ?=" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

SGksIFpob3UuDQoNCkknbSBvbiBob2xpZGF5IG5vdywgeW91IGNhbiBhc2sgb3RoZXIgcGVvcGxl
IHRvIGhlbHAgdGVzdCwgaWYgbmVjZXNzYXJ5Lg0KDQpUaGFua3MNCk1pbmZlaQ0KDQo+INTaIDIw
MTbE6jPUwjI0yNWjrDEyOjI5o6xaaG91LCBXZW5qaWFuL9bczsS9oyA8emhvdXdqLWZuc3RAY24u
ZnVqaXRzdS5jb20+INC0tcCjug0KPiANCj4gSGVsbG8gTWluZmVpLA0KPiANCj4gSG93IGRvIHRo
ZXNlIHR3byBwYXRjaGVzIHdvcms/DQo+IA0KPiAtLSANCj4gVGhhbmtzDQo+IFpob3UNCj4gDQo+
PiBPbiAwMy8xOC8yMDE2IDAxOjQ4IFBNLCAiWmhvdSwgV2Vuamlhbi/W3M7EvaMiIHdyb3RlOg0K
Pj4+IE9uIDAzLzE4LzIwMTYgMTI6MTYgUE0sIE1pbmZlaSBIdWFuZyB3cm90ZToNCj4+Pj4gT24g
MDMvMTgvMTYgYXQgMTA6NDZhbSwgIlpob3UsIFdlbmppYW4v1tzOxL2jIiB3cm90ZToNCj4+Pj4g
SGVsbG8gTWluZmVpLA0KPj4+PiANCj4+Pj4gU2luY2UgSSBjYW4ndCBwcm9kdWNlIHRoZSBidWcs
IEkgcmV2aWV3ZWQgdGhlIHBhdGNoIGFuZCB3cm90ZSBhbiBpbmNyZW1lbnQgcGF0Y2guDQo+Pj4+
IFRob3VnaCB0aGVyZSBhcmUgc29tZSBidWdzIGluIHRoZSBpbmNyZW1lbnQgcGF0Y2gsDQo+Pj4+
IEkgd29uZGVyIGlmIHRoZSBwcmV2aW91cyBidWcgc3RpbGwgZXhpc3RzIHdpdGggdGhpcyBwYXRj
aC4NCj4+Pj4gQ291bGQgeW91IGhlbHAgbWUgY29uZmlybSBpdD8NCj4+PiANCj4+PiBPay4gSSB3
aWxsIGhlbHAgdmVyaWZ5IHRoaXMgaW5jcmVhc2luZyBwYXRjaC4NCj4+IA0KPj4gVGhhbmsgeW91
IHZlcnkgbXVjaC4NCj4+IA0KPj4+PiANCj4+Pj4gQW5kIEkgaGF2ZSBhbm90aGVyIHF1ZXN0aW9u
Lg0KPj4+PiBEaWQgaXQgb25seSBvY2N1ciBpbiBwYXRjaCB2ND8NCj4+PiANCj4+PiBUaGlzIGlz
c3VlIGRvZXNuJ3QgZXhpc3QgaW4gdjMuIEkgaGF2ZSBwYXN0ZWQgdGhlIHRlc3QgcmVzdWx0IHdp
dGgNCj4+PiAtLW51bS10aHJlYWQgMzIgaW4gdGhhdCB0aHJlYWQuDQo+Pj4gDQo+Pj4gYXBwbGll
ZCBtYWtlZHVtcGZpbGUgd2l0aCBvcHRpb24gLWQgMzEgLS1udW0tdGhyZWFkcyAzMg0KPj4+IHJl
YWwgICAgM20zLjUzM3MNCj4+IA0KPj4gT2gsIHRoZW4gdGhlIHBhdGNoIGluIHRoZSBwcmV2aW91
cyBtYWlsIG1heSBub3Qgd29yay4NCj4+IA0KPj4gSSdtIGFwcHJlY2lhdGVkIGlmIHlvdSBjYW4g
YWxzbyB0ZXN0IHRoZSBwYXRjaCBpbiB0aGlzIGxldHRlci4NCj4+IA0KPj4gSSBpbnRyb2R1Y2Vk
IHNlbWFwaG9yZSB0byBmaXggdGhlIGJ1ZyBpbiB0aGUgdjMuDQo+PiBTbyBJIHdhbnQgdG8ga25v
dyBpZiBpdCBpcyB0aGlzIHdoaWNoIGFmZmVjdHMgdGhlIHJlc3VsdC4NCj4+IFRoZSBhdHRhY2hl
ZCBwYXRjaCBpcyBiYXNlZCBvbiB2NCwgdXNlZCB0byByZW1vdmUgc2VtYW9ob3JlLg0KPj4gDQo+
PiANCj4+IA0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4+IGtleGVjIG1haWxpbmcgbGlzdA0KPj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
Pj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYw0KPiAN
Cj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
