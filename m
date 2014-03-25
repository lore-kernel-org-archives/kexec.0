Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qc0-x232.google.com ([2607:f8b0:400d:c01::232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSSNg-0006pq-Fp
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 14:31:09 +0000
Received: by mail-qc0-f178.google.com with SMTP id i8so628869qcq.23
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 07:30:45 -0700 (PDT)
Received: from brickies-eth0.mosers.us (d14-69-66-169.try.wideopenwest.com.
 [69.14.169.66])
 by mx.google.com with ESMTPSA id f2sm32709366qaa.28.2014.03.25.07.30.44
 for <kexec@lists.infradead.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Mar 2014 07:30:45 -0700 (PDT)
Date: Tue, 25 Mar 2014 10:30:43 -0400 (EDT)
From: Scott Moser <smoser@ubuntu.com>
Subject: cannot seem to load multiboot images
Message-ID: <alpine.DEB.2.02.1403251023480.4659@brickies>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

kexec explictly (in --help and man page) reports to support multiboot
format images. That doesn't work for at least some subset of seemingly
proper multiboot images. For some context, the goal essentially the same
as discussed at [1].

Has anyone seen this work?  I've just checked with git at current tip
(401e037e5e9527134c594b8923342a69ff38b7cb) and see the same problem.

mbchk is from 'multiboot' package (built from source).

Also note that 'qemu-system-x86_64' loads this multiboot image properly
with 'qemu-system-x86_64 -kernel'

$ dpkg-query --show kexec-tools
kexec-tools 1:2.0.4-1ubuntu1

$ mbchk /boot/grub/i386-pc/core.img
/boot/grub/i386-pc/core.img: The Multiboot header is found at the offset
2416.
/boot/grub/i386-pc/core.img: Page alignment is turned off.
/boot/grub/i386-pc/core.img: Memory information is turned off.
/boot/grub/i386-pc/core.img: Address fields is turned on.
/boot/grub/i386-pc/core.img: All checks passed.

$ sudo ./build.out/sbin/kexec --debug --type multiboot-x86
/boot/grub/i386-pc/core.img
kernel: 0xe19010 kernel_size: 0x6315
MEMORY RANGES
0000000000000100-000000000009f000 (0)
000000000009f000-00000000000a0000 (1)
00000000000e7000-0000000000100000 (1)
0000000000100000-00000000bf760000 (0)
00000000bf76e000-00000000bf770000 (1)
00000000bf770000-00000000bf77e000 (2)
00000000bf77e000-00000000bf7d0000 (3)
00000000bf7d0000-00000000bf7e0000 (1)
00000000bf7ec000-00000000c0000000 (1)
00000000e0000000-00000000f0000000 (1)
00000000fee00000-00000000fee01000 (1)
00000000ffc00000-0000000100000000 (1)
0000000100000000-0000000c40000000 (0)
Cannot determine the file type of /boot/grub/i386-pc/core.img


$ kexec --debug --type multiboot-x86 /boot/grub/i386-pc/core.img
kernel: 0x1767010 kernel_size: 6315
MEMORY RANGES
0000000000000100-000000000009f000 (0)
000000000009f000-00000000000a0000 (1)
00000000000e7000-0000000000100000 (1)
0000000000100000-00000000bf760000 (0)
00000000bf76e000-00000000bf770000 (1)
00000000bf770000-00000000bf77e000 (2)
00000000bf77e000-00000000bf7d0000 (3)
00000000bf7d0000-00000000bf7e0000 (1)
00000000bf7ec000-00000000c0000000 (1)
00000000e0000000-00000000f0000000 (1)
00000000fee00000-00000000fee01000 (1)
00000000ffc00000-0000000100000000 (1)
0000000100000000-0000000c40000000 (0)
Cannot determine the file type of /boot/grub/i386-pc/core.img


Note, I also
  I filed an ubuntu bug at http://pad.lv/1297316 .

https://bugs.launchpad.net/ubuntu/+source/kexec-tools/+bug/1297316


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
