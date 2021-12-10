Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvlD8-003O9Y-0C
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 19:05:40 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 7so14434073oip.12
 for <kexec@lists.infradead.org>; Fri, 10 Dec 2021 11:05:36 -0800 (PST)
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
In-Reply-To: <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Dec 2021 14:05:25 -0500
Message-ID: <CADnq5_NphKQwa=sPWEWPTDbQVHGXQd0Ue8GNJR975jCvka7dQA@mail.gmail.com>
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

On Fri, Dec 10, 2021 at 9:25 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> On 10/12/2021 11:16, Alex Deucher wrote:> [...]
> > Why not just reload the driver after kexec?
> >
> > Alex
>
> Because the original issue is the kdump case, and we want a very very
> tiny kernel - also, the crash originally could have been caused by
> amdgpu itself, so if it's a GPU issue, we don't want to mess with that
> in kdump. And I confess I tried modprobe amdgpu after a kdump, no
> success - kdump won't call shutdown handlers, so GPU will be in a
> "rogue" state...
>
> My question was about regular kexec because it's much simpler usually,
> we can do whatever we want there. My line of thought was: if I make it
> work in regular kexec with a simple framebuffer, I might be able to get
> it working on kdump heheh
>

Well if the GPU is hung, I'm not sure if you'll be able to get back
the display environment without a GPU reset and once you do that,
you've lost any state you might have been trying to preserve.

Alex

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
