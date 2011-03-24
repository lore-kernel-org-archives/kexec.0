Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pw0-f49.google.com ([209.85.160.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q2YFQ-0003r0-Li
	for kexec@lists.infradead.org; Thu, 24 Mar 2011 00:17:58 +0000
Received: by pwi8 with SMTP id 8so1267691pwi.36
	for <kexec@lists.infradead.org>; Wed, 23 Mar 2011 17:17:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110322083453.M34905@cdotd.ernet.in>
References: <20110322083453.M34905@cdotd.ernet.in>
Date: Wed, 23 Mar 2011 17:17:54 -0700
Message-ID: <AANLkTincRC3upuXNOA7DO4k56RddKm4QbpxZGq8--tuC@mail.gmail.com>
Subject: Re: KEXEC on Montavista PPC LINUX (2.6.10) with U-BOOT
From: Maxim Uvarov <muvarov@gmail.com>
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
To: Deepak Gaur <dgaur@cdotd.ernet.in>
Cc: kexec@lists.infradead.org

Deepack,

it's  better to read docs which came with BSP. If your kernel is
2.6.10 then kexec tools there should be a little bit different with
main line (I synced them later). So probably you need
--start-memory-range=<addr> --end-memory-range=<addr>  to be set. It's
better to ask support if something does not work out of box in your
build. I think people here can't help you because they don't  know
internals of environment  you have (Montavista PPC LINUX).

Maxim.

2011/3/22 Deepak Gaur <dgaur@cdotd.ernet.in>:
> Hi All
>
> I have a MPC8560 based custom board with linux 2.6.10 as OS and U-BOOT as a
> bootloader.
> The compressed OS and rootfilesytem are combined in one multi image
> (ubImgae)and it resides in a flash partition as raw data. Bootloader is able
> to load the image, decompress it and execute it . The sytem comes up
> properly.
>
> In order to reduce the bootup time i was planning to use kexec to reboot the
> OS. My version of kexec is
> ./kexec -v
> kexec 1.101 released 15 February 2005
>
> I tried to load the OS+Rootfile Filesystem (with U-BOOT header) but it gave
> following output
>
> ./kexec -l ./ubImage --append=\"`cat /proc/cmdline`\"
> Invalid memory range : (nil) - (nil)
> Could not get memory layout
>
> My question is
>
> Does Kexec understand u-boot images ? Or I am missing some parameters
>
> I searched the Internet forum for this and got the guideline that os and
> initrd should be given seperately (---initrd=/boot/vmlinuz-rootfs.img)
>
> but the kexec does not recognize such an option and its help does not show
> any such option (--initrd)
>
> # ./kexec --help
> kexec 1.101 released 15 February 2005
> Usage: kexec [OPTION]... [kernel]
> Directly reboot into a new kernel
>
> -h, --help Print this help.
> -v, --version Print the version of kexec.
> -f, --force Force an immediate kexec, don't call shutdown.
> -x, --no-ifdown Don't bring down network interfaces.
> (if used, must be last option specified)
> -l, --load Load the new kernel into the current kernel.
> -p, --load-panic Load the new kernel for use on panic.
> -u, --unload Unload the current kexec target kernel.
> -e, --exec Execute a currently loaded kernel.
> -t, --type=TYPE Specify the new kernel is of this type.
> --mem-min=<addr> Specify the lowest memory addres to load code into.
> --mem-max=<addr> Specify the highest memory addres to load code into.
>
> Supported kernel file types and options:
> elf-ppc
> --command-line=STRING Set the kernel command line to STRING.
> --append=STRING Set the kernel command line to STRING.
> --gamecube=1|0 Enable/disable support for ELFs with changed
> addresses suitable for the GameCube.
> dol-ppc
> -d, --debug Enable debugging to help spot a failure.
> --command-line=STRING Set the kernel command line to STRING.
> --append=STRING Set the kernel command line to STRING.
> Architecture options:
> the following parameters should be specified:
> --start-memory-range=<addr>
> --end-memory-range=<addr>
>
> for this reason i was trying with a combined OS and Rootfs image
>
> my kernel command line is
>
> # cat /proc/cmdline
> console=ttyCPM,9600n8 wdt=1 ip=dhcp root=/dev/ram0 rw crashkernel=128M@16M
>
> and I have compiled the kernel with all option related to KEXEC on.
>
> Please help me in understand the method for using kexec with U-BOOT as a
> bootloader. The ARCH is ppc in kernel 2.6.10.
>
> Do i need to use kexec with uncompressed OS image , but as the tool kexec
> does not recognize --initrd option, how to inform kexec abt it?
>
> with regards,
>
> Deepak Gaur
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>
>



-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
