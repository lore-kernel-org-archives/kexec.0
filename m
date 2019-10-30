Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPjA4-00004t-Ge
 for kexec@lists.infradead.org; Wed, 30 Oct 2019 08:17:01 +0000
Received: by mail-io1-xd42.google.com with SMTP id r144so1484434iod.8
 for <kexec@lists.infradead.org>; Wed, 30 Oct 2019 01:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <ae74bb79-a68e-a319-f61c-5b93fd70ae59@gmail.com>
 <CAKv+Gu8oUfSfMLW17QOwBCrrn+3AggHND6b0KZWfB=Npo9d8Hw@mail.gmail.com>
 <CAJ2QiJLOE8D_Cf8ysRzv2oJ=+Bv1scpQCUX0yK=_zxjm6Rr6ow@mail.gmail.com>
 <CAKv+Gu981sk=GifDZbB-c-QYYP84RweHSmPQFkLPis1UDgrhAg@mail.gmail.com>
In-Reply-To: <CAKv+Gu981sk=GifDZbB-c-QYYP84RweHSmPQFkLPis1UDgrhAg@mail.gmail.com>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Wed, 30 Oct 2019 13:46:48 +0530
Message-ID: <CAJ2QiJJ4KKYGiEU2P_wuY3E0Q-FJm4LiNu+1jbOJoO84W_FDJw@mail.gmail.com>
Subject: Re: [edk2-devel] How /sys/firmware/fdt getting created
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: naresh.bhat@linaro.org, edk2-devel-groups-io <devel@edk2.groups.io>, kexec@lists.infradead.org

On Wed, Oct 30, 2019 at 1:14 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 30 Oct 2019 at 08:36, Prabhakar Kushwaha
> <prabhakar.pkin@gmail.com> wrote:
> >
> > On Wed, Oct 30, 2019 at 12:43 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Tue, 29 Oct 2019 at 18:17, Prabhakar Kushwaha
> > > <prabhakar.pkin@gmail.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > I am working on Ubuntu-18.04 with UEFI on ARM64(64 bit) platform. The
> > > > UEFI used is having ACPI tables.
> > > >
> > > > I am trying to understand where and how /sys/firmware/fdt is getting
> > > > created. is it created by UEFI or grub and passed to Linux?
> > > >
> > >
> > > Neither. It is created by Linux itself.
> > >
> > >
> > >
> >
> > Thanks Ard,
> >
> > Can you please point me the code where it is getting created.
> > I want to add below in /sys/firmware/fdt.
> >
> > #size-cells = <0x02>;
> > #address-cells = <0x02>;
> >
>
> Actually, in your case it is GRUB not the kernel that creates the FDT.
> It does this to pass the initrd information.
>
> So if you want to add these properties, you should add them there.
>
> Can you explain why doing this is necessary?

I am trying to test kexec -p (kdump feature) on CentOS-release
7.7.1908 and Ubuntu-18.04 distributions.

 "kexec -p" command show error on Ubuntu. While no error on CentOS

CentOS:
$ kexec -p /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
-r`.img --reuse-cmdline
$    ==> No error

Ubuntu
$ kexec -p /boot/vmlinuz-`uname -r` --initrd=/boot/initrd.img-`uname
-r` --reuse-cmdline
$ kexec: elfcorehdr doesn't fit cells-size.
$ kexec: setup_2nd_dtb failed.
$ kexec: load failed.
$ Cannot load /boot/vmlinuz-5.4.0-rc4+

Note: Both CentOS and Ubuntu has Linux-5.4-rc4 tag.

When i debugged further reason for Ubuntu error is due to
address-cells and size-cells as "1"
log from kexec tool :-
load_crashdump_segments: elfcorehdr 0x7f7cbfc000-0x7f7cbff7ff
read_1st_dtb: found name =dtb_sys  /sys/firmware/fdt
get_cells_size: #address-cells:1 #size-cells:1

On CentOS both values are "2".
log from kexec tool :-
load_crashdump_segments: elfcorehdr 0xbf98bf0000-0xbf98bf33ff
read_1st_dtb: found nmae=dtb_sys /sys/firmware/fdt
get_cells_size: #address-cells:2 #size-cells:2

Note: Kexec tool read values from /sys/firmware/fdt.

I am trying to figure out why 2 distributions showing different values.

--pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
