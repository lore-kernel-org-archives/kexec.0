Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Tue, 19 Jul 2011 15:02:12 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC][PATCH -mmotm 1/4] Add static function calls of pstore to
	kexec path
Message-ID: <20110719190212.GA4844@redhat.com>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C199C64C3@USINDEVS01.corp.hds.com>
	<20110719183506.GA23770@srcf.ucam.org>
	<5C4C569E8A4B9B42A84A977CF070A35B2C199C64D6@USINDEVS01.corp.hds.com>
	<20110719185411.GA3400@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110719185411.GA3400@redhat.com>
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
To: Don Zickus <dzickus@redhat.com>
Cc: Satoru Moriya <satoru.moriya@hds.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Jarod Wilson <jwilson@redhat.com>, Americo Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Seiji Aguchi <seiji.aguchi@hds.com>, Matthew Garrett <mjg@redhat.com>

On Tue, Jul 19, 2011 at 02:54:11PM -0400, Don Zickus wrote:
> On Tue, Jul 19, 2011 at 02:48:22PM -0400, Seiji Aguchi wrote:
> > >How is this safe? What happens if there's a pstore access in process
> > >when you hit this codepath?
> > 
> > This will never happen because pstore_kmsg_dump_in_interrupt() is called after machine_crash_shutdown().
> > 
> > Panicked cpu sends NMI to all other cpus in machine_crash_shutdown() and they stop.
> > 
> > 
> > @@ -1081,6 +1083,7 @@ void crash_kexec(struct pt_regs *regs)
> >  			crash_setup_regs(&fixed_regs, regs);
> >  			crash_save_vmcoreinfo();
> >  			machine_crash_shutdown(&fixed_regs);
> > +			pstore_kmsg_dump_in_interrupt(KMSG_DUMP_KEXEC);
> > 
> > Seiji
> 
> Another interesting question is do we need to log anything in the kdump
> path?  Isn't kdump generating the same info?  What added value do we get
> over kdump?

I had the same question. The argument is that kdump can fail and they
can not afford to not capture any info at all. So before kdump executes
they want to save some state to NVRAM.

I am wondering that saving this info to NVRAM, can it be done early in
second kernel? I guess we are not supposed to take any EFI services in
second kernel so it might not be possible.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
