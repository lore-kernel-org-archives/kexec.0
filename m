Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]
 helo=co1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxNu7-0001SI-Sf
 for kexec@lists.infradead.org; Thu, 11 Jul 2013 20:55:56 +0000
Message-ID: <51DF1BBB.5060904@mail.usask.ca>
Date: Thu, 11 Jul 2013 14:55:23 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
Subject: visible memory seems wrong in kexec crash dump kernel
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

Hi,

I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system with 8GB of memory.  (It's an embedded system and I can't do much about the fact that it's using older software.)

I booted the original kernel with "crashkernel=224M@32M" in the boot args.  I then loaded the crash kernel with:

./kexec -p vmlinux.kontron.strip --append="root=/dev/mtdblock0 rw rootfstype=jffs2 panic=5 1 maxcpus=1 noirqdistrib reset_devices"

Then I triggered a crash:

echo 1 > /proc/sys/kernel/sysrq
echo c > /proc/sysrq-trigger


When the crash kernel came up, it had "elfcorehdr=48392K savemaxmem=8192M" in the kernel boot args, and "free" showed the system as having 7908652 KB of total memory instead of the expected 224MB.

Do I need to manually specify some options to kexec in order to preserve the memory of the original system?  I seem to recall that kexec did this automatically on x86 systems.

Thanks,
Chris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
