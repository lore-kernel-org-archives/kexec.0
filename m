Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZzDW-0008Uz-2S
 for kexec@lists.infradead.org; Thu, 31 May 2012 06:50:43 +0000
Received: by dadm1 with SMTP id m1so989225dad.36
 for <kexec@lists.infradead.org>; Wed, 30 May 2012 23:50:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120531135358.c1fc797f.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120531135358.c1fc797f.kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 31 May 2012 10:50:39 +0400
Message-ID: <CAJGZr0LSC3GKKTSDm9zH4YiY3V3B27O1t0v7YQWNho_Q+s3msw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] makedumpfile: cyclic processing to keep memory
 consumption.
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5940723426544595948=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

--===============5940723426544595948==
Content-Type: multipart/alternative; boundary=e89a8ff1cc405cab5704c14f7c56

--e89a8ff1cc405cab5704c14f7c56
Content-Type: text/plain; charset=ISO-8859-1

Atsushi,

do you have speed measurements for saving vmcore with this patches and
without them?
How much is speed up?

Thanks,
Maxim.

2012/5/31 Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

> Hello,
>
> I made the prototype of cyclic processing to keep memory consumption.
> I attache the patch set based on v1.4.4, I would like to get your advice.
>
> Introduction:
>
>  - The basic idea of cyclic processing is represented as below.
>  - cyclic processing doesn't use temporary bitmap file, store partial
> bitmap data
>   in memory only for each cycle instead.
>  - The prototype only support compressed kdump format.
>  - The prototype worked for almost kernel version except some kernel
> disabled PAE
>   in my environment.
>
> Basic idea (HATAYAMA-san wrote):
>
>   +------------------------------------------+
>   |    main header (struct disk_dump_header) |
>   |------------------------------------------+
>   |    sub header (struct kdump_sub_header)  |
>   |------------------------------------------+
>   |                                          | <-- 1st cycle
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |            1st-bitmap                    | <-- 2nd cycle
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |                                          | <-- 3rd cycle
>   |------------------------------------------+
>   |                                          | <-- 1st cycle
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |            2nd-bitmap                    | <-- 2nd cycle
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |                                          | <-- 3rd cycle
>   |------------------------------------------+
>   |                                          | <-- 1st cycle
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |            page header                   | <-- 2nd cycle
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |                                          | <-- 3rd cycle
>   |------------------------------------------|
>   |                                          |
>   |            page data                     | <-- 1st cycle
>   |                                          |
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |            page data                     | <-- 2nd cycle
>   | -  -  -  -  -  -  -  -  -  -  -  -  -  - |
>   |                                          |
>   |                                          |
>   |            page data                     | <-- 3rd cycle
>   |                                          |
>   |                                          |
>   +------------------------------------------+
>
>
> How to use:
>
>  Specify 'K' option, then makedumpfile works cyclically.
>
> Example:
>
>  a. normal processing:
>
>    $ makedumpfile -cd31 vmcore testdump.cd31
>    Copying data                       : [100 %]
>
>    The dumpfile is saved to testdump.cd31.
>
>    makedumpfile Completed.
>
>  b. cyclic processing (too many messages will be displayed):
>
>    $ makedumpfile -Kcd31 vmcore testdump.Kcd31
>    Copying data                       : [  5 %]
>    Excluding free pages               : [100 %]
>    ...
>    Excluding free pages               : [100 %]
>    Copying data                       : [100 %]
>
>    The dumpfile is saved to testdump.Kcd31.
>
>    makedumpfile Completed.
>
>  c. compare each dumpfiles:
>
>    $ cmp testdump.cd31 testdump.Kcd31
>    $
>
> TODO:
>
>  - Optimize code for performance.
>   (e.g. initialize for compression is done every cycle, it's a waste.)
>  - Support ELF format.
>  - Consider suitable size of target region.
>  - Fix some messages.
>  - And something noticed by you.
>
>
> Thanks
> Atsushi Kumagai
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



-- 
Best regards,
Maxim Uvarov

--e89a8ff1cc405cab5704c14f7c56
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Atsushi,<br><br>do you have speed measurements for saving vmcore with this =
patches and without them?<br>How much is speed up?<br><br>Thanks,<br>Maxim.=
<br><br><div class=3D"gmail_quote">2012/5/31 Atsushi Kumagai <span dir=3D"l=
tr">&lt;<a href=3D"mailto:kumagai-atsushi@mxc.nes.nec.co.jp" target=3D"_bla=
nk">kumagai-atsushi@mxc.nes.nec.co.jp</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hello,<br>
<br>
I made the prototype of cyclic processing to keep memory consumption.<br>
I attache the patch set based on v1.4.4, I would like to get your advice.<b=
r>
<br>
Introduction:<br>
<br>
=A0- The basic idea of cyclic processing is represented as below.<br>
=A0- cyclic processing doesn&#39;t use temporary bitmap file, store partial=
 bitmap data<br>
 =A0 in memory only for each cycle instead.<br>
=A0- The prototype only support compressed kdump format.<br>
=A0- The prototype worked for almost kernel version except some kernel disa=
bled PAE<br>
 =A0 in my environment.<br>
<br>
Basic idea (HATAYAMA-san wrote):<br>
<br>
 =A0 +------------------------------------------+<br>
 =A0 | =A0 =A0main header (struct disk_dump_header) |<br>
 =A0 |------------------------------------------+<br>
 =A0 | =A0 =A0sub header (struct kdump_sub_header) =A0|<br>
 =A0 |------------------------------------------+<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| &lt;-- 1st cycle<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A01st-bitmap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| &lt;-- 2nd cycle<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| &lt;-- 3rd cycle<br>
 =A0 |------------------------------------------+<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| &lt;-- 1st cycle<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A02nd-bitmap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| &lt;-- 2nd cycle<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| &lt;-- 3rd cycle<br>
 =A0 |------------------------------------------+<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| &lt;-- 1st cycle<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0page header =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | &lt;-- 2nd cycle<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| &lt;-- 3rd cycle<br>
 =A0 |------------------------------------------|<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0|<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0page data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | &lt;-- 1st cycle<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0|<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0page data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | &lt;-- 2nd cycle<br>
 =A0 | - =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- =A0- |=
<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0|<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0|<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0page data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | &lt;-- 3rd cycle<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0|<br>
 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0|<br>
 =A0 +------------------------------------------+<br>
<br>
<br>
How to use:<br>
<br>
 =A0Specify &#39;K&#39; option, then makedumpfile works cyclically.<br>
<br>
Example:<br>
<br>
 =A0a. normal processing:<br>
<br>
 =A0 =A0$ makedumpfile -cd31 vmcore testdump.cd31<br>
 =A0 =A0Copying data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [100 %]<=
br>
<br>
 =A0 =A0The dumpfile is saved to testdump.cd31.<br>
<br>
 =A0 =A0makedumpfile Completed.<br>
<br>
 =A0b. cyclic processing (too many messages will be displayed):<br>
<br>
 =A0 =A0$ makedumpfile -Kcd31 vmcore testdump.Kcd31<br>
 =A0 =A0Copying data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [ =A05 %=
]<br>
 =A0 =A0Excluding free pages =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [100 %]<br>
 =A0 =A0...<br>
 =A0 =A0Excluding free pages =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [100 %]<br>
 =A0 =A0Copying data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [100 %]<=
br>
<br>
 =A0 =A0The dumpfile is saved to testdump.Kcd31.<br>
<br>
 =A0 =A0makedumpfile Completed.<br>
<br>
 =A0c. compare each dumpfiles:<br>
<br>
 =A0 =A0$ cmp testdump.cd31 testdump.Kcd31<br>
 =A0 =A0$<br>
<br>
TODO:<br>
<br>
=A0- Optimize code for performance.<br>
 =A0 (e.g. initialize for compression is done every cycle, it&#39;s a waste=
.)<br>
=A0- Support ELF format.<br>
=A0- Consider suitable size of target region.<br>
=A0- Fix some messages.<br>
=A0- And something noticed by you.<br>
<br>
<br>
Thanks<br>
Atsushi Kumagai<br>
<br>
_______________________________________________<br>
kexec mailing list<br>
<a href=3D"mailto:kexec@lists.infradead.org">kexec@lists.infradead.org</a><=
br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/kexec" target=3D"_bl=
ank">http://lists.infradead.org/mailman/listinfo/kexec</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Best regards,<br>Maxim =
Uvarov<br>

--e89a8ff1cc405cab5704c14f7c56--


--===============5940723426544595948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5940723426544595948==--

