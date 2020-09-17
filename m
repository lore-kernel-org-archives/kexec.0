Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIrhq-0003CM-Oj
 for kexec@lists.infradead.org; Thu, 17 Sep 2020 11:04:03 +0000
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: RE: [PATCH v2 1/1] Calculate offset to field 'init_uts_ns.name'
In-Reply-To: <OSBPR01MB199111D24037A49B136EBF76DD3E0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200916135147.1303016-1-egorenar@linux.ibm.com>
 <OSBPR01MB199111D24037A49B136EBF76DD3E0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Date: Thu, 17 Sep 2020 13:03:51 +0200
Message-ID: <87r1r01x7s.fsf@oc8242746057.ibm.com>
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
ZXM6CgoKPiBUaGFuayB5b3UgZm9yIGNhdGNoaW5nIHRoaXMgYW5kIHRoZSBwYXRjaC4KPgo+IGJ1
dCBkbyB5b3Uga25vdyB0aGUga2VybmVsIHBhdGNoIGNvcnJlc3BvbmRpbmcgdG8gdGhpcyBwYXRj
aCwgaS5lLiBhZGRzCj4gdGhlIE9GRlNFVChpbml0X3V0c19ucy5uYW1lKSAoc3RyaWN0bHksIE9G
RlNFVCh1dHNfbmFtZXNwYWNlLm5hbWUpIHByb2JhYmx5KQo+IGVudHJ5IHRvIHZtY29yZWluZm8/
ICBUaGUgbWFrZWR1bXBmaWxlIHVzdWFsbHkganVzdCByZWFkIGl0IGZyb20gdm1jb3JlLAo+IHNv
IGNhbm5vdCBjYWxjdWxhdGUgd2l0aG91dCBkZWJ1ZyBpbmZvIGluIHZtbGludXguCj4KPiBJZiBp
dCBoYXMgbm90IGJlZW4gcG9zdGVkIHlldCwgd2UgbmVlZCB0byBkby4gIFRoZSBiZXN0IHNpdHVh
dGlvbiBpcwo+IHRoYXQgdGhlIHBhdGNoIGlzIG1lcmdlZCBpbnRvIGxpbnV4LW5leHQgZmlyc3Qg
YW5kIHRoZW4gbWVyZ2VkIGludG8KPiBtYWlubGluZSB0b2dldGhlciB3aXRoIHRoZSBjb21taXQg
OWE1NjQ5M2Y2OTQyLgo+Cj4gSXMgaXQgcG9zc2libGUgZm9yIHlvdT8gIG90aGVyd2lzZSwgYW55
b25lIG9yIEkgbWlnaHQgdHJ5Lgo+Cj4gVGhhbmtzLAo+IEthenUKPgoKSGkgS2F6dSwKCnNvcnJ5
LCBpJ20gbmV3IHRvIG1ha2VkdW1wZmlsZSBhbmQgYXBwYXJlbnRseSBzdGlsbCBub3QgdW5kZXJz
dGFuZGluZwpldmVyeXRoaW5nIGNvcnJlY3RseS4gSSBjaGVja2VkIHRoZSAqbGludXgtbmV4dCog
cmVwbyBhbmQgY291bGRuJ3QgZmluZAphbnl0aGluZyB3aGljaCBhZGRzICppbml0X3V0c19ucy5u
YW1lKi4gSSBvbmx5IHNlZQoKCVZNQ09SRUlORk9fT1NSRUxFQVNFKGluaXRfdXRzX25zLm5hbWUu
cmVsZWFzZSk7CgoJVk1DT1JFSU5GT19TWU1CT0woaW5pdF91dHNfbnMpOwoKSSBjaGVja2VkIGtl
cm5lbC9jcmFzaF9jb3JlLmMsIHRoaXMgaXMgdGhlIHJpZ2h0IHBsYWNlIHRvIGNoZWNrLCByaWdo
dCA/CkJ1dCBteSBmaXggc2VlbXMgdG8gd29yayB3aXRoIGEgY3Jhc2ggZHVtcCBmcm9tIGxpbnV4
LW5leHQuCgpUaGFua3MKUmVnYXJkcwpBbGV4CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
