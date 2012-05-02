Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SPal6-0006tB-Uh
 for kexec@lists.infradead.org; Wed, 02 May 2012 14:42:26 +0000
Message-ID: <4FA147CD.1060600@canonical.com>
Date: Wed, 02 May 2012 16:42:21 +0200
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: makedumpfile availability for x86 3.2 kernels
References: <4F99AFB3.3070803@canonical.com>
 <20120427132448.d7854fd6.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120427132448.d7854fd6.kumagai-atsushi@mxc.nes.nec.co.jp>
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

Le 27/04/2012 06:24, Atsushi Kumagai a =E9crit :
> Hello Louis,
> Sorry, I haven't tested makedumpfile for 3.2 kernel yet, but I think it =

> will work fine. If makedumpfile doesn't work in your environmental, then
> would you report it ? =

> =

> For your information, Suzuki reported that makedumpfile works for 3.2 ker=
nel
> on ppc32.
> =

>   http://lists.infradead.org/pipermail/kexec/2012-February/006022.html
> =

> =

> Thanks
> Atsushi Kumagai

Following your advice, I tested it on our current kernel build. One of
the Ubuntu kernel developper tested it as well and here is what we get :

> makedumpfile -g vmcoreinfo-3.2.0-24-generic -x ../../build/build-generic/=
vmlinux
> The kernel version is not supported.
> The created dumpfile may be incomplete.
> generate_vmcoreinfo: Can't find the memory type.
> =

> makedumpfile Failed.

I am rebuilding makedumpfile from the latest source (our version is
1.3.7 which is rather old) and will try to debug it further. I will let
you know what I find.

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
