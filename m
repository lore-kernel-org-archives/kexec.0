Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hfrgn-0000ZG-Kn
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 02:06:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: kexec-tools compile problem
References: <BAY114-W15D4C5FD0B852C94E1FD65CE4B0@phx.gbl>
Date: Mon, 23 Apr 2007 00:05:31 -0600
In-Reply-To: <BAY114-W15D4C5FD0B852C94E1FD65CE4B0@phx.gbl> (Aaron Catella's
	message of "Sun, 22 Apr 2007 22:57:07 -0700")
Message-ID: <m1zm4zy6ac.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Aaron Catella <aaroncatella@hotmail.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Aaron Catella <aaroncatella@hotmail.com> writes:

> Mr. Biederman,
>  
> When I attempt to compile the latest kexec-tools on my x86_64, I get the
> following compile-time error:
>  
> mkdir -p /home/rientjes/kexec-tools-testing-20061214/objdir/purgatory/arch/
> x86_64
> gcc -Wall -Os -I/usr/lib/gcc/i486-linux-gnu/4.0.3/include -Ipurgatory/include
> -Ipurgatory/arch/x86_64/include  -I./include -I./util_lib/include -DVERSION=
> '"20061214"' -DRELEASE_DATE='"14th December 2006"' -DPACKAGE=
> '"kexec-tools-testing"' -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\"
> -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\"
> -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1
> -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1
> -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_ZLIB_H=1 -Wall -g
> -fno-strict-aliasing    -ffreestanding    -fno-zero-initialized-in-bss -o /home
> /rientjes/kexec-tools-testing-20061214/objdir/purgatory/arch/x86_64/
> entry64-32.o -c purgatory/arch/x86_64/entry64-32.S
> purgatory/arch/x86_64/entry64-32.S: Assembler messages:
> purgatory/arch/x86_64/entry64-32.S:82: Error: cannot represent relocation type
> BFD_RELOC_64
> make: *** [/home/rientjes/kexec-tools-testing-20061214/objdir/purgatory/arch/
> x86_64/entry64-32.o] Error 1
>
> The only other thing that is irregular is the following message at the end of .
> /configure:
>  
> config.status: WARNING:  Makefile.conf.in seems to ignore the --datarootdir
> setting
>  
> I am using an x86_64 kernel with a mixed 32/64-bit Ubuntu.  I realize it's
> probably a gcc/cross-compiler issue but I'm not proficient enough to diagnose
> it on my own.
>  
> Anything you can suggest would be sincerely appreciated.

Off the top of my head I'm drawing a blank.  Let me bounce this to the list
and see someone else can think of something.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
