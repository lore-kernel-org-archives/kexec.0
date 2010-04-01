Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NxETb-0005wb-S2
	for kexec@lists.infradead.org; Thu, 01 Apr 2010 07:06:04 +0000
Date: Thu, 1 Apr 2010 09:05:59 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 3/7] powerpc32: pull in libfdt
Message-ID: <20100401070559.GA20047@Chamillionaire.breakpoint.cc>
References: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
	<1270023858-26947-4-git-send-email-sebastian@breakpoint.cc>
	<20100331225819.GC10909@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100331225819.GC10909@verge.net.au>
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
Cc: kexec@lists.infradead.org

* Simon Horman | 2010-04-01 09:58:19 [+1100]:

>Hi,
Hi,

>I'm seeing some signed vs unsigned comparison warnings in this code.
>Here is a stab that I took at fixing them. Do they seem reasonable to you?
All but fdt_create() and fdt_strerror() look fine on the first look. The
two mentioned don't have the .c file updated. fdt_strerror() should
remain unsigned as the error code is negative.

>If so, we could either merge them into your patch or just apply them
>as another patch.
I would prefer leaving it as it. It is an external library and the time
we update it, we lose this changes. If you are going to compile this
with -Werror could you add -Wno-sign-compare for the libfdt part? If not
please apply it as a separate patch and I try to forward it upstream if
you don't.

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
