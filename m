Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SIFl8-0006hA-9K
 for kexec@lists.infradead.org; Thu, 12 Apr 2012 08:52:09 +0000
Date: Thu, 12 Apr 2012 17:49:32 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120412174932.f78f2af8.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <1334131443.2711.10.camel@br98xy6r>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <1333386933.9539.8.camel@br98xy6r>
 <20120406170911.093369b0.kumagai-atsushi@mxc.nes.nec.co.jp>
 <1334131443.2711.10.camel@br98xy6r>
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
To: holzheu@linux.vnet.ibm.com
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello Michael,

On Wed, 11 Apr 2012 10:04:03 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> > bitmap file is main cause of memory consuming if 2nd kernel uses initramfs
> > only. There are other parts where the size of allocated memory varies based
> > on 1-st kernel memory size, but they don't have big influence.
> 
> Thanks for the explanation. 
> 
> I ask because I want to exactly calculate the required size for the
> crashkernel parameter. On s390 the kdump kernel memory consumption is
> fix and not dependent on the 1st kernel memory size. So based on your
> explanation I, will use:
> 
> crashkernel=<base size> + <variable size>
> 
> where
> 
> <variable size> = <pages of 1st kernel> * (2 + x) / 8
> 
> where "x" is the variable makedumpfile memory allocation that is on top
> of the bitmap allocation. What would be a good value for "x"?

I'm sorry that I don't have the exact number, but even the second biggest
memory allocation would require under 1/100 of the bitmap size, so, I think
0.01 is usually enough for "x".

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
