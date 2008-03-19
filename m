Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wf-out-1314.google.com ([209.85.200.173])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JbrQq-0005bx-26
	for kexec@lists.infradead.org; Wed, 19 Mar 2008 06:05:48 +0000
Received: by wf-out-1314.google.com with SMTP id 29so261526wff.24
	for <kexec@lists.infradead.org>; Tue, 18 Mar 2008 23:05:46 -0700 (PDT)
Message-ID: <170fa0d20803182305x3b16f7bt198d767a53553c8e@mail.gmail.com>
Date: Wed, 19 Mar 2008 02:05:46 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
Subject: kexec won't --load-panic a 2.6.22 relocatable kernel?
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

I'm building a x86_64 2.6.22 kernel with the following options set:

CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_RELOCATABLE=y
CONFIG_PHYSICAL_START=0x200000

If I try to load the kernel with the following I get:

./kexec --args-linux -p '--command-line=ro root=LABEL=/1 rhgb quiet
irqpoll maxcpus=1' --initrd=/boot/initrd-2.6.22.19.img
/boot/vmlinuz-2.6.22.19

./kexec: unrecognized option `--args-linux'
kexec-tools-testing 20080318-rc released 18th March 2008
Usage: kexec [OPTION]... [kernel]
...
Cannot load /boot/vmlinuz-2.6.22.19

Now if I remove --args-linux kexec successfully loads the panic kernel
but when I trigger a crash it just loads the kernel and doesn't
actually perform a kdump.  So this proves the relocatable nature of
the kernel is working right?  Its just not passing args as would be
needed to trigger a crash dump?

If I use the same commandline above (--args-linux included) with a
RHEL5U1 kernel kexec will load the panic kernel without problems and
kdump will work when I enduce a crash.

So long story short:  is there some fix that went in upstream after
2.6.22 was released that would enable kexec to load a relocatable
x86_64 kernel with the --args-linux option?  Nothing stands out to me
but I could easily be overlooking something...

Mike

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
