Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9Xxr-0008Co-Eq
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 09:01:32 +0000
Date: Thu, 6 Sep 2012 10:01:28 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Message-ID: <20120906090128.GA858@mudshark.cambridge.arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
 <20120905123850.GA11453@verge.net.au>
 <000001cd8b73$82e6b4f0$88b41ed0$@leach@arm.com>
 <20120906032901.GG6432@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120906032901.GG6432@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Matthew Leach <Matthew.Leach@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi guys,

On Thu, Sep 06, 2012 at 04:29:02AM +0100, Simon Horman wrote:
> On Wed, Sep 05, 2012 at 03:34:09PM +0100, Matthew Leach wrote:
> > Also, I use a
> > different segment for the dtb rather than appending it to the
> > zImage; I think this approach would be better as it is less
> > restrictive, however a kernel patch is required to set r2 to the
> > appropriate address on entry to the new kernel. What are your
> > thoughts?
> 
> I would prefer to avoid requiring kernel changes unless necessary -
> the kernels some of the boards I work with require DT since 3.5.
> However, I am happy to discuss this further, there certainly is
> merit to a clean implementation.

I had a quick look at both the approaches and it looks like Matthew requires
changes to the host kernel (to load the dtb correctly) and Simon requires
changes to the target kernel (to pick up the dtb correctly).

I would personally prefer changing the host, as the target should ideally
have no knowledge about the kexec. Given that kexec has not supported DT on
ARM so far and these patches have no affect on the existing ATAG mechanism,
I don't think there is a problem with making changes to the kernel.

I also wouldn't like to hedge my bets on CONFIG_ARM_APPENDED_DTB staying
around forever -- it's intended as convenience for legacy bootloaders rather
than something that should be used in preference to passing the dtb via r2.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
