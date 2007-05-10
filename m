Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kazeon.com ([209.172.74.40] helo=bigfoot.kazeon.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HmGqM-0006Ko-5l
	for kexec@lists.infradead.org; Thu, 10 May 2007 18:10:39 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: kexec and kdb
Date: Thu, 10 May 2007 15:10:16 -0700
Message-ID: <4E022DDAB8F45741914ACD6EDFE2309B041EAD74@BIGFOOT.kazeon.local>
In-Reply-To: <20070510025553.GD30920@verge.net.au>
From: "Preetesh Parekh" <preetesh@kazeon.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

I have a question about kexec and kdb. Please advice or point me to the
right mailing list that can answer this.

I have a linux 2.6.20 kernel (patched with kdb patches) on i686 system.
I have setup a crash kernel using "kexec -p" command which is working
very well. I tested this by triggering a crash by using "echo c >
/proc/sysrq-trigger" command. 

The requirement is to allow kdb to invoke first after the kernel crash
which is not happening now (The system directly gets booted with the
dump kernel). 

Please let me know how to do this. Do we have any patch or steps for it
?

You will get more details about my system below:

# uname -a
Linux mybox 2.6.20smp #1 SMP Mon May 7 11:23:42 PDT 2007 i686 i686 i386
GNU/Linux

# kexec -p /boot/vmlinux-dump --initrd=/boot/initrd-dump.img
--args-linux --append="root=/dev/hda6 init 1 irqpoll maxcpus=1"

# more /proc/sys/kernel/kdb
1

# System Kernel config file:
CONFIG_KEXEC=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_KDB=y
CONFIG_KDB_MODULES=y
# CONFIG_KDB_OFF is not set
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_KDB_USB=y

Thanks
Preetesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
