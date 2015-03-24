Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-we0-x235.google.com ([2a00:1450:400c:c03::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YaJ0F-0001zt-P5
 for kexec@lists.infradead.org; Tue, 24 Mar 2015 07:11:56 +0000
Received: by weoy45 with SMTP id y45so6168403weo.2
 for <kexec@lists.infradead.org>; Tue, 24 Mar 2015 00:11:33 -0700 (PDT)
Date: Tue, 24 Mar 2015 08:11:29 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Re: [PATCH v2] kernel/panic/kexec: fix
 "crash_kexec_post_notifiers" option issue in oops path
Message-ID: <20150324071129.GA28619@gmail.com>
References: <54F9D645.2050008@jp.fujitsu.com>
 <20150323034752.GD2068@dhcp-16-105.nay.redhat.com>
 <20150323071943.GA22765@gmail.com> <5510DA42.6040708@hitachi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5510DA42.6040708@hitachi.com>
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
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, =?utf-8?B?IkhhdGF5YW1hLCBEYWlzdWtlL+eVkeWxsSDlpKfovJQi?= <d.hatayama@jp.fujitsu.com>, mingo@redhat.com, ebiederm@xmission.com, hidehiro.kawai.ez@hitachi.com, akpm@linux-foundation.org, bp@suse.de, Vivek Goyal <vgoyal@redhat.com>

CiogTWFzYW1pIEhpcmFtYXRzdSA8bWFzYW1pLmhpcmFtYXRzdS5wdEBoaXRhY2hpLmNvbT4gd3Jv
dGU6Cgo+ICgyMDE1LzAzLzIzIDE2OjE5KSwgSW5nbyBNb2xuYXIgd3JvdGU6Cj4gPiAKPiA+ICog
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gCj4gPj4gQ0MgbW9yZSBwZW9w
bGUgLi4uCj4gPj4KPiA+PiBPbiAwMy8wNy8xNSBhdCAwMTozMWFtLCAiSGF0YXlhbWEsIERhaXN1
a2Uv55WR5bGxIOWkp+i8lCIgd3JvdGU6Cj4gPj4+IFRoZSBjb21taXQgZjA2ZTUxNTNmNGFlMmUy
ZjNiMDMwMGYwZTI2MGU0MGNiN2ZlZmQ0NSBpbnRyb2R1Y2VkCj4gPj4+ICJjcmFzaF9rZXhlY19w
b3N0X25vdGlmaWVycyIga2VybmVsIGJvb3Qgb3B0aW9uLCB3aGljaCB0b2dnbGVzCj4gPj4+IHdo
ZWF0aGVyIHBhbmljKCkgY2FsbHMgY3Jhc2hfa2V4ZWMoKSBiZWZvcmUgcGFuaWNfbm90aWZpZXJz
IGFuZCBkdW1wCj4gPj4+IGttc2cgb3IgYWZ0ZXIuCj4gPj4+Cj4gPj4+IFRoZSBwcm9ibGVtIGlz
IHRoYXQgdGhlIGNvbW1pdCBvdmVybG9va3MgcGFuaWNfb25fb29wcyBrZXJuZWwgYm9vdAo+ID4+
PiBvcHRpb24uIElmIGl0IGlzIGVuYWJsZWQsIGNyYXNoX2tleGVjKCkgaXMgY2FsbGVkIGRpcmVj
dGx5IHdpdGhvdXQKPiA+Pj4gZ29pbmcgdGhyb3VnaCBwYW5pYygpIGluIG9vcHMgcGF0aC4KPiA+
Pj4KPiA+Pj4gVG8gZml4IHRoaXMgaXNzdWUsIHRoaXMgcGF0Y2ggYWRkcyBhIGNoZWNrIHRvCj4g
Pj4+ICJjcmFzaF9rZXhlY19wb3N0X25vdGlmaWVycyIgaW4gdGhlIGNvbmRpdGlvbiBvZiBrZXhl
Y19zaG91bGRfY3Jhc2goKS4KPiA+Pj4KPiA+Pj4gQWxzbywgcHV0IGEgY29tbWVudCBpbiBrZXhl
Y19zaG91bGRfY3Jhc2goKSB0byBleHBsYWluIG5vdCBvYnZpb3VzCj4gPj4+IHRoaW5ncyBvbiB0
aGlzIHBhdGNoLgo+ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBIQVRBWUFNQSBEYWlzdWtlIDxk
LmhhdGF5YW1hQGpwLmZ1aml0c3UuY29tPgo+ID4+PiBBY2tlZC1ieTogQmFvcXVhbiBIZSA8Ymhl
QHJlZGhhdC5jb20+Cj4gPj4+IFRlc3RlZC1ieTogSGlkZWhpcm8gS2F3YWkgPGhpZGVoaXJvLmth
d2FpLmV6QGhpdGFjaGkuY29tPgo+ID4+PiBSZXZpZXdlZC1ieTogTWFzYW1pIEhpcmFtYXRzdSA8
bWFzYW1pLmhpcmFtYXRzdS5wdEBoaXRhY2hpLmNvbT4KPiA+Pj4gLS0tCj4gPj4+ICBpbmNsdWRl
L2xpbnV4L2tlcm5lbC5oIHwgIDMgKysrCj4gPj4+ICBrZXJuZWwva2V4ZWMuYyAgICAgICAgIHwg
MTEgKysrKysrKysrKysKPiA+Pj4gIGtlcm5lbC9wYW5pYy5jICAgICAgICAgfCAgMiArLQo+ID4+
PiAgMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAK
PiA+IFRoaXMgaXMgaGFjayB1cG9uIGhhY2ssIGJ1dCB3aHkgd2FzIHRoaXMgY3JhcCBtZXJnZWQg
aW4gdGhlIGZpcnN0IAo+ID4gcGxhY2U/Cj4gPiAKPiA+IEkgc2VlIHR3byBwcm9ibGVtcyBqdXN0
IGJ5IGN1cnNvcnkgcmV2aWV3Ogo+ID4gCj4gPiAxKQo+ID4gCj4gPiBGaXJzdGx5LCB0aGUgcmVh
bCBidWcgaW46Cj4gPiAKPiA+ICAgZjA2ZTUxNTNmNGFlICgia2VybmVsL3BhbmljLmM6IGFkZCAi
Y3Jhc2hfa2V4ZWNfcG9zdF9ub3RpZmllcnMiIG9wdGlvbiBmb3Iga2R1bXAgYWZ0ZXIgcGFuaWNf
bm90aWZlcnMiKQo+ID4gCj4gPiBXYXMgdGhhdCBjcmFzaF9rZXhlYygpIHdhcyBjYWxsZWQgdW5j
b25kaXRpb25hbGx5IGFmdGVyIG5vdGlmaWVycyB3ZXJlIAo+ID4gY2FsbGVkLCB3aGljaCBzaG91
bGQgYmUgZml4ZWQgdmlhIHRoZSBzaW1wbGUgcGF0Y2ggYmVsb3cgKHVudGVzdGVkKS4gCj4gPiBM
b29rcyBtdWNoIHNpbXBsZXIgdGhhbiB5b3VyIGZpeC4KPiAKPiBObywgRGFpc3VrZSdzIHBhdGNo
IGlzIG5vdCBmb3IgdGhhdCBjYXNlLiBbLi4uXQoKWWV0IHRoZSBhY3R1YWwgYnVnIGlzIGluIHRo
YXQgY29tbWl0LCAnY3Jhc2hfa2V4ZWNfcG9zdF9ub3RpZmllcnMnIHdhcyAKY2xlYXJseSBub3Qg
YSBuby1vcCBpbiB0aGUgZGVmYXVsdCBjYXNlLCBhZ2FpbnN0IGV4cGVjdGF0aW9ucy4KClNvIHRo
ZSBmaXJzdCBzdGVwIHNob3VsZCBiZSB0byByZXN0b3JlIHRoZSBvcmlnaW5hbCBiZWhhdmlvciAo
bXkgCnBhdGNoKSwgdGhlbiBzaG91bGQgYW55IG5ldyB0d2Vha3MgYmUgYWRkZWQuCgpUaGFua3Ms
CgoJSW5nbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
