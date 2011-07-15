Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QhisX-00029v-Bu
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 13:56:30 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6FDuNbq021898
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 13:56:23 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
	[9.149.37.229])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6FDuMHb2023570
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 14:56:22 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6FDuMhC017520
	for <kexec@lists.infradead.org>; Fri, 15 Jul 2011 07:56:22 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110714175532.GE6672@redhat.com>
References: <20110705202615.GJ24348@redhat.com>
	<1309944287.3937.39.camel@br98xy6r> <20110707193321.GE28850@redhat.com>
	<20110708110121.5acfc3c9@mschwide> <20110711144255.GE30674@redhat.com>
	<20110711175626.121dcc58@mschwide> <20110713160239.GE4426@redhat.com>
	<20110713184611.6dcb09b4@mschwide> <20110713200004.GG4426@redhat.com>
	<20110714091800.720da848@mschwide> <20110714175532.GE6672@redhat.com>
Date: Fri, 15 Jul 2011 15:56:21 +0200
Message-ID: <1310738181.10789.16.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

Hello Vivec,

On Thu, 2011-07-14 at 13:55 -0400, Vivek Goyal wrote:

[snip]

> > The first thing we want to do is to check if
> > the purgatory is still fine, that is do a checksum. If we have the
> > infrastructure in place to do one checksum then we can easily do the
> > other checksums as well.
> 
> Some piece of code you have to assume is fine. Are you not already
> assuming that IPL code you have in first 64K bytes is fine and no
> body has overwritten it.

We can assume that the IPL dump code is fine, because it is freshly
loaded into memory. Only when the disk is somehow corrupted we have a
problem.

> Are you not assuming that hook in panic()
> (I think you are calling it shutdown trigger) is fine so that it
> can help you jump to right place.

Yes, that is correct for automatic dump in case of panic(). The panic()
path can fail.

But there are two other options where really *no* code that was in
memory, when the system crashed, is used for the dump process or
verification of kdump:
1) Manual IPL/boot of stand-alone dump by the operator via the virtual
guest console
2) Automatic IPL/boot of stand-alone dump by our z/VM hypervisor
watchdog

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
