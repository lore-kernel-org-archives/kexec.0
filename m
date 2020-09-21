Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKG5C-0005Xi-G5
 for kexec@lists.infradead.org; Mon, 21 Sep 2020 07:17:55 +0000
Received: by mail-il1-f197.google.com with SMTP id p10so7173660ilp.14
 for <kexec@lists.infradead.org>; Mon, 21 Sep 2020 00:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200909075016.104407-1-kasong@redhat.com>
 <87ft7r82sf.fsf@x220.int.ebiederm.org>
 <CACPcB9f4k+MV2JeNRjo_vd5FCMkjOMdBCpC6zAn4Z3o8jy_eug@mail.gmail.com>
In-Reply-To: <CACPcB9f4k+MV2JeNRjo_vd5FCMkjOMdBCpC6zAn4Z3o8jy_eug@mail.gmail.com>
From: Kairui Song <kasong@redhat.com>
Date: Mon, 21 Sep 2020 15:17:36 +0800
Message-ID: <CACPcB9ff0t63QgVpi1_u8RUp8iCy3DVrSy9qztBZGmmNubAaSw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add writing support to vmcore for reusing oldmem
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
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Sep 10, 2020 at 12:43 AM Kairui Song <kasong@redhat.com> wrote:
>
> On Wed, Sep 9, 2020 at 10:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Kairui Song <kasong@redhat.com> writes:
> >
> > > Currently vmcore only supports reading, this patch series is an RFC
> > > to add writing support to vmcore. It's x86_64 only yet, I'll add other
> > > architecture later if there is no problem with this idea.
> > >
> > > My purpose of adding writing support is to reuse the crashed kernel's
> > > old memory in kdump kernel, reduce kdump memory pressure, and
> > > allow kdump to run with a smaller crashkernel reservation.
> > >
> > > This is doable because in most cases, after kernel panic, user only
> > > interested in the crashed kernel itself, and userspace/cache/free
> > > memory pages are not dumped. `makedumpfile` is widely used to skip
> > > these pages. Kernel pages usually only take a small part of
> > > the whole old memory. So there will be many reusable pages.
> > >
> > > By adding writing support, userspace then can use these pages as a fast
> > > and temporary storage. This helps reduce memory pressure in many ways.
> > >
> > > For example, I've written a POC program based on this, it will find
> > > the reusable pages, and creates an NBD device which maps to these pages.
> > > The NBD device can then be used as swap, or to hold some temp files
> > > which previouly live in RAM.
> > >
> > > The link of the POC tool: https://github.com/ryncsn/kdumpd
> >
> > A couple of thoughts.
> > 1) Unless I am completely mistaken treating this as a exercise in
> >    memory hotplug would be much simpler.
> >
> >    AKA just plug in the memory that is not needed as part of the kdump.
> >
> >    I see below that you have problems doing this because
> >    of fragmentation.  I still think hotplug is doable using some
> >    kind of fragmented memory zone.
> >
> > 2) The purpose of the memory reservation is because hardware is
> >    still potentially running agains the memory of the old kernel.
> >
> >    By the time we have brought up a new kernel enough of the hardware
> >    may have been reinitialized that we don't have to worry about
> >    hardware randomly dma'ing into the memory used by the old kernel.
> >
> >    With IOMMUs and care we may be able to guarantee for some machine
> >    configurations it is impossible for DMA to come from some piece of
> >    hardware that is present but the kernel does not have a driver
> >    loaded for.\
> >
> > I really do not like this approach because it is fundamentlly doing the
> > wrong thing.  Adding write support to read-only drivers.  I do not see
> > anywhere that you even mentioned the hard problem and the reason we
> > reserve memory in the first place.  Hardware spontaneously DMA'ing onto
> > it.
> >
> That POC tool looks ugly for now as it only a draft to prove this
> works, sorry about it.
>
> For the patch, yes, it is expecting IOMMU to lower the chance of
> potential DMA issue, and expecting DMA will not hit userspace/free
> page, or at least won't override a massive amount of reusable old
> memory. And I thought about some solutions for the potential DMA
> issue.
>
> As old memories are used as a block device, which is proxied by
> userspace, so upon each IO, the userspace tool could do an integrity
> check of the corresponding data stored in old mem, and keep multiple
> copies of the data. (eg. use 512M of old memory to hold a 128M block
> device). These copies will be kept far away from each other regarding
> the physical memory location. The reusable old memories are sparse so
> the actual memory containing the data should be also sparse.
> So if some part is corrupted, it is still recoverable. Unless the DMA
> went very wrong and wiped a large region of memory, but if such thing
> happens, it's most likely kernel pages are also being wiped by DMA, so
> the vmcore is already corrupted and kdump may not help. But at least
> it won't fail silently, the userspace tool can still do something like
> dump some available data to an easy to setup target.
>
> And also that's one of the reasons not using old memory as kdump's
> memory directly.
>
> > > It's have been a long time issue that kdump suffers from OOM issue
> > > with limited crashkernel memory. So reusing old memory could be very
> > > helpful.
> >
> > There is a very fine line here between reusing existing code (aka
> > drivers and userspace) and doing something that should work.
> >
> > It might make sense to figure out what is using so much memory
> > that an OOM is triggered.
> >
> > Ages ago I did something that was essentially dumping the kernels printk
> > buffer to the serial console in case of a crash and I had things down to
> > something comparatively miniscule like 8M or less.
> >
> > My memory is that historically it has been high performance scsi raid
> > drivers or something like that, that are behind the need to have such
> > large memory reservations.
> >
> > Now that I think about it, you aren't by any chance doing something
> > silly like running systemd in your initrd are you?  Are these OOMs by
> > any chance a userspace problem rather than a problem with inefficient
> > drivers?
>
> The problem with the user space is that, kdump is expected to dump to
> different kinds of dump targets, and there are some very memory
> consuming ones, eg. the NFSv3 case. And there are many other labor
> heavy jobs for the dump target setup, like network setup, lvm setup,
> iscsi setup, multipath etc, etc, not to mention potential corner cases
> with these dump targets. And it is not practical to reimplement them
> again in a memory friendly way.
>
> And the user space is growing, even if user only included "bash
> makedumpfile ssh ip" and required libs in initramfs, which are
> essential for dumping the vmcore over SSH (dump over SSH is commonly
> used), the initramfs will take 20M after decompressed.
>
> The kernel driver memory usage is trackable and I only encountered a
> few of such issues, and many have applied workaround for kdump. And if
> userspace memory pressure is reduced, kernel will also have more
> memory.
>
> And now in Fedora, it is using the existing tool Dracut to generate
> the initramfs, which heavily depends on systemd indeed. Even with
> these helpers, it has been taking quite some work to support all the
> dump targets.
>
> >
> > In summary you either need to show that it is safe to reuse the
> > memory of the old kernel, or do some work to reduce the memory footprint
> > of the crashdump kernel, and the crashdump userspace.
> >
> > Eric
> >
>
>

Hi Eric,

I'm trying a new idea, that is, stop the DMA by clearing the PCI's bus
master bit, it's still a best-effort try, but should be helpful for
most cases:

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..736e3d13287f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1825,6 +1825,10 @@ int pci_setup_device(struct pci_dev *dev)
        /* Early fixups, before probing the BARs */
        pci_fixup_device(pci_fixup_early, dev);

+       if (reset_devices && !(class & (PCI_CLASS_DISPLAY_VGA |
PCI_BASE_CLASS_BRIDGE)))
+               pci_clear_master(dev);
+
        pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
                 dev->vendor, dev->device, dev->hdr_type, dev->class);

With these techniques (some are mentioned in the previous reply), do
you think reuse old memory will be acceptable?

1. Try to stop DMA by clearing the bus master bit.
2. Do some verification upon each IO to detect DMA issues, store
redundant data for recovery.
3. If an unrecoverable DMA issue still occurs, do a fallback dump to
an easy-to-setup target.

--
Best Regards,
Kairui Song


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
