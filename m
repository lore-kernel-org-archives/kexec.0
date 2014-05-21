Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-x22f.google.com ([2a00:1450:4010:c03::22f])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wn3js-0003QM-M1
 for kexec@lists.infradead.org; Wed, 21 May 2014 10:27:13 +0000
Received: by mail-la0-f47.google.com with SMTP id pn19so1419519lab.34
 for <kexec@lists.infradead.org>; Wed, 21 May 2014 03:26:48 -0700 (PDT)
MIME-Version: 1.0
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Wed, 21 May 2014 12:26:28 +0200
Message-ID: <CAGm1_ksYHbdWLxBUt3QetkmKLF-fegEGgYO=mt3t44ApwEJiMA@mail.gmail.com>
Subject: omap:am335x: unable to start kernel via kexec
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
To: wangnan0@huawei.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, kexec <kexec@lists.infradead.org>

Kernel: vanilla 3.15-rc5
kexec: latest git (21.05.2014)

I can load the zImage + dtb from u-boot, but invoking kexec prints
following data and nothing happens after "Bye!":

# kexec -d -f --dtb=/mnt/boot/am335x-evmsk.dtb /mnt/boot/zImage
kernel: 0xb5eab008 kernel_size: 0x2036c
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb5eab008
segment[0].bufsz = 0x43d328
segment[0].mem   = 0x80008000
segment[0].memsz = 0x43e000
segment[1].buf   = 0x29008
segment[1].bufsz = 0x7e89
segment[1].mem   = 0x810f6000
segment[1].memsz = 0x8000
Starting new kernel
Bye!

u-boot output for the same kernel+dtb:

SD/MMC found on device 0
reading uEnv.txt
582 bytes read in 8 ms (70.3 KiB/s)
Loaded environment from uEnv.txt
Importing environment from mmc ...
Running uenvcmd ...
4444968 bytes read in 466 ms (9.1 MiB/s)
32393 bytes read in 46 ms (687.5 KiB/s)
Kernel image @ 0x82000000 [ 0x000000 - 0x43d328 ]
## Flattened Device Tree blob at 80000000
   Booting using the fdt blob at 0x80000000
   Loading Device Tree to 8f618000, end 8f622e88 ... OK

Wang, what hardware do you use?

Regards,
Yegor

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
