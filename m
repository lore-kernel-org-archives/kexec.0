Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUurv-0006hZ-0F
 for kexec@lists.infradead.org; Fri, 19 Sep 2014 09:52:47 +0000
Date: Fri, 19 Sep 2014 05:52:25 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
In-Reply-To: <145412866.25258463.1411119061796.JavaMail.zimbra@redhat.com>
Subject: [RFC] autokdump - automated kdump testsuite
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, crash-utility <crash-utility@redhat.com>, kexec <kexec@lists.infradead.org>, kexec kdump redhat mailing list <kexec-kdump-list@redhat.com>

I plan to release an automated kdump testsuite that will be
focus on testing kernel and the crash utility. It should work
for all major distros since it will use none of distro-specific
stuff, and also support different arches including x86, ARM,
PPC64 and s390x.

It does the following:
1) check if there is a memory reserved for kdump. If not,
   reserve the memory and reboot the system.
2) once the system is back, load kexec on panic and
   prepare a separate initramfs that including needed
   modules to load a local filesystem and necessary utilities
   in order to analyse /proc/vmcore in the 2nd kernel.
3) trigger the system crash using methods like sysrq-c, NMI,
   and panic_on_hung_task etc.
4) in the 2nd kernel, mount a filesystem and use the crash
   utility to analyse /proc/vmcore. Then, gather the analyse
   logs, serial console output, dmesg etc into the filesystem.
5) reboot back into the 1st kernel.

implementation:
It will setup a daemon to handle reboots.

plan:
I might also to test the makedumpfile all together later.
   CAI Qian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
