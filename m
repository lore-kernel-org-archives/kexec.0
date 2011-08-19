Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuPFc-0007iX-7e
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 13:36:44 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7JDaen6029321
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 13:36:40 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7JDaeBN2158676
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 14:36:40 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7JDadEa031343
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 07:36:39 -0600
Subject: Re: [patch 0/3] kdump: Add external kdump entry point for s390
	stand-alone dump tools
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110819132019.GA18656@redhat.com>
References: <20110729123944.562622201@linux.vnet.ibm.com>
	<20110819011431.GB20747@verge.net.au>
	<1313758400.3858.12.camel@br98xy6r>
	<20110819132019.GA18656@redhat.com>
Date: Fri, 19 Aug 2011 15:36:38 +0200
Message-ID: <1313760998.3858.32.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Fri, 2011-08-19 at 09:20 -0400, Vivek Goyal wrote:
> On Fri, Aug 19, 2011 at 02:53:20PM +0200, Michael Holzheu wrote:
> 
> [...]
> > > although I am a little unclear about the status of the kernel side of
> > > things. Please let me know if you would like me to merge the kexec-tools
> > > patches now or wait a bit (for an updated version?).
> > 
> > I think that we are almost done with the discussion. I will send you my
> > current kexec-tools patches and would be glad, if you could integrate
> > them now.
> 
> I guess kexec-tools integration will make more sense once kernel patches
> show up atleast in one maintainer's subtree.

The s390 kexec-tools kdump code will inactive as long a kernel shows
"Crash kernel" in /proc/iomem. So IMHO there is little risk to integrate
the code.

> Also in kernel patches, atleast we need to resolve the issue of arch
> specific kmap(), kunmap() calls so that we don't have to make
> kimage_load_crash_segment() arch specific.

As I told in my last mail we will do this later. So I think there are
currently no more open issues, correct?

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
