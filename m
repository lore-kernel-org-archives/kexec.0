Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www17.your-server.de ([213.133.104.17])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KKVLM-0004zg-10
	for kexec@lists.infradead.org; Sun, 20 Jul 2008 09:36:40 +0000
Subject: Re: linux-next: Tree for July 18: warning at kernel/lockdep.c:2068
	trace_hardirqs_on_caller
From: Thomas Meyer <thomas@m3y3r.de>
In-Reply-To: <1216544462.9311.20.camel@nimitz>
References: <20080718195352.e562a00f.sfr@canb.auug.org.au>
	<200807190928.33978.m.kozlowski@tuxland.pl>
	<19f34abd0807190255x304173d4wf2bfabb2d5bce511@mail.gmail.com>
	<19f34abd0807190559y2fe5ebf9h7095793e82de3122@mail.gmail.com>
	<20080719221723.GB5578@suse.de>
	<19f34abd0807191527u61c5ed61kffe2279c8d46915d@mail.gmail.com>
	<19f34abd0807191544nfd73be5nf7dde4b61992a7e8@mail.gmail.com>
	<20080719225817.GA6264@suse.de>
	<19f34abd0807191611y7cabf405iad307ba79591e04f@mail.gmail.com>
	<1216544462.9311.20.camel@nimitz>
Date: Sun, 20 Jul 2008 11:35:46 +0200
Message-Id: <1216546546.3217.0.camel@dhcppc2>
Mime-Version: 1.0
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
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Vegard Nossum <vegard.nossum@gmail.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Greg KH <gregkh@suse.de>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@redhat.com>

Am Sonntag, den 20.07.2008, 02:01 -0700 schrieb Dave Hansen:
> On Sun, 2008-07-20 at 01:11 +0200, Vegard Nossum wrote:
> > Maybe the firmware memmap code can simply run a little later in the
> > boot sequence?
> 
> Heh, I'm catching up on this thread...
> 

On that thread?

http://lkml.org/lkml/2008/7/15/108




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
