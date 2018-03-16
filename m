Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ewnmb-0006hH-OM
 for kexec@lists.infradead.org; Fri, 16 Mar 2018 11:44:27 +0000
Date: Fri, 16 Mar 2018 12:44:13 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH v4 4/5] kexec: add option to fall back to KEXEC_LOAD
 when KEXEC_FILE_LOAD is not supported.
Message-ID: <20180316124413.6b398baf@naga.suse.cz>
In-Reply-To: <20180316064502.GA11233@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <19a47e290fc03efea82af845740ae8f6b30f13b8.1520342150.git.msuchanek@suse.de>
 <20180314032159.GA4889@dhcp-128-65.nay.redhat.com>
 <20180315120637.4f4c8dc6@kitsune.suse.cz>
 <20180316064502.GA11233@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>

T24gRnJpLCAxNiBNYXIgMjAxOCAxNDo0NTowMiArMDgwMApEYXZlIFlvdW5nIDxkeW91bmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cgo+IE9uIDAzLzE1LzE4IGF0IDEyOjA2cG0sIE1pY2hhbCBTdWNow6Fu
ZWsgd3JvdGU6Cj4gPiBPbiBXZWQsIDE0IE1hciAyMDE4IDExOjIxOjU5ICswODAwCj4gPiBEYXZl
IFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAgIAo+ID4gPiBJdCBsb29rcyB0
byBtZSBpdCBpcyBlbm91Z2ggb25seSBjaGVja2luZyAtRU5PU1lTIG1heWJlIGFsc28KPiA+ID4g
LUVOT1RTVVBQIGFuZCB0aGVuIHNldCBkb19rZXhlY19maWxlX3N5c2NhbGwgPSAwOwo+ID4gPiAK
PiA+ID4gRUlOVkFMIGFuZCBFTk9FWEVDIGFyZSByZWFsIGVycm9ycywgSSBkbyBub3QgdW5kZXJz
dGFuZCB3aHkgc3RpbGwgCj4gPiA+IGZhbGxiYWNrLiAgICAKPiA+IAo+ID4gSWYgeW91IHBhc3Mg
YW4gaW1hZ2UgdHlwZSB0aGF0IHRoZSBrZXJuZWwgZG9lcyBub3QgdW5kZXJzdGFuZCAoZWcuCj4g
PiBtdWx0aWJvb3Qgb3IgdUltYWdlKSB0aGVuIHRoZSBrZXJuZWwgd2lsbCByZXR1cm4gYSByZWFs
IGVycm9yCj4gPiBiZWNhdXNlIGl0IGRvZXMgbm90IHVuZGVyc3RhbmQgdGhlIGltYWdlLiBIb3dl
dmVyLCBrZXhlYy10b29scwo+ID4gc2hvdWxkIHN0aWxsIGJlIGFibGUgdG8gbG9hZCBpdCwgYXV0
b21hdGljYWxseS4gVGhhdCdzIHdoYXQgdGhlCj4gPiAtYXV0byBzdGFuZHMgZm9yLiAgCj4gCj4g
VGhpcyBzZW1lcyBvdmVyIGVuZ2luZWVyaW5nLCB0aGUgaW5pdGlhbCBwdXJwb3NlIGlzIHRvIGZh
bGxiYWNrIHdoZW4KPiBrZXhlY19maWxlX2xvYWQgaXMgbm90IHN1cHBvcnRlZCwgc28gSSB3b3Vs
ZCBzdWdnZXN0IG5vdCB0byBkbyBtb3JlCj4gdGhhbiB0aGF0LgoKVGhlIGluaXRpYWwgcHVycG9z
ZSBpcyBmb3IgdXNlcnMgdG8gbm90IG5lZWQgdG8gc3BlY2lmeSBhbnkgZmxhZyB0bwpzZWxlY3Qg
YSBzeXNjYWxsIHRvIHVzZS4gU2luY2UgdGhpcyBpcyBub3QgYWNjZXB0YWJsZSBiZWNhdXNlIGl0
IG1pZ2h0Cm1ha2Uga2V4ZWMgd29yayBvdXQgb2YgdGhlIGJveCBvbiBzeXN0ZW1zIHdoZXJlIGl0
IHdhcyBwcmV2aW91c2x5IGJyb2tlbgpvciB3aGF0ZXZlciB0aGlzIG5ldyBmbGFnIGlzIHN1cHBv
c2VkIHRvIGFjaGlldmUgdGhhdDogd2hlbiBzcGVjaWZpZWQKa2V4ZWMgdHJpZXMgaGFyZCB0byBk
byB0aGUgYmVzdCB0aGluZyBwb3NzaWJsZSB3aXRoIHRoZSBpbWFnZSBpdApyZWNlaXZlZC4KClRo
YW5rcwoKTWljaGFsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
