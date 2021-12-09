Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvNoa-00H8Nq-4w
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 18:06:45 +0000
Received: by mail-ot1-x335.google.com with SMTP id
 w6-20020a9d77c6000000b0055e804fa524so7063638otl.3
 for <kexec@lists.infradead.org>; Thu, 09 Dec 2021 10:06:43 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
In-Reply-To: <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Dec 2021 13:06:31 -0500
Message-ID: <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
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
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel@gpiccoli.net, kasong@redhat.com, Baoquan He <bhe@redhat.com>, =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, pjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>, Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Dec 9, 2021 at 1:00 PM Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 09/12/2021 14:31, Alex Deucher wrote:
> > [...]
> > Once the driver takes over, none of the pre-driver state is retained.
> > You'll need to load the driver in the new kernel to initialize the
> > displays.  Note the efifb doesn't actually have the ability to program
> > any hardware, it just takes over the memory region that was used for
> > the pre-OS framebuffer and whatever display timing was set up by the
> > GOP driver prior to the OS loading.  Once that OS driver has loaded
> > the area is gone and the display configuration may have changed.
> >
>
> Hi Christian and Alex, thanks for the clarifications!
>
> Is there any way to save/retain this state before amdgpu takes over?

Not really in a generic way.  It's asic and platform specific.  In
addition most modern displays require link training to bring up the
display, so you can't just save and restore registers.

> Would simpledrm be able to program the device again, to a working state?

No.  You need an asic specific driver that knows how to program the
specific hardware.  It's also platform specific in that you need to
determine platform specific details such as the number and type of
display connectors and encoders that are present on the system.

>
> Finally, do you have any example of such a GOP driver (open source) so I
> can take a look? I tried to find something like that in Tianocore
> project, but didn't find anything that seemed useful for my issue.

The drivers are asic and platform specific.  E.g., the driver for
vangogh is different from renoir is different from skylake, etc.  The
display programming interfaces are asic specific.

Alex

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
