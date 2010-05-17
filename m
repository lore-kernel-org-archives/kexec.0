Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OE57h-0005n9-Cd
	for kexec@lists.infradead.org; Mon, 17 May 2010 18:33:06 +0000
Date: Mon, 17 May 2010 20:32:59 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: kexec powerpc booke
Message-ID: <20100517183259.GA30249@Chamillionaire.breakpoint.cc>
References: <AANLkTikSH5inonuS6b1n_ZEmQLYoGN0Py0L_RMBEdwJS@mail.gmail.com>
	<4BED067F.9000902@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BED067F.9000902@linutronix.de>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

* Sebastian Andrzej Siewior | 2010-05-14 10:14:55 [+0200]:

>Maxim Uvarov wrote:
>>Sebastian,
>Maxim,
>
>>I tried this kernel and result is hang after "Bye!".  Which
>>kexec-tools is suitable for your kernel? Can you please throw them
>>to me?
Please look into branch kexec_v6_v33-rc7 or kexec_v6 at [0] gitweb [1].
The problem with v5 was that it never hit the mailing list as it was my
internal testing which did not work as expected. v6 got published as
v4 on the mailing list. Sorry for that.

>>I posted the patch, which make 83xx classic powerpc work (not
>>booke). Both kexec and kdump. Now I want to do booke boards
>>workable.
>>That's why I need to know how things are now.  What is already done
>>and what is needed.

I had a brief look at it. It looks like you pulled the dtb scanning tree
from ppc64. Could that be?
At [2] in ppc32 branch is my current statenincluding ramdisk support.
ppc32_hacking has dtb suckin code from /proc with libfdt support. The
whole think basically works however later during the init of the serial
line the box hangs. I haven't figured what is going wrong, maybe the
order is important. The interrupt numbers mach on the other hand :)

I pulled in libfdt because I gives nicer dtb handling than what ppc64
has. I did not have much more time I could spent on it so the auto-dtb
code is not complete.


[0] git://git.breakpoint.cc/bigeasy/linux.git
[1] http://git.breakpoint.cc/cgi-bin/gitweb.cgi?p=bigeasy/linux.git;a=shortlog;h=refs/heads/kexec_v6
[2] http://git.breakpoint.cc/cgi-bin/gitweb.cgi?p=bigeasy/kexec-tools.git

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
