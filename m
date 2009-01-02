Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LIopw-00031Q-Ql
	for kexec@lists.infradead.org; Fri, 02 Jan 2009 18:33:36 +0000
In-Reply-To: <20090102140842.GA24775@in.ibm.com>
References: <20090102140842.GA24775@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <b9c5b5d9e58e64de3b8459f477acacc5@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] ppc64: Support for relocatable kernel in kexec-tools
Date: Fri, 2 Jan 2009 12:39:50 -0600
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
To: mohan@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org


On Jan 2, 2009, at 8:08 AM, M. Mohan Kumar wrote:

> Support for relocatable kernel in kexec-tools
>
> This patch is based on the  patch sent by Milton Miller with the 
> subject [PATCH 1/2
>  kexec-tools] ppc64: new relocatble kernel activation ABI
>
> http://patchwork.ozlabs.org/patch/5378/
>
> Even with the above patch, the relocatable kernel always move to 
> physical
> address 0 (ie PHYSICAL_START). Following patch fixes this problem by 
> marking
> a local variable to 1 in purgatory during kdump kernel load time 
> (kexec -p).
> After a crash, purgatory sets __run_at_load variable location in the 
> kernel
> to 1 if the local variable is set to 1. So that the kernel will be 
> running
> as a relocatable kernel.
>
> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
> Signed-off-by: Milton Miller <miltonm@bga.com>

your sign-off should have been after mine as you were making changes to 
my patch.

I actually completed my own testing last night with a slightly 
different version:

(1) I unconditionally store the purgatory value to the kernel (less 
maintence if we decide to define further flags in the future).

(2) I use less registers in asm (no need for r18)

(3) I renamed the variable in the c code to be my_run_at_load to be 
more consistent  with the other names.

Also, I have some cleanup patches on top of this one.  I'm in the 
process of setting up a new email client to send my patches, so it will 
be a few hours yet until I get them posted.  But I would appreciate 
waiting for my series so I don't have to rediff the later patches.

thanks,
milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
