Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9kDz-0003EU-0x
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 22:07:00 +0000
Received: by obbta17 with SMTP id ta17so3587686obb.36
 for <kexec@lists.infradead.org>; Thu, 06 Sep 2012 15:06:57 -0700 (PDT)
Date: Thu, 6 Sep 2012 15:06:51 -0700
From: Jerry Snitselaar <dev@snitselaar.org>
Subject: Re: Getting the kexec on panic
Message-ID: <20120906220651.GB1745@cantor.Home>
References: <20120906094336.GJ1943@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120906094336.GJ1943@vicerveza.homeunix.net>
Reply-To: Jerry Snitselaar <dev@snitselaar.org>
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
To: =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
Cc: kexec@lists.infradead.org

On Thu Sep 06 12, Llu=EDs Batlle i Rossell wrote:
> Hello,
> =

> while I can load immediately a kernel using kexec, when I set it for pani=
c and
> crash with sysrq-c, the computer hangs.
> =

> I'm using the nvidia X driver; can it be that it stops the panic handling=
 from
> working? I don't understand why it would work with normal kexec though, i=
f it
> were the case.
> =

> Regards,
> Llu=EDs.

Hi Lluis,


What kernel are you using? The commit 722bc6b "x86/mm: Fix the size calcula=
tion of mapping tables" which started showing up in 3.5-rc1 causes problems=
 for the crash kernel. You might try this patchset[1] from Jacob Shin and s=
ee if it resolves the problem for you if you are experiencing your problem =
on a 3.5-rc1+ kernel.

[1] https://lkml.org/lkml/2012/8/24/474

Regards,
Jerry

> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
