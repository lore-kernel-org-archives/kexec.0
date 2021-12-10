Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com
 ([40.107.236.71] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvhsj-002Rvh-I3
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 15:32:23 +0000
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
 <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <81a250d2-5469-6985-b9ed-62ee6a7b4326@amd.com>
Date: Fri, 10 Dec 2021 16:32:02 +0100
In-Reply-To: <0847ff12-8b1c-a046-eb05-f0011f81e172@igalia.com>
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

QW0gMTAuMTIuMjEgdW0gMTY6MjQgc2NocmllYiBHdWlsaGVybWUgRy4gUGljY29saToKPiBPbiAx
MC8xMi8yMDIxIDEyOjEzLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBbLi4uXQo+PiBIb3cg
YWJvdXQgaXNzdWluZyBhIFBDSWUgcmVzZXQgYW5kIHJlLWluaXRpYWxpemluZyB0aGUgQVNJQyB3
aXRoIGp1c3QKPj4gdGhlIFZCSU9TPwo+Pgo+PiBUaGF0IHNob3VsZCBiZSBwcmV0dHkgc3RyYWln
aHRmb3J3YXJkIEkgdGhpbmsuCj4+Cj4+IENocmlzdGlhbi4KPgo+IFRoYW5rcyBDaHJpc3RpYW4s
IHRoYXQnZCBiZSBwZXJmZWN0ISBJcyBpdCBmZWFzaWJsZT8gUGVyIEFsZXggY29tbWVudCwKPiB3
ZSdkIG5lZWQgdG8gcnVuIGF0b21iaW9zIGNvbW1hbmRzIHRvIHJlcHJvZ3JhbSB0aGUgdGltaW5n
cywgZGlzcGxheQo+IGluZm8sIGV0Yy4uLmxpa2UgYSBzbWFsbCBkcml2ZXIgd291bGQgZG8sIGEg
ZnVsbCBpbml0Lgo+Cj4gQWxzbywgd2hhdCBraW5kIG9mIFBDSWUgcmVzZXQgaXMgcmVjb21tZW5k
ZWQgZm9yIHRoaXMgYWRhcHRlcj8gTGlrZSBhCj4gaG90IHJlc2V0LCBwb3dlcmluZy1vZmYvcmUt
cG93ZXIsIEZMUiBvciB0aGF0IE1PREUyIHJlc2V0IHByZXNlbnQgaW4KPiBhbWRncHUgY29kZT8g
UmVtZW1iZXJpbmcgdGhpcyBpcyBhbiBBUFUgZGV2aWNlLgoKV2VsbCwgQWxleCBpcyB0aGUgZXhw
ZXJ0IG9uIHRoYXQuCgpBUFUgbWFrZXMgdGhlIHdob2xlIHRoaW5nIHByZXR0eSB0cmlja3kgc2lu
Y2UgdGhlIFZCSU9TIGlzIHBhcnQgb2YgdGhlIApzeXN0ZW0gQklPUyB0aGVyZSBhbmQgSSdtIG5v
dCBzdXJlIHlvdSBjYW4gb25seSByZS1pbml0aWFsaXplIHRoZSBHUFUgCndpdGhvdXQgYSBjb21w
bGV0ZSByZXNldC4KCk9uIGRHUFVzIGp1c3QgbWFraW5nIHN1cmUgdGhlIFJPTSBpcyBtYXBwZWQg
YW5kIGNhbGxpbmcgdGhlIFZFU0EgbW9kZXNldCAKQklPUyBmdW5jdGlvbnMgbWlnaHQgYWxyZWFk
eSBkbyB0aGUgdHJpY2suCgpDaHJpc3RpYW4uCgo+Cj4gVGhhbmtzIGEgbG90IQo+CgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
