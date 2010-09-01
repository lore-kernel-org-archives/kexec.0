Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Oqf3p-0004Gw-Pq
	for kexec@lists.infradead.org; Wed, 01 Sep 2010 04:36:35 +0000
Date: Wed, 1 Sep 2010 13:33:18 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile failed for 2.6.36-rc2
Message-Id: <20100901133319.10518b01.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <1356467030.1627921283243342687.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <20100831162850.855f034a.oomichi@mxs.nes.nec.co.jp>
	<1356467030.1627921283243342687.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
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
To: CAI Qian <caiqian@redhat.com>
Cc: kexec <kexec@lists.infradead.org>


Hi Cai,

On Tue, 31 Aug 2010 04:29:02 -0400 (EDT)
CAI Qian <caiqian@redhat.com> wrote:
> > > > I'd like to reproduce the same problem on my machine,
> > > > could you please send your kernel .config file ?
> > >
> > > Attached.
> > 
> > Thank you.
> > The linux-2.6.36-rc2 kernel is building now with your .config file.
> > After building, I will test makedumpfile on the kernel.

I built linux-2.6.36-rc2 kernel with your .config file, but it gets a
panic while 1st-kernel is booting. I'm not digging the cause.

So I built linux-2.6.36-rc2 kernel with my .config file instead, and it
can boot and the kdump is successful. But makedumpfile runs successfully,
so I cannot reproduce the problem which you reported.

I will try linux-2.6.36-rc3 kernel with your .config file later.
BTW, do you have the way how I get the compressed copy of your /proc/vmcore ?
I'd like to research the problem directly.


> > >> readmem: Can't seek the dump memory(/proc/vmcore). Invalid
> > argument
> > 
> > lseek(2) failed with "Invalid argument", so the problem may be due to
> > an
> > invalid offset. I'd like to know its value, so can you try the
> > attached
> > patch in the condition makedumpfile fails ?
> > And can you send the output of `readelf -a /proc/vmcore` ?
> Here you go,
> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument
> readmem: type_addr: 0, addr:ffff880480027000, size:32

The above output does not include the offset value which should be
printed by my previous patch. Could you check the patch is applied
to right place (lseek(2) call in readmem() function) ?
In addiction, could you operate makedumpfile with "-D" option ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
