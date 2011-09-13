Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]
	helo=ch1outboundpool.messaging.microsoft.com)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R3ZLB-0007IP-PO
	for kexec@lists.infradead.org; Tue, 13 Sep 2011 20:12:22 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: Kexec on P1020 - "Can't add kernel to addr 0x00000000"
Date: Tue, 13 Sep 2011 20:10:04 +0000
Message-ID: <CAEsOVNd2+VKXNUYmTat7hhKA4w=01pq-ZAzt742=AMKLSLu5kQ@mail.gmail.com>
References: <CAGWwFG=OWdnGMib_0RhTfKRcPd8A4P_nkm_EWYBqfuP-11b5VA@mail.gmail.com>
In-Reply-To: <CAGWwFG=OWdnGMib_0RhTfKRcPd8A4P_nkm_EWYBqfuP-11b5VA@mail.gmail.com>
Content-Language: en-US
Content-ID: <4539AEF270C59A479944A226876E1AE7@freescale.net>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: john hagen <hjagen@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, Sep 9, 2011 at 9:36 AM, john hagen <hjagen@gmail.com> wrote:
> Hello,
>
> I'm trying to make use of kexec on a couple of boards, a P1020rdb and
> a custom P1011 board. My first attempts seem to report this "Can't add
> kernel to addr 0x00000000". What is kexec trying to tell me? Looking
> for a pointer here, thanks.
>
> JH
>
> [root@P1020RDB jlhagen]# cat /proc/cmdline
> root=3D/dev/ram rw crashkernel=3D128M@32M console=3DttyS0,115200 ramdisk_=
size=3D600000
>
> [root@P1020RDB jlhagen]# dmesg | grep -i reser
> Reserving 128MB of memory at 32MB for crashkernel (System RAM: 512MB)
>
> [root@P1020RDB jlhagen]# ls -al /proc/device-tree/memory/
> dr-xr-xr-x =A0 =A02 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 0=
0:11 .
> dr-xr-xr-x =A0 10 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A00 Jan =A01 00:=
11 ..
> -r--r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A07 Jan =A01 0=
0:11 device_type
> -r--r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 =A07 Jan =A01 0=
0:11 name
> -r--r--r-- =A0 =A01 root =A0 =A0 root =A0 =A0 =A0 =A0 =A0 16 Jan =A01 00:=
11 reg
>
> [root@P1020RDB jlhagen]# ./kexec -t uImage-ppc -l uImage-3.0.3
> --dtb=3D./p1020rdb.dtb
> kernel: 0x4802f008 kernel_size: 24bda4
> Can't add kernel to addr 0x00000000 len 8182336
> Cannot load uImage-3.0.3

This seems wrong since if you are just kexec'ing it does not matter
what the load address is. Something else is setting an overlapping
region that is conflicting or there is an issue. Can you try with a
vmlinuxx or recompile with DEBUG?

> [root@P1020RDB jlhagen]# ./kexec -p -t uImage-ppc uImage-3.0.3
> kernel: 0x4802f008 kernel_size: 24bda4
> Can't add kernel to addr 0x00000000 len 8182336
> Cannot load uImage-3.0.3

You uImage has a hard coded address of 0x0 for the kernel image. It's
saying I can't load the kexec kernel here since it's not in your
crashkernel memory region. Did you run a custom mkimage to modify the
load/entry address of your kexec uImage for kdump?

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
