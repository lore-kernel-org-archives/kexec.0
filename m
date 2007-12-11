Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.186])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J29Ok-0006bJ-Ep
	for kexec@lists.infradead.org; Tue, 11 Dec 2007 18:00:08 +0000
Received: by rv-out-0910.google.com with SMTP id c24so2131472rvf
	for <kexec@lists.infradead.org>; Tue, 11 Dec 2007 10:00:00 -0800 (PST)
Message-ID: <86802c440712111000l39291faaka797bc4ee22f798a@mail.gmail.com>
Date: Tue, 11 Dec 2007 10:00:00 -0800
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
In-Reply-To: <m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <20071206213951.GB28898@hmsreliant.think-freely.org>
	<86802c440712070050s3c5017a4w8e747a7035d10d3a@mail.gmail.com>
	<86802c440712070122q6e5824bcp12e1c3f560e2ab53@mail.gmail.com>
	<20071207142144.GA10389@hmsendeavour.rdu.redhat.com>
	<20071207175832.GA18485@hmsreliant.think-freely.org>
	<m1k5nm2g3w.fsf@ebiederm.dsl.xmission.com>
	<20071211034349.GA3635@localhost.localdomain>
	<m1ejdt25x0.fsf@ebiederm.dsl.xmission.com>
	<20071211143910.GA10999@hmsreliant.think-freely.org>
	<m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>

On Dec 11, 2007 7:29 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Neil Horman <nhorman@tuxdriver.com> writes:
>
> > On Mon, Dec 10, 2007 at 09:48:11PM -0700, Eric W. Biederman wrote:
> >> Neil Horman <nhorman@tuxdriver.com> writes:
> >>
> >> Almost there.
> > cool! :)
> >
> > <snip>
> >>
> >> We should not need check_hypertransport_config as the generic loop
> >> now does the work for us.
> >> > +
> >> >  static void __init nvidia_bugs(void)
> >> >  {
> >> >  #ifdef CONFIG_ACPI
> >> > @@ -83,15 +127,25 @@ static void __init ati_bugs(void)
> >> >  #endif
> >> >  }
> >> >
> >> > +static void __init amd_host_bugs(void)
> >> > +{
> >> > +  printk(KERN_CRIT "IN AMD_HOST_BUGS\n");
> >> > +  check_hypertransport_config();
> >> > +}
> >>
> >> Likewise this function is unneeded and the printk is likely confusing
> >> for users.
> >>
> > Copy that. Fixed
> >
> > <snip>
> >> >    {}
> >> So make that fix_hypertransport_config and we should be good.
> > Done
> >
> >>
> >> We don't need to shift device.  Although we can do:
> >> device_vendor = read_pci_config(num, slot, func, PCI_VENDOR_ID);
> >> device = device_vendor >> 16;
> >> vendor = device_vendor & 0xffff;
> >>
> > I'm not so sure about this.  In my testing, it was clear that I needed to do a
> > shift on device to make valid comparisons to the defined PCI_DEVICE_* macros.
> > The origional code had to do the same thing with the class field, which is
> > simmilarly positioned in the pci config space.
>
> Ok.  I just looked at read_pci_config.  It doesn't do the right thing for
> a non-aligned 32bit access.  (Not that I am convinced there is a right
> thing we can do).  Please make this read_pci_config_16 instead
> and you won't need the shift.
>
> Either that or as I earlier suggested just do a 32bit read from offset 0
> and use shifts and masks to get vendor and device fields.
>
> The current code doing a shift where none should be needed (because
> we ignore the two low order bits in our read) is totally weird
> when looking at it.
>
> > Other than that, new patch attached.  Enables the detection of AMD
> > hypertransport functions and checks for the proper quirk just as before, and
> > incoporates your comments above Eric, as well as yours Yinghai.
>
> You almost got YH's comment.  You need return 2 for the old functions
> so we don't try and apply a per chipset fixup for every device in
> the system.
>
> I'm actually inclined to remove the return magic and just do something
> like:
>         static fix_applied;
>         if (fix_applied++)
>                 return;
> In those functions that should be called only once.

it seems we need to have two tables. one for northbridge (sweep all
the NB_K8) and another for SB ( like Nvidia, ati..., one touch and
leave)

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
