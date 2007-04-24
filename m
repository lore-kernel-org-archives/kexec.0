Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HgFMJ-00063N-Mm
	for kexec@lists.infradead.org; Tue, 24 Apr 2007 03:23:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
References: <m1ircghb6w.fsf@ebiederm.dsl.xmission.com>
	<20070331232957.e1c93f19.akpm@linux-foundation.org>
	<20070402074159.GA13704@in.ibm.com>
	<m1abxrf9o3.fsf@ebiederm.dsl.xmission.com>
	<20070402094520.GC13704@in.ibm.com>
	<m1648eg01d.fsf@ebiederm.dsl.xmission.com>
	<20070403040152.GA5108@in.ibm.com>
	<m1zm5qc9q2.fsf@ebiederm.dsl.xmission.com>
	<20070403100349.GA21759@in.ibm.com>
	<m18xcjznbm.fsf_-_@ebiederm.dsl.xmission.com>
	<20070424063139.GA22742@in.ibm.com>
Date: Tue, 24 Apr 2007 01:21:03 -0600
In-Reply-To: <20070424063139.GA22742@in.ibm.com> (Vivek Goyal's message of
	"Tue, 24 Apr 2007 12:01:40 +0530")
Message-ID: <m1vefmtezk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1974638538=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>

--===============1974638538==
Content-Type: text/plain; charset=macintosh
Content-Transfer-Encoding: quoted-printable

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Sun, Apr 22, 2007 at 11:12:13PM -0600, Eric W. Biederman wrote:
>>=20
>> Currently because vmlinux does not reflect that the kernel is relocatable
>> we still have to support CONFIG_PHYSICAL_START.  So this patch adds a sm=
all
>> c program to do what we cannot do with a linker script, set the elf head=
er
>> type to ET_DYN.
>>=20
>> This should remove the last obstacle to removing CONFIG_PHYSICAL_START
>> on x86_64.
>>=20
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> [Dropping fastboot mailing list from CC as kexec mailing list is new list
>  for this discussion]
>
> [..]
>> +void file_open(const char *name)
>> +{
>> +	if ((fd =3D open(name, O_RDWR, 0)) < 0)
>> +		die("Unable to open `%s': %m", name);
>> +}
>> +
>> +static void mketrel(void)
>> +{
>> +	unsigned char e_type[2];
>> +	if (read(fd, &e_ident, sizeof(e_ident)) !=3D sizeof(e_ident))
>> +		die("Cannot read ELF header: %s\n", strerror(errno));
>> +
>> +	if (memcmp(e_ident, ELFMAG, 4) !=3D 0)
>> +		die("No ELF magic\n");
>> +
>> +	if ((e_ident[EI_CLASS] !=3D ELFCLASS64) &&
>> +	    (e_ident[EI_CLASS] !=3D ELFCLASS32))
>> +		die("Unrecognized ELF class: %x\n", e_ident[EI_CLASS]);
>> +=09
>> +	if ((e_ident[EI_DATA] !=3D ELFDATA2LSB) &&
>> +	    (e_ident[EI_DATA] !=3D ELFDATA2MSB))
>> +		die("Unrecognized ELF data encoding: %x\n", e_ident[EI_DATA]);
>> +
>> +	if (e_ident[EI_VERSION] !=3D EV_CURRENT)
>> +		die("Unknown ELF version: %d\n", e_ident[EI_VERSION]);
>> +
>> +	if (e_ident[EI_DATA] =3D=3D ELFDATA2LSB) {
>> +		e_type[0] =3D ET_REL & 0xff;
>> +		e_type[1] =3D ET_REL >> 8;
>> +	} else {
>> +		e_type[1] =3D ET_REL & 0xff;
>> +		e_type[0] =3D ET_REL >> 8;
>> +	}
>
> Hi Eric,
>
> Should this be ET_REL or ET_DYN? kexec refuses to load this vmlinux
> as it does not find it to be executable type.

Doh.  It should be ET_DYN.  I had relocatable much to much on the brain,
and so I stuffed in the wrong type.

> I am not well versed with various conventions but if I go through "Execut=
able
> and Linking Format" document, this is what it says about various file typ=
es.
>
> =A5 A relocatable file holds code and data suitable for linking with other
>   object files to create an executable or a shared object file.
>
> =A5 An executable file holds a program suitable for execution.
>
> =A5 A shared object file holds code and data suitable for linking in two
>   contexts. First, the link editor may process it with other relocatable =
and
>   shared object files to create another object file. Second, the dynamic
>   linker combines it with an executable file and other shared objects
>   to create a process image.
>
> So above does not seem to fit in the ET_REL type. We can't relink this
> vmlinux? And it does not seem to fit in ET_DYN definition too. We are
> not relinking this vmlinux with another executable or other relocatable
> files.
>
> I remember once you mentioned the term dynamic executable which can be
> loaded at a non-compiled address and let run without requiring any
> relocation processing. This vmlinux will fall in that category but can't=
=20
> relate it to standard elf file definitions.

Sorry about that.=20=20

ET_DYN without a PT_DYNAMIC segment, without a PT_INTERP segment,
and with a valid entry point is exactly that.  Loaders never perform
relocation processing on a ET_DYN executable but they are allowed to
shift all of the addresses by a single delta so long as all of the
alignment restrictions are honored.

Relocation processing when it happens comes from the dynamic linker,
which is set in PT_INTERP and the dynamic linker looks a PT_DYNAMIC
to figure out what relocations are available for processing.

The basic issue is that ld don't really comprehend what we are doing
since we are building a position independent executable in a way
that the normal tools don't allow, so we have to poke the header.

If we had compiled with -fPIC we could have specified -pie or
--pic-executable to ld and it would have done the right thing.
But as it is our executable only changes physical addresses and
not virtual addresses something completely foreign to ld.

Eric


--===============1974638538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1974638538==--
