Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nfxu7-0002Wh-4b
	for kexec@lists.infradead.org; Fri, 12 Feb 2010 15:58:09 +0000
Date: Fri, 12 Feb 2010 10:57:55 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump not writing any vmcore
Message-ID: <20100212155755.GA27909@hmsreliant.think-freely.org>
References: <b08bcbf51002100831k3c1e35d7t8b0d80a1bf89fa07@mail.gmail.com>
	<20100210164530.GE27658@hmsreliant.think-freely.org>
	<b08bcbf51002110826x184e281ei175625f969288313@mail.gmail.com>
	<20100211180606.GE26458@shamino.rdu.redhat.com>
	<b08bcbf51002120642k46e5a73and2f200764c01b714@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b08bcbf51002120642k46e5a73and2f200764c01b714@mail.gmail.com>
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

On Fri, Feb 12, 2010 at 03:42:20PM +0100, Gallus wrote:
> On 11 February 2010 19:06, Neil Horman <nhorman@redhat.com> wrote:
> > On Thu, Feb 11, 2010 at 05:26:50PM +0100, Gallus wrote:
> >
> > > Does someone have any experience with such problems? Is there
> > > something left to try out?
> > >
> > Yes, this is what I fix all the time. =A0despite your comments above, a=
 console
> > log would still be helpful. =A0It will give us the bet pointer to whats=
 going
> > wrong.
> > Neil
> =

> =

> Can you share some thoughts about such problems? Any suggestion may be he=
lpful.
> =

> Gallus

I can, but its just blind guessing until you provide details of the error
(preferably in the form of a log file from the time the kdump kernel booted=
).

It could be that the kernel has a legitimate bug that it encounters during =
boot
up, and never makes it to the initramfs.  That would be evident if the end =
of a
console log showed a panic with a backtrace

It could be that your nic driver isn't initalizing the ethernet card proper=
ly,
and you're not sending frames, so you can't establish a connection to your
ftp/ssh/nfs/etc server.  A console log would show dhcp or other network err=
ors
in this case

It could be that the kernel was unable to parse the elf headers that kexec =
wrote
into the kernel before the crash, and as such, can't deliver the core to any
user space apps for reconding, this would show up as write errors on the
console.

The list goes on.  But the central theme is that we can't diagnose it witho=
ut at
minimum a console log.

Neil


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
