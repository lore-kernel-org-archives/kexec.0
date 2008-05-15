Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jwilk-0005tB-Bk
	for kexec@lists.infradead.org; Thu, 15 May 2008 19:05:36 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 21:05:47 +0200
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<m13aok1pt1.fsf@frodo.ebiederm.org>
	<1210815739.23707.74.camel@caritas-dev.intel.com>
In-Reply-To: <1210815739.23707.74.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200805152105.48820.rjw@sisk.pl>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Thursday, 15 of May 2008, Huang, Ying wrote:
> On Wed, 2008-05-14 at 15:30 -0700, Eric W. Biederman wrote:
> [...]
> > >  
> > > +	if (image->preserve_context) {
> > > +		KJUMP_MAGIC(control_page) = KJUMP_MAGIC_NUMBER;
> > > +		if (kexec_jump_save_cpu(control_page)) {
> > > +			image->start = KJUMP_ENTRY(control_page);
> > > +			return;
> > 
> > Tricky, and I expect unnecessary.
> > We should be able to just have relocate_new_kernel return?
> 
> OK, I will check this. Maybe we can move CPU state saving code into
> relocate_new_kernel.
> 
> [...]
> > > -static void kernel_kexec(void)
> > > +static int kernel_kexec(void)
> > >  {
> > > +	int ret = -ENOSYS;
> > >  #ifdef CONFIG_KEXEC
> > > -	struct kimage *image;
> > > -	image = xchg(&kexec_image, NULL);
> > > -	if (!image)
> > > -		return;
> > > -	kernel_restart_prepare(NULL);
> > > -	printk(KERN_EMERG "Starting new kernel\n");
> > > -	machine_shutdown();
> > > -	machine_kexec(image);
> > > +	if (xchg(&kexec_lock, 1))
> > > +		return -EBUSY;
> > > +	if (!kexec_image) {
> > > +		ret = -EINVAL;
> > > +		goto unlock;
> > > +	}
> > > +	if (!kexec_image->preserve_context) {
> > > +		kernel_restart_prepare(NULL);
> > > +		printk(KERN_EMERG "Starting new kernel\n");
> > > +		machine_shutdown();
> > > +	}
> > > +	ret = kexec_jump(kexec_image);
> > > +unlock:
> > > +	xchg(&kexec_lock, 0);
> > >  #endif
> > 
> > Ugh.  No.  Not sharing the shutdown methods with reboot and
> > the normal kexec path looks like a recipe for failure to me.
> > 
> > This looks like where we really need to have the conversation.
> > What methods do we use to shutdown the system.
> > 
> > My take on the situation is this.  For proper handling we
> > need driver device_detach and device_reattach methods.
> > 
> > With the following semantics.  The device_detach methods
> > will disable DMA and place the hardware in a sane state
> > from which the device driver can reclaim and reinitialize it,
> > but the hardware will not be touched.
> > 
> > device_reattach reattaches the driver to the hardware.
> 
> Yes. Current device PM callback is not suitable for hibernation (kexec
> based or original). I think we can collaborate with Rafael J. Wysocki on
> the new device drivers hibernation callbacks.

Thanks, I'm also open for collaboration.  There will be a lot of work to do
related to the new callbacks, so any contribution is certainly welcome.

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
