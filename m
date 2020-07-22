Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyGFw-0002vl-O4
 for kexec@lists.infradead.org; Wed, 22 Jul 2020 15:02:06 +0000
Received: by mail-qk1-f198.google.com with SMTP id i3so1618107qkf.0
 for <kexec@lists.infradead.org>; Wed, 22 Jul 2020 07:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com>
 <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
 <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
 <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com>
 <20200305035329.GD4433@MiWiFi-R3L-srv>
 <CABeXuvogFGv8-i4jsJYN5ya0hjf35EXLkmPqYWayDUvXaBKidA@mail.gmail.com>
 <20200306093829.GA27711@MiWiFi-R3L-srv>
In-Reply-To: <20200306093829.GA27711@MiWiFi-R3L-srv>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 22 Jul 2020 22:52:26 +0800
Message-ID: <CACPcB9cpEX-uYeTp7DVEXtwDRWBCTVoPCB4dxPbyq1sDeixP_w@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
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
To: Baoquan He <bhe@redhat.com>
Cc: jroedel@suse.de, linux-pci@vger.kernel.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Randy Wright <rwright@hpe.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, Bjorn Helgaas <helgaas@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Myron Stowe <myron.stowe@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Fri, Mar 6, 2020 at 5:38 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/04/20 at 08:53pm, Deepa Dinamani wrote:
> > On Wed, Mar 4, 2020 at 7:53 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > +Joerg to CC.
> > >
> > > On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> > > > I looked at this some more. Looks like we do not clear irqs when we do
> > > > a kexec reboot. And, the bootup code maintains the same table for the
> > > > kexec-ed kernel. I'm looking at the following code in
> > >
> > > I guess you are talking about kdump reboot here, right? Kexec and kdump
> > > boot take the similar mechanism, but differ a little.
> >
> > Right I meant kdump kernel here. And, clearly the is_kdump_kernel() case below.
> >
> > >
> > > > intel_irq_remapping.c:
> > > >
> > > >         if (ir_pre_enabled(iommu)) {
> > > >                 if (!is_kdump_kernel()) {
> > > >                         pr_warn("IRQ remapping was enabled on %s but
> > > > we are not in kdump mode\n",
> > > >                                 iommu->name);
> > > >                         clear_ir_pre_enabled(iommu);
> > > >                         iommu_disable_irq_remapping(iommu);
> > > >                 } else if (iommu_load_old_irte(iommu))
> > >
> > > Here, it's for kdump kernel to copy old ir table from 1st kernel.
> >
> > Correct.
> >
> > > >                         pr_err("Failed to copy IR table for %s from
> > > > previous kernel\n",
> > > >                                iommu->name);
> > > >                 else
> > > >                         pr_info("Copied IR table for %s from previous kernel\n",
> > > >                                 iommu->name);
> > > >         }
> > > >
> > > > Would cleaning the interrupts(like in the non kdump path above) just
> > > > before shutdown help here? This should clear the interrupts enabled
> > > > for all the devices in the current kernel. So when kdump kernel
> > > > starts, it starts clean. This should probably help block out the
> > > > interrupts from a device that does not have a driver.
> > >
> > > I think stopping those devices out of control from continue sending
> > > interrupts is a good idea. While not sure if only clearing the interrupt
> > > will be enough. Those devices which will be initialized by their driver
> > > will brake, but devices which drivers are not loaded into kdump kernel
> > > may continue acting. Even though interrupts are cleaning at this time,
> > > the on-flight DMA could continue triggerring interrupt since the ir
> > > table and iopage table are rebuilt.
> >
> > This should be handled by the IOMMU, right? And, hence you are getting
> > UR. This seems like the correct execution flow to me.
>
> Sorry for late reply.
> Yes, this is initializing IOMMU device.
>
> >
> > Anyway, you could just test this theory by removing the
> > is_kdump_kernel() check above and see if it solves your problem.
> > Obviously, check the VT-d spec to figure out the exact sequence to
> > turn off the IR.
>
> OK, I will talk to Kairui and get a machine to test it. Thanks for your
> nice idea, if you have a draft patch, we are happy to test it.
>
> >
> > Note that the device that is causing the problem here is a legit
> > device. We want to have interrupts from devices we don't know about
> > blocked anyway because we can have compromised firmware/ devices that
> > could cause a DoS attack. So blocking the unwanted interrupts seems
> > like the right thing to do here.
>
> Kairui said it's a device which driver is not loaded in kdump kernel
> because it's not needed by kdump. We try to only load kernel modules
> which are needed, e.g one device is the dump target, its driver has to
> be loaded in. In this case, the device is more like a out of control
> device to kdump kernel.
>

Hi Bao, Deepa, sorry for this very late response. The test machine was
not available for sometime, and I restarted to work on this problem.

For the workaround mention by Deepa (by remote the is_kdump_kernel()
check), it didn't work, the machine still hangs upon shutdown.
The devices that were left in an unknown state and sending interrupt
could be a problem, but it's irrelevant to this hanging problem.

I think I didn't make one thing clear, The PCI UR error never arrives
in kernel, it's the iLo BMC on that HPE machine caught the error, and
send kernel an NMI. kernel is panicked by NMI, I'm still trying to
figure out why the NMI hanged kernel, even with panic=-1,
panic_on_io_nmi, panic_on_unknown_nmi all set. But if we can avoid the
NMI by shutdown the devices in right order, that's also a solution.

--
Best Regards,
Kairui Song


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
