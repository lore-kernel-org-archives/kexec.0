Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvghW-002AvU-27
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 14:16:43 +0000
Received: by mail-ot1-x334.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso9705634otj.11
 for <kexec@lists.infradead.org>; Fri, 10 Dec 2021 06:16:41 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
 <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
In-Reply-To: <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Dec 2021 09:16:30 -0500
Message-ID: <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, "Deucher, Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Dec 10, 2021 at 9:09 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Thanks a lot Alex / Gerd and Thomas, very informative stuff! I'm glad
> there are projects to collect/save the data and reuse after a kdump,
> this is very useful.
>
> I'll continue my study on the atombios thing of AMD and QXL, maybe at
> least we can make it work in qemu, that'd be great (like a small
> initdriver to reprogram de paravirtual device on kexec boot).

Why not just reload the driver after kexec?

Alex


>
> Cheers,
>
>
> Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
