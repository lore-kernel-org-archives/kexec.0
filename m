Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from sandesh.cdotd.ernet.in ([196.1.105.47])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q1xXG-0004Q7-3y
	for kexec@lists.infradead.org; Tue, 22 Mar 2011 09:05:55 +0000
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])
	by sandesh.cdotd.ernet.in (Postfix) with ESMTP id C4B45193C54
	for <kexec@lists.infradead.org>; Tue, 22 Mar 2011 14:03:07 +0530 (IST)
Received: from cdotd.ernet.in (mail1.cdotd.ernet.in [127.0.0.1])
	by mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id p2M8aNnu005702
	for <kexec@lists.infradead.org>; Tue, 22 Mar 2011 14:06:23 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
Subject: KEXEC on Montavista PPC LINUX (2.6.10) with U-BOOT
Date: Tue, 22 Mar 2011 14:06:23 +0530
Message-Id: <20110322083453.M34905@cdotd.ernet.in>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0703143552=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0703143552==
Content-Type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<HTML>
<HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" http-equiv=3DContent-Type>
<META content=3D"OPENWEBMAIL" name=3DGENERATOR>
</HEAD>
<BODY bgColor=3D#ffffff>
Hi All
<br />=20
<br />
I have a MPC8560 based custom board with linux 2.6.10 as OS and U-BOOT as a=
 bootloader.
<br />
The compressed OS and rootfilesytem are combined in one multi image
(ubImgae)and it resides in a flash partition as raw data. Bootloader is
able to load the image, decompress it and execute it . The sytem comes
up properly.
<br />=20
<br />
In order to reduce the bootup time i was planning to use kexec to reboot th=
e OS.  My version of kexec is=20
<br />
./kexec -v
<br />
kexec 1.101 released 15 February 2005
<br />=20
<br />
I tried to load the OS+Rootfile Filesystem (with U-BOOT header) but it gave=
 following output
<br />=20
<br />
 ./kexec -l ./ubImage --append=3D\&quot;`cat /proc/cmdline`\&quot;
<br />
Invalid memory range : (nil) - (nil)
<br />
Could not get memory layout
<br />=20
<br />
My question is
<br />=20
<br />
Does Kexec understand u-boot images ? Or I am missing some parameters
<br />=20
<br />
I searched the Internet forum for this and got the guideline that os
and initrd should be given seperately
(---initrd=3D/boot/vmlinuz-rootfs.img)
<br />=20
<br />
but the kexec does not recognize such an option and its help does not show =
any such option (--initrd)
<br />=20
<br />
# ./kexec --help
<br />
kexec 1.101 released 15 February 2005
<br />
Usage: kexec [OPTION]... [kernel]
<br />
Directly reboot into a new kernel
<br />=20
<br />
 -h, --help           Print this help.
<br />
 -v, --version        Print the version of kexec.
<br />
 -f, --force          Force an immediate kexec, don't call shutdown.
<br />
 -x, --no-ifdown      Don't bring down network interfaces.
<br />
                      (if used, must be last option specified)
<br />
 -l, --load           Load the new kernel into the current kernel.
<br />
 -p, --load-panic     Load the new kernel for use on panic.
<br />
 -u, --unload         Unload the current kexec target kernel.
<br />
 -e, --exec           Execute a currently loaded kernel.
<br />
 -t, --type=3DTYPE      Specify the new kernel is of this type.
<br />
     --mem-min=3D&lt;addr&gt; Specify the lowest memory addres to load code=
 into.
<br />
     --mem-max=3D&lt;addr&gt; Specify the highest memory addres to load cod=
e into.
<br />=20
<br />
Supported kernel file types and options:
<br />
elf-ppc
<br />
    --command-line=3DSTRING Set the kernel command line to STRING.
<br />
    --append=3DSTRING       Set the kernel command line to STRING.
<br />
    --gamecube=3D1|0        Enable/disable support for ELFs with changed
<br />
                          addresses suitable for the GameCube.
<br />
dol-ppc
<br />
-d, --debug               Enable debugging to help spot a failure.
<br />
    --command-line=3DSTRING Set the kernel command line to STRING.
<br />
    --append=3DSTRING       Set the kernel command line to STRING.
<br />
Architecture options:
<br />
the following parameters should be specified:
<br />
        --start-memory-range=3D&lt;addr&gt;
<br />
        --end-memory-range=3D&lt;addr&gt;
<br />=20
<br />
for this reason i was trying with a combined OS and Rootfs image
<br />=20
<br />
my kernel command line is
<br />=20
<br />
# cat /proc/cmdline
<br />
console=3DttyCPM,9600n8 wdt=3D1 ip=3Ddhcp root=3D/dev/ram0 rw crashkernel=
=3D128M@16M
<br />=20
<br />
and I have compiled the kernel with all option related to KEXEC on.
<br />=20
<br />
Please help me in understand the method for using kexec with U-BOOT as a bo=
otloader.  The ARCH is ppc in kernel 2.6.10.=20
<br />=20
<br />
Do i need to use kexec with uncompressed OS image , but as the tool
kexec does not recognize --initrd option, how to inform kexec abt it?
<br />=20
<br />
with regards,
<br />=20
<br />
Deepak Gaur
<br />

</BODY>
</HTML>



--===============0703143552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0703143552==--
