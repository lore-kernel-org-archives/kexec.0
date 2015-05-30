Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YyeuG-0002UR-DW
 for kexec@lists.infradead.org; Sat, 30 May 2015 11:26:24 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Sat, 30 May 2015 11:23:36 +0000
Message-ID: <3085F41B-FE6D-4E39-916A-F7B539B28BCB@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>,
 <20150529162151.GB20384@8bytes.org>
In-Reply-To: <20150529162151.GB20384@8bytes.org>
Content-Language: zh-CN
MIME-Version: 1.0
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
To: Joerg Roedel <joro@8bytes.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "bhe@redhat.com" <bhe@redhat.com>, "Vaden, 
 Tom (HP Server OS Architecture)" <tom.vaden@hp.com>, "Wright,
 Randy (HP Servers Linux)" <rwright@hp.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mitchell,
 Lisa (MCLinux in
 Fort Collins)" <lisa.mitchell@hp.com>, "Hoemann, Jerry" <jerry.hoemann@hp.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "ddutile@redhat.com" <ddutile@redhat.com>, "Hatch, Douglas B (HPS Linux
 PM)" <doug.hatch@hp.com>, "ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "billsumnerlinux@gmail.com" <billsumnerlinux@gmail.com>, "Zhang, Li
 (Zoe@HPservers-Core-OE-PSC)" <li.zhang6@hp.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

DQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB0aGlzLg0KDQp6aGVuaHVhDQoNCkZyb20gTXkgaVBo
b25lDQoNCj4g1NogMjAxNcTqNdTCMzDI1aOsMDA6MjKjrEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0
ZXMub3JnPiDQtLXAo7oNCj4gDQo+PiBPbiBNb24sIE1heSAxMSwgMjAxNSBhdCAwNTo1Mjo0NFBN
ICswODAwLCBMaSwgWmhlbi1IdWEgd3JvdGU6DQo+PiBMaSwgWmhlbi1IdWEgKDEwKToNCj4+ICBp
b21tdS92dC1kOiBOZXcgZnVuY3Rpb24gdG8gYXR0YWNoIGRvbWFpbiB3aXRoIGlkDQo+PiAgaW9t
bXUvdnQtZDogSXRlbXMgcmVxdWlyZWQgZm9yIGtkdW1wDQo+PiAgaW9tbXUvdnQtZDogRnVuY3Rp
b24gdG8gZ2V0IGV4aXN0aW5nIGNvbnRleHQgZW50cnkNCj4+ICBpb21tdS92dC1kOiBmdW5jdGlv
bnMgdG8gY29weSBkYXRhIGZyb20gb2xkIG1lbQ0KPj4gIGlvbW11L3Z0LWQ6IEFkZCBmdW5jdGlv
bnMgdG8gbG9hZCBhbmQgc2F2ZSBvbGQgcmUNCj4+ICBpb21tdS92dC1kOiBkYXRhdHlwZXMgYW5k
IGZ1bmN0aW9ucyB1c2VkIGZvciBrZHVtcA0KPj4gIGlvbW11L3Z0LWQ6IGVuYWJsZSBrZHVtcCBz
dXBwb3J0IGluIGlvbW11IG1vZHVsZQ0KPj4gIGlvbW11L3Z0LWQ6IGFzc2lnbiBuZXcgcGFnZSB0
YWJsZSBmb3IgZG1hX21hcA0KPj4gIGlvbW11L3Z0LWQ6IENvcHkgZnVuY3Rpb25zIGZvciBpcnRl
DQo+PiAgaW9tbXUvdnQtZDogVXNlIG9sZCBpcnRlIGluIGtkdW1wIGtlcm5lbA0KPj4gDQo+PiBk
cml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgICAgICAgICB8IDUzNiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4+IGRyaXZlcnMvaW9tbXUvaW50ZWxfaXJxX3JlbWFwcGlu
Zy5jIHwgIDk2ICsrKysrKy0NCj4+IGluY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaCAgICAgICAg
IHwgIDE2ICsrDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDYyMyBpbnNlcnRpb25zKCspLCAyNSBkZWxl
dGlvbnMoLSkNCj4gDQo+IEFwcGxpZWQgd2l0aCBhIGZldyBtaW5vciBjaGFuZ2VzLCB0aGFua3Mu
DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
