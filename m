Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fanzine2.igalia.com ([213.97.179.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvhlK-002Pyp-6B
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 15:24:45 +0000
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
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
Date: Fri, 10 Dec 2021 12:24:08 -0300
MIME-Version: 1.0
In-Reply-To: <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
Content-Language: en-US
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

T24gMTAvMTIvMjAyMSAxMjoxMywgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBbLi4uXQo+IEhv
dyBhYm91dCBpc3N1aW5nIGEgUENJZSByZXNldCBhbmQgcmUtaW5pdGlhbGl6aW5nIHRoZSBBU0lD
IHdpdGgganVzdCAKPiB0aGUgVkJJT1M/Cj4gCj4gVGhhdCBzaG91bGQgYmUgcHJldHR5IHN0cmFp
Z2h0Zm9yd2FyZCBJIHRoaW5rLgo+IAo+IENocmlzdGlhbi4KCgpUaGFua3MgQ2hyaXN0aWFuLCB0
aGF0J2QgYmUgcGVyZmVjdCEgSXMgaXQgZmVhc2libGU/IFBlciBBbGV4IGNvbW1lbnQsCndlJ2Qg
bmVlZCB0byBydW4gYXRvbWJpb3MgY29tbWFuZHMgdG8gcmVwcm9ncmFtIHRoZSB0aW1pbmdzLCBk
aXNwbGF5CmluZm8sIGV0Yy4uLmxpa2UgYSBzbWFsbCBkcml2ZXIgd291bGQgZG8sIGEgZnVsbCBp
bml0LgoKQWxzbywgd2hhdCBraW5kIG9mIFBDSWUgcmVzZXQgaXMgcmVjb21tZW5kZWQgZm9yIHRo
aXMgYWRhcHRlcj8gTGlrZSBhCmhvdCByZXNldCwgcG93ZXJpbmctb2ZmL3JlLXBvd2VyLCBGTFIg
b3IgdGhhdCBNT0RFMiByZXNldCBwcmVzZW50IGluCmFtZGdwdSBjb2RlPyBSZW1lbWJlcmluZyB0
aGlzIGlzIGFuIEFQVSBkZXZpY2UuCgpUaGFua3MgYSBsb3QhCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
