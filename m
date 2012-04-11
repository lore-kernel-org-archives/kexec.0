Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SHsXK-0001lY-LA
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 08:04:19 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 11 Apr 2012 09:04:08 +0100
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3B844wL1097748
 for <kexec@lists.infradead.org>; Wed, 11 Apr 2012 09:04:04 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3B8445j020368
 for <kexec@lists.infradead.org>; Wed, 11 Apr 2012 02:04:04 -0600
Message-ID: <1334131443.2711.10.camel@br98xy6r>
Subject: Re: makedumpfile memory usage grows with system memory size
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2012 10:04:03 +0200
In-Reply-To: <20120406170911.093369b0.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <1333386933.9539.8.camel@br98xy6r>
 <20120406170911.093369b0.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello Kumagai,

On Fri, 2012-04-06 at 17:09 +0900, Atsushi Kumagai wrote:
> Hello Michael,
> 
> On Mon, 02 Apr 2012 19:15:33 +0200
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 
> > Hello Ken'ichi,
> > 
> > On Thu, 2012-03-29 at 17:09 +0900, Ken'ichi Ohmichi wrote:
> > > On Wed, 28 Mar 2012 17:22:04 -0400
> > > makedumpfile uses the system memory of 2nd-kernel for a bitmap if RHEL.
> > > The bitmap represents each page of 1st-kernel is excluded or not.
> > > So the bitmap size depends on 1st-kernel's system memory.
> > 
> > Does this mean that makedumpfile's memory demand linearly grows with 1
> > bit per page of 1-st kernel's memory?
> 
> Yes, you are right. (Precisely, 2 bit per page.)
> 
> > Is that the exact factor, if /tmp is in memory? Or is there any other
> > memory allocation that is not constant regarding the 1-st kernel memory
> > size?
> 
> bitmap file is main cause of memory consuming if 2nd kernel uses initramfs
> only. There are other parts where the size of allocated memory varies based
> on 1-st kernel memory size, but they don't have big influence.

Thanks for the explanation. 

I ask because I want to exactly calculate the required size for the
crashkernel parameter. On s390 the kdump kernel memory consumption is
fix and not dependent on the 1st kernel memory size. So based on your
explanation I, will use:

crashkernel=<base size> + <variable size>

where

<variable size> = <pages of 1st kernel> * (2 + x) / 8

where "x" is the variable makedumpfile memory allocation that is on top
of the bitmap allocation. What would be a good value for "x"?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
