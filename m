Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com
 ([40.107.92.60] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvqet-004Mh5-8M
 for kexec@lists.infradead.org; Sat, 11 Dec 2021 00:54:41 +0000
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
 <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
 <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
 <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
 <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3988a221-2f6a-540a-3d77-18c2c67ddbe7@amd.com>
Date: Fri, 10 Dec 2021 19:54:34 -0500
In-Reply-To: <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>, kernel@gpiccoli.net, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, pjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

T24gMjAyMS0xMi0xMCAxMDoxMyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBB
bSAxMC4xMi4yMSB1bSAxNToyNSBzY2hyaWViIEd1aWxoZXJtZSBHLiBQaWNjb2xpOgo+PiBPbiAx
MC8xMi8yMDIxIDExOjE2LCBBbGV4IERldWNoZXIgd3JvdGU6PiBbLi4uXQo+Pj4gV2h5IG5vdCBq
dXN0IHJlbG9hZCB0aGUgZHJpdmVyIGFmdGVyIGtleGVjPwo+Pj4KPj4+IEFsZXgKPj4gQmVjYXVz
ZSB0aGUgb3JpZ2luYWwgaXNzdWUgaXMgdGhlIGtkdW1wIGNhc2UsIGFuZCB3ZSB3YW50IGEgdmVy
eSB2ZXJ5Cj4+IHRpbnkga2VybmVsIC0gYWxzbywgdGhlIGNyYXNoIG9yaWdpbmFsbHkgY291bGQg
aGF2ZSBiZWVuIGNhdXNlZCBieQo+PiBhbWRncHUgaXRzZWxmLCBzbyBpZiBpdCdzIGEgR1BVIGlz
c3VlLCB3ZSBkb24ndCB3YW50IHRvIG1lc3Mgd2l0aCB0aGF0Cj4+IGluIGtkdW1wLiBBbmQgSSBj
b25mZXNzIEkgdHJpZWQgbW9kcHJvYmUgYW1kZ3B1IGFmdGVyIGEga2R1bXAsIG5vCj4+IHN1Y2Nl
c3MgLSBrZHVtcCB3b24ndCBjYWxsIHNodXRkb3duIGhhbmRsZXJzLCBzbyBHUFUgd2lsbCBiZSBp
biBhCj4+ICJyb2d1ZSIgc3RhdGUuLi4KPj4KPj4gTXkgcXVlc3Rpb24gd2FzIGFib3V0IHJlZ3Vs
YXIga2V4ZWMgYmVjYXVzZSBpdCdzIG11Y2ggc2ltcGxlciB1c3VhbGx5LAo+PiB3ZSBjYW4gZG8g
d2hhdGV2ZXIgd2Ugd2FudCB0aGVyZS4gTXkgbGluZSBvZiB0aG91Z2h0IHdhczogaWYgSSBtYWtl
IGl0Cj4+IHdvcmsgaW4gcmVndWxhciBrZXhlYyB3aXRoIGEgc2ltcGxlIGZyYW1lYnVmZmVyLCBJ
IG1pZ2h0IGJlIGFibGUgdG8gZ2V0Cj4+IGl0IHdvcmtpbmcgb24ga2R1bXAgaGVoZWgKPgo+IEhv
dyBhYm91dCBpc3N1aW5nIGEgUENJZSByZXNldCBhbmQgcmUtaW5pdGlhbGl6aW5nIHRoZSBBU0lD
IHdpdGgganVzdCAKPiB0aGUgVkJJT1M/Cj4KPiBUaGF0IHNob3VsZCBiZSBwcmV0dHkgc3RyYWln
aHRmb3J3YXJkIEkgdGhpbmsuCgpEbyB5b3UgYWN0dWFsbHkgbmVlZCB0byByZXN0b3JlIHRoZSBl
eGFjdCBib290LXVwIG1vZGU/IElmIHlvdSBoYXZlIHRoZSAKc2FtZSBmcmFtZWJ1ZmZlciBtZW1v
cnkgbGF5b3V0ICh3aWR0aCwgaGVpZ2h0LCBicHAsIHN0cmlkZSkgdGhlIHByZWNpc2UgCmRpc3Bs
YXkgdGltaW5nIGRvZXNuJ3QgcmVhbGx5IG1hdHRlci4gU28gd2UgImp1c3QiIG5lZWQgdG8gc3dp
dGNoIHRvIGEgCm1vZGUgdGhhdCdzIGNvbXBhdGlibGUgd2l0aCB0aGUgZWZpZmIgZnJhbWVidWZm
ZXIgcGFyYW1ldGVycyBhbmQgcG9pbnQgCnRoZSBkaXNwbGF5IGVuZ2luZSBhdCB0aGUgZWZpZmIg
YXMgdGhlIHNjYW4tb3V0IGJ1ZmZlci4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCj4KPiBDaHJpc3Rp
YW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
