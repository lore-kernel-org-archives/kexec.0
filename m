Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Oqfbn-0001kx-53
	for kexec@lists.infradead.org; Wed, 01 Sep 2010 05:11:40 +0000
Date: Wed, 1 Sep 2010 01:11:36 -0400 (EDT)
From: caiqian@redhat.com
Message-ID: <2037587462.1773341283317896712.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1017070299.1773321283317772856.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
> 
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
This might be hardware related, and here is the information,
# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
CPU(s):                64
Thread(s) per core:    2
Core(s) per socket:    8
CPU socket(s):         4
NUMA node(s):          4
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 46
Stepping:              6
CPU MHz:               1064.000
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              18432K
NUMA node0 CPU(s):     0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60
NUMA node1 CPU(s):     1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61
NUMA node2 CPU(s):     2,6,10,14,18,22,26,30,34,38,42,46,50,54,58,62
NUMA node3 CPU(s):     3,7,11,15,19,23,27,31,35,39,43,47,51,55,59,63

Given this is an internal system that I am not sure if I can get you the vmcore.
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
