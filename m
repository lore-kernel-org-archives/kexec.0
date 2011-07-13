Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-iw0-f177.google.com ([209.85.214.177])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QguxJ-0001EZ-HL
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 08:38:10 +0000
Received: by iwn35 with SMTP id 35so6262837iwn.36
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 01:37:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C17AAE59A@USINDEVS01.corp.hds.com>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C17AAE59A@USINDEVS01.corp.hds.com>
Date: Wed, 13 Jul 2011 16:37:12 +0800
Message-ID: <CAM_iQpX3WhSus-8=igB_Bev5BkqnRfxEuAU2yzAQHfqcJPkNvw@mail.gmail.com>
Subject: Re: [RFC][PATCH] Replace a function call chain of
	kmsg_dump(KMSG_DUMP_KEXEC) with static function calls
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "Eric W. Biederman" <ebiederm@xmission.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, "hpa@zytor.com" <hpa@zytor.com>, Jarod Wilson <jwilson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Matthew Garrett <mjg@redhat.com>

MjAxMS83LzExIFNlaWppIEFndWNoaSA8c2VpamkuYWd1Y2hpQGhkcy5jb20+Ogo+IEhpLAo+CgpI
aSwKCj4KPiBbUGF0Y2ggRGVzY3JpcHRpb25dCj4KPiDCoEZvciBtZWV0aW5nIEVyaWMvVml2ZWsn
cyByZXF1aXJlbWVudHMgYW5kIHNvbHZpbmcgaXNzdWVzIG9mIHBzdG9yZS9lZml2YXJzIGRyaXZl
ciwgwqBJIHByb3Bvc2UgYSBmb2xsb3dpbmcgcGF0Y2guCj4KPiDCoCDCoC0gUmVtb3ZlIGttc2df
ZHVtcChLTVNHX0RVTVBfS0VYRUMpIGZyb20gY3Jhc2hfa2V4ZWMoKQoKSXQgaXMgYWxyZWFkeSBy
ZW1vdmVkIGluIC1tbSwgY2FuIHlvdSByZWJhc2UgeW91ciBwYXRjaCBhZ2FpbnN0IC1tbT8KCj4g
wqAgwqAtIEFkZCBrbXNnX2R1bXBfa2V4ZWMoKSB0byBjcmFzaF9rZXhlYygpCj4gwqAgwqAgwqAg
wqBrbXNnX2R1bXBfa2V4ZWMoKSBtb3ZlZCBiZWhpbmQgbWFjaGluZV9jcmFzaF9zaHV0ZG93bigp
IHNvIHRoYXQKPiDCoCDCoCDCoCDCoHdlIGNhbiBvdXRwdXQga2VybmVsIG1lc3NhZ2VzIHdpdGhv
dXQgZ2V0dGluZyBhbnkgbG9ja3MuCj4KPiDCoCDCoC0gSW50cm9kdWNlIENPTkZJR19LTVNHX0RV
TVBfS0VYRUMKPiDCoCDCoCDCoCDCoC0gQ09ORklHX0tNU0dfRFVNUF9LRVhFQyBkZXBlbmRzIG9u
IENPTkZJR19QUklOVEsgd2hpY2ggaXMgcmVxdWlyZWQgZm9yIGttc2dfZHVtcGVyLgo+Cj4gwqAg
wqAgwqAgwqAtIENPTkZJR19LTVNHX0RVTVBfS0VYRUM9biAoZGVmYXVsdCkKPiDCoCDCoCDCoCDC
oCDCoEtlcm5lbCBtZXNzYWdlIGxvZ2dpbmcgZmVhdHVyZSBkb2Vzbid0IHdvcmsgaW4ga2R1bXAg
cGF0aC4KPgo+IMKgIMKgIMKgIMKgLSBDT05GSUdfS01TR19EVU1QX0tFWEVDPXkKPiDCoCDCoCDC
oCDCoCDCoGZvbGxvd2luZyBzdGF0aWMgZnVuY3Rpb25zIGFyZSBjYWxsZWQgaW4ga2R1bXAgcGF0
aC4KPiDCoCDCoCDCoCDCoCDCoC0ga21zZ19kdW1wX2tleGVjKCk6IFRoaXMgaXMgYmFzZWQgb24g
a21zZ19kdW1wKCkgYW5kIGp1c3QgcmVtb3ZlZCBzcGlubG9jayBhbmQgYSBmdW5jdGlvbiBjYWxs
IGNoYWluIGZyb20gaXQuCj4gwqAgwqAgwqAgwqAgwqAtIGRvX2ttc2dfZHVtcF9rZXhlYygpOiBU
aGlzIGlzIGJhc2VkIG9uIHBzdG9yZV9kdW1wKCkgYW5kIGp1c3QgcmVtb3ZlZCBtdXRleCBsb2Nr
IGZyb20gaXQuCj4KPiDCoCDCoCDCoCDCoFNvbWUgcGVvcGxlIHdobyBhcmUgbm90IGZhbWlsaWFy
IHdpdGgga2V4ZWMgbWF5IGFkZCBmdW5jdGlvbiBjYWxscyBnZXR0aW5nIHNwaW5fbG9jay9tdXRl
eF9sb2NrIGluIGtleGVjIHBhdGguCj4gwqAgwqAgwqAgwqBUaGVzZSBmdW5jdGlvbiBjYWxscyBj
YXVzZXMgZmFpbHVyZSBvZiBrZXhlYy4KPiDCoCDCoCDCoCDCoFNvLCBJIHN1Z2dlc3QgcmVwbGFj
ZSBhIGNhbGwgY2hhaW4gd2l0aCBzdGF0aWMgZnVuY3Rpb24gY2FsbHMgc28gdGhhdCB3ZSBjYW4g
a2VlcCByZWxpYWJpbGl0eSBvZiBrZXhlYy4KPgo+IMKgIMKgIC0gQWRkIGVmaV9rbXNnX2R1bXBf
a2V4ZWMoKSB3aGljaCBvdXRwdXRzIGtlcm5lbCBtZXNzYWdlcyBpbnRvIE5WUkFNIHdpdGggRUZJ
Lgo+IMKgIMKgIMKgIFRoaXMgaXMgY2FsbGVkIGJ5IGRvX2ttc2dfZHVtcF9rZXhlYygpIHN0YXRp
Y2FsbHkuCj4gwqAgwqAgwqAgQnkgYXBwbHlpbmcgdG8gTWF0dGhldyBHYXJyZXQncyBwYXRjaCBi
ZWxvdywgaXRzIGtlcm5lbCBtZXNzYWdlcyBpbiBOVlJBTSBhcmUgdmlzaWJsZSB0aHJvdWdoIC9k
ZXYvcHN0b3JlLgoKVGhpcyBsb29rcyB3ZWlyZCwga21zZ19kdW1wX2tleGVjKCkgY2FsbHMgZG9f
a21zZ19kdW1wX2tleGVjKCkKd2hpY2ggdGhlbiBjYWxscyBlZmlfa21zZ19kdW1wX2tleGVjKCks
IHNvLCB3aHkgbm90IGp1c3QgY2FsbAplZmlfa21zZ19kdW1wX2tleGVjKCk/CnNpbmNlIHRoZXJl
IGlzIG5vIG90aGVyIHVzZXIgb2Yga21zZ19kdW1wX2tleGVjKCkuCgpGcm9tIHRoZSBuYW1lIENP
TkZJR19LTVNHX0RVTVBfS0VYRUMsIHlvdSBzZWVtIHRvIHByb3ZpZGUgYSBnZW5lcmljIG1ldGhv
ZCwKYnV0IGFjdHVhbGx5IG9ubHkgZWZpX2ttc2dfZHVtcF9rZXhlYygpIGlzIGFuZCBjYW4gYmUg
Y2FsbGVkLgoKVGhhbmtzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
