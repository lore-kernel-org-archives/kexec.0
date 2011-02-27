Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PthQ2-00025w-Im
	for kexec@lists.infradead.org; Sun, 27 Feb 2011 14:16:19 +0000
Date: Sun, 27 Feb 2011 09:16:00 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
Message-ID: <20110227141600.GA27699@redhat.com>
References: <20110226162008.GA23879@laptop> <4D6972CE.8040401@zytor.com>
	<m14o7q5m6d.fsf@fess.ebiederm.org> <20110227132409.GA4036@laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110227132409.GA4036@laptop>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>

On Sun, Feb 27, 2011 at 03:24:09PM +0200, Ahmed S. Darwish wrote:
> On Sat, Feb 26, 2011 at 04:57:30PM -0800, Eric W. Biederman wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > >
> > > I can't see any sane reason to *not* make kexec purgatory
> > > position-independent.  It is the obvious thing to do.
> > 
> > This isn't a case of the code not being position independent.  This is
> > case of where the relocations are applied.
> > 
> > I can see a couple of handling this with different tradeoffs.
> > 
> > 1) We teach bootloaders how to load two kernels at once.  This
> >    completely avoids the purgatory, as it is replaced by code in the
> >    bootloader that already exists to load the primary kernel and setup
> >    it's arguments.
> > 
> 
> This is in fact my plan. Using Syslinux, I loaded 'purgatory.ro' to RAM
> thinking that it will still be needed. Re-checking the purgatory code
> now after reading above note, it seems it does 5 important points:
> 
>    a) reset the VGA (if instructed)
>    b) reset the PIC to legacy mode (if instructed)
>    c) check the overall integrity of the second kernel image (SHA-2)
>    d) setup the environment for second kernel entry (switch back to
>       32-bit protected mode in x86-64, reset registers, etc)
>    e) saves the first 640K in a backup region
> 
> So (a) and (b) can be done elsewhere if needed; (c) isn't needed cause
> if the bootloader corrupts images, we have bigger problems;

First kernel boot itself could corrupt the second kernel?

Secondly, Once you are booted sucessfully, I guess same can be used for
regular kernel crash without reloading the kdump kernel (For poeple who are
looking to capture just logs). If yes, it will be good to check integrity
of second kernel image.

Is bootloader going to set up the kernels in such a way that second kernel
boot is not going to overwrite the first kernel's memory? Otherwise how
do we make sure that second kernel does not overwrite the oops/logs
information you are trying to save.

On a side note, does UEFI provide some functionality where first kernel
can save some limited amount of buffer and retrieve it back when a new
kernel is booting. I might be completely into weedes here. This is just
based on discussion with somebody long back who mentioned that UEFI
might allow us to save kernel oops and the retrieve it back when fresh
kernel is booting.

Do two kernels boot from mutually exclusive locations or you will continue
to copy new kernel at some low meory address and boot from there? Copying
will again lead to issue of how not to overwrite or concept of backup
region. For not copying we need to make sure what the highest address
kernel can boot from and also letting first kernel know not to overwrite
second kernel.

Above are just some random thoughts without going into details of the proposal.

Thanks
Vivek
 

>(d) can be
> done as a stub;
>(e), on the contrary of kdump, isn't critical for my
> goals.
> 
> Am I missing an important detail?
> 
> > 2) We add minimal relocation processing to purgatory, allowing us to do
> >    the setup for the second kernel extremely early and allow it to be
> >    compiled into the first kernel.
> > 
> > 3) We come up with a scheme where we don't share code and the first
> >    kernel copies the firmware information to place where the second
> >    kernel can get at it, and uses it's own home grown stub and not
> >    purgatory.
> > 
> 
> Sorry, but how the third point differs from the first? I thought they
> were complementary.
> 
> > I think this whole thing can be prototyped easily with a getting /sbin/kexec
> > to load to a fixed address and then baking that section into the primary
> > kernel. ...
> 
> I'll prototype this now by loading the second kernel (bzImage), using
> syslinux, without the purgatory.  Let's hope I won't face many
> surprises.
> 
> > ... I'm not convinced that directly using /sbin/kexec is the right
> > way forward to handle the general case.  This is something where the
> > devil is in the details.
> > 
> 
> Lots of details per se; spent last week exploring Kexec user and
> kernel code to understand how it does its magic.
> 
> > Eric
> 
> thanks,
> 
> -- 
> Darwish
> http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
