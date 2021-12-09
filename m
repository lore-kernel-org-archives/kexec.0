Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvOyO-00HLTH-Pq
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 19:20:58 +0000
Received: by mail-oi1-x230.google.com with SMTP id m6so10106786oim.2
 for <kexec@lists.infradead.org>; Thu, 09 Dec 2021 11:20:56 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
In-Reply-To: <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Dec 2021 14:20:44 -0500
Message-ID: <CADnq5_P+J_xxJ62zmTPGY0NfQR05Vnp51M_bYGXmdY1cXARfLA@mail.gmail.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
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
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Dec 9, 2021 at 1:18 PM Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> Thanks again Alex! Some comments inlined below:
>
> On 09/12/2021 15:06, Alex Deucher wrote:
> > Not really in a generic way.  It's asic and platform specific.  In
> > addition most modern displays require link training to bring up the
> > display, so you can't just save and restore registers.
>
> Oh sure, I understand that. My question is more like: is there a way,
> inside amdgpu driver, to save this state before taking
> over/overwriting/reprogramming the device? So we could (again, from
> inside the amdgpu driver) dump this pre-saved state in the shutdown
> handler, for example, having the device in a "pre-OS" state when the new
> kexec'ed kernel starts.

Sure, it could be done, it's just a fair amount of work.  Things like
legacy vga text mode is a bit more of a challenge, but that tends to
be less relevant as non-legacy UEFI becomes more pervasive.

>
> >
> > The drivers are asic and platform specific.  E.g., the driver for
> > vangogh is different from renoir is different from skylake, etc.  The
> > display programming interfaces are asic specific.
>
> Cool, that makes sense! But if you (or anybody here) know some of these
> GOP drivers, e.g. for the qemu/qxl device, I'm just curious to
> see/understand how complex is the FW driver to just put the
> device/screen in a usable state.

Most of the asic init and display setup on AMD GPUs is handled via
atombios command tables (basically little scripted stored in the
vbios) which are shared by the driver and the GOP driver for most
programming sequences.  In our case, the GOP driver is pretty simple.
Take a look at the pre-DC display code in amdgpu to see what a basic
display driver would look like (e.g., dce_v11_0.c).  The GOP driver
would call the atombios asic_init table to make sure the chip itself
is initialized (e.g., memory controller, etc.), then walk the display
data tables in the vbios to determine the display configuration
specific to this board, then probe the displays and use the atombios
display command tables to light them up.

Alex

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
