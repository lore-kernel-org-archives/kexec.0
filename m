Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TNcgl-00034L-Ep
 for kexec@lists.infradead.org; Mon, 15 Oct 2012 04:54:06 +0000
Date: Mon, 15 Oct 2012 13:46:50 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/7] makedumpfile security key filtering with eppic
Message-Id: <20121015134650.9be8ae8a4a0af9869c7aedf5@mxc.nes.nec.co.jp>
In-Reply-To: <5077AAAD.9060400@linux.vnet.ibm.com>
References: <20120606095709.12534.63967.stgit@aravinda>
 <20120611174432.114cdead.kumagai-atsushi@mxc.nes.nec.co.jp>
 <502C9273.30504@linux.vnet.ibm.com>
 <20120817131637.804c9194d21e7e44133f63f9@mxc.nes.nec.co.jp>
 <5077AAAD.9060400@linux.vnet.ibm.com>
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
To: mahesh@linux.vnet.ibm.com
Cc: aravinda@linux.vnet.ibm.com, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, ananth@in.ibm.com, buendgen@de.ibm.com

Hello Mahesh,

On Fri, 12 Oct 2012 10:59:17 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 08/17/2012 09:46 AM, Atsushi Kumagai wrote:
> > Hello Aravinda,
> > 
> > On Thu, 16 Aug 2012 11:55:55 +0530
> > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> > 
> >> Hello Kumagai-san,
> >>
> >> Did you get a chance to review the makedumpfile security key enhancement
> >> patches?
> >>
> >> - Aravinda
> > 
> > Sorry for not responding.
> > 
> > I'm afraid that I can't start to review them yet.
> > I've been working on the cyclic mode feature for a few months,
> > and I'm now preparing the next release including the feature.
> > 
> > I'll release the next version soon, I'll review your patches after that.
> > 
> 
> Hi Atsushi,
> 
> Did you get chance to review these patches?

I'm sorry for keeping you waiting.
I have just started reviewing these patches, I have a comment for them.

These patches require all users to prepare libeppic, but I think 
it's not good implementation because everyone has to build libeppic
from the source code themselves, it isn't desirable for the users who
don't need to use this feature.

So, I hope to change them to optional like LZO and snappy compression.
Is it possible ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
