Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from na3sys010aog114.obsmtp.com ([74.125.245.96])
 by merlin.infradead.org with smtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RkPQ1-0001Gn-SP
 for kexec@lists.infradead.org; Tue, 10 Jan 2012 00:18:26 +0000
Received: by mail-qy0-f177.google.com with SMTP id c1so3076642qcs.8
 for <kexec@lists.infradead.org>; Mon, 09 Jan 2012 16:18:22 -0800 (PST)
Message-ID: <4F0B83CC.6010007@plexxi.com>
Date: Mon, 09 Jan 2012 19:18:20 -0500
From: Joe Lorenz <joe.lorenz@plexxi.com>
MIME-Version: 1.0
Subject: kexec x86_64 - Unhandled rela relocation: R_X86_64_PLT32
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Help needed, please:

Sandy Bridge.
2.6.27.21 kernel
x86_64 toolchain built from crosstools-ng.
Using relocatable bzImage as first kernel as well as crash kernel.

# cat /proc/cmdline
rw root=/dev/sda3 rootwait console=ttyS0,38400 crashkernel=128M@16M

# kexec -l /boot/bzImage --reuse-cmdline
Unhandled rela relocation: R_X86_64_PLT32

Why??


I fooled around in kexec-elf-rel-x86_64.c and noticed there's no case for that 
r_type, so I added it as a fall-through to one of the existing ones. Then I got 
this:

# kexec -l /boot/bzImage --reuse-cmdline
Unhandled rela relocation: R_X86_64_GOTPCREL

Strange.
So I added that to the fallthrough, and then suddenly it seemed as if the crash 
kernel was getting loaded OK (no error messages anymore).

But then I tried:

# kexec -l /boot/bzImage --reuse-cmdline
# kexec -e
[  952.817842] md: stopping all md devices.
[  953.818808] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  953.961590] igb 0000:02:00.0: PME# enabled
[  953.962395] igb 0000:02:00.0: PME# enabled
[  953.976468] Starting new kernel

After several seconds pause, it ended up back at GRUB, which I didn't expect.

Any help would be most appreciated - thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
