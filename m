Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]
	helo=VA3EHSOBE010.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R3al4-0000hu-Mp
	for kexec@lists.infradead.org; Tue, 13 Sep 2011 21:43:15 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: vmcore_init() failure using uImage on fsl_booke
Date: Tue, 13 Sep 2011 21:42:55 +0000
Message-ID: <CAEsOVNcbaUH3nEay4qgWv9tU7oSqsBvkAN136m7DVQpqijXT3A@mail.gmail.com>
References: <D58A856745AB5A47B1448181D1A8BBFA0F6195C855@EUSAACMS0701.eamcs.ericsson.se>
In-Reply-To: <D58A856745AB5A47B1448181D1A8BBFA0F6195C855@EUSAACMS0701.eamcs.ericsson.se>
Content-Language: en-US
Content-ID: <AFB3469D42557C41ADFA07ADBAD60E20@freescale.net>
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
To: Dennis Flynn <dennis.flynn@ericsson.com>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Sep 13, 2011 at 4:33 PM, Dennis Flynn <dennis.flynn@ericsson.com> w=
rote:
> Reserved crash kernel memory: crashkernel=3D256M@512

I assume this is 512M?

> Reading 16 bytes from address 0x000000002086E000 within /dev/oldmem
> 00 00 00 00 00 00 00 00
> Warning: Core image elf header not found
> Kdump: vmcore not initialized
>
> Here's the crash kernel bootline showing the elfcorehdr argument passed t=
o the crash kernel.
>
> Kernel command line: irqpoll maxcpus=3D1 reset_devices boot_mode=3Dcrash =
root=3D/dev/nfs =A0nfsroot=3D127.3.252.1:/var/export/hitchhiker-6kn/current=
/rootfs =A0ip=3D127.3.10.1:127.3.252.1:127.3.252.1:255.255.0.0:hitchhiker-6=
kn:eth0:off =A0rbn_net_dev=3Deth0 console=3DttyS0,115200 dump_type=3Dkernel=
 dump_server=3D0.0.0.0 dump_server_port=3D9999 hwether=3Dx board_name=3Dwol=
f_lc slot_number=3D255 =A0elfcorehdr=3D532920K savemaxmem=3D2048M
>
> To help me debug all of this I added some debug prints to the powerpc kex=
ec code (default_machine_kexec()) so I could verify the kernel kimage and m=
emory segment contents. See below.
>
> Bye!
> Calling reboot_code_buffer (vaddr:0xe086f000): page_list=3D0x00000004, re=
boot_code_buffer_phys=3D0x2086f000, start=3D0x2fffa724
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

It appears to have allocated a segment at this address. Can you try
adding debug statements to exec to see the contents of this segment? I
suspect kexec is loading nothing since it does not have an ELF header
to load for the uImage case.

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
