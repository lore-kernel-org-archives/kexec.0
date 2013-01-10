Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtIsQ-00017o-UL
 for kexec@lists.infradead.org; Thu, 10 Jan 2013 14:13:04 +0000
Received: by mail-wg0-f54.google.com with SMTP id fg15so285136wgb.9
 for <kexec@lists.infradead.org>; Thu, 10 Jan 2013 06:13:01 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 10 Jan 2013 19:43:00 +0530
Message-ID: <CAJXQGf+3BNfsByUzU90P+z2vB5zmueDbDfF-fm7MdJZDp92XZg@mail.gmail.com>
Subject: KDUMP on ARM cortex-a15
From: Naresh Bhat <nareshgbhat@gmail.com>
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
Cc: Daniel Mack <zonque@gmail.com>

Hi

I am trying KDUMP feature on ARM Versatile Express Cortex-A15 target.

Target - Daughterboard Site 1: V2P-CA15_A7 Cortex A15
Kernel - git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kexec-tools - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

I have referred the
https://wiki.linaro.org/KenWerner/Sandbox/crash-utility and passed
crashkernel command line argument as below

crashkernel=128M@0x20000000

My command line arguments is bootargs="root=/dev/nfs rw ip=dhcp
console=ttyAMA0,38400n8 nosmp crashkernel=128M@0x20000000"

But the target is got stuck as below

.........
................
Loading: #
done
Bytes transferred = 12141 (2f6d hex)
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-3.8.0-rc3
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2586312 Bytes = 2.5 MiB
   Load Address: fffffff2
   Entry Point:  fffffff2
   Verifying Checksum ... OK
## Flattened Device Tree blob at 81f00000
   Booting using the fdt blob at 0x81f00000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 9fee3000, end 9fee8f6c ... OK

Starting kernel ...


Can anybody please suggest me a proper crashkernel=X@Y ?

-- Thanks and Regards
-Naresh Bhat

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
