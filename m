Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nfxzd-00058Z-3t
	for kexec@lists.infradead.org; Fri, 12 Feb 2010 16:03:50 +0000
Date: Fri, 12 Feb 2010 11:03:39 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump not writing any vmcore
Message-ID: <20100212160339.GB27909@hmsreliant.think-freely.org>
References: <b08bcbf51002100831k3c1e35d7t8b0d80a1bf89fa07@mail.gmail.com>
	<20100210164530.GE27658@hmsreliant.think-freely.org>
	<b08bcbf51002110826x184e281ei175625f969288313@mail.gmail.com>
	<20100211180606.GE26458@shamino.rdu.redhat.com>
	<b08bcbf51002120642k46e5a73and2f200764c01b714@mail.gmail.com>
	<b08bcbf51002120652r785285bbw9206d3e867cfaefb@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b08bcbf51002120652r785285bbw9206d3e867cfaefb@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Gallus <gall.cwpl@gmail.com>
Cc: kexec@lists.infradead.org

On Fri, Feb 12, 2010 at 03:52:01PM +0100, Gallus wrote:
> PS. I can add some overall information about the box:
> =

> a) Modules loaded:
> kernel: Modules linked in: dm_mirror dm_multipath dm_mod video sbs
> backlight i2c_ec i2c_core button battery asus_acpi ac parport_pc lp
> parport serio_raw ide_cd bnx2 cdrom pcspkr cciss sd_mod scsi_mod ext3
> jbd uhci_hcd ohci_hcd ehci_hcd
> =

> b) Some Oops that occurred (I'm not sure whether it was in crash
> kernel or in normal one):
> kernel: list_add corruption. prev->next should be e70ee78c, but was 54746=
46e
> kernel: BUG: unable to handle kernel NULL pointer dereference at
> virtual address 00000084 kernel:  printing eip:
> kernel: c06097b2
> kernel: *pde =3D 1cf15001
> Oops: 0000 [#1]
> kernel: SMP
> kernel: last sysfs file: /devices/pci0000:00/0000:00:00.0/class
> kernel: CPU:    0
> kernel: EIP:    0060:[<c06097b2>]    Tainted: G      VLI
> kernel: EFLAGS: 00210046   (2.6.18-92.el5PAE #1)
> kernel: EIP is at do_page_fault+0x1d1/0x5d3
> kernel: eax: d2ef6000   ebx: 00000000   ecx: d2ef6064   edx: 0000000d
> kernel: esi: 00000000   edi: d2ef6094   ebp: 00000000   esp: d2ef6044
> =

> c) hardware:
> Quad-Core AMD Opteron(tm) Processor 8356, model 2, stepping 3
> =

> Gallus
> =


This helps not one bit.  Theres not enough info here to determine what the =
cause
(or even the location) of this corruption is.  All it tells us is that a li=
st in
the kernel was corrupted.  If that happened in the production kernel it wou=
ld
cause kdump to start.  If it happened in the kdump kernel, it would explain=
 why
you never got a vmcore.  But without the call stack, I can't even tell you =
what
list this might have been.  If we knew that, we might be able to dredge bug=
zilla
to search for simmilar bugs, and if they were fixed.

Currently, about all I can tell you from this is that 2.6.18-92 is a bit of=
 an
old kernel.  If you're working with RHEL, I'd update to whatever the latest
release is (I don't recall the exact number, -128 perhaps).  I know that si=
nce
that kernel I have fixed a few quad core opteron specific bugs (although th=
ose
were primarily hangs in kdump, not oopses).  Worth a shot though.

Better still, open a support issue with Red Hat, and this bug will most lik=
ely
find its way to me, then we can get you a fix in a more timely manner :)

Neil

> On 12 February 2010 15:42, Gallus <gall.cwpl@gmail.com> wrote:
> > On 11 February 2010 19:06, Neil Horman <nhorman@redhat.com> wrote:
> >> On Thu, Feb 11, 2010 at 05:26:50PM +0100, Gallus wrote:
> >>
> >> > Does someone have any experience with such problems? Is there
> >> > something left to try out?
> >> >
> >> Yes, this is what I fix all the time. =A0despite your comments above, =
a console
> >> log would still be helpful. =A0It will give us the bet pointer to what=
s going
> >> wrong.
> >> Neil
> >
> >
> > Can you share some thoughts about such problems? Any suggestion may be =
helpful.
> >
> > Gallus
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
