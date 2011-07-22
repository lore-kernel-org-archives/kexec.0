Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QkHcd-0006iQ-8u
	for kexec@lists.infradead.org; Fri, 22 Jul 2011 15:26:40 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6MFQXTL021286
	for <kexec@lists.infradead.org>; Fri, 22 Jul 2011 15:26:33 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6MFQXCk2568416
	for <kexec@lists.infradead.org>; Fri, 22 Jul 2011 16:26:33 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6MFQW6L001351
	for <kexec@lists.infradead.org>; Fri, 22 Jul 2011 16:26:33 +0100
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110718152532.GF31986@redhat.com>
References: <20110714091800.720da848@mschwide>
	<20110714175532.GE6672@redhat.com> <20110714180528.GF6672@redhat.com>
	<1310739717.10789.31.camel@br98xy6r> <20110715143820.GG3428@redhat.com>
	<1310744603.10789.79.camel@br98xy6r>
	<20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r> <20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r> <20110718152532.GF31986@redhat.com>
Date: Fri, 22 Jul 2011 17:26:32 +0200
Message-ID: <1311348392.5772.56.camel@br98xy6r>
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

Hello Vivek,

Still thinking how we best get elfcorehdr size...

On Mon, 2011-07-18 at 11:25 -0400, Vivek Goyal wrote:
> On Mon, Jul 18, 2011 at 04:44:13PM +0200, Michael Holzheu wrote:
> You could do that but I think a more generic parameter will make more
> sense.
> 
> - Either something along the lines of memmap=
> - Or excludemem=x@y
> - Or modify memory map in s390 specific bootloading protocol block etc.

Wouldn't it be most natural to pass the length along with the address of
the ELF core header? What about extending the kernel elfcorehdr kernel
parameter and adding optional size:

elfcorehdr=<addr>[KMG],<size>[KMG]

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
