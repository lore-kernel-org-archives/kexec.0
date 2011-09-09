Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R22C7-0002oL-EX
	for kexec@lists.infradead.org; Fri, 09 Sep 2011 14:36:40 +0000
Received: by eyg24 with SMTP id 24so1908314eyg.30
	for <kexec@lists.infradead.org>; Fri, 09 Sep 2011 07:36:37 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 9 Sep 2011 09:36:37 -0500
Message-ID: <CAGWwFG=OWdnGMib_0RhTfKRcPd8A4P_nkm_EWYBqfuP-11b5VA@mail.gmail.com>
Subject: Kexec on P1020 - "Can't add kernel to addr 0x00000000"
From: john hagen <hjagen@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

I'm trying to make use of kexec on a couple of boards, a P1020rdb and
a custom P1011 board. My first attempts seem to report this "Can't add
kernel to addr 0x00000000". What is kexec trying to tell me? Looking
for a pointer here, thanks.

JH

[root@P1020RDB jlhagen]# cat /proc/cmdline
root=/dev/ram rw crashkernel=128M@32M console=ttyS0,115200 ramdisk_size=600000

[root@P1020RDB jlhagen]# dmesg | grep -i reser
Reserving 128MB of memory at 32MB for crashkernel (System RAM: 512MB)

[root@P1020RDB jlhagen]# ls -al /proc/device-tree/memory/
dr-xr-xr-x    2 root     root            0 Jan  1 00:11 .
dr-xr-xr-x   10 root     root            0 Jan  1 00:11 ..
-r--r--r--    1 root     root            7 Jan  1 00:11 device_type
-r--r--r--    1 root     root            7 Jan  1 00:11 name
-r--r--r--    1 root     root           16 Jan  1 00:11 reg

[root@P1020RDB jlhagen]# ./kexec -t uImage-ppc -l uImage-3.0.3
--dtb=./p1020rdb.dtb
kernel: 0x4802f008 kernel_size: 24bda4
Can't add kernel to addr 0x00000000 len 8182336
Cannot load uImage-3.0.3

[root@P1020RDB jlhagen]# ./kexec -p -t uImage-ppc uImage-3.0.3
kernel: 0x4802f008 kernel_size: 24bda4
Can't add kernel to addr 0x00000000 len 8182336
Cannot load uImage-3.0.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
