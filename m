Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6YiO-0000sD-1E
 for kexec@lists.infradead.org; Tue, 06 Aug 2013 04:17:45 +0000
Date: Tue, 6 Aug 2013 13:15:16 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile-1.5.4 "make install" assumes directories
 exist
Message-Id: <20130806131516.e241735b96b329741535d271@mxc.nes.nec.co.jp>
In-Reply-To: <CAPud5_4aDH32GR=sZbUQQ46Sz0OAPgRnUDWZk8BZEt5wf+0W3A@mail.gmail.com>
References: <CAPud5_4aDH32GR=sZbUQQ46Sz0OAPgRnUDWZk8BZEt5wf+0W3A@mail.gmail.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: nick@pistoncloud.com
Cc: nishimura@mxp.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Hello Nick,

On Mon, 29 Jul 2013 09:31:55 -0700
Nick Bartos <nick@pistoncloud.com> wrote:

> The make install of makedumpfile-1.5.4 uses cp instead of the usual
> "install" command, which has some side effects of not pre-creating
> directories.  This results in installs to an alternate DESTDIR fail because
> the parent directories do not exist.
> 
> I have attached a patch which modifies make install to use the install
> utility.
>
> ---
> diff -U3 -r makedumpfile-1.5.4.orig/Makefile makedumpfile-1.5.4/Makefile
> --- makedumpfile-1.5.4.orig/Makefile	2013-07-01 08:08:49.000000000 +0000
> +++ makedumpfile-1.5.4/Makefile	2013-07-18 17:15:01.109058204 +0000
> @@ -86,8 +86,8 @@
>  	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8.gz makedumpfile.conf.5.gz
>  
>  install:
> -	cp makedumpfile ${DESTDIR}/bin
> -	cp makedumpfile-R.pl ${DESTDIR}/bin
> -	cp makedumpfile.8.gz ${DESTDIR}/usr/share/man/man8
> -	cp makedumpfile.conf.5.gz ${DESTDIR}/usr/share/man/man5
> -	cp makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
> +	install -m 755 -d ${DESTDIR}/usr/bin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8 ${DESTDIR}/etc
> +	install -m 755 -t ${DESTDIR}/usr/bin makedumpfile makedumpfile-R.pl
> +	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8.gz
> +	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5.gz
> +	install -m 644 -D makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample

I think /usr/sbin is better than /usr/bin as installation directory
according to Filesystem Hierarchy Standard.

  4.10. /usr/sbin : Non-essential standard system binaries
  4.10.1. Purpose

    This directory contains any non-essential binaries used exclusively
    by the system administrator. System administration programs that are
    required for system repair, system recovery, mounting /usr, or other
    essential functions must be placed in /sbin instead.

So may I fix that when I merge this patch ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
