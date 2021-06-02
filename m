Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loGaX-001c35-Mq
 for kexec@lists.infradead.org; Wed, 02 Jun 2021 02:26:34 +0000
Date: Tue, 1 Jun 2021 19:26:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to mem_sections
Message-Id: <20210601192630.884b1f51b81f60f5f0823694@linux-foundation.org>
In-Reply-To: <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
 <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
 <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
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
To: "HAGIO =?UTF-8?B?S0FaVUhJVE8=?= (=?UTF-8?B?6JCp5bC+44CA5LiA5LuB?=)" <k-hagio-ab@nec.com>
Cc: David Hildenbrand <david@redhat.com>, Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

T24gV2VkLCAyIEp1biAyMDIxIDAxOjExOjA3ICswMDAwIEhBR0lPIEtBWlVISVRPKOiQqeWwvuOA
gOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6Cgo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tCj4gPiBPbiBUdWUsIDEgSnVuIDIwMjEgMTA6NDA6MDkgKzAyMDAgRGF2aWQgSGls
ZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gCj4gPiA+ID4gVGhhbmtzLCBp
IGV4cGxhaW5lZCB0aGUgcmVhc29uIGR1cmluZyBteSBsYXN0IHJlcGx5Lgo+ID4gPiA+IEFuZHJl
dyBoYXMgYWxyZWFkeSBwaWNrZWQgdGhpcyBwYXRjaCB0byAtbW0gdHJlZS4KPiA+ID4KPiA+ID4g
SnVzdCBiZWNhdXNlIGl0J3MgaW4gQW5kcmV3cyB0cmVlIGRvZXNuJ3QgbWVhbiBpdCB3aWxsIGVu
ZCB1cCB1cHN0cmVhbS4gOykKPiA+ID4KPiA+ID4gQW55aG93LCBubyByZWFsbHkgc3Ryb25nIG9w
aW5pb24sIGl0J3Mgc2ltcGx5IHVubmVjZXNzYXJ5IGNvZGUgY2h1cm4KPiA+ID4gdGhhdCBtYWtl
cyBiaXNlY3RpbmcgaGFyZGVyIHdpdGhvdXQgcmVhbCB2YWx1ZSBJTUhPLgo+ID4gCj4gPiBJIHRo
aW5rIGl0J3MgYSBnb29kIGNoYW5nZSAtIG1lbV9zZWN0aW9ucyByZWZlcnMgdG8gbXVsdGlwbGUg
aW5zdGFuY2VzCj4gPiBvZiBhIG1lbV9zZWN0aW9uLiAgQ2h1cm4gaXMgYSBwYWluLCBidXQgdGhh
dCdzIHRoZSBwcmljZSB3ZSBwYXkgZm9yIG1vcmUKPiA+IHJlYWRhYmxlIGNvZGUuICBBbmQgZm9y
IGhhdmluZyBzY3Jld2VkIGl0IHVwIG9yaWdpbmFsbHkgOykKPiAKPiA+RnJvbSBhIG1ha2VkdW1w
ZmlsZS9jcmFzaC11dGlsaXR5IHZpZXdwb2ludCwgSSBkb24ndCBkZW55IGtlcm5lbCBpbXByb3Zl
bWVudAo+IGFuZCBwcm9iYWJseSB0aGUgY2hhbmdlIHdpbGwgbm90IGJlIGhhcmQgZm9yIHRoZW0g
dG8gc3VwcG9ydCwgYnV0IEknZCBsaWtlCj4geW91IHRvIHJlbWVtYmVyIHRoYXQgdGhlIHRvb2wg
dXNlcnMgd2lsbCBuZWVkIHRvIHVwZGF0ZSB0aGVtIGZvciB0aGUgY2hhbmdlLgo+IAo+IFRoZSBz
aXR1YXRpb24gd2hlcmUgd2UgbmVlZCB0byB1cGRhdGUgdGhlIHRvb2xzIGZvciBuZXcga2VybmVs
cyBpcyB1c3VhbCwgYnV0Cj4gdGhlcmUgYXJlIG5vdCBtYW55IGNhc2VzIHRoYXQgdGhleSBjYW5u
b3QgZXZlbiBzdGFydCBzZXNzaW9uLCBhbmQgdGhpcyBjaGFuZ2UKPiB3aWxsIGNhdXNlIGl0LiAg
UGVyc29uYWxseSBJIHdvbmRlciB0aGUgY2hhbmdlIGlzIHdvcnRoIGZvcmNpbmcgdXNlcnMgdG8g
dXBkYXRlCj4gdGhlbS4KCkRpZG4ndCBrbm93IHRoYXQuICBJIGd1ZXNzIEknbGwgZHJvcCBpdCB0
aGVuLgoKV2UgY291bGQgZG8gYW4gYXNzZW1ibHktbGV2ZWwgYWxpYXMgSSBhc3N1bWUuLgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
