Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bay0-omc3-s24.bay0.hotmail.com ([65.54.190.162])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NUUCv-0000hg-He
	for kexec@lists.infradead.org; Tue, 12 Jan 2010 00:02:06 +0000
Message-ID: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>
From: Zitt Zitterkopf <zittware@hotmail.com>
Subject: Problems compiling kexec-tools
Date: Mon, 11 Jan 2010 16:01:59 -0800
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0822835292=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0822835292==
Content-Type: multipart/alternative;
	boundary="_fd755148-f9ca-4563-84e9-2af8d927b3e2_"

--_fd755148-f9ca-4563-84e9-2af8d927b3e2_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


All=2C

I'm attempting to compile kexec-tools so I can compile kboot from source.

=20

I've obtained the kexec-tools-2.0.0 source from RPM.

=20

I've done:

./configure

make

=20

which I receive the following errors:

gcc -lz   -g -O2 -static -fno-strict-aliasing -Wall -Wstrict-prototypes -o =
build/sbin/kexec kexec/kexec.o kexec/ifdown.o kexec/kexec-elf.o kexec/kexec=
-elf-exec.o kexec/kexec-elf-core.o kexec/kexec-elf-rel.o kexec/kexec-elf-bo=
ot.o kexec/kexec-iomem.o kexec/firmware_memmap.o kexec/crashdump.o kexec/cr=
ashdump-xen.o kexec/phys_arch.o kexec/proc_iomem.o kexec/virt_to_phys.o kex=
ec/add_segment.o kexec/add_buffer.o kexec/arch_reuse_initrd.o kexec/arch/i3=
86/kexec-x86.o kexec/arch/i386/kexec-x86-common.o kexec/arch/i386/kexec-elf=
-x86.o kexec/arch/i386/kexec-elf-rel-x86.o kexec/arch/i386/kexec-bzImage.o =
kexec/arch/i386/kexec-multiboot-x86.o kexec/arch/i386/kexec-beoboot-x86.o k=
exec/arch/i386/kexec-nbi.o kexec/arch/i386/x86-linux-setup.o kexec/arch/i38=
6/crashdump-x86.o kexec/purgatory.o libutil.a
kexec/kexec.o: In function `slurp_decompress_file':
/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:485: undefined =
reference to `gzopen'
/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:501: undefined =
reference to `gzread'
/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:506: undefined =
reference to `gzerror'
/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:515: undefined =
reference to `gzclose'
/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:517: undefined =
reference to `gzerror'
/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:487: undefined =
reference to `gzerror'
collect2: ld returned 1 exit status
make: *** [build/sbin/kexec] Error 1


I've installed zlib:

zlib-1.2.3-29.4.moblin2.i586.rpm

zlib-devel-1.2.3-29.4.moblin2.i586.rpm

so I'm unsure what I've done wrong.

=20

Suggestions?

John

=20
 		 	   		  =

--_fd755148-f9ca-4563-84e9-2af8d927b3e2_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
All=2C<BR>
I'm attempting to compile kexec-tools so I can compile kboot from source.<B=
R>
&nbsp=3B<BR>
I've obtained the kexec-tools-2.0.0 source from RPM.<BR>
&nbsp=3B<BR>
I've done:<BR>
./configure<BR>
make<BR>
&nbsp=3B<BR>
which I receive&nbsp=3Bthe following errors:<BR>
gcc -lz&nbsp=3B&nbsp=3B -g -O2 -static -fno-strict-aliasing -Wall -Wstrict-=
prototypes -o build/sbin/kexec kexec/kexec.o kexec/ifdown.o kexec/kexec-elf=
.o kexec/kexec-elf-exec.o kexec/kexec-elf-core.o kexec/kexec-elf-rel.o kexe=
c/kexec-elf-boot.o kexec/kexec-iomem.o kexec/firmware_memmap.o kexec/crashd=
ump.o kexec/crashdump-xen.o kexec/phys_arch.o kexec/proc_iomem.o kexec/virt=
_to_phys.o kexec/add_segment.o kexec/add_buffer.o kexec/arch_reuse_initrd.o=
 kexec/arch/i386/kexec-x86.o kexec/arch/i386/kexec-x86-common.o kexec/arch/=
i386/kexec-elf-x86.o kexec/arch/i386/kexec-elf-rel-x86.o kexec/arch/i386/ke=
xec-bzImage.o kexec/arch/i386/kexec-multiboot-x86.o kexec/arch/i386/kexec-b=
eoboot-x86.o kexec/arch/i386/kexec-nbi.o kexec/arch/i386/x86-linux-setup.o =
kexec/arch/i386/crashdump-x86.o kexec/purgatory.o libutil.a<BR>kexec/kexec.=
o: In function `slurp_decompress_file':<BR>/home/moblin/rpmbuild/BUILD/kexe=
c-tools-2.0.0/kexec/kexec.c:485: undefined reference to `gzopen'<BR>/home/m=
oblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:501: undefined referen=
ce to `gzread'<BR>/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec=
.c:506: undefined reference to `gzerror'<BR>/home/moblin/rpmbuild/BUILD/kex=
ec-tools-2.0.0/kexec/kexec.c:515: undefined reference to `gzclose'<BR>/home=
/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:517: undefined refer=
ence to `gzerror'<BR>/home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/ke=
xec.c:487: undefined reference to `gzerror'<BR>collect2: ld returned 1 exit=
 status<BR>make: *** [build/sbin/kexec] Error 1<BR><BR>
I've installed zlib:<BR>
zlib-1.2.3-29.4.moblin2.i586.rpm<BR>
zlib-devel-1.2.3-29.4.moblin2.i586.rpm<BR>
so I'm unsure what I've done wrong.<BR>
&nbsp=3B<BR>
Suggestions?<BR>
John<BR>
&nbsp=3B<BR> 		 	   		  </body>
</html>=

--_fd755148-f9ca-4563-84e9-2af8d927b3e2_--


--===============0822835292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0822835292==--

