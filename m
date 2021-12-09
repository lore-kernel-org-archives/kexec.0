Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvNH9-00GyiE-33
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 17:32:12 +0000
Received: by mail-oi1-x22b.google.com with SMTP id be32so9597678oib.11
 for <kexec@lists.infradead.org>; Thu, 09 Dec 2021 09:32:03 -0800 (PST)
MIME-Version: 1.0
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
In-Reply-To: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Dec 2021 12:31:50 -0500
Message-ID: <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 12:04 PM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Hi all, I have a question about the possibility of reusing a framebuffer
> after a regular (or panic) kexec - my case is with amdgpu (APU, aka, not
> a separate GPU hardware), but I guess the question is kinda generic
> hence I've looped most of the lists / people I think does make sense
> (apologies for duplicates).
>
>
> The context is: we have a hardware that has an amdgpu-controlled device
> (Vangogh model) and as soon as the machine boots, efifb is providing
> graphics - I understand the UEFI/GRUB outputs rely in EFI framebuffer as
> well. As soon amdgpu module is available, kernel loads it and it takes
> over the GPU, providing graphics. The kexec_file_load syscall allows to
> pass a valid screen_info structure, so by kexec'ing a new kernel, we
> have again efifb taking over on boot time, but this time I see nothing
> in the screen. I've manually blacklisted amdgpu in this new kexec'ed
> kernel, I'd like to rely in the simple framebuffer - the goal is to have
> a tiny kernel kexec'ed. I'm using kernel version 5.16.0-rc4.
>
> I've done some other experiments, for exemple: I've forced screen_info
> model to match VLFB, so vesafb took over after the kexec, with the same
> result. Also noticed that BusMaster bit was off after kexec, in the AMD
> APU PCIe device, so I've set it on efifb before probe, and finally
> tested the same things in qemu, with qxl, all with the same result
> (blank screen).
> The most interesting result I got (both with amdgpu and qemu/qxl) is
> that if I blacklist these drivers and let the machine continue using
> efifb since the beginning, after kexec the efifb is still able to
> produce graphics.
>
> Which then led me to think that likely there's something fundamentally
> "blocking" the reuse of the simple framebuffer after kexec, like maybe
> DRM stack is destroying the old framebuffer somehow? What kind of
> preparation is required at firmware level to make the simple EFI VGA
> framebuffer work, and could we perform this in a kexec (or "save it"
> before the amdgpu/qxl drivers take over and reuse later)?
>

Once the driver takes over, none of the pre-driver state is retained.
You'll need to load the driver in the new kernel to initialize the
displays.  Note the efifb doesn't actually have the ability to program
any hardware, it just takes over the memory region that was used for
the pre-OS framebuffer and whatever display timing was set up by the
GOP driver prior to the OS loading.  Once that OS driver has loaded
the area is gone and the display configuration may have changed.

Alex


> Any advice is greatly appreciated!
> Thanks in advance,
>
>
> Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
