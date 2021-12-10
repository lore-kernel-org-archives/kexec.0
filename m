Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvlIs-003QZz-Mm
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 19:11:36 +0000
Received: by mail-oi1-x231.google.com with SMTP id bf8so14523408oib.6
 for <kexec@lists.infradead.org>; Fri, 10 Dec 2021 11:11:34 -0800 (PST)
MIME-Version: 1.0
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
 <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
In-Reply-To: <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Dec 2021 14:11:22 -0500
Message-ID: <CADnq5_O4+8r_NKCK3JBtHPf03hniR9Q53r-A2PFFFBR9X1nFMQ@mail.gmail.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

T24gRnJpLCBEZWMgMTAsIDIwMjEgYXQgMTA6MjQgQU0gR3VpbGhlcm1lIEcuIFBpY2NvbGkKPGdw
aWNjb2xpQGlnYWxpYS5jb20+IHdyb3RlOgo+Cj4gT24gMTAvMTIvMjAyMSAxMjoxMywgQ2hyaXN0
aWFuIEvDtm5pZyB3cm90ZToKPiA+IFsuLi5dCj4gPiBIb3cgYWJvdXQgaXNzdWluZyBhIFBDSWUg
cmVzZXQgYW5kIHJlLWluaXRpYWxpemluZyB0aGUgQVNJQyB3aXRoIGp1c3QKPiA+IHRoZSBWQklP
Uz8KPiA+Cj4gPiBUaGF0IHNob3VsZCBiZSBwcmV0dHkgc3RyYWlnaHRmb3J3YXJkIEkgdGhpbmsu
Cj4gPgo+ID4gQ2hyaXN0aWFuLgo+Cj4KPiBUaGFua3MgQ2hyaXN0aWFuLCB0aGF0J2QgYmUgcGVy
ZmVjdCEgSXMgaXQgZmVhc2libGU/IFBlciBBbGV4IGNvbW1lbnQsCj4gd2UnZCBuZWVkIHRvIHJ1
biBhdG9tYmlvcyBjb21tYW5kcyB0byByZXByb2dyYW0gdGhlIHRpbWluZ3MsIGRpc3BsYXkKPiBp
bmZvLCBldGMuLi5saWtlIGEgc21hbGwgZHJpdmVyIHdvdWxkIGRvLCBhIGZ1bGwgaW5pdC4KPgoK
WW91IG5lZWQgdGhlIGVxdWl2YWxlbnQgb2YgYSBHT1AgZHJpdmVyIG9yIGEgZnVsbCBHUFUgZHJp
dmVyLiAgSSB0aGluawppdCB3b3VsZCBiZSBsZXNzIGVmZm9ydCB0byBqdXN0IGZpeCB1cCBhbnkg
cHJvYmxlbXMgYW1kZ3B1IGhhcyB3aGVuCnRyeWluZyB0byBsb2FkIGFmdGVyIHRoZSBjcmFzaCB0
aGFuIHRvIHdyaXRlIGEgbmV3IG1pbmkgZHJpdmVyLiAgQnkKdGhlIHRpbWUgeW91IGFkZCBldmVy
eXRoaW5nIHlvdSdkIG5lZWQsIHlvdSdkIGJlIHByZXR0eSBjbG9zZSB0byBhCmZ1bGwgR1BVIGRy
aXZlci4KCj4gQWxzbywgd2hhdCBraW5kIG9mIFBDSWUgcmVzZXQgaXMgcmVjb21tZW5kZWQgZm9y
IHRoaXMgYWRhcHRlcj8gTGlrZSBhCj4gaG90IHJlc2V0LCBwb3dlcmluZy1vZmYvcmUtcG93ZXIs
IEZMUiBvciB0aGF0IE1PREUyIHJlc2V0IHByZXNlbnQgaW4KPiBhbWRncHUgY29kZT8gUmVtZW1i
ZXJpbmcgdGhpcyBpcyBhbiBBUFUgZGV2aWNlLgoKWW91J2QgbmVlZCB0byBpc3N1ZSB0aGUgcmVs
ZXZhbnQgZGV2aWNlIHNwZWNpZmljIHJlc2V0IHNlcXVlbmNlLiAgSXQKd291bGQgYmUgYSBtb2Rl
MiByZXNldCBvbiB2YW5nb2doLCBidXQgdmFyaWVzIG9uIG90aGVyIGFzaWNzLiAgSXQKd291bGQg
cHJvYmFibHkgYmUgZWFzaWVzdCB0byBqdXN0IGZpeCB1cCB0aGUgbG9naWMgaW4gYW1kZ3B1IHRv
IGRldGVjdApiYWQgR1BVIHN0YXRlIG9uIGRyaXZlciBsb2FkIGFuZCBkbyBhIEdQVSByZXNldCBi
ZWZvcmUgZHJpdmVyIGluaXQuCldlIGFscmVhZHkgaGF2ZSB0aGUgbG9naWMgaW4gcGxhY2UgZm9y
IHNvbWUgZEdQVXMsIGJ1dCBBUFVzIG9ubHkKcmVjZW50bHkgZ290IGZ1bGwgR1BVIHJlc2V0IHN1
cHBvcnQgZHVlIHRvIGFyY2hpdGVjdHVyYWwgbGltaXRhdGlvbnMKYW5kIGhhcmR3YXJlIGJ1Z3Mu
CgpBbGV4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
