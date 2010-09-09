Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
	helo=TX2EHSOBE004.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OtodF-00016S-JX
	for kexec@lists.infradead.org; Thu, 09 Sep 2010 21:26:10 +0000
Received: from mail155-tx2 (localhost.localdomain [127.0.0.1])	by
	mail155-tx2-R.bigfish.com (Postfix) with ESMTP id 5AD653E0586	for
	<kexec@lists.infradead.org>; Thu,  9 Sep 2010 21:26:06 +0000 (UTC)
Received: from TX2EHSMHS010.bigfish.com (unknown [10.9.14.239])	by
	mail155-tx2.bigfish.com (Postfix) with ESMTP id 63C8AC48063	for
	<kexec@lists.infradead.org>; Thu,  9 Sep 2010 21:25:49 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id
	o89LPlDf009887	for <kexec@lists.infradead.org>; Thu, 9 Sep 2010 14:25:47
	-0700 (MST)
From: Matthew McClintock <msm@freescale.com>
Date: Thu, 9 Sep 2010 16:25:53 -0500
Subject: Optimizations for purgatory
Message-ID: <A0628CD0-7A34-488D-A8C8-D8C12C6E8141@freescale.com>
MIME-Version: 1.0 (Apple Message framework v1081)
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
To: kexec@lists.infradead.org

Hello all,

I've been compiling kexec-tools natively for ppc32 and everything has been working fine. However, I recently had to start cross compiling on an x86_64 box and I ran into an issue with the code generation in purgatory. I can eliminate the my issue by stepping down to (or up?) to -O2 -fno-reorder-blocks. Somehow -freorder-blocks is causing a problem even though according to the gcc documentation -Os disables this flag [1]. If I had to make a guess, I would think that purgatory elf relocatable generated with my compiler is not being properly updated by kexec-tools before being passed to the kernel.

So my question is two-fold...

1) Is there any reason we don't just use -O0 instead of -0s? This would provide a consistent set of compiler optimization flags across all versions of gcc and we don't have to worry about a flag being added or removed across versions. Or perhaps explicitly list all desired flags?

2) Has anyone else experienced issue with purgatory code not being generated correctly? Specifically looking at a disassebly it looks like -freorder-blocks is changed how functions return. On ppc for example it appears that the functions are not returning using the link register and instead are just branching.

Regards,
Matthew

[1] - http://gcc.gnu.org/onlinedocs/gcc-4.4.1/gcc/Optimize-Options.html#Optimize-Options

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
