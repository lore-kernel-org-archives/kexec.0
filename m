Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
	helo=TX2EHSOBE004.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAnBi-00050U-18
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 18:24:26 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: [PATCH] kexec: powerpc: crash_dump: No backup region for PPC BookE
Date: Mon, 3 Oct 2011 18:23:55 +0000
Message-ID: <CAEsOVNefdrEgkSG9gO13kQW2akjYWX=Q6xEEkwxQ4Vv5ndfGKw@mail.gmail.com>
References: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
Content-Language: en-US
Content-ID: <6DD7D59F4121C342BB4BB7B4A11966D0@freescale.net>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: "M. Mohan Kumar" <mohan@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Oct 3, 2011 at 5:18 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote:
> Disable backup regions for BookE in case of a CRASH Dump, as they can
> be run from anywhere.
>
> The patch introduces --with-booke option to support the BookE.
>
> With the patch, we get :
>
> ## On a 256M machine:
>
> # busybox cat /proc/cmdline
> init=3D/bin/init console=3DttyS0,16550 crashkernel=3D128M@100M
> # kexec -p root/vmlinux
> usable memory rgns size:1 base:6400000 size:8000000
> CRASH MEMORY RANGES
> 0000000000000000-0000000006400000
> 000000000e400000-0000000010000000
> Command line after adding elfcorehdr: =A0elfcorehdr=3D112380K
> Command line after adding elfcorehdr: =A0elfcorehdr=3D112380K savemaxmem=
=3D256M

So there were two crash regions when we only needed the one specified
on the command line?

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
