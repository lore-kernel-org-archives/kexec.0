Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIlLr-0007R9-86
	for kexec@lists.infradead.org; Mon, 22 Jun 2009 15:22:38 +0000
Received: by gxk7 with SMTP id 7so4961970gxk.18
	for <kexec@lists.infradead.org>; Mon, 22 Jun 2009 08:22:30 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 22 Jun 2009 23:22:29 +0800
Message-ID: <e997b7420906220822w354dbafdo34126535500626d1@mail.gmail.com>
Subject: kexec ,instruction error in misc_32.s
From: "wilbur.chan" <wilbur512@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0029609772=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0029609772==
Content-Type: multipart/alternative; boundary=00163630efc9406d86046cf17152

--00163630efc9406d86046cf17152
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

powerpc 8541 ,kernel 2.6.21.7



In  misc_32.s, when executed "rif "  instruction ,  the kernel went wrong
because of the
invalid instruction address.

So , I changed r4 into virtual address(not physical address), this programm
can go on ,
however , there seemed to be some

kernel overflow oops  in  page copying process in misc_32.s, causing  kernel
's termination.




here are my steps,(r4 is physical address)

# kexec -l uImage --devtree=your.fdt.dtb --devtree_addr=0x800000
   Image Name:   Linux-2.6.21.7
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1190265 Bytes =    Load Address: 00000000
   Entry Point:  00000000

# kexec -e
Starting new kernel
virtual address: cfc09000
physical address: fc09000
calling function: reboot_code(page_list=0xfc08002,
reboot_code_buffer_phys=0xfc09000, image
->start=0x0,image->segment[1].mem=0x800000)

Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x0fc09028




Please help. thank you very much.


regards,

--00163630efc9406d86046cf17152
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>powerpc 8541 ,kernel 2.6.21.7<br>=A0<br>=A0<br>=A0<br>In=A0 misc_32.s, w=
hen executed &quot;rif &quot;=A0 instruction ,=A0 the kernel went wrong=A0 =
because of the <br>invalid instruction address.<br>=A0<br>So , I changed r4=
 into virtual address(not physical address), this programm can go on , <br>
however , there seemed to be some <br>=A0<br>kernel overflow oops=A0 in=A0 =
page copying process in misc_32.s, causing=A0 kernel &#39;s termination.<br=
>=A0<br>=A0<br>=A0<br>=A0<br>here are my steps,(r4 is physical address)<br>=
=A0<br># kexec -l uImage --devtree=3Dyour.fdt.dtb --devtree_addr=3D0x800000=
<br>
=A0=A0 Image Name:=A0=A0 Linux-2.6.21.7<br>=A0=A0 Image Type:=A0=A0 PowerPC=
 Linux Kernel Image (gzip compressed)<br>=A0=A0 Data Size:=A0=A0=A0 1190265=
 Bytes =3D=A0=A0=A0 Load Address: 00000000<br>=A0=A0 Entry Point:=A0 000000=
00</p>
<p># kexec -e<br>Starting new kernel<br>virtual address: cfc09000<br>physic=
al address: fc09000<br>calling function: reboot_code(page_list=3D0xfc08002,=
 reboot_code_buffer_phys=3D0xfc09000, image<br>-&gt;start=3D0x0,image-&gt;s=
egment[1].mem=3D0x800000)<br>
=A0<br>Unable to handle kernel paging request for instruction fetch<br>Faul=
ting instruction address: 0x0fc09028<br>=A0<br>=A0<br>=A0</p>
<p>Please help. thank you very much.<br>=A0<br>=A0<br>regards,</p>

--00163630efc9406d86046cf17152--


--===============0029609772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0029609772==--

