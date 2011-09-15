Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R4AWJ-00020n-2b
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 11:54:20 +0000
From: Dennis Flynn <dennis.flynn@ericsson.com>
Date: Thu, 15 Sep 2011 07:54:05 -0400
Subject: RE: vmcore_init() failure using uImage on fsl_booke
Message-ID: <D58A856745AB5A47B1448181D1A8BBFA0F6195D0FD@EUSAACMS0701.eamcs.ericsson.se>
References: <D58A856745AB5A47B1448181D1A8BBFA0F6195C855@EUSAACMS0701.eamcs.ericsson.se>
	<CAEsOVNcbaUH3nEay4qgWv9tU7oSqsBvkAN136m7DVQpqijXT3A@mail.gmail.com>
In-Reply-To: <CAEsOVNcbaUH3nEay4qgWv9tU7oSqsBvkAN136m7DVQpqijXT3A@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: McClintock Matthew-B29882 <B29882@freescale.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>


> I assume this is 512M?
Yes, 512M.
 =

> It appears to have allocated a segment at this address. Can you try addin=
g debug statements to exec to see the contents of this segment? I suspect k=
exec is loading nothing since it does not have an ELF header to load for th=
e uImage case.

I added code to default_machine_kexec() to ioremap the segment[2].mem physi=
cal address and then use print_hex_dump() to dump the contents of this segm=
ent. Looks like the ELF header signature is present. Just not visible via /=
dev/oldmem from the crash kernel?


ioremap vaddr 0xe086e000 --> paddr 0x2086e000 (size=3D1000)
e086e000: 7f454c46 01020100 00000000 00000000  .ELF............
e086e010: 00040014 00000001 00000000 00000034  ...............4
e086e020: 00000000 00000000 00340020 00050000  .........4. ....
e086e030: 00000000 00000004 0189221c 00000000  ..........".....
e086e040: 0189221c 00000400 00000400 00000000  ..".............
e086e050: 00000000 00000004 00866df8 00000000  ..........m.....
e086e060: 00866df8 00001000 00001000 00000000  ..m.............
e086e070: 00000000 00000001 2085e000 c0000000  ........ .......
e086e080: 00000000 00010000 00010000 00000007  ................
e086e090: 00000000 00000001 00010000 c0010000  ................
e086e0a0: 00010000 1fff0000 1fff0000 00000007  ................
e086e0b0: 00000000 00000001 30000000 ffffffff  ........0.......
e086e0c0: 30000000 50000000 50000000 00000007  0...P...P.......
e086e0d0: 00000000 00000000 00000000 00000000  ................

[ remaining zero-filled locations deleted ]

Dennis

-----Original Message-----
From: McClintock Matthew-B29882 [mailto:B29882@freescale.com] =

Sent: Tuesday, September 13, 2011 5:43 PM
To: Dennis Flynn
Cc: kexec@lists.infradead.org; McClintock Matthew-B29882
Subject: Re: vmcore_init() failure using uImage on fsl_booke

On Tue, Sep 13, 2011 at 4:33 PM, Dennis Flynn <dennis.flynn@ericsson.com> w=
rote:
> Reserved crash kernel memory: crashkernel=3D256M@512

I assume this is 512M?

> Reading 16 bytes from address 0x000000002086E000 within /dev/oldmem 00 =

> 00 00 00 00 00 00 00
> Warning: Core image elf header not found
> Kdump: vmcore not initialized
>
> Here's the crash kernel bootline showing the elfcorehdr argument passed t=
o the crash kernel.
>
> Kernel command line: irqpoll maxcpus=3D1 reset_devices boot_mode=3Dcrash =

> root=3D/dev/nfs =A0
> nfsroot=3D127.3.252.1:/var/export/hitchhiker-6kn/current/rootfs =A0
> ip=3D127.3.10.1:127.3.252.1:127.3.252.1:255.255.0.0:hitchhiker-6kn:eth0:
> off =A0rbn_net_dev=3Deth0 console=3DttyS0,115200 dump_type=3Dkernel =

> dump_server=3D0.0.0.0 dump_server_port=3D9999 hwether=3Dx board_name=3Dwo=
lf_lc =

> slot_number=3D255 =A0elfcorehdr=3D532920K savemaxmem=3D2048M
>
> To help me debug all of this I added some debug prints to the powerpc kex=
ec code (default_machine_kexec()) so I could verify the kernel kimage and m=
emory segment contents. See below.
>
> Bye!
> Calling reboot_code_buffer (vaddr:0xe086f000): page_list=3D0x00000004, =

> reboot_code_buffer_phys=3D0x2086f000, start=3D0x2fffa724
>
> Dumping kimage @ 0xdfbdf800
> =A0head: 0x00000004
> =A0entry: 0xdfbdf800
> =A0last_entry: 0xdfbdf800
> =A0destination: 0x00000000
> =A0start: 0x2fffa724
> =A0control_code_page: 0xc0c97de0
> =A0swap_page: 0x =A0(null)
> =A0control_page: 0x2086ffff
> =A0type: 0x00000001
> =A0preserve_context: 0x00000000
> nr_segments =3D 5
> segment[0].buf =A0 =3D 48831008
> segment[0].bufsz =3D 75d640
> segment[0].mem =A0 =3D 0x20000000
> segment[0].memsz =3D 85e000
> segment[1].buf =A0 =3D 1007d988
> segment[1].bufsz =3D 10000
> segment[1].mem =A0 =3D 0x2085e000
> segment[1].memsz =3D 10000
> segment[2].buf =A0 =3D 1007d350
> segment[2].bufsz =3D 400
> segment[2].mem =A0 =3D 0x2086e000
> segment[2].memsz =3D 1000

It appears to have allocated a segment at this address. Can you try adding =
debug statements to exec to see the contents of this segment? I suspect kex=
ec is loading nothing since it does not have an ELF header to load for the =
uImage case.

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
