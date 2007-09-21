Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.189])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYiLF-0001CB-KL
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 09:14:48 -0400
Received: by rv-out-0910.google.com with SMTP id c24so835541rvf
	for <kexec@lists.infradead.org>; Fri, 21 Sep 2007 06:14:43 -0700 (PDT)
Message-ID: <851fc09e0709210614q33cf3c81u1441fda17a66a6fd@mail.gmail.com>
Date: Fri, 21 Sep 2007 21:14:43 +0800
From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
In-Reply-To: <200709211409.25008.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211157.28622.nigel@nigel.suspend2.net>
	<m18x70ofp3.fsf@ebiederm.dsl.xmission.com>
	<200709211409.25008.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>

On 9/21/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 21 September 2007 05:33, Eric W. Biederman wrote:
> > Nigel Cunningham <nigel@nigel.suspend2.net> writes:
> > >
> > > That's not true. Kexec will itself be an implementation, otherwise you'd end
> > > up with people screaming about no hibernation support.
> >
> > There needs to be an implementation of hibernation based on kexec with
> > return yes.
> >
> > > And it won't result in
> > > the complete removal of the existing hibernation code from the kernel. At the
> > > very least, it's going to want the kernel being hibernated to have an
> > > interface by which it can find out which pages need to be saved.
> >
> > That interface should be running kernel -> user space -> target kernel.
> > Not direct kernel to kernel.
> >
> > > I wouldn't
> > > be surprised if it also ends up with an interface in which the kernel being
> > > hibernated tells it what bdev/sectors in which to save the image as well
> > > (otherwise you're going to need a dedicated, otherwise untouched partition
> > > exclusively for the kexec'd kernel to use), or what network settings to use
> > > if it wants to try to save the image to a network storage device.
> >
> > initramfs.  We already seem to have that interface.  And distros
> > seems to do a pretty decent job of using it to configure systems.
> >
> > > On top of
> > > that, there are all the issues related to device reinitialisation and so on,
> >
> > Yes.
> >
> > > and it looks like there's greatly increased pain for users wanting to
> > > configure this new implementation.
> >
> > Not to be callous but that really is a user space and distro issue.
> >
> > > Kexec is by no means proven to be the panacea for all the issues.
> >
> > I agree.  I'm still not quite convinced it will do a satisfactory job.
> > But I think it does make sense to implement a general kexec with
> > return and see if that can reasonably be used for handling hibernation
> > issues.  If done cleanly and with care the implementation won't be
> > hibernation specific.
>
> Yes, and that's worth doing anyway, IMO.
>
> > Frankly this looks like the best way I can see to implement a general
> > mechanism for calling silly firmware/BIOS/EFI services after we
> > have a kernel up and running.  It's a little bit like allowing
> > X to call iopl(3) and do inb/outb directly.
> >
> > The configuration issues you raise pretty much exist for kexec on
> > panic, and they seem to be being resolved for that case in a
> > reasonable way.  I do agree that the current kexec+return effort seems
> > to be one of those unfortunate cases where we give every mechanism in
> > the kernel to do something in user space and then no one actually
> > implements the user space.  That doesn't do any one any good.
> >
> > For hibernation we don't have the absolute need to step outside of the
> > current kernel that we do in the kexec on panic approach.  However we
> > have this practical fight about mechanism and policy, and kexec with
> > return has this seductive allure that it appears to be the minimal
> > necessary mechanism in the kernel.
> >
> > No one has yet attacked the hard problem of coming up with separate
> > hibernate methods for drivers.
>
> Well, I've been playing a bit with that for some time, but it's not easy by any
> means.
>
> In short, I'm seeing some problems related to the handling of ACPI that seem to
> shatter the entire idea of having separate hibernate methods, at least as far
> as ACPI systems are concerned.

So sadly to hear this. Can you details it a little? Or a link?

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
