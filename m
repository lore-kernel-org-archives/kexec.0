Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vwp2514.webpack.hosteurope.de ([2a01:488:42:1000:57e6:2a18::])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TcBbb-0008DU-Pb
 for kexec@lists.infradead.org; Sat, 24 Nov 2012 09:00:56 +0000
Message-ID: <1353747642.6515.16.camel@bender>
Subject: kexec 2.0.4-rc1 won't work on an ARM kernel without device-tree
From: Sven Neumann <s.neumann@raumfeld.com>
Date: Sat, 24 Nov 2012 10:00:42 +0100
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

Hi,

I am trying to use kexec-2.0.4-rc1 on an ARM device running Linux 3.0.4.
This old kernel does obviously not have device-tree support. Here's the
error message I get:

# uname -a
Linux speaker 3.0.4 #1 PREEMPT Fri Nov 23 09:15:39 CET 2012 armv5tel GNU/Linux

# kexec --append="console=ttyS0,115200 root=ubi0:RootFS rootfstype=ubifs rw ubi.mtd=3" /boot/uImage --force
unrecoverable error: could not scan "/proc/device-tree/": No such file or directory


Looks like the release candidate depends on the very latest kernel
features and won't work on older kernels? Is that intentional?


Regards,
Sven

-- 
Sven Neumann <s.neumann@raumfeld.com>
Raumfeld by Teufel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
