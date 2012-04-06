Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SG4Fm-0008W3-Nq
 for kexec@lists.infradead.org; Fri, 06 Apr 2012 08:10:45 +0000
Date: Fri, 6 Apr 2012 17:09:11 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120406170911.093369b0.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <1333386933.9539.8.camel@br98xy6r>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <1333386933.9539.8.camel@br98xy6r>
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

On Mon, 02 Apr 2012 19:15:33 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Hello Ken'ichi,
> 
> On Thu, 2012-03-29 at 17:09 +0900, Ken'ichi Ohmichi wrote:
> > On Wed, 28 Mar 2012 17:22:04 -0400
> > makedumpfile uses the system memory of 2nd-kernel for a bitmap if RHEL.
> > The bitmap represents each page of 1st-kernel is excluded or not.
> > So the bitmap size depends on 1st-kernel's system memory.
> 
> Does this mean that makedumpfile's memory demand linearly grows with 1
> bit per page of 1-st kernel's memory?

Yes, you are right. (Precisely, 2 bit per page.)

> Is that the exact factor, if /tmp is in memory? Or is there any other
> memory allocation that is not constant regarding the 1-st kernel memory
> size?

bitmap file is main cause of memory consuming if 2nd kernel uses initramfs
only. There are other parts where the size of allocated memory varies based
on 1-st kernel memory size, but they don't have big influence.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
