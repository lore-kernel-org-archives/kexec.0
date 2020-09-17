Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIwpj-0003qu-8b
 for kexec@lists.infradead.org; Thu, 17 Sep 2020 16:32:32 +0000
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: RE: [PATCH v2 1/1] Calculate offset to field 'init_uts_ns.name'
In-Reply-To: <OSBPR01MB199111D24037A49B136EBF76DD3E0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200916135147.1303016-1-egorenar@linux.ibm.com>
 <OSBPR01MB199111D24037A49B136EBF76DD3E0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Date: Thu, 17 Sep 2020 18:32:23 +0200
Message-ID: <87mu1o1i08.fsf@oc8242746057.ibm.com>
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
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQk8ay1oYWdpby1hYkBuZWMuY29tPiB3cml0
ZXM6Cgo+Cj4gVGhhbmsgeW91IGZvciBjYXRjaGluZyB0aGlzIGFuZCB0aGUgcGF0Y2guCj4KPiBi
dXQgZG8geW91IGtub3cgdGhlIGtlcm5lbCBwYXRjaCBjb3JyZXNwb25kaW5nIHRvIHRoaXMgcGF0
Y2gsIGkuZS4gYWRkcwo+IHRoZSBPRkZTRVQoaW5pdF91dHNfbnMubmFtZSkgKHN0cmljdGx5LCBP
RkZTRVQodXRzX25hbWVzcGFjZS5uYW1lKSBwcm9iYWJseSkKPiBlbnRyeSB0byB2bWNvcmVpbmZv
PyAgVGhlIG1ha2VkdW1wZmlsZSB1c3VhbGx5IGp1c3QgcmVhZCBpdCBmcm9tIHZtY29yZSwKPiBz
byBjYW5ub3QgY2FsY3VsYXRlIHdpdGhvdXQgZGVidWcgaW5mbyBpbiB2bWxpbnV4Lgo+Cj4gSWYg
aXQgaGFzIG5vdCBiZWVuIHBvc3RlZCB5ZXQsIHdlIG5lZWQgdG8gZG8uICBUaGUgYmVzdCBzaXR1
YXRpb24gaXMKPiB0aGF0IHRoZSBwYXRjaCBpcyBtZXJnZWQgaW50byBsaW51eC1uZXh0IGZpcnN0
IGFuZCB0aGVuIG1lcmdlZCBpbnRvCj4gbWFpbmxpbmUgdG9nZXRoZXIgd2l0aCB0aGUgY29tbWl0
IDlhNTY0OTNmNjk0Mi4KPgo+IElzIGl0IHBvc3NpYmxlIGZvciB5b3U/ICBvdGhlcndpc2UsIGFu
eW9uZSBvciBJIG1pZ2h0IHRyeS4KPgoKSGkgS2F6dSwKCm15IHBhdGNoIGRvZXNuJ3QgcmVhbGx5
IHdvcmsgOiggVGhlIG9mZnNldCBmcm9tICdpbml0X3V0c19ucycgdG8gJ25hbWUnCmhhcyBjaGFu
Z2VkIGZyb20gNCB0byAwIGJ1dCBob3cgZG8geW91IGhhbmRsZSB0aGF0IGluIG1ha2VkdW1wZmls
ZSB3L28KZmlyc3Qga25vd2luZyB3aGF0IGtlcm5lbCB2ZXJzaW9uIHRoYXQgaXMuIEl0IGlzIGEg
Y2hpY2tlbi1hbmQtZWdnCnByb2JsZW0uIE5vdCBzdXJlIGhvdyB0byBzb2x2ZSBpdC4gVGhlIExp
bnV4IGtlcm5lbCBkb2Vzbid0IHByb3ZpZGUKdGhlIHN5bWJvbCAnaW5pdF9uc19ucy5uYW1lJyBh
cyBpIGluaXRpYWxseSB0aG91Z2h0IGFuZCAsdGhlcmVmb3JlLAppIGJhc2VkIG15IHBhdGNoIG9u
IGEgd3JvbmcgYXNzdW1wdGlvbi4gSXQgd291bGQgYmUgbmljZSBpZiBrZXJuZWwganVzdApwcm92
aWRlZCBhIHN5bWJvbCBmb3IgJ2luaXRfdXRzX25zLm5hbWUnIGluc3RlYWQgb2YgJ2luaXRfdXRz
X25zJyB3aGljaAptaWdodCBjaGFuZ2UgYW55dGltZS4KClJlZ2FyZHMKQWxleAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
