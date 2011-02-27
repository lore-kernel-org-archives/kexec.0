Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bw0-f49.google.com ([209.85.214.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ptimm-0002a5-Uu
	for kexec@lists.infradead.org; Sun, 27 Feb 2011 15:43:54 +0000
Received: by bwz1 with SMTP id 1so3322627bwz.36
	for <kexec@lists.infradead.org>; Sun, 27 Feb 2011 07:43:51 -0800 (PST)
Date: Sun, 27 Feb 2011 17:43:46 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
Message-ID: <20110227154346.GA18300@laptop>
References: <20110226162008.GA23879@laptop> <4D6972CE.8040401@zytor.com>
	<m14o7q5m6d.fsf@fess.ebiederm.org> <20110227132409.GA4036@laptop>
	<20110227141600.GA27699@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110227141600.GA27699@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>

On Sun, Feb 27, 2011 at 09:16:00AM -0500, Vivek Goyal wrote:
> On Sun, Feb 27, 2011 at 03:24:09PM +0200, Ahmed S. Darwish wrote:
> > 
> > This is in fact my plan. Using Syslinux, I loaded 'purgatory.ro' to RAM
> > thinking that it will still be needed. Re-checking the purgatory code
> > now after reading above note, it seems it does 5 important points:
> > 
> >    a) reset the VGA (if instructed)
> >    b) reset the PIC to legacy mode (if instructed)
> >    c) check the overall integrity of the second kernel image (SHA-2)
> >    d) setup the environment for second kernel entry (switch back to
> >       32-bit protected mode in x86-64, reset registers, etc)
> >    e) saves the first 640K in a backup region
> > 
> > So (a) and (b) can be done elsewhere if needed; (c) isn't needed cause
> > if the bootloader corrupts images, we have bigger problems;
> 
> First kernel boot itself could corrupt the second kernel?
> 

Indeed; that didn't pass my mind though. Linus was also quite nervous
of writing to disk upon panic, so some validity guarantee of the second
kernel image will be asked for.

That means, I guess, that the purgatory will still be needed. Eric, any
thoughts?

> Secondly, Once you are booted sucessfully, I guess same can be used for
> regular kernel crash without reloading the kdump kernel (For poeple who are
> looking to capture just logs). If yes, it will be good to check integrity
> of second kernel image.
> 

Didn't understand the above paragraph, but in all cases, it seems that
checking the second kernel integrity will be quite important.

Maybe we'll also need to check the integrity of the integrator :)

> Is bootloader going to set up the kernels in such a way that second kernel
> boot is not going to overwrite the first kernel's memory? Otherwise how
> do we make sure that second kernel does not overwrite the oops/logs
> information you are trying to save.
> 

There will be some sort of protection for the logs area, yes. How such
communication between the two kernels will occur, I don't know. For now,
I'm focused on loading and booting the second kernel.

> On a side note, does UEFI provide some functionality where first kernel
> can save some limited amount of buffer and retrieve it back when a new
> kernel is booting. I might be completely into weedes here. This is just
> based on discussion with somebody long back who mentioned that UEFI
> might allow us to save kernel oops and the retrieve it back when fresh
> kernel is booting.
> 

I have zero contact with EFI, though there's some sort of ACPI-interfaced
nonvolatile RAM in modern high-end x86 servers.

> Do two kernels boot from mutually exclusive locations or you will continue
> to copy new kernel at some low meory address and boot from there? Copying
> will again lead to issue of how not to overwrite or concept of backup
> region. For not copying we need to make sure what the highest address
> kernel can boot from and also letting first kernel know not to overwrite
> second kernel.
> 

Yes, I'll need to utilize the boot protocol for this, making sure the
first kernel mark the second one's loaded image (and its purgatory) as
reserved.

> Above are just some random thoughts without going into details of the
> proposal.

Appreciated! I need all input possible at this stage.

> Thanks
> Vivek
> 

thanks,

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
