Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pw0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RpwSQ-0006Hl-Dk
 for kexec@lists.infradead.org; Wed, 25 Jan 2012 06:35:47 +0000
Received: by pbdx9 with SMTP id x9so1739813pbd.36
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2012 22:35:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120125023929.GK11038@verge.net.au>
References: <F9C551623D2CBB4C9488801D14F864C607154A@ex-mb1.corp.adtran.com>
 <20110920085133.GE15087@verge.net.au>
 <F9C551623D2CBB4C9488801D14F864C6072473@ex-mb1.corp.adtran.com>
 <20110921112837.GF17108@verge.net.au>
 <F9C551623D2CBB4C9488801D14F864C60E2D98@ex-mb1.corp.adtran.com>
 <20120125023929.GK11038@verge.net.au>
Date: Tue, 24 Jan 2012 22:35:42 -0800
Message-ID: <CAJGZr0LShFy2rcPi4+ywDuavovxRH5jNJuRtQb3PGGzt1mfy_Q@mail.gmail.com>
Subject: Re: kexec 2.0.2 MIPS
From: Maxim Uvarov <muvarov@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Matt Evans <matt@ozlabs.org>

2012/1/24 Simon Horman <horms@verge.net.au>:
> Hi,
>
> sorry for the extensive delay in responding to this.
> I am now back from Christmas, New Year, holidays and
> attending LCA 2012.
>
> On Fri, Dec 16, 2011 at 05:27:31AM +0000, ANDY KENNEDY wrote:
>> Simon/All,
>>
>> After two months, I'm back working on this again. =A0After 3 hours
>> tonight, I have the final result of what you told me to do. =A0Looks lik=
e,
>> based on the comment:
>>
>> =A0 =A0 - remove kexec/arch/mips/mips-setup-simple.S which prepares cmdl=
ine for
>> =A0 =A0 =A0 new kernel, it is better to move this work to kernel code. B=
TW this code was
>> =A0 =A0 =A0 compilable only on o32 because of t4 is not defined on 64-64=
 or n32 MIPS ABIs.
>>
>> The problem is that my 2.6.36.2 apparently doesn't have whatever Maxim
>> is talking about. =A0Therefore, the newer versions must not be backwards
>> compatible. =A0Perhaps this is okay with you guys. =A0If so, I'll just m=
ake
>> sure to include a patch to BuildRoot that clearly states that the v2.0.1
>> is the only version that works with *some* versions of MIPS. =A0If you
>> guys were expecting this to be backwards compatible, I'll gladly work
>> with you to test whatever you need checked out. =A0Just let me know.
>
> It is not apparent to me that the kernel code Maxim makes mention of
> exists in any released kernel. I think that the best option at this
> stage would be to revert that portion of his change.
>
> Maxim, do you have any thoughts on this?
>

Yes, kernel patches were not accepted and looks like stuck linux-mips@
queue forever.
Reverting this patches it ok for me especially if somebody going to
work on them. As I remember
the was problem with supporting all mips ABIs (o32, n32, 32-64). It's
mostly related to asm purgatory
code. It will be nice if somebody can synchronize kernel and user land
parts and make mips kexec code
board independent. I think at this time it should be much easy since
mips supports device tree.

Maxim.

> Andy, could you prepare a patch to do that?
> At the very least it ought to be useful to you.
>
>> There are build errors that I would like (if it hasn't already) to
>> be fixed
>> 1) in purgatory/Makefile, Near line 71
>>
>> $(PURGATORY): LDFLAGS=3D$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --no-undefined -nostartf=
iles -nostdlib -nodefaultlibs \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -e purgatory_start -r
>>
>>
>> The newer gcc's don't like --no-undefined. =A0I think a fix is
>> -Wl,--no-undefined.
>
> Thanks, there is a fix for that in git and 2.0.3.
>
>> 2) In the newer version of the kexec/arch/mips/Makefile, there is
>> a -Werror in the CFLAGS. =A0This causes the build to fail if using a
>> newer version of gcc, as many more warnings are available.
>
> Thanks, there is a fix for that in git and 2.0.3.
>
> Due to some quirks in the kexec build system
> -Werror was effecting all architectures.
>
>> Now, here is the result of the bisect:
>>
>> root@akennedy_lin:~/src/kexec/kexec-tools# git bisect good
>> 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 is the first bad commit
>> commit 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17
>> Author: Maxim Uvarov <muvarov@gmail.com>
>> Date: =A0 Wed Mar 3 14:05:53 2010 +0300
>>
>> =A0 =A0 some kexec MIPS improvements
>>
>> =A0 =A0 - =A0using simple =A0 mips* ) in configure.ac to make it compila=
ble on mips2
>> =A0 =A0 =A0 =A0and mips64
>> =A0 =A0 - remove kexec/arch/mips/mips-setup-simple.S which prepares cmdl=
ine for
>> =A0 =A0 =A0 new kernel, it is better to move this work to kernel code. B=
TW this code was
>> =A0 =A0 =A0 compilable only on o32 because of t4 is not defined on 64-64=
 or n32 MIPS ABIs.
>> =A0 =A0 - simple put cmdline as string, kernel code should catch cmdline=
 like this
>>
>> =A0 =A0 int board_kexec_prepare(struct kimage *image)
>> =A0 =A0 {
>> =A0 =A0 =A0 =A0 int i;
>> =A0 =A0 =A0 =A0 char *bootloader =3D "kexec";
>> =A0 =A0 =A0 =A0 board_boot_desc_ptr->argc =3D 0;
>> =A0 =A0 =A0 =A0 for(i=3D0;i<image->nr_segments;i++)
>> =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 printk("segment %d
>> =A0 =A0 =A0 =A0 =A0 =A0 if (!strncmp(bootloader, (char*)image->segment[i=
].buf,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlen(bootloader)))
>> =A0 =A0 =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* convert command line string to array
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of parameters (as bootloader does).
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int argc =3D 0, offt;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *str =3D (char *)image->segment[i].=
buf;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *ptr =3D strchr(str, ' ');
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ptr && (ARGV_MAX_ARGS > argc)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr =3D '\0';
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ptr[1] !=3D ' ') {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offt =3D (int)(ptr - str=
 + 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boot_desc_ptr->argv[argc=
] =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 image->segment[i=
].mem + offt;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 argc++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr =3D strchr(ptr + 1, ' ');
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boot_desc_ptr->argc =3D argc;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0Keep it as string make code simple and more readable.
>>
>> =A0 =A0 - add crashdump support
>> =A0 =A0 - do not redefine syscalls numbers if they defined in system
>> =A0 =A0 =A0 remove fixups for /proc/iomem. If your board provides wrong =
/proc/iomem please
>> =A0 =A0 =A0 fix kernel, or at least you local version of kexec. No need =
to support it in
>> =A0 =A0 =A0 main line. At least add option --fake-iomem
>> =A0 =A0 - some minor fixes
>>
>> =A0 =A0 Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
>> =A0 =A0 Signed-off-by: Simon Horman <horms@verge.net.au>
>>
>> :100644 100644 a911f8ad03c5321faeba93069924fa79aceeba9c 88d2e0bb2479ecd9=
56d0ec31c571d2472fef7721 M =A0 =A0 =A0configure.ac
>> :040000 040000 4dcef15024daa7ccc62bd6983e127cb87f036c5d 69204c980286b2e0=
8308d4a10eb2bf2775d9d962 M =A0 =A0 =A0kexec
>>
>> Andy
>>
>> > -----Original Message-----
>> > From: ANDY KENNEDY
>> > Sent: Thursday, September 29, 2011 1:07 PM
>> > To: 'Simon Horman'
>> > Cc: kexec@lists.infradead.org; Matt Evans; Maxim Uvarov
>> > Subject: RE: kexec 2.0.2 MIPS
>> >
>> > > My bad, yes the idea is to check between 2.0.1 and 2.0.2.
>> > > I will explain git bisect further down. However, it looking at
>> > the
>> > > logs
>> > > it strikes me that there was only one significant MIPS change
>> > > between
>> > > 2.0.1 and 2.0.2. So that seems like a likely culprit.
>> > >
>> > > Could you try the following?
>> > >
>> > > $ git clone git://github.com/horms/kexec-tools.git
>> > > $ cd kexec-tools
>> > > $ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17^
>> >
>> > Works.
>> >
>> > >
>> > > Build and see if it works. If so could you then try?
>> > >
>> > > $ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17
>> >
>> > Works.
>> >
>> > >
>> > > Build and see if it works. If it does not then
>> > > revision 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 starts to smell
>> > > a lot like the cause of the problem you have observed.
>> > >
>> > >
>> > > Git Bisect
>> > > ----------
>> > >
>> > > A git bisection works by doing a binary search over a set of
>> > > commits
>> > > in order to (hopefully) isolate which commit introduces a
>> > > regression.
>> > >
>> > > To this, the git commands are something along these lines:
>> > >
>> > > $ git clone git://github.com/horms/kexec-tools.git
>> > > $ cd kexec-tools
>> > > $ git checkout v2.0.1
>> >
>> > root@akennedy_lin:~/src/kexec/kexec-tools# git checkout v2.0.1
>> > error: pathspec 'v2.0.1' did not match any file(s) known to git.
>> > (yes, I run as root. =A0Have since 1994, so, please no holy wars.)
>> >
>> > >
>> > > Build and confirm that it does work
>> > >
>> > > $ git checkout v2.0.2
>> > >
>> > > Build and confirm that it does not work.
>> > >
>> > > Now we actually start the bisect
>> > >
>> > > $ git bisect start
>> > > $ git bisect bad v2.0.2
>> > > $ git bisect good v2.0.1
>> > >
>> > > Git should now select a revision between v2.0.1 and v2.0.2
>> > > Test it and see if it works or not. If it does run
>> > >
>> > > $ git bisect good
>> > > If not run
>> > >
>> > > $ git bisect bad
>> > >
>> > > Git will now select another revision for you to test...
>> >
>> > I have some time right now to test, so, when you can get
>> > back to me I'll be able to continue.
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>



-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
