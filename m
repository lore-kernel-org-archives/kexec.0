Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9SmC-0005b3-Bp
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 03:29:08 +0000
Date: Thu, 6 Sep 2012 12:29:02 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Message-ID: <20120906032901.GG6432@verge.net.au>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
 <20120905123850.GA11453@verge.net.au>
 <000001cd8b73$82e6b4f0$88b41ed0$@leach@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000001cd8b73$82e6b4f0$88b41ed0$@leach@arm.com>
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
To: Matthew Leach <matthew.leach@arm.com>
Cc: kexec@lists.infradead.org, Will Deacon <Will.Deacon@arm.com>

Hi Matt,

On Wed, Sep 05, 2012 at 03:34:09PM +0100, Matthew Leach wrote:
> Hi Simon,
> 
> > Hi Matt,
> > 
> > are you aware that I posted patches to add ARM DT support
> > to kexec-tools a few weeks ago?
> 
> Ah, I missed that...
>  
> > I'm not particularly concerned which version goes in,
> > but perhaps we can learn from each others efforts.
> 
> After looking over your patches I propose that I incorporate your
> generic fs2dt code instead of pulling in the dtc.

Thanks. It was that part of the code that I spent the bulk of my time on.
And although it is still has a few rough edges I would be happy for it
to be used.

> Also, I use a
> different segment for the dtb rather than appending it to the
> zImage; I think this approach would be better as it is less
> restrictive, however a kernel patch is required to set r2 to the
> appropriate address on entry to the new kernel. What are your
> thoughts?

I would prefer to avoid requiring kernel changes unless necessary -
the kernels some of the boards I work with require DT since 3.5.
However, I am happy to discuss this further, there certainly is
merit to a clean implementation.

> If you are happy with this I will submit a v2 set of patches.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
