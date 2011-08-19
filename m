Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuOZj-0006GX-9r
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 12:53:29 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7JCrMFs021138
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 12:53:22 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7JCrLFB2314482
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 13:53:21 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7JCrLcI019104
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 06:53:21 -0600
Subject: Re: [patch 0/3] kdump: Add external kdump entry point for s390
	stand-alone dump tools
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110819011431.GB20747@verge.net.au>
References: <20110729123944.562622201@linux.vnet.ibm.com>
	<20110819011431.GB20747@verge.net.au>
Date: Fri, 19 Aug 2011 14:53:20 +0200
Message-ID: <1313758400.3858.12.camel@br98xy6r>
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
To: Simon Horman <horms@verge.net.au>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

Hello Simon,

On Fri, 2011-08-19 at 10:14 +0900, Simon Horman wrote:
> On Fri, Jul 29, 2011 at 02:39:44PM +0200, Michael Holzheu wrote:
> > Hello Vivek,
> > 
> > I finished the patches that add the stand-alone dump tools support on
> > top of the recently sent v2 patch series. The following three patches
> > implement the program check idea that we have discussed recently:
> > 
> > [1] kdump: Add new machine_kexec_finish() architecture callback
> > [2] s390: Add external kdump entry point for s390 stand-alone dump tools
> > [3] kexec-tools: Emit program check on s390 for checksum failure
> 
> Hi Michael,
> 
> in general I am fine with these patches and happy to merge them

That's good news.

> although I am a little unclear about the status of the kernel side of
> things. Please let me know if you would like me to merge the kexec-tools
> patches now or wait a bit (for an updated version?).

I think that we are almost done with the discussion. I will send you my
current kexec-tools patches and would be glad, if you could integrate
them now.

From Monday I will be two weeks on vacation. If there are additional
questions please contact Martin Schwidefsky and Heiko Carstens.

> Also, if you could give me any pointers on how to obtain an s390
> cross-compiling environment for x86_64 I would be most grateful.

There are debian packages for under:
http://debian.speedblue.org/ 

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
