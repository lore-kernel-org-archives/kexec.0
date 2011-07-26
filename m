Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qle0P-0003Ln-N1
	for kexec@lists.infradead.org; Tue, 26 Jul 2011 09:32:50 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6Q9WbP3029492
	for <kexec@lists.infradead.org>; Tue, 26 Jul 2011 09:32:37 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6Q9WbSG2023510
	for <kexec@lists.infradead.org>; Tue, 26 Jul 2011 10:32:37 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6Q9WbmP011229
	for <kexec@lists.infradead.org>; Tue, 26 Jul 2011 03:32:37 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110725180714.GC11009@redhat.com>
References: <20110714180528.GF6672@redhat.com>
	<1310739717.10789.31.camel@br98xy6r> <20110715143820.GG3428@redhat.com>
	<1310744603.10789.79.camel@br98xy6r>
	<20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r> <20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r> <20110718152532.GF31986@redhat.com>
	<1311348392.5772.56.camel@br98xy6r> <20110725180714.GC11009@redhat.com>
Date: Tue, 26 Jul 2011 11:32:36 +0200
Message-ID: <1311672756.4146.1.camel@br98xy6r>
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

On Mon, 2011-07-25 at 14:07 -0400, Vivek Goyal wrote:
> On Fri, Jul 22, 2011 at 05:26:32PM +0200, Michael Holzheu wrote:
> > Hello Vivek,
> > 
> > Still thinking how we best get elfcorehdr size...
> > 
> > On Mon, 2011-07-18 at 11:25 -0400, Vivek Goyal wrote:
> > > On Mon, Jul 18, 2011 at 04:44:13PM +0200, Michael Holzheu wrote:
> > > You could do that but I think a more generic parameter will make more
> > > sense.
> > > 
> > > - Either something along the lines of memmap=
> > > - Or excludemem=x@y
> > > - Or modify memory map in s390 specific bootloading protocol block etc.
> > 
> > Wouldn't it be most natural to pass the length along with the address of
> > the ELF core header? What about extending the kernel elfcorehdr kernel
> > parameter and adding optional size:
> > 
> > elfcorehdr=<addr>[KMG],<size>[KMG]
> 
> I think it could be memap= style. elfcorehdr=X[KMG]@Y[KMG]. Though to
> support backward compatibility we will have to support old format of
> plain elfcorehdr=X too.

Ok, fine. I will add a patch for that.

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
