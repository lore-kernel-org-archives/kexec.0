Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SDS82-0001MO-I9
 for kexec@lists.infradead.org; Fri, 30 Mar 2012 03:03:57 +0000
Date: Fri, 30 Mar 2012 12:02:00 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: Fwd: Re: makedumpfile security key enhancement using SIAL
Message-Id: <20120330120200.04bcde45.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <4F6B60C6.7060707@linux.vnet.ibm.com>
References: <4F6870DD.6060102@linux.vnet.ibm.com>
 <20120321154328.4bbcff7d.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F6B60C6.7060707@linux.vnet.ibm.com>
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
To: aravinda@linux.vnet.ibm.com
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, lucchouina@yahoo.com, anderson@redhat.com

Hello Aravinda,

On Thu, 22 Mar 2012 22:56:30 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> On Wednesday 21 March 2012 12:13 PM, Atsushi Kumagai wrote:
> > Hello Aravinda,
> >
> > I have two questions, could you answer me ?
> >
> > First, what problems do you have about the current format of makedumpfile.conf ?
> 
> Even though makedumpfile.conf is capable of filtering out data from the
> vmocore, it is not possible to specify and erase complex
> data-structures. For example it is not possible to traverse a nested
> list or a tree and then erase a particular node based on some
> conditions. Extending makedumpfile.conf to support these would require
> implementing a lot of language constructs. But we can reuse SIAL
> instead of extending makedumpfile.conf.
> 
> > Second, what benefits do you expect from using SIAL ? I can't imagine
> > specific benefits with using SIAL now.
> 
> SIAL can be used as a language construct to specify rules/commands to
> erase data in the image file. The makedumpfile would interpret the
> rules/commands provided by SIAL macros with the help of SIAL library
> and would suitably erase the required data in the dump file. As SIAL
> provides a lot of language constructs like conditional statements,
> logical and arithmetic operators, nested loops, functions etc, it would
> be possible to traverse nested lists and trees and conditionally erase
> data in the dump file, enabling users to literally erase any data in
> the dump file.

Thank you for your explanation.
It seems good to specify rules with SIAL.

If makedumpfile uses SIAL library, I will discard the current format of 
makedumpfile.conf to reduce the size of source code.
What do you think about it ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
