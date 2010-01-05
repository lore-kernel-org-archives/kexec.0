Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NSHTo-0008Vf-03
	for kexec@lists.infradead.org; Tue, 05 Jan 2010 22:02:24 +0000
Date: Wed, 6 Jan 2010 09:02:16 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: Linux kernel crash dumps for ARM
Message-ID: <20100105220216.GA8630@verge.net.au>
References: <EB1A7C66AD0C92419BFFC785A947865A09EA8C9129@BLRINMSMBX01.bglrodc.lntinfotech.com>
	<m17hrx9lgo.fsf@fess.ebiederm.org>
	<20100105084850.GA27860@linux-sh.org>
	<20100105091625.GA19871@verge.net.au>
	<20100105190047.GD30868@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100105190047.GD30868@flint.arm.linux.org.uk>
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
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Venkappa Mala <Venkappa.Mala@lntinfotech.com>, Paul Mundt <lethal@linux-sh.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Jan 05, 2010 at 07:00:47PM +0000, Russell King wrote:
> On Tue, Jan 05, 2010 at 08:16:28PM +1100, Simon Horman wrote:
> > To add to this, my understanding is that kexec support varies across
> > different ARM platforms - that is to say, it works on some and fails on
> > others. While this seems to be slowly improving, I'm also aware of any list
> > of what is supported and what isn't.
> 
> I'm unaware of that; the only area of weakness with kexec that I'm
> aware of is when the ARMv7 processor support didn't implement the
> necessary code to bring the caches/mmu/tlbs into a safe state for
> software-reboot, which is also what's required by kexec.

Ok, I could well be mistaken and its just ARMv7 that has a few issues
at this time.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
