Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGYOF-00040u-6A
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 17:26:00 +0000
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 17:23:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B3521B0805F
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 17:25:51 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2FHPf4551118290
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 17:25:41 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2FHPoJ2013106
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 11:25:50 -0600
Date: Fri, 15 Mar 2013 18:25:49 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/s390: Replace clgfi with cghi
Message-ID: <20130315182549.652495c3@holzheu>
In-Reply-To: <20130315155732.GF16561@verge.net.au>
References: <20130315134632.1177a239@holzheu>
 <20130315155732.GF16561@verge.net.au>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hello Simon,

From the "Principles of Operations" (the s390 bible):

The first operand is compared with the second operand, and the result
is indicated in the condition code.

For COMPARE LOGICAL IMMEDIATE (CLGFI), the first operand is treated as
64 bits, and the second operand is treated as 32 bits with 32 zeros
appended on the left.

This instruction works with 32 bit immediate values.

For COMPARE HALFWORD IMMEDIATE (CGHI), the first operand is treated as
a 64-bit signed binary integer.

This instruction works only with 16 bit immediate values.

See:

http://pic.dhe.ibm.com/infocenter/ratdevz/v8r0/topic/com.ibm.tpf.toolkit.hlasm.doc/dz9zr006.pdf

Because I only want to check against zero the two instructions will
have the same effect in the purgatory code.

Michael


On Fri, 15 Mar 2013 16:57:33 +0100
Simon Horman <horms@verge.net.au> wrote:

> On Fri, Mar 15, 2013 at 01:46:32PM +0100, Michael Holzheu wrote:
> > The clgfi instruction needs at least z9 machine level. To allow
> > kexec-tools compiled also with z900, this patch replaces clgfi with
> > the older cghi instruction.
> 
> Hi,
> 
> could you update the changelog to include a brief description of the
> difference between the two instructions - I assume they work the same
> way in the context of this change.
> 
> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > ---
> >  purgatory/arch/s390/setup-s390.S |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: kexec-tools-2.0.3/purgatory/arch/s390/setup-s390.S
> > ===================================================================
> > --- kexec-tools-2.0.3.orig/purgatory/arch/s390/setup-s390.S
> > +++ kexec-tools-2.0.3/purgatory/arch/s390/setup-s390.S
> > @@ -16,7 +16,7 @@ purgatory_start:
> >  	larl	%r15,lstack_end
> >  	aghi	%r15,-160
> >  
> > -	clgfi	%r2,0
> > +	cghi	%r2,0
> >  	je	verify_checksums
> >  
> >  	brasl	%r14,purgatory
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
