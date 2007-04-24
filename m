Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HgEaO-0002eB-EL
	for kexec@lists.infradead.org; Tue, 24 Apr 2007 07:33:13 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3O6WLdI005917
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 02:32:21 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3O6WLT1200300
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 00:32:21 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3O6WKok000577
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 00:32:20 -0600
Date: Tue, 24 Apr 2007 12:01:40 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Message-ID: <20070424063139.GA22742@in.ibm.com>
References: <m1ircghb6w.fsf@ebiederm.dsl.xmission.com>
	<20070331232957.e1c93f19.akpm@linux-foundation.org>
	<20070402074159.GA13704@in.ibm.com>
	<m1abxrf9o3.fsf@ebiederm.dsl.xmission.com>
	<20070402094520.GC13704@in.ibm.com>
	<m1648eg01d.fsf@ebiederm.dsl.xmission.com>
	<20070403040152.GA5108@in.ibm.com>
	<m1zm5qc9q2.fsf@ebiederm.dsl.xmission.com>
	<20070403100349.GA21759@in.ibm.com>
	<m18xcjznbm.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m18xcjznbm.fsf_-_@ebiederm.dsl.xmission.com>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>

T24gU3VuLCBBcHIgMjIsIDIwMDcgYXQgMTE6MTI6MTNQTSAtMDYwMCwgRXJpYyBXLiBCaWVkZXJt
YW4gd3JvdGU6Cj4gCj4gQ3VycmVudGx5IGJlY2F1c2Ugdm1saW51eCBkb2VzIG5vdCByZWZsZWN0
IHRoYXQgdGhlIGtlcm5lbCBpcyByZWxvY2F0YWJsZQo+IHdlIHN0aWxsIGhhdmUgdG8gc3VwcG9y
dCBDT05GSUdfUEhZU0lDQUxfU1RBUlQuICBTbyB0aGlzIHBhdGNoIGFkZHMgYSBzbWFsbAo+IGMg
cHJvZ3JhbSB0byBkbyB3aGF0IHdlIGNhbm5vdCBkbyB3aXRoIGEgbGlua2VyIHNjcmlwdCwgc2V0
IHRoZSBlbGYgaGVhZGVyCj4gdHlwZSB0byBFVF9EWU4uCj4gCj4gVGhpcyBzaG91bGQgcmVtb3Zl
IHRoZSBsYXN0IG9ic3RhY2xlIHRvIHJlbW92aW5nIENPTkZJR19QSFlTSUNBTF9TVEFSVAo+IG9u
IHg4Nl82NC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBFcmljIFcuIEJpZWRlcm1hbiA8ZWJpZWRlcm1A
eG1pc3Npb24uY29tPgoKW0Ryb3BwaW5nIGZhc3Rib290IG1haWxpbmcgbGlzdCBmcm9tIENDIGFz
IGtleGVjIG1haWxpbmcgbGlzdCBpcyBuZXcgbGlzdAogZm9yIHRoaXMgZGlzY3Vzc2lvbl0KClsu
Ll0KPiArdm9pZCBmaWxlX29wZW4oY29uc3QgY2hhciAqbmFtZSkKPiArewo+ICsJaWYgKChmZCA9
IG9wZW4obmFtZSwgT19SRFdSLCAwKSkgPCAwKQo+ICsJCWRpZSgiVW5hYmxlIHRvIG9wZW4gYCVz
JzogJW0iLCBuYW1lKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgbWtldHJlbCh2b2lkKQo+ICt7
Cj4gKwl1bnNpZ25lZCBjaGFyIGVfdHlwZVsyXTsKPiArCWlmIChyZWFkKGZkLCAmZV9pZGVudCwg
c2l6ZW9mKGVfaWRlbnQpKSAhPSBzaXplb2YoZV9pZGVudCkpCj4gKwkJZGllKCJDYW5ub3QgcmVh
ZCBFTEYgaGVhZGVyOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKPiArCj4gKwlpZiAobWVtY21w
KGVfaWRlbnQsIEVMRk1BRywgNCkgIT0gMCkKPiArCQlkaWUoIk5vIEVMRiBtYWdpY1xuIik7Cj4g
Kwo+ICsJaWYgKChlX2lkZW50W0VJX0NMQVNTXSAhPSBFTEZDTEFTUzY0KSAmJgo+ICsJICAgIChl
X2lkZW50W0VJX0NMQVNTXSAhPSBFTEZDTEFTUzMyKSkKPiArCQlkaWUoIlVucmVjb2duaXplZCBF
TEYgY2xhc3M6ICV4XG4iLCBlX2lkZW50W0VJX0NMQVNTXSk7Cj4gKwkKPiArCWlmICgoZV9pZGVu
dFtFSV9EQVRBXSAhPSBFTEZEQVRBMkxTQikgJiYKPiArCSAgICAoZV9pZGVudFtFSV9EQVRBXSAh
PSBFTEZEQVRBMk1TQikpCj4gKwkJZGllKCJVbnJlY29nbml6ZWQgRUxGIGRhdGEgZW5jb2Rpbmc6
ICV4XG4iLCBlX2lkZW50W0VJX0RBVEFdKTsKPiArCj4gKwlpZiAoZV9pZGVudFtFSV9WRVJTSU9O
XSAhPSBFVl9DVVJSRU5UKQo+ICsJCWRpZSgiVW5rbm93biBFTEYgdmVyc2lvbjogJWRcbiIsIGVf
aWRlbnRbRUlfVkVSU0lPTl0pOwo+ICsKPiArCWlmIChlX2lkZW50W0VJX0RBVEFdID09IEVMRkRB
VEEyTFNCKSB7Cj4gKwkJZV90eXBlWzBdID0gRVRfUkVMICYgMHhmZjsKPiArCQllX3R5cGVbMV0g
PSBFVF9SRUwgPj4gODsKPiArCX0gZWxzZSB7Cj4gKwkJZV90eXBlWzFdID0gRVRfUkVMICYgMHhm
ZjsKPiArCQllX3R5cGVbMF0gPSBFVF9SRUwgPj4gODsKPiArCX0KCkhpIEVyaWMsCgpTaG91bGQg
dGhpcyBiZSBFVF9SRUwgb3IgRVRfRFlOPyBrZXhlYyByZWZ1c2VzIHRvIGxvYWQgdGhpcyB2bWxp
bnV4CmFzIGl0IGRvZXMgbm90IGZpbmQgaXQgdG8gYmUgZXhlY3V0YWJsZSB0eXBlLgoKSSBhbSBu
b3Qgd2VsbCB2ZXJzZWQgd2l0aCB2YXJpb3VzIGNvbnZlbnRpb25zIGJ1dCBpZiBJIGdvIHRocm91
Z2ggIkV4ZWN1dGFibGUKYW5kIExpbmtpbmcgRm9ybWF0IiBkb2N1bWVudCwgdGhpcyBpcyB3aGF0
IGl0IHNheXMgYWJvdXQgdmFyaW91cyBmaWxlIHR5cGVzLgoK4oCiIEEgcmVsb2NhdGFibGUgZmls
ZSBob2xkcyBjb2RlIGFuZCBkYXRhIHN1aXRhYmxlIGZvciBsaW5raW5nIHdpdGggb3RoZXIKICBv
YmplY3QgZmlsZXMgdG8gY3JlYXRlIGFuIGV4ZWN1dGFibGUgb3IgYSBzaGFyZWQgb2JqZWN0IGZp
bGUuCgrigKIgQW4gZXhlY3V0YWJsZSBmaWxlIGhvbGRzIGEgcHJvZ3JhbSBzdWl0YWJsZSBmb3Ig
ZXhlY3V0aW9uLgoK4oCiIEEgc2hhcmVkIG9iamVjdCBmaWxlIGhvbGRzIGNvZGUgYW5kIGRhdGEg
c3VpdGFibGUgZm9yIGxpbmtpbmcgaW4gdHdvCiAgY29udGV4dHMuIEZpcnN0LCB0aGUgbGluayBl
ZGl0b3IgbWF5IHByb2Nlc3MgaXQgd2l0aCBvdGhlciByZWxvY2F0YWJsZSBhbmQKICBzaGFyZWQg
b2JqZWN0IGZpbGVzIHRvIGNyZWF0ZSBhbm90aGVyIG9iamVjdCBmaWxlLiBTZWNvbmQsIHRoZSBk
eW5hbWljCiAgbGlua2VyIGNvbWJpbmVzIGl0IHdpdGggYW4gZXhlY3V0YWJsZSBmaWxlIGFuZCBv
dGhlciBzaGFyZWQgb2JqZWN0cwogIHRvIGNyZWF0ZSBhIHByb2Nlc3MgaW1hZ2UuCgpTbyBhYm92
ZSBkb2VzIG5vdCBzZWVtIHRvIGZpdCBpbiB0aGUgRVRfUkVMIHR5cGUuIFdlIGNhbid0IHJlbGlu
ayB0aGlzCnZtbGludXg/IEFuZCBpdCBkb2VzIG5vdCBzZWVtIHRvIGZpdCBpbiBFVF9EWU4gZGVm
aW5pdGlvbiB0b28uIFdlIGFyZQpub3QgcmVsaW5raW5nIHRoaXMgdm1saW51eCB3aXRoIGFub3Ro
ZXIgZXhlY3V0YWJsZSBvciBvdGhlciByZWxvY2F0YWJsZQpmaWxlcy4KCkkgcmVtZW1iZXIgb25j
ZSB5b3UgbWVudGlvbmVkIHRoZSB0ZXJtIGR5bmFtaWMgZXhlY3V0YWJsZSB3aGljaCBjYW4gYmUK
bG9hZGVkIGF0IGEgbm9uLWNvbXBpbGVkIGFkZHJlc3MgYW5kIGxldCBydW4gd2l0aG91dCByZXF1
aXJpbmcgYW55CnJlbG9jYXRpb24gcHJvY2Vzc2luZy4gVGhpcyB2bWxpbnV4IHdpbGwgZmFsbCBp
biB0aGF0IGNhdGVnb3J5IGJ1dCBjYW4ndCAKcmVsYXRlIGl0IHRvIHN0YW5kYXJkIGVsZiBmaWxl
IGRlZmluaXRpb25zLgoKVGhhbmtzClZpdmVrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
