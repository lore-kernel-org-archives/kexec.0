Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V563j-0004Oh-49
 for kexec@lists.infradead.org; Fri, 02 Aug 2013 03:29:44 +0000
Date: Fri, 2 Aug 2013 11:29:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: makefumpfile tool to estimate vmcore file size
Message-ID: <20130802032906.GB7653@dhcp-16-252.nay.redhat.com>
References: <51E64EA6.9040209@redhat.com>
 <20130724160640.84e00a3a2e4d811fbdfaa34e@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20130724160640.84e00a3a2e4d811fbdfaa34e@mxc.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Atsushi,

Sorry to reply so late.
By discussing with customer, their idea is below:

*******************************
The idea about a tool like this is that it works in the 1st kernel and
that it will tell you how big the vmcore will be based on what filtering
level and/or compression selected in kdump.conf. Our customer wrote a perl
script to demonstrate this, I have attached it as attachment. This perl
script only looks at uncompressed and dumplevel 31 - in the 1st kernel.
Being told about the dump size when in the 2nd (kdump/kexec kernel) is
somewhat pointless as you are not then in a position to adjust the
destination filesystem to accommodate the vmcore size should you need to.
This is proactively looking at what size is required for a vmcore.

If the kdump.conf says "filter level 11, compress", a tool to estimate
the vmcore size should take that into account, gauge what pages would
be included in that, and roughly what size that would equate to
compressed. The problem is that this is quite dynamic, so the perl
script deliberately only looks at filter level 31 (trying to work the
rest out was too hard for me to do).
**********************************

Per discussion with customer, I think the tool is expected to work in
1st kernel. With configuration file which specify the fileter level and
compression algorithm, a rough vmcore size can be given. Since they
maybe have thousands of servers, an estimated vmcore size can be very
helpful to refer to.

Baoquan
Thanks a lot

On 07/24/13 at 04:06pm, Atsushi Kumagai wrote:
> On Wed, 17 Jul 2013 15:58:30 +0800
> Baoquan <bhe@redhat.com> wrote:
> 
> > #makedumpfile -d31 -c/-l/-p
> > 
> > TYPE			PAGES		INCLUDED
> > 
> > Zero Page		x		no
> > Cache Without Private	x           	no
> > Cache With Private	x		no
> > User Data		x		no
> > Free Page		x		no
> > Kernel Code		x		yes
> > Kernel Data		x		yes
> > 
> > Total Pages on system:			311000  (Just for example)
> > Total Pages included in kdump:		160000  (Just for example)
> > Estimated vmcore file size:		48000  (30% compression ratio)
> > ##########################################################
> 
> Does this image mean that you want to run makedumpfile in 1st
> kernel without generating a actual dumpfile ?
> Unfortunately, makedumpfile can't work in 1st kernel because it
> only supports /proc/vmcore as input data. 
> 
> If you don't persist in doing in 1st kernel, your desire can be
> achieved by modifying print_report() and discarding a output
> data to /dev/null, and running makedumpfile via kdump as usual.
> 
> > By configured dump level, total pages included in kdump can be computed.
> > Then with option which specify a compression algorithm, an estimated
> > vmcore file size can be given. Though the estimated value is changed
> > dynamically with time, it does give user a valuable reference.
> 
> Compression ratio is very dependent on the memory usage.
> So I think it's difficult to estimate the size when any compression
> algorithm is specified.
>  
> 
> Thanks
> Atsushi Kumagai
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

--5G06lTa6Jq83wMTw
Content-Type: application/x-perl
Content-Disposition: attachment; filename="vmcore-size-guess.pl"
Content-Transfer-Encoding: quoted-printable

#!perl -w=0A#=0A# Quickly put together by Anders Rayner-Karlsson <tak@redha=
t.com>=0A# after discussion with Neil Horman in Red Hat Engineering=0A# =0A=
# GPL - Red Hat =C2=A9 2009=0A# =0A# The script simply gives you an estimat=
e of what size your vmcore=0A# would be if you ran "makedumpfile -d31" as y=
our core collector.=0A# If you change *anything* on your running system, th=
e size will=0A# likely have changed. Compression can reduce your vmcore siz=
e even=0A# further, but it depends on what you have in your RAM.=0A#=0A# I =
make no warranties as to the scripts correctness, and it should=0A# simply =
be seen as an educationary tool, nothing more.=0A=0Ause strict;=0Ause warni=
ngs;=0A=0Amy @iomem;=0Amy @slabinfo;=0Amy $memusage=3D0;=0A=0A### grab iome=
m=0Aopen(FH, "< /proc/iomem") or die $!;=0A@iomem =3D <FH>;=0Aclose(FH);=0A=
=0A### grab slabinfo=0Aopen(FH, "< /proc/slabinfo") or die $!;=0A@slabinfo =
=3D <FH>;=0Aclose(FH);=0A=0A### iomem calculation=0A### values are in HEX, =
at least on F11=0A### look for Kernel code/data/bss=0A### todo: work out ho=
w to do this on Xen=0A=0Aforeach ( @iomem ) {=0A	m/ (\w+)-(\w+) : Kernel co=
de/ && do {=0A		my $start =3D hex($1);=0A		my $end   =3D hex($2);=0A		my $d=
iff  =3D $end - $start;=0A		$memusage +=3D $diff;=0A	};=0A	m/ (\w+)-(\w+) :=
 Kernel data/ && do {=0A		my $start =3D hex($1);=0A		my $end   =3D hex($2);=
=0A		my $diff  =3D $end - $start;=0A		$memusage +=3D $diff;=0A	};=0A	m/ (\w=
+)-(\w+) : Kernel bss/ && do {=0A		my $start =3D hex($1);=0A		my $end   =3D=
 hex($2);=0A		my $diff  =3D $end - $start;=0A		$memusage +=3D $diff;=0A	};=
=0A};=0A### iomem done=0A=0A### slabinfo calculation=0A### for now, assume =
column 2 & 3 (index from 0)=0A### todo: check the "header" line and decide =
column there=0A=0Aforeach ( @slabinfo ) {=0A	my @row =3D split(' ', $_);=0A=
=0A	if( $row[2] =3D~ /^(\d+\.?\d*|\.\d+)$/ and $row[3] =3D~ /^(\d+\.?\d*|\.=
\d+)$/ ) {=0A		my $diff =3D $row[2] * $row[3];=0A		$memusage +=3D $diff;=0A=
	};=0A};=0A### slabinfo done=0A=0A### print how many MB (bytes) we use=0Apr=
int "vmcore likely to be " . sprintf("%0.2f", $memusage / 1024**2) . " MB (=
" . $memusage . " bytes)\n";=0A=0A### EOF=0A
--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--5G06lTa6Jq83wMTw--

