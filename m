Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHrWo-0005Pp-K5
 for kexec@lists.infradead.org; Fri, 16 Dec 2016 12:22:23 +0000
Message-ID: <1481890738.9552.70.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 16 Dec 2016 14:18:58 +0200
In-Reply-To: <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion>
 <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>, Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE2LTEyLTE2IGF0IDEwOjMyICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IE9u
IDEyLzE1LzE2IGF0IDEyOjI4cG0sIEplYW4gRGVsdmFyZSB3cm90ZToKPiA+IEhpIEFuZHksCj4g
PiAKPiA+IE9uIEZyaSzCoMKgMiBEZWMgMjAxNiAyMTo1NDoxNiArMDIwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOgo+ID4gPiBVbnRpbCBub3cga2V4ZWMnZWQga2VybmVsIGhhcyBubyBjbHVlIHdo
ZXJlIHRvIGxvb2sgZm9yIERNSSBlbnRyeQo+ID4gPiBwb2ludC4KPiA+ID4gCj4gPiA+IFBhc3Mg
aXQgdmlhIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVyIGluIHRoZSBzYW1lIHdheSBhcyBp
dCdzCj4gPiA+IGRvbmUgZm9yIEFDUEkKPiA+ID4gUlNEUC4KPiA+IAo+ID4gSSBhbSBubyBrZXhl
YyBleHBlcnQgYnV0IHRoaXMgY29uZnVzZXMgbWUuIFNob3VsZG4ndCB0aGUgc2Vjb25kCj4gPiBr
ZXJuZWwKPiA+IGhhdmUgYWNjZXNzIHRvIHRoZSBFRkkgc3lzdGFiIGFzIHRoZSBmaXJzdCBrZXJu
ZWwgZG9lcz8gSXQgaW5jbHVkZXMKPiA+IG1hbnkgbW9yZSBwb2ludGVycyB0aGFuIGp1c3QgQUNQ
SSBhbmQgRE1JIHRhYmxlcywgYW5kIGl0IHdvdWxkIHNlZW0KPiA+IGluY29udmVuaWVudCB0byBo
YXZlIHRvIHBhc3MgYWxsIHRoZXNlIGFkZHJlc3NlcyBpbmRpdmlkdWFsbHkKPiA+IGV4cGxpY2l0
bHkuCj4gCj4gWWVzLCBpbiBtb2Rlcm4gbGludXgga2VybmVsLCBrZXhlYyBoYXMgdGhlIHN1cHBv
cnQgZm9yIEVGSSwgSSB0aGluayBpdAo+IHNob3VsZCB3b3JrIG5hdHVyYWxseSBhdCBsZWFzdCBp
biB4ODZfNjQuCgpUaGFua3MgZm9yIHRoaXMgZ29vZCBuZXdzIQoKVW5mb3J0dW5hdGVseSBJbnRl
bCBHYWxpbGVvIGlzIDMyLWJpdCBwbGF0Zm9ybS4KCi0tIApBbmR5IFNoZXZjaGVua28gPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KSW50ZWwgRmlubGFuZCBPeQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
