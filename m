Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loHAv-001fH4-Cy
 for kexec@lists.infradead.org; Wed, 02 Jun 2021 03:04:10 +0000
Date: Wed, 2 Jun 2021 11:03:53 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to mem_sections
Message-ID: <20210602030353.GA409140@MiWiFi-R3L-srv>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
 <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
 <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
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
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

T24gMDYvMDIvMjEgYXQgMDE6MTFhbSwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3Jv
dGU6Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IE9uIFR1ZSwgMSBKdW4gMjAyMSAx
MDo0MDowOSArMDIwMCBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiAKPiA+ID4gPiBUaGFua3MsIGkgZXhwbGFpbmVkIHRoZSByZWFzb24gZHVyaW5nIG15IGxh
c3QgcmVwbHkuCj4gPiA+ID4gQW5kcmV3IGhhcyBhbHJlYWR5IHBpY2tlZCB0aGlzIHBhdGNoIHRv
IC1tbSB0cmVlLgo+ID4gPgo+ID4gPiBKdXN0IGJlY2F1c2UgaXQncyBpbiBBbmRyZXdzIHRyZWUg
ZG9lc24ndCBtZWFuIGl0IHdpbGwgZW5kIHVwIHVwc3RyZWFtLiA7KQo+ID4gPgo+ID4gPiBBbnlo
b3csIG5vIHJlYWxseSBzdHJvbmcgb3BpbmlvbiwgaXQncyBzaW1wbHkgdW5uZWNlc3NhcnkgY29k
ZSBjaHVybgo+ID4gPiB0aGF0IG1ha2VzIGJpc2VjdGluZyBoYXJkZXIgd2l0aG91dCByZWFsIHZh
bHVlIElNSE8uCj4gPiAKPiA+IEkgdGhpbmsgaXQncyBhIGdvb2QgY2hhbmdlIC0gbWVtX3NlY3Rp
b25zIHJlZmVycyB0byBtdWx0aXBsZSBpbnN0YW5jZXMKPiA+IG9mIGEgbWVtX3NlY3Rpb24uICBD
aHVybiBpcyBhIHBhaW4sIGJ1dCB0aGF0J3MgdGhlIHByaWNlIHdlIHBheSBmb3IgbW9yZQo+ID4g
cmVhZGFibGUgY29kZS4gIEFuZCBmb3IgaGF2aW5nIHNjcmV3ZWQgaXQgdXAgb3JpZ2luYWxseSA7
KQo+IAo+IEZyb20gYSBtYWtlZHVtcGZpbGUvY3Jhc2gtdXRpbGl0eSB2aWV3cG9pbnQsIEkgZG9u
J3QgZGVueSBrZXJuZWwgaW1wcm92ZW1lbnQKPiBhbmQgcHJvYmFibHkgdGhlIGNoYW5nZSB3aWxs
IG5vdCBiZSBoYXJkIGZvciB0aGVtIHRvIHN1cHBvcnQsIGJ1dCBJJ2QgbGlrZQo+IHlvdSB0byBy
ZW1lbWJlciB0aGF0IHRoZSB0b29sIHVzZXJzIHdpbGwgbmVlZCB0byB1cGRhdGUgdGhlbSBmb3Ig
dGhlIGNoYW5nZS4KCkFzIFZJTSB1c2VyLCBJIGNhbiB1bmRlcnN0YW5kIEFpc2hlbmcncyBmZWVs
aW5nIG9uIHRoZSBtZW1fc2VjdGlvbgp2YXJpYWJsZSB3aGljaCBoYXMgdGhlIHNhbWUgc3ltYm9s
IG5hbWUgYXMgaXRzIHR5cGUuIE1lYW53aGlsZSBpdCBkb2VzCmNhdXNlIG1ha2VkdW1wZmlsZS9j
cmFzaCBoYXZpbmcgdG8gYmUgY2hhbmdlZCBhY2NvcmRpbmdseS4KCk1heWJlIHdlIGNhbiBjYXJy
eSBpdCB3aGVuIGFueSBlc3NlbnRpYWwgY2hhbmdlIGlzIG5lZWRlZCBpbiBib3RoIGtlcm5lbAph
bmQgbWFrZWR1bXBmaWxlL2NyYXNoIGFyb3VuZCBpdC4KCj4gCj4gVGhlIHNpdHVhdGlvbiB3aGVy
ZSB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGUgdG9vbHMgZm9yIG5ldyBrZXJuZWxzIGlzIHVzdWFsLCBi
dXQKPiB0aGVyZSBhcmUgbm90IG1hbnkgY2FzZXMgdGhhdCB0aGV5IGNhbm5vdCBldmVuIHN0YXJ0
IHNlc3Npb24sIGFuZCB0aGlzIGNoYW5nZQoKQnkgdGhlIHdheSwgS2F6dSwgYWJvdXQgYSBjYXNl
IHN0YXJ0aW5nIHNlc3Npb24sIGNvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljCm9yIHJlcGhyYXNl
PyBJIG1heSBub3QgZ2V0IGl0IGNsZWFybHkuIFRoYW5rcy4KCj4gd2lsbCBjYXVzZSBpdC4gIFBl
cnNvbmFsbHkgSSB3b25kZXIgdGhlIGNoYW5nZSBpcyB3b3J0aCBmb3JjaW5nIHVzZXJzIHRvIHVw
ZGF0ZQo+IHRoZW0uCj4gCj4gVGhhbmtzLAo+IEthenUKPiAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
