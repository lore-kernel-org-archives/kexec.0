Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NXN3O-0006sm-Ux
	for kexec@lists.infradead.org; Tue, 19 Jan 2010 23:00:11 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: powerpc32 support with device tree
Date: Tue, 19 Jan 2010 23:59:40 +0100
Message-Id: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Kumar Gala <galak@kernel.crashing.org>

I've rebased my old patches on top of current kexec-tools tree and added
support for the uImage target. There was no negative feedback the last I
have posted as far I remember.

Now that there is uImage support, there is no need for a wrapper around
the kernel:
 kexec -l uImage --dtb=file.dtb

If the device tree does not contain the current memory size, clocks, mac
address, ... the --reuse-node option can be used in order to set the value
to the "current" value. This value is obtained from /proc/device-tree so
it requires that the kernel exports the device tree.

I'm currently not sure if the --reuse-node option is very convenient to
use. Another way to go would be to suck the complete device tree via /proc
and only update the command line. Any comments on this?

There are two more things sitting on my todo list: SMP support & initrd. 

The patch series is also available in the git repository at:

  git://breakpoint.cc/bigeasy/kexec-tools ppc32


Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
