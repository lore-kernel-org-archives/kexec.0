Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwA6R-0000l6-1V
 for kexec@lists.infradead.org; Thu, 06 Apr 2017 16:17:44 +0000
Received: by mail-qk0-x233.google.com with SMTP id p68so16368467qke.1
 for <kexec@lists.infradead.org>; Thu, 06 Apr 2017 09:17:21 -0700 (PDT)
MIME-Version: 1.0
From: Kristian Kielhofner <kris@kriskinc.com>
Date: Thu, 6 Apr 2017 11:17:00 -0500
Message-ID: <CAKDfjgcvs=OQrBSXB=u9uYgo6y0vOE62+XmhObqON0z9TR3DoQ@mail.gmail.com>
Subject: Kexec on ARM - memory detection
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

Hello,

  I'm trying to use kexec on ARM. I'm using LEDE 17.01 with their
ipq806x target on various boards of this type.

  I've followed many threads and a bit on the history of kexec on ARM
because I'm running into a strange problem:

root@LEDE:/tmp# kexec -d -t uImage --dtb=C2600-uImage.dtb
--command-line="" -l C2600-uImage
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on C2600-uImage of 65536 bytes failed
kernel: 0xb6d27010 kernel_size: 0x1eb76e
MEMORY RANGES
00012028b6d27010-bea6aee700000004 (0)
zImage header: 0x016f2818 0x00000000 0x001e5cd0
zImage size 0x1e5cd0, file size 0x1eb72e
Could not find a free area of memory of 0x1edcd0 bytes...
Cannot load C2600-uImage
root@LEDE:/tmp# cat /proc/iomem
00108000-00108fff : /soc/rpm@108000
00700000-00700fff : /soc/qfprom@700000
00800000-00803fff : /soc/pinmux@800000
00900000-00903fff : /soc/clock-controller@900000
02011000-02011fff : /soc/clock-controller@2011000
02088000-02088fff : /soc/clock-controller@2088000
0208a000-0208a0ff : /soc/timer@200a000
02098000-02098fff : /soc/clock-controller@2098000
08000000-081fffff : ath
10000000-10007fff : /soc/usb30@1/dwc3@10000000
  10000000-10007fff : /soc/usb30@1/dwc3@10000000
1000c100-1000ccff : /soc/usb30@1/dwc3@10000000
100f8800-100f882f : /soc/phy@100f8800
100f8830-100f885f : /soc/phy@100f8830
11000000-11007fff : /soc/usb30@0/dwc3@11000000
  11000000-11007fff : /soc/usb30@0/dwc3@11000000
1100c100-1100ccff : /soc/usb30@0/dwc3@11000000
110f8800-110f882f : /soc/phy@110f8800
110f8830-110f885f : /soc/phy@110f8830
16300000-163000ff : /soc/gsbi@16300000
16340000-16340fff : msm_serial
18300000-183fffff : /soc/dma@18300000
1a200000-1a2000ff : /soc/gsbi@1a200000
1a280000-1a280fff : /soc/gsbi@1a200000/spi@1a280000
1a500000-1a5001ff : /soc/rng@1a500000
1b500000-1b500fff : dbi
1b502000-1b50207f : elbi
1b600000-1b6000ff : parf
1b700000-1b700fff : dbi
1b702000-1b70207f : elbi
1b800000-1b8000ff : parf
2e000000-2e1fffff : ath
37200000-373fffff : /soc/ethernet@37200000
37400000-375fffff : /soc/ethernet@37400000
42000000-5fffffff : System RAM
  42208000-4278de77 : Kernel code
  427c4000-4283ab77 : Kernel data
root@LEDE:/tmp# uname -a
Linux LEDE 4.4.53 #0 SMP Fri Mar 17 12:56:58 2017 armv7l GNU/Linux
root@LEDE:/tmp#

  I've tried every possible combination of uImage/zImage (with and
without initramfs, etc) and always end up with the same error. I've
compiled my own LEDE 17.01 image with the following LEDE options
enabled:

grep -i kexec .config
CONFIG_KERNEL_KEXEC=y
CONFIG_PACKAGE_kexec-tools=y
CONFIG_KEXEC_TOOLS_kdump=y
CONFIG_KEXEC_ZLIB=y
CONFIG_KEXEC_LZMA=y

  I've also updated my local build to use kexec-tools-2.0.14 but
always the same result. What else should I be looking at?

Thanks!

-- 
Kristian Kielhofner

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
