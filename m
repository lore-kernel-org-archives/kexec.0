Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www.tglx.de ([62.245.132.106])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OCq2y-0004vo-FW
	for kexec@lists.infradead.org; Fri, 14 May 2010 08:15:05 +0000
Message-ID: <4BED067F.9000902@linutronix.de>
Date: Fri, 14 May 2010 10:14:55 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
Subject: Re: kexec powerpc booke
References: <AANLkTikSH5inonuS6b1n_ZEmQLYoGN0Py0L_RMBEdwJS@mail.gmail.com>
In-Reply-To: <AANLkTikSH5inonuS6b1n_ZEmQLYoGN0Py0L_RMBEdwJS@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

Maxim Uvarov wrote:
> Sebastian,
Maxim,

> I saw you did a lot of work for powerpc booke boards. What is the 
> current status of your patches?
They worked the last time I checked on v31. Userland is useable however
you have to tweak the dtb file. Recently I hacked kexec-tools so they can
suck the dtb from /proc/device-tree while I've been traveling but I had no
time to test it. Ah and initrd support as well.

> Will they be included to main line?
I hope so. I fixed what Kumar did not like in the last version. As far as
I know, he had no time review it.

> 
> As I understand 8572 board has to work with  your kernel:
> 
> http://git.breakpoint.cc/cgi-bin/gitweb.cgi?p=bigeasy/linux.git;a=shortlog;h=refs/heads/kexec_booke

Not really. 8572 is SMP and SMP is not supported at the moment. The plan 
for SMP was
- pin userland to the boot cpu
- halt the other cpu in kernel during kexec
- the what we do right now
- use the ipic to reset the cpu and bring it back to virgin state.

That was only the plan I made. Halt the CPU means spin I think so you
should respect the "reserved region" in dtb.

> I tried this kernel and result is hang after "Bye!".  Which kexec-tools 
> is suitable for your kernel? Can you please throw them to me?

[0] is what I used last time I checked and Simon merged it. So it should
work. I try to rebase the kernel to v33 and see if it got broken somehow.
Maybe I should merge console support so it is easier to debug. The plan
here was to set the uart type & address into the purgatory code from what
we know from the dtb. However I have no idea how to set the MMU mapping
for it.

> I posted the patch, which make 83xx classic powerpc work (not booke). 
> Both kexec and kdump. Now I want to do booke boards workable.
> That's why I need to know how things are now.  What is already done and 
> what is needed.

I'm supprised that the UP part is not working. I look at it. I post the 
proc/dtb-suck-in patches once they are tested. I could push it to my pubic 
git tree if you want to look at them. SMP support is missing and I haven't
looked at kdump at all.

[0] 
http://git.breakpoint.cc/cgi-bin/gitweb.cgi?p=bigeasy/kexec-tools.git;a=shortlog;h=refs/heads/ppc32

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
