Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KVaDc-0001bG-Vd
	for kexec@lists.infradead.org; Tue, 19 Aug 2008 23:02:29 +0000
Date: Wed, 20 Aug 2008 09:02:27 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Explicitly use BUILD_CC and TARGET_CC
Message-ID: <20080819230225.GE10528@verge.net.au>
References: <1219030410.884068.167991623519.1.gpush@pingu>
	<20080818071037.GA5029@verge.net.au>
	<200808181519.48759.jk@ozlabs.org>
	<200808192240.16919.jk@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200808192240.16919.jk@ozlabs.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

On Tue, Aug 19, 2008 at 10:40:16PM +0800, Jeremy Kerr wrote:
> 
> > That should be fine: we just add a rule for %.o: %.S
> 
> OK, that's not going to work, because rules of the form
> 
>  list: pattern: prereq
> 
> *require* the prereqs to be build. ie, in our case:
> 
>  $(PURGATORY_OBJS): %.o: %.S
> 
> will require a .S for all .o files in PURGATORY_OBJS. Which is not what 
> we want :(
> 
> So, the solution left would be to override COMPILE.c, COMPILE.S and 
> LINK.o for target and build compiles. For example:
> 
> $(PURGATORY_OBJS): COMPILE.c = $(TARGET_CC) $(TARGET_CFLAGS) \
>                                $(TARGET_CPPFLAGS) -c
> 
> It's unlikely that a user is going to override COMPILE.c on the make 
> command-line :)
> 
> How does that sound?

Sounds fine to me.

Another option is to split up PURGATORY_OBJS and PURGATORY_SRCS based
on wheather the source is a .S or a .c file. Though I suspect your
idea is cleaner.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
