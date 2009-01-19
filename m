Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from adelie.canonical.com ([91.189.90.139])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LP1gU-0003Ow-Ja
	for kexec@lists.infradead.org; Mon, 19 Jan 2009 21:29:29 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1LP1gT-0003vk-EQ
	for <kexec@lists.infradead.org>; Mon, 19 Jan 2009 21:29:25 +0000
Received: from cpe-67-242-211-173.rochester.res.rr.com ([67.242.211.173]
	helo=[192.168.1.200]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <michael.casadevall@canonical.com>)
	id 1LP1gT-0002u3-9u
	for kexec@lists.infradead.org; Mon, 19 Jan 2009 21:29:25 +0000
Message-ID: <4974F0B3.2030501@canonical.com>
Date: Mon, 19 Jan 2009 16:29:23 -0500
From: Michael Casadevall <michael.casadevall@canonical.com>
MIME-Version: 1.0
Subject: kexec on ARM
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

Hello all,
I've recently been working on trying to use kexec on ARM, but I've been
running into some trouble, which may or may not be user error. I'm
simply using kexec to load another kenel and execute it (for my
purposes, I'm not interested in crash kernel support). I have the host
kernel compiled in with kexec support, and I compiled kexec-tools for
ARM. I can load the second kernel with kexec -l, and see it get loaded,
but I just get a hang when I use kexec -e, I just get a hang. Looking at
the printk's, it seems execution leaves the main kernel, and gets into
the relocation stub before dying. On real hardware, it just hangs, but
on QEMU, I get the following dump on the console:

 qemu: fatal: Trying to execute code outside RAM or ROM at 0xc0035460

R00=0f9b6000 R01=000005f8 R02=bf000c12 R03=ceddefc8
R04=0f9b6000 R05=cf9b6000 R06=fee1dead R07=00000000
R08=c002c008 R09=cedaa000 R10=00000000 R11=cedabe6c
R12=00092070 R13=cedabe58 R14=c0030ffc R15=c0035460
PSR=600000d3 -ZC- A svc32
Aborted (core dumped)

[1]+  Exit 134                ./start-arm

I'm hoping this is user error; does the second kernel require something
special such as relocation support? I'm fairly new to kexec so any help
that can be offered would be greatly appreciated.
Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
