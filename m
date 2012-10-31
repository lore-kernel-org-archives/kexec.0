Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TTPsN-0001G2-2b
 for kexec@lists.infradead.org; Wed, 31 Oct 2012 04:26:01 +0000
Date: Wed, 31 Oct 2012 13:21:07 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/7] makedumpfile security key filtering with eppic
Message-Id: <20121031132107.efaa63ab20b1060fbaf740c5@mxc.nes.nec.co.jp>
In-Reply-To: <508E5749.7050408@linux.vnet.ibm.com>
References: <20120606095709.12534.63967.stgit@aravinda>
 <20121029170641.40b19d2ba2635804dbf8eb31@mxc.nes.nec.co.jp>
 <508E5749.7050408@linux.vnet.ibm.com>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, buendgen@de.ibm.com

Hello Aravinda,

On Mon, 29 Oct 2012 15:45:37 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> Hi Atsushi,
> 
> Thanks for reviewing. I will work on your comments.
> 
> On 2012-10-29 13:36, Atsushi Kumagai wrote:
> 
> > Hello Aravinda,
> > 
> > Now, I have reviewed your patches to [PATCH 4/7], 
> > so please give me a little more time.
> >
> 
> 
> sure...

I've finished reviewing your patches completely. 
Some errors are found by checkpatch.pl, so please check and fix each patches.

  $ <linux kernel source>/scripts/checkpatch.pl <your patch>

So, could you post the v2 patches which include my comments above and
in other threads ?

> > BTW, do you have any test case for this feature ?
> > If you can give it to me, it's very helpful.
> >
> 
> 
> I have developed few semi-automated tests. I will automate it completely
> and mail it to you in 2-3 days.
> 

Thanks, I'm waiting for it.


Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
