Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QlPYl-00038U-J9
	for kexec@lists.infradead.org; Mon, 25 Jul 2011 18:07:20 +0000
Date: Mon, 25 Jul 2011 14:07:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110725180714.GC11009@redhat.com>
References: <20110714180528.GF6672@redhat.com>
	<1310739717.10789.31.camel@br98xy6r>
	<20110715143820.GG3428@redhat.com>
	<1310744603.10789.79.camel@br98xy6r>
	<20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r>
	<20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r>
	<20110718152532.GF31986@redhat.com>
	<1311348392.5772.56.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1311348392.5772.56.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

On Fri, Jul 22, 2011 at 05:26:32PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> Still thinking how we best get elfcorehdr size...
> 
> On Mon, 2011-07-18 at 11:25 -0400, Vivek Goyal wrote:
> > On Mon, Jul 18, 2011 at 04:44:13PM +0200, Michael Holzheu wrote:
> > You could do that but I think a more generic parameter will make more
> > sense.
> > 
> > - Either something along the lines of memmap=
> > - Or excludemem=x@y
> > - Or modify memory map in s390 specific bootloading protocol block etc.
> 
> Wouldn't it be most natural to pass the length along with the address of
> the ELF core header? What about extending the kernel elfcorehdr kernel
> parameter and adding optional size:
> 
> elfcorehdr=<addr>[KMG],<size>[KMG]

I think it could be memap= style. elfcorehdr=X[KMG]@Y[KMG]. Though to
support backward compatibility we will have to support old format of
plain elfcorehdr=X too.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
