Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic5PJ-0004aP-RA
 for kexec@lists.infradead.org; Tue, 03 Dec 2019 10:27:51 +0000
Received: by mail-wm1-x32a.google.com with SMTP id g206so2381544wme.1
 for <kexec@lists.infradead.org>; Tue, 03 Dec 2019 02:27:48 -0800 (PST)
MIME-Version: 1.0
From: Khouloud Touil <ktouil@baylibre.com>
Date: Tue, 3 Dec 2019 11:27:36 +0100
Message-ID: <CALL1Z1xngzUT3bGQCargLDBSHvjZNWrgFuQOK2jpwoLLkvS+RQ@mail.gmail.com>
Subject: Using kexec for rpi-4-b
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
To: kexec@lists.infradead.org
Cc: Corentin Labbe <clabbe@baylibre.com>

Hello,

I am trying to boot another kernel for rpi4, using a kexec tools,
The kernel booted already, is compiled with KEXEC=y,
using the official sources for rpi (4.19.86-v8+)
The rootfs generated with debootstarp for arch 64
The command I am trying to execute is:
kexec -l /boot/Image --dtb=/boot/bcm2711-rpi-4-b.dtb --ramdisk=/boot/rootfs.cpio
-- reuse-cmdline
this doesn't work and the logs are:
[    99.107018] Can't kexec: CPUs are stuck in the kernel.
kexec_load failed: Device or resource busy
entry      = 0x3d9d690 flags = 0xb70000
nr_segments = 4
segment[0].buf = 0x7f84316010
segment[0].bufsz = 0x1951a99
segment[0].mem = 0x80000
segment[0].memsz = 0x19ca000
segment[1].buf = 0x7f81fc9010
segment[1.bufsz = 0x234c800
segment[1].mem = 0x1a4a000
segment[1].memsz = 0x234d000
segment[2].buf = 0x5597abe9b0
segment[2].bufsz = 0x521b
segment[2].mem = 3d97000
segment[2].memsz = 0x6000
segment[3].buf = 0x5597ac4030
segment[3].bufsz = 0x3458
segment[3].mem = 0x3d9d000
segment[3].memsz =  0x4000

Could someone please help to figure out what's the problem ?

Regards,

Khouloud

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
