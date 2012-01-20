Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ro9mi-0007BX-7F
 for kexec@lists.infradead.org; Fri, 20 Jan 2012 08:25:22 +0000
Date: Fri, 20 Jan 2012 17:02:44 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile can't build on Fedora 16
Message-Id: <20120120170244.c84c4050.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <4F19157C.3090809@gmail.com>
References: <4F15A377.3090302@gmail.com> <4F1613CC.9040405@cn.fujitsu.com>
 <20120118094055.239c362d.oomichi@mxs.nes.nec.co.jp>
 <4F16CCE5.1060500@gmail.com>
 <20120119165816.125f11b0.oomichi@mxs.nes.nec.co.jp>
 <20120120160322.d5dbd362.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F19157C.3090809@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xiyou.wangcong@gmail.com
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org, wency@cn.fujitsu.com

Hi, Cong

On Fri, 20 Jan 2012 15:19:24 +0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On 01/20/2012 03:03 PM, Atsushi Kumagai wrote:
> > Hi,
> 
> Hi, Kumagai-san,
> 
> > I think that makedumpfile should be compiled with -static option,
> > because it must be executable in many environment as possible, e.g. even if
> > there are no dynamic libraries in 2nd kernel environment. (as written in README)
> >
> > But I've got some requests to build it using dynamic libraries,
> > so I will change the Makefile as attached patch.
> >
> > If you want to build makedumpfile using dynamic libraries,
> > you need "LINKTYPE=dynamic"(see below).
> >
> > How to build:
> >    a) linking static libraries (default)
> >      $ make
> >      ...
> >      $ ldd makedumpfile
> >          not a dynamic executable
> >
> >    b) linking dynamic libraries
> >      $ make LINKTYPE=dynamic
> >      ...
> >      $ ldd makedumpfile
> >          libdw.so.1 =>  /usr/lib64/libdw.so.1 (0x0000003ca2800000)
> >          libbz2.so.1 =>  /usr/lib64/libbz2.so.1 (0x000000394b200000)
> >          libdl.so.2 =>  /lib64/libdl.so.2 (0x00000031a5a00000)
> >          libelf.so.1 =>  /usr/lib64/libelf.so.1 (0x0000003ca2400000)
> >          libz.so.1 =>  /usr/lib64/libz.so.1 (0x00000031a6200000)
> >          libc.so.6 =>  /lib64/libc.so.6 (0x00000031a5200000)
> >          /lib64/ld-linux-x86-64.so.2 (0x00000031a4e00000)
> >
> > What do you think, Cong?
> 
> This also works for me! Thanks for your patch!
> 
> BTW, we also need to update README. ;)

Thank you for your notice.
I will update Makefile and README at v1.4.2.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
