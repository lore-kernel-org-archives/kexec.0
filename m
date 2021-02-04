Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7WIZ-0002z4-2i
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 04:31:20 +0000
Received: by mail-oi1-x22d.google.com with SMTP id n7so2408417oic.11
 for <kexec@lists.infradead.org>; Wed, 03 Feb 2021 20:31:17 -0800 (PST)
MIME-Version: 1.0
References: <CAN_LGv3Go0DgKbjPVHFFXU+U8RRU15m-np3F6_RrVmx6FmBoHQ@mail.gmail.com>
 <20210128052924.GC2339@MiWiFi-R3L-srv>
 <20210203064849.GA11522@dhcp-128-65.nay.redhat.com>
 <CADnq5_MdLTLvVdwFQJxuRaQcQFNkLUNRt267zaxULNH0FUvFeA@mail.gmail.com>
 <87wnvoodny.fsf@x220.int.ebiederm.org>
In-Reply-To: <87wnvoodny.fsf@x220.int.ebiederm.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Feb 2021 23:31:05 -0500
Message-ID: <CADnq5_OBZmmieaUzMhtdVbJKhx5R34c8M669VKfcE0KSWcyv4A@mail.gmail.com>
Subject: Re: amdgpu problem after kexec
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Young <dyoung@redhat.com>, "Alexander E. Patrakov" <patrakov@gmail.com>, Baoquan He <bhe@redhat.com>

On Wed, Feb 3, 2021 at 7:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Alex Deucher <alexdeucher@gmail.com> writes:
>
> > On Wed, Feb 3, 2021 at 3:36 AM Dave Young <dyoung@redhat.com> wrote:
> >>
> >> Hi Baoquan,
> >>
> >> Thanks for ccing.
> >> On 01/28/21 at 01:29pm, Baoquan He wrote:
> >> > On 01/11/21 at 01:17pm, Alexander E. Patrakov wrote:
> >> > > Hello,
> >> > >
> >> > > I was trying out kexec on my new laptop, which is a HP EliteBook 735
> >> > > G6. The problem is, amdgpu does not have hardware acceleration after
> >> > > kexec. Also, strangely, the lines about BlueTooth are missing from
> >> > > dmesg after kexec, but I have not tried to use BlueTooth on this
> >> > > laptop yet. I don't know how to debug this, the relevant amdgpu lines
> >> > > in dmesg are:
> >> > >
> >> > > amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB
> >> > > test failed on gfx (-110).
> >> > > [drm:process_one_work] *ERROR* ib ring test failed (-110).
> >> > >
> >> > > The good and bad dmesg files are attached. Is it a kexec problem (and
> >> > > amdgpu is only a victim), or should I take it to amdgpu lists? Do I
> >> > > need to provide some extra kernel arguments for debugging?
>
> The best debugging I can think of is can you arrange to have the amdgpu
> modules removed before the final kexec -e?
>
> That would tell us if the code to shutdown the gpu exist in the rmmod
> path aka the .remove method and is simply missing in the kexec path aka
> the .shutdown method.
>
>
> >> > I am not familiar with graphical component. Add Dave to CC to see if
> >> > he has some comments. It would be great if amdgpu expert can have a look.
> >>
> >> It needs amdgpu driver people to help.  Since kexec bypass
> >> bios/UEFI initialization so we requires drivers to implement .shutdown
> >> method and test it to make 2nd kernel to work correctly.
> >
> > kexec is tricky to make work properly on our GPUs.  The problem is
> > that there are some engines on the GPU that cannot be re-initialized
> > once they have been initialized without an intervening device reset.
> > APUs are even trickier because they share a lot of hardware state with
> > the CPU.  Doing lots of extra resets adds latency.  The driver has
> > code to try and detect if certain engines are running at driver load
> > time and do a reset before initialization to make this work, but it
> > apparently is not working properly on your system.
>
> There are two cases that I think sometimes get mixed up.
>
> There is kexec-on-panic in which case all of the work needs to happen in
> the driver initialization.
>
> There is also a simple kexec in which case some of the work can happen
> in the kernel that is being shutdown and sometimes that is easer.
>
> Does it make sense to reset your device unconditionally on driver removal?

I think we tried that at some point in the past but users complained
that it added latency or artifacts on the display at shutdown or
reboot time.

> Would it make sense to reset your device unconditionally on driver add?

Pretty much the same issue there.  It adds latency and you get
artifacts on the display when the reset happens.

>
> How can someone debug the smart logic of reset on driver load?

See this block of code in amdgpu_device.c:
        /* check if we need to reset the asic
         *  E.g., driver was not cleanly unloaded previously, etc.
         */
    if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
        r = amdgpu_asic_reset(adev);
                if (r) {
                        dev_err(adev->dev, "asic reset on init failed\n");
                        goto failed;
                }
        }

You'll want to see if amdgpu_asic_need_reset_on_init() was able to
determine that the asic needs a reset.  If it does,
amdgpu_asic_reset() getds called to reset it.
The tricky thing is that some reset methods require a fair amount of
driver state and so, they are only possible when the driver is up and
running.  Those methods are not necessarily available at driver load
time because we need to reset the GPU before we can initialize it and
determine that state so we end up in a kind of catch 22.
Unfortunately, generic PCI resets don't necessarily work on many of
our GPUs so that's not an option either.

Alex

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
