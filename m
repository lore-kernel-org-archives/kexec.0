Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OqfgM-0001rU-7V
	for kexec@lists.infradead.org; Wed, 01 Sep 2010 05:16:22 +0000
Date: Wed, 1 Sep 2010 01:16:20 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <601148450.1773381283318180197.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20100901133319.10518b01.oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile failed for 2.6.36-rc2
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec <kexec@lists.infradead.org>


----- "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> Hi Cai,
> 
> On Tue, 31 Aug 2010 04:29:02 -0400 (EDT)
> CAI Qian <caiqian@redhat.com> wrote:
> > > > > I'd like to reproduce the same problem on my machine,
> > > > > could you please send your kernel .config file ?
> > > >
> > > > Attached.
> > > 
> > > Thank you.
> > > The linux-2.6.36-rc2 kernel is building now with your .config
> file.
> > > After building, I will test makedumpfile on the kernel.
> 
> I built linux-2.6.36-rc2 kernel with your .config file, but it gets a
> panic while 1st-kernel is booting. I'm not digging the cause.
Another pointer is that 2.6.35-rc1 worked fine for me, while 2.6.35-rc4 and beyond started to fail.
> So I built linux-2.6.36-rc2 kernel with my .config file instead, and
> it
> can boot and the kdump is successful. But makedumpfile runs
> successfully,
> so I cannot reproduce the problem which you reported.
> 
> I will try linux-2.6.36-rc3 kernel with your .config file later.
> BTW, do you have the way how I get the compressed copy of your
> /proc/vmcore ?
> I'd like to research the problem directly.
> 
> 
> > > >> readmem: Can't seek the dump memory(/proc/vmcore). Invalid
> > > argument
> > > 
> > > lseek(2) failed with "Invalid argument", so the problem may be due
> to
> > > an
> > > invalid offset. I'd like to know its value, so can you try the
> > > attached
> > > patch in the condition makedumpfile fails ?
> > > And can you send the output of `readelf -a /proc/vmcore` ?
> > Here you go,
> > readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> > readmem: type_addr: 0, addr:ffff880480027000, size:32
> 
> The above output does not include the offset value which should be
> printed by my previous patch. Could you check the patch is applied
> to right place (lseek(2) call in readmem() function) ?
> In addiction, could you operate makedumpfile with "-D" option ?
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
