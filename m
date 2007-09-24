Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IZx57-00031f-FV
	for kexec@lists.infradead.org; Mon, 24 Sep 2007 19:11:19 -0400
Received: from midway.site ([71.117.233.180]) by xenotime.net for
	<kexec@lists.infradead.org>; Mon, 24 Sep 2007 16:11:03 -0700
Date: Mon, 24 Sep 2007 16:11:03 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: 2.6.23-rc7-mm1: build error with CONFIG_KEXEC=y and
	CONFIG_NOHIGHMEM=y
Message-Id: <20070924161103.17d7349a.rdunlap@xenotime.net>
In-Reply-To: <46F819BC.3010802@free.fr>
References: <20070924021716.9bfe7dfb.akpm@linux-foundation.org>
	<46F819BC.3010802@free.fr>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Laurent Riffard <laurent.riffard@free.fr>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

[adding kexec m-l]

On Mon, 24 Sep 2007 22:10:36 +0200 Laurent Riffard wrote:

> Le 24.09.2007 11:17, Andrew Morton a =E9crit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc=
7/2.6.23-rc7-mm1/
> > =

> =

> I've got this compilation when CONFIG_KEXEC=3Dy and CCONFIG_NOHIGHMEM=3Dy:
> =

> linux-2.6-mm$ LANG=3DC make =

>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CC      arch/i386/kernel/setup.o
> arch/i386/kernel/setup.c: In function 'reserve_crashkernel':
> arch/i386/kernel/setup.c:391: error: 'highend_pfn' undeclared (first use =
in this function)
> arch/i386/kernel/setup.c:391: error: (Each undeclared identifier is repor=
ted only once
> arch/i386/kernel/setup.c:391: error: for each function it appears in.)
> arch/i386/kernel/setup.c:391: error: 'highstart_pfn' undeclared (first us=
e in this function)
> make[1]: *** [arch/i386/kernel/setup.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> =

> =

> .config attached.
> ~~
> laurent
> =



---
~Randy
Phaedrus says that Quality is about caring.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
