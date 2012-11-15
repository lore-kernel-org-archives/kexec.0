Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from col0-omc1-s8.col0.hotmail.com ([65.55.34.18])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYn8J-0002Yi-1n
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 00:16:40 +0000
Message-ID: <COL115-DS10732CE1033159B778B27FBC520@phx.gbl>
From: "Jun Hu" <duanshuidao@hotmail.com>
References: <935158332.31770683.1352922720179.JavaMail.root@redhat.com>
In-Reply-To: <935158332.31770683.1352922720179.JavaMail.root@redhat.com>
Subject: Re: [PATCH 0/5] crash: Bundle of fixes for Xen
Date: Thu, 15 Nov 2012 08:16:19 +0800
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, andrew cooper3 <andrew.cooper3@citrix.com>, ptesarik@suse.cz, jbeulich@suse.com, kexec@lists.infradead.org, crash-utility@redhat.com

SGkgRGFuaWVsOgoKSSBhbSBwbGVhc2VkIHRvIHNlZSB0aG9zZSBwYXRjaCwgYW5kICB3YW50IHRv
IHRlc3QgIHRoZSBsYXRlc3QgY3Jhc2ggdmVyc2lvbiAKZm9yIG15IGlzc3VlLgoKYnV0ICBob3cg
IEkgZ2V0IHRoZSBsYXRlc3QgY3Jhc2ggdmVyc2lvbiAsIGJ5IGdpdCAgb3Igb3RoZXIgPyAgIEkg
Y2FuJ3QgZmluZCAKaXQuCgpwbGVhc2UgdGVsbCBtZS4KCgotLS0tLeWOn+Wni+mCruS7ti0tLS0t
IApGcm9tOiBEYXZlIEFuZGVyc29uClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNSwgMjAxMiAz
OjUyIEFNClRvOiBEYW5pZWwgS2lwZXIKQ2M6IGtvbnJhZCB3aWxrIDsgYW5kcmV3IGNvb3BlcjMg
OyBvbGFmQGFlcGZsZS5kZSA7IGpiZXVsaWNoQHN1c2UuY29tIDsgCnB0ZXNhcmlrQHN1c2UuY3og
OyBjcmFzaC11dGlsaXR5QHJlZGhhdC5jb20gOyBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnIDsg
Cnhlbi1kZXZlbEBsaXN0cy54ZW5zb3VyY2UuY29tIDsgZHVhbnNodWlkYW9AaG90bWFpbC5jb20K
U3ViamVjdDogUmU6IFtQQVRDSCAwLzVdIGNyYXNoOiBCdW5kbGUgb2YgZml4ZXMgZm9yIFhlbgoK
CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gSGksCj4KPiBIZXJlIGlzIG5leHQgYnVu
ZGxlIG9mIGZpeGVzIGZvciBjcmFzaCBYZW4gc3VwcG9ydDoKPiAgIC0geGVuOiBGaXggcGFnZSB0
YWJsZXMgY2FjaGluZyBpc3N1ZXMsCj4gICAtIHhlbjogVXNlIGluaXRfdHNzIGFycmF5IG9yIHBl
cl9jcHVfX2luaXRfdHNzLAo+ICAgLSB4ZW46IFVzZSBwZXJfY3B1X19jcmFzaF9ub3RlcyBvciBj
cmFzaF9ub3RlcyBhcnJheSwKPiAgIC0geGVuOiBUcnkgaGFyZCB0byBnZXQgbWF4X2NwdXMgdmFs
dWUsCj4gICAtIHhlbjogVXNlIGNwdV9wcmVzZW50X21hcCBpbnN0ZWFkIG9mIGNwdV9vbmxpbmVf
bWFwLgo+Cj4gQWxsIHBhdGNoZXMgd2VyZSB0ZXN0ZWQgd2l0aCBYZW4gdmVyc2lvbnMgdXAgdG8g
NC4yLgo+Cj4gRGFuaWVsCj4KCkhpIERhbmllbCwKClRoZSBwYXRjaGVzIGxvb2sgcmVhc29uYWJs
ZSB0byBtZSwgYW5kIHRoZXkgdGVzdCBPSyBvbiBvbGRlcgpSSEVMNSBkb20wIGR1bXBmaWxlcy4g
IEl0IHdvdWxkIGJlIGludGVyZXN0aW5nIHRvIHNlZSB3aGV0aGVyCnRoZXkgd29yayBmb3IgSHUg
SnVuJ3MgU1VTRSBrZXJuZWwgZHVtcGZpbGUuICBJJ3ZlIGNjJ2QgaGltCmRpcmVjdGx5LgoKVGhh
bmtzLAogIERhdmUgCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
