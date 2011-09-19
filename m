Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from p02c12o141.mxlogic.net ([208.65.145.74])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R5k9f-0003tI-Qs
	for kexec@lists.infradead.org; Mon, 19 Sep 2011 20:09:28 +0000
From: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Subject: kexec 2.0.2 MIPS
Date: Mon, 19 Sep 2011 20:09:21 +0000
Message-ID: <F9C551623D2CBB4C9488801D14F864C607150A@ex-mb1.corp.adtran.com>
Content-Language: en-US
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "horms@verge.net.au" <horms@verge.net.au>

Attempting to make kexec work for Mips32r2.  2.0.1 works, 2.0.2 doesn't.  Looking through the differences of the arch/mips folders I find that there is a reference to an extern simple_setup_start.  In 2.0.1 this appears to be referencing asm code from the file simple_setup_start.S, however, in 2.0.2 I cannot find the referenced location.

Is this the reason that I cannot get a Linux kernel to boot using 2.0.2 using the same command line as the 2.0.1?

Thanks in advance for any help you can provide,
Andy Kennedy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
