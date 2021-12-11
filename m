Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvyeh-004ohc-Gv
 for kexec@lists.infradead.org; Sat, 11 Dec 2021 09:27:01 +0000
Date: Sat, 11 Dec 2021 10:20:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
Message-ID: <20211211092050.wbczxxrnzoywbns6@sirius.home.kraxel.org>
References: <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
 <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
 <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
 <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
 <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
 <3988a221-2f6a-540a-3d77-18c2c67ddbe7@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3988a221-2f6a-540a-3d77-18c2c67ddbe7@amd.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Alex Deucher <alexdeucher@gmail.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Baoquan He <bhe@redhat.com>, Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= <siglesias@igalia.com>, kernel@gpiccoli.net, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, pjones@redhat.com, Thomas Zimmermann <tzimmermann@suse.de>, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Dec 10, 2021 at 07:54:34PM -0500, Felix Kuehling wrote:
 
> Do you actually need to restore the exact boot-up mode? If you have the same
> framebuffer memory layout (width, height, bpp, stride) the precise display
> timing doesn't really matter. So we "just" need to switch to a mode that's
> compatible with the efifb framebuffer parameters and point the display
> engine at the efifb as the scan-out buffer.

That'll probably doable for a normal kexec but in case of a crashdump
kexec I don't think it is a good idea to touch the gpu using the driver
of the kernel which just crashed ...

take care,
  Gerd


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
