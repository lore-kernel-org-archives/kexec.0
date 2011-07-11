Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate4.uk.ibm.com ([194.196.100.164])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QgI4D-00085W-EP
	for kexec@lists.infradead.org; Mon, 11 Jul 2011 15:06:38 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate4.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6BF6Ukq003633
	for <kexec@lists.infradead.org>; Mon, 11 Jul 2011 15:06:30 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6BF6UY02400360
	for <kexec@lists.infradead.org>; Mon, 11 Jul 2011 16:06:30 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6BF6Tt7008810
	for <kexec@lists.infradead.org>; Mon, 11 Jul 2011 09:06:29 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110711140754.GD30674@redhat.com>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com> <1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>
	<1310133738.3508.245.camel@br98xy6r>
	<20110711140754.GD30674@redhat.com>
Date: Mon, 11 Jul 2011 17:06:29 +0200
Message-ID: <1310396789.3557.43.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Mon, 2011-07-11 at 10:07 -0400, Vivek Goyal wrote:
> On Fri, Jul 08, 2011 at 04:02:18PM +0200, Michael Holzheu wrote:
> > Hello Vivek,
> > 
> > I attached a document where the s390 port is described in more detail.
> > Perhaps this helps you to understand what want and what we are doing. If
> > not - just delete it :-)
> > 
> 
> Michael,
> 
> Thanks for the documentation. I have gone through it quickly and there
> are some parts I am still missing.
> 
> On x86, after the kernel crash we jump to purgatory code which does the
> checksum verification of all the loaded segments and if everything is
> fine, it jumps to kdump kernel's entry point and second kernel boots.
> 
> On s390, looks like after purgatory, control is going to some other
> piece of code (which does IPL?), and that code decides whether to
> start kdump kernel or launch stand alone kernel as backup plan?
>
> If yes, is that code whic does the IPL, also loaded in crashkernel memory
> as part of kdump kernel? If not, how does kexec-tools come to know
> where to jump after doing checksum on loaded kernel?

On s390 currently we currently do not use the purgatory kexec-tools code
at all. Therefore this checksum check is not done.

We have defined a new kernel entry point for kdump at <crashk base> +
0x10008. When this entry point is used, the first instructions swap the
area [0, crashk size] with [crashk base, crashk base + crashk size]. The
information about crashk base and size is taken from meminfo. After the
swap the Linux kernel is started with the information that we are in
kdump mode and the information about crashk base and size (which is
oldmem base and size now).

There are different ways how the kdump entry point can be called on s390
depending on the setting (/sys/firmware) for "panic" and
"restart" (something like NMI on intel). If you do not want the more
reliable two stage approach with the stand-alone dump tools, it is also
possible that the entry point is called directly via machine_kexec(). In
this case the crashed kernel does the s390 specific checksum test and
then jumps to <crashk base> + 0x10008.

The more reliable solution with our stand-alone dump tools works as
follows:
1. Stand-alone dump disk or tape is IPLed (booted). This can be done
either automatically via the panic() kernel code path or manually by the
operator of the (virtual) machine.
2. The stand-alone dump tool (mini OS) is loaded to 0x2000 under
0x10000. This area is always free and is not used by Linux on s390.
3. The stand-alone dump tool finds the crashkernel memory via meminfo
that can be found via a pointer at address 0xe14.
4. The stand-alone verifies the kdump checksums and jumps to <crashk
base> + 0x10008, if everything is ok.

Michael








_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
