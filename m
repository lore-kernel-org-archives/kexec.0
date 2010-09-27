Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]
	helo=VA3EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P0G2n-0004h8-Ex
	for kexec@lists.infradead.org; Mon, 27 Sep 2010 15:55:10 +0000
Subject: Re: Can't kexec/kdump on mpc85xx
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <4C9FFA9E.4080705@miraclelinux.com>
Date: Mon, 27 Sep 2010 10:55:14 -0500
Message-ID: <81FA9276-7283-4106-9155-83F17327D496@freescale.com>
References: <4C9FFA9E.4080705@miraclelinux.com>
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
To: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
Cc: kexec@lists.infradead.org


On Sep 26, 2010, at 8:59 PM, Makito SHIOKAWA wrote:

> 
> Is there any operation mistakes, or is something not ready on current
> kernel/kexec-tools?

Actually, it looks like you did everything correct. I've never tested on a mpc8548 but it should work. 

> Not just kexec, I need to make kdump work on the custom board, but currently
> CONFIG_CRASH_DUMP, CONFIG_PROC_VMCORE aren't settable on MPC8548. Is there any
> plan to make these options settable, or what kind of work I need to do if I
> implement by myself?

I would focus on kexec -e first and you don't need those two options. I suspect those two things should work but I would have to look and see why they are not selectable.

> 
> I would appreciate any help to this.
> Thanks,
> 

First off, what SHA of the kernel are you using? It looks like 2.6.35 should have the patches you need, but I want to double check. Also, how did you compile kexec-tools? Cross compile? What compiler are you using? 

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
