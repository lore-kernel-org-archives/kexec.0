Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sa2vX-0001XY-RT
 for kexec@lists.infradead.org; Thu, 31 May 2012 10:48:24 +0000
Message-ID: <4FC74C74.3040302@canonical.com>
Date: Thu, 31 May 2012 12:48:20 +0200
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: makedumpfile-1.4.4: Support for LZO compression.
References: <20120530131644.9548f784.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120530131644.9548f784.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

Hello Kumagai-san,

Le 30/05/2012 06:16, Atsushi Kumagai a =E9crit :
> Hi,
> =

> makedumpfile version 1.4.4 is released.
> Your comments/patches are welcome.
> =

...
> =

> Changelog:
...
>    Other commit
>     - [PATCH] Support newer kernels. (by Atsushi Kumagai) 4f39edb
> =


I have been eagerly waiting for this release in order to address an
ongoing bug we have on ubuntu 12.04 Precise Pangolin where makedumpfile
fails to generate the vmcoreinfo file :

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/988512

My current test on the latest Ubuntu Precise kernel (3.2.0-24.39) show
that we still have the same issue :

> # /crashdata/tmp/usr/bin/makedumpfile -g /crashdata/kernel/linux-3.2.0/de=
bian/linux-image-3.2.0-24-generic/boot/vmcoreinfo-3.2.0-24-generic -x /cras=
hdata/kernel/linux-3.2.0/debian/build/build-generic/vmlinux
> generate_vmcoreinfo: Can't find the memory type.
> =

> makedumpfile Failed.

There seems to be some issue in get_mem_type() that I will try to debug
further. Please let me know if you have something specific that you want
me to test and/or try as I have everything needed.

Kind regards,

...Louis


-- =

Louis Bouchard
Backline Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
