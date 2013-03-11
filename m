Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UF6em-0007b8-A2
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 17:37:05 +0000
Date: Mon, 11 Mar 2013 13:36:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 01/20] vmcore: refer to e_phoff member explicitly
Message-ID: <20130311173650.GG8482@redhat.com>
References: <20130302083554.31252.30615.stgit@localhost6.localdomain6>
 <5135A054.7010401@cn.fujitsu.com> <513C2C47.5020008@cn.fujitsu.com>
 <20130311.093141.331282420.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130311.093141.331282420.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

T24gTW9uLCBNYXIgMTEsIDIwMTMgYXQgMDk6MzE6NDFBTSArMDkwMCwgSEFUQVlBTUEgRGFpc3Vr
ZSB3cm90ZToKPiBGcm9tOiBaaGFuZyBZYW5mZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3UuY29t
Pgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDEvMjBdIHZtY29yZTogcmVmZXIgdG8gZV9waG9m
ZiBtZW1iZXIgZXhwbGljaXRseQo+IERhdGU6IFN1biwgMTAgTWFyIDIwMTMgMTQ6NDY6MzEgKzA4
MDAKPiAKPiA+IOS6jiAyMDEz5bm0MDPmnIgwNeaXpSAxNTozNSwgWmhhbmcgWWFuZmVpIOWGmemB
kzoKPiA+PiDkuo4gMjAxM+W5tDAz5pyIMDLml6UgMTY6MzUsIEhBVEFZQU1BIERhaXN1a2Ug5YaZ
6YGTOgo+IDxjdXQ+Cj4gPiAKPiA+IE9uZSBtaW5vciBzdWdnZXN0aW9uLgo+ID4gCj4gPiBQcmV2
aW91c2x5LCB3aGVuIHRoZSBjb2RlIGFzc3VtZXMgcHJvZ3JhbSBoZWFkZXJzIGFyZSBmb2xsb3dp
bmcgaW1tZWRpYXRlbHkKPiA+IHRoZSBFTEYgaGVhZGVyLCBpdCB1c2VzCj4gPiAKPiA+ICBlbGZj
b3JlYnVmX3N6ID0gc2l6ZW9mKEVsZjY0X0VoZHIpICsgZWhkci5lX3BobnVtICogc2l6ZW9mKEVs
ZjY0X1BoZHIpOwo+ID4gCj4gPiB0byBjYWxjdWxhdGUgdGhlIHNpemUgb2YgRUxGIGhlYWRlciBh
bmQgRUxGIHByb2dyYW0gaGVhZGVycwo+ID4gCj4gPiBUaGlzIHBhdGNoIGF2b2lkcyB0aGUgYXNz
dW1wdGlvbiwgYW5kIHVzZXMgZWhkci5lX3Bob2ZmIHRvIGdldCB0aGUgcHJvZ3JhbQo+ID4gaGVh
ZGVycycgYWRkcmVzcy4gQnV0IGl0IHdpbGwgcmVhZCB1bnJlbGF0ZWQgY29udGVudHMgaW50byBl
bGZjb3JlYnVmIGlmCj4gPiBwcm9ncmFtIGhlYWRlcnMgYXJlIG5vdCBmb2xsb3dpbmcgaW1tZWRp
YXRlbHkgdGhlIEVMRiBoZWFkZXIuIFNvIGNvdWxkIHRoZQo+ID4gY29kZSBiZToKPiA+IAo+ID4g
ZWxmY29yZWJ1Zl9zeiA9IHNpemVvZihFbGY2NF9FaGRyKSArIGVoZHIuZV9waG51bSAqIHNpemVv
ZihFbGY2NF9QaGRyKTsKPiA+IGFkZHIgPSBlbGZjb3JlaGRyX2FkZHIgKyBlaGRyLmVfcGhvZmY7
Cj4gPiBtZW1jcHkoZWxmY29yZWJ1ZiwgJmVoZHIsIHNpemVvZihFbGY2NF9FaGRyKSk7Cj4gPiBy
ZWFkX2Zyb21fb2xkbWVtKGVsZmNvcmVidWYgKyBzaXplb2YoRWxmNjRfRWhkciksIGVsZmNvcmVi
dWZfc3ogLQo+ID4gICAgICAgICAgICAgICAgICBzaXplb2YoRWxmNjRfRWhkciksICZhZGRyLCAw
KTsKPiA+IChFbGY2NF9FaGRyICopZWxmY29yZWJ1Zi0+ZV9waG9mZiA9IHNpemVvZihFbGY2NF9F
aGRyKTsKPiAKPiBUaGFua3MuIFRoaXMgaXMgbm90IG1pbm9yIHN1Z2dlc3Rpb24uIFRoaXMgaXMg
Y3JpdGljYWwuIE15IGNvZGUgaXMKPiBjb21wbGV0ZWx5IGJyb2tlbi4gT24gRUxGLCBzZWdtZW50
cyBhbmQgaGVhZGVycyBvdGhlciB0aGFuIEVMRiBoZWFkZXIKPiBjYW4gb2NjdXIgaW4gYW55IHBv
c2l0aW9ucy4gVGhpcyBtZWFucyBwcm9ncmFtIGhlYWRlciB0YWJsZSBjYW4gb2NjdXIKPiBhZnRl
ciBzZWdtZW50cy4gU28sIG9uIHRlcmFieXRlIHN5c3RlbXMsIGVfcGhvZmYgY2FuIGJlIG1vcmUg
dGhhbgo+IHRlcmFieXRlcy4KCkFncmVlZC4gSXQgaXMgc2FmZXIgdG8gbm90IGNvcHkgYWwgdGhl
IGJpdHMgdGlsbCBlX3Bob2ZmLgoKVGhhbmtzClZpdmVrCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
