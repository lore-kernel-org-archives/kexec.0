Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9h8B-0005Bu-Jb
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 18:48:48 +0000
Received: by lagu2 with SMTP id u2so1297298lag.36
 for <kexec@lists.infradead.org>; Thu, 06 Sep 2012 11:48:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120906094336.GJ1943@vicerveza.homeunix.net>
References: <20120906094336.GJ1943@vicerveza.homeunix.net>
Date: Thu, 6 Sep 2012 21:48:43 +0300
Message-ID: <CAEnQRZCL--p6jB2H6gN7=sPHCnpQaDpJgu0RuHHDmX89hGhWmw@mail.gmail.com>
Subject: Re: Getting the kexec on panic
From: Daniel Baluta <daniel.baluta@gmail.com>
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
To: =?ISO-8859-1?Q?Llu=EDs_Batlle_i_Rossell?= <viric@viric.name>
Cc: kexec@lists.infradead.org

On Thu, Sep 6, 2012 at 12:43 PM, Llu=EDs Batlle i Rossell
<viric@viric.name> wrote:
> Hello,
>
> while I can load immediately a kernel using kexec, when I set it for pani=
c and
> crash with sysrq-c, the computer hangs.
>
> I'm using the nvidia X driver; can it be that it stops the panic handling=
 from
> working? I don't understand why it would work with normal kexec though, i=
f it
> were the case.

Hello,

Did you setup a kernel for load on panic? Can you paste the output for
# cat /proc/cmdline ?

thanks,
Daniel.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
