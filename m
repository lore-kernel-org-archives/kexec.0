Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvaDQ-0012wA-2m
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 07:21:13 +0000
Date: Fri, 10 Dec 2021 08:19:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
Message-ID: <20211210071914.n4l2mdknbv3yeqtq@sirius.home.kraxel.org>
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>, Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>

  Hi,

> > The drivers are asic and platform specific.  E.g., the driver for
> > vangogh is different from renoir is different from skylake, etc.  The
> > display programming interfaces are asic specific.
> 
> Cool, that makes sense! But if you (or anybody here) know some of these
> GOP drivers, e.g. for the qemu/qxl device,

OvmfPkg/QemuVideoDxe in tianocore source tree.

> I'm just curious to see/understand how complex is the FW driver to
> just put the device/screen in a usable state.

Note that qemu has a paravirtual interface for vesa vga mode programming
where you basically program a handful of registers with xres, yres,
depth etc. (after resetting the device to put it into vga compatibility
mode) and you are done.

Initializing physical hardware is an order of magnitude harder than
that.

With qxl you could also go figure the current state of the hardware and
fill screen_info with that to get a working boot framebuffer in the
kexec'ed kernel.

Problem with this approach is this works only in case the framebuffer
happens to be in a format usable by vesafb/efifb.  So no modifiers
(tiling etc.) and continuous in physical address space.  That is true
for qxl.  With virtio-gpu it wouldn't work though (framebuffer can be
scattered), and I expect with most modern physical hardware it wouldn't
work either.

take care,
  Gerd


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
