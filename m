Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQH4c-0004mz-U6
 for kexec@lists.infradead.org; Thu, 31 Oct 2019 20:29:41 +0000
Received: by mail-lf1-f69.google.com with SMTP id r21so1677869lff.1
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2019 13:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <ae74bb79-a68e-a319-f61c-5b93fd70ae59@gmail.com>
 <CAKv+Gu8oUfSfMLW17QOwBCrrn+3AggHND6b0KZWfB=Npo9d8Hw@mail.gmail.com>
 <CAJ2QiJLOE8D_Cf8ysRzv2oJ=+Bv1scpQCUX0yK=_zxjm6Rr6ow@mail.gmail.com>
 <CAKv+Gu981sk=GifDZbB-c-QYYP84RweHSmPQFkLPis1UDgrhAg@mail.gmail.com>
 <CAJ2QiJJ4KKYGiEU2P_wuY3E0Q-FJm4LiNu+1jbOJoO84W_FDJw@mail.gmail.com>
In-Reply-To: <CAJ2QiJJ4KKYGiEU2P_wuY3E0Q-FJm4LiNu+1jbOJoO84W_FDJw@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 1 Nov 2019 01:59:19 +0530
Message-ID: <CACi5LpPQcvvb-Tymdy6KVCfJKfBSGWNyNXifpccXncGvZ15itA@mail.gmail.com>
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
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>, edk2-devel-groups-io <devel@edk2.groups.io>, kexec mailing list <kexec@lists.infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Hi Prabhakar,

On Wed, Oct 30, 2019 at 1:47 PM Prabhakar Kushwaha
<prabhakar.pkin@gmail.com> wrote:
>
> On Wed, Oct 30, 2019 at 1:14 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Wed, 30 Oct 2019 at 08:36, Prabhakar Kushwaha
> > <prabhakar.pkin@gmail.com> wrote:
> > >
> > > On Wed, Oct 30, 2019 at 12:43 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Tue, 29 Oct 2019 at 18:17, Prabhakar Kushwaha
> > > > <prabhakar.pkin@gmail.com> wrote:
> > > > >
> > > > > Hi All,
> > > > >
> > > > > I am working on Ubuntu-18.04 with UEFI on ARM64(64 bit) platform. The
> > > > > UEFI used is having ACPI tables.
> > > > >
> > > > > I am trying to understand where and how /sys/firmware/fdt is getting
> > > > > created. is it created by UEFI or grub and passed to Linux?
> > > > >
> > > >
> > > > Neither. It is created by Linux itself.
> > > >
> > > >
> > > >
> > >
> > > Thanks Ard,
> > >
> > > Can you please point me the code where it is getting created.
> > > I want to add below in /sys/firmware/fdt.
> > >
> > > #size-cells = <0x02>;
> > > #address-cells = <0x02>;
> > >
> >
> > Actually, in your case it is GRUB not the kernel that creates the FDT.
> > It does this to pass the initrd information.
> >
> > So if you want to add these properties, you should add them there.
> >
> > Can you explain why doing this is necessary?
>
> I am trying to test kexec -p (kdump feature) on CentOS-release
> 7.7.1908 and Ubuntu-18.04 distributions.
>
>  "kexec -p" command show error on Ubuntu. While no error on CentOS
>
> CentOS:
> $ kexec -p /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
> -r`.img --reuse-cmdline
> $    ==> No error
>
> Ubuntu
> $ kexec -p /boot/vmlinuz-`uname -r` --initrd=/boot/initrd.img-`uname
> -r` --reuse-cmdline
> $ kexec: elfcorehdr doesn't fit cells-size.
> $ kexec: setup_2nd_dtb failed.
> $ kexec: load failed.
> $ Cannot load /boot/vmlinuz-5.4.0-rc4+
>
> Note: Both CentOS and Ubuntu has Linux-5.4-rc4 tag.
>
> When i debugged further reason for Ubuntu error is due to
> address-cells and size-cells as "1"
> log from kexec tool :-
> load_crashdump_segments: elfcorehdr 0x7f7cbfc000-0x7f7cbff7ff
> read_1st_dtb: found name =dtb_sys  /sys/firmware/fdt
> get_cells_size: #address-cells:1 #size-cells:1
>
> On CentOS both values are "2".
> log from kexec tool :-
> load_crashdump_segments: elfcorehdr 0xbf98bf0000-0xbf98bf33ff
> read_1st_dtb: found nmae=dtb_sys /sys/firmware/fdt
> get_cells_size: #address-cells:2 #size-cells:2
>
> Note: Kexec tool read values from /sys/firmware/fdt.
>
> I am trying to figure out why 2 distributions showing different values.

There are a couple of things I can suggest:

1. Try to see if it is a kexec-tools specific issue or is the kernel
itself passed an incorrectly fixed DTB (by grub?) with incorrect
#address-cells and #size-cells values (in the past I have seen
kexec-tools sometimes reports incorrect #address-cells and #size-cells
values, but they should be fixed in the newer kexec-tools versions):

a). Can you check the kexec-tools version and share the same:
$ kexec -v

b). Using 'dtc' tool, you can confirm if it reports a correct
#address-cells and #size-cells values:
# dtc -I dtb -O dts /sys/firmware/fdt | grep cells | less

For e.g on my fedora arm64 system, it reports:
    #address-cells = <0x2>;
    #size-cells = <0x2>;

2a). If its not a kexec-tools specific issue, it is most probably a
bootloader (grub?) issue in your case:

For e.g. I use the following grub2 on my Fedora arm64 board:
<https://github.com/rhboot/grub2>
and <https://github.com/rhboot/grub2/blob/master/grub-core/loader/efi/fdt.c#L34>
contains the changes to send the correct #address-cells and
#size-cells values to Linux (and hence user-space tools like
kexec-tools later).

I believe the same grub2 is used (backported) for CentOS, so things
should be fine there.

2b). I see that the latest devel branch of ubuntu grub2
(<https://code.launchpad.net/ubuntu/+source/grub2>) also contains this
fix, but I am not sure which grub2 version you have on your ubuntu
machine.

But you can do some debugging on the same by stopping the boot process
on the grub prompt and debugging grub further to check the version and
fixes done in fdt there. See
<https://help.ubuntu.com/community/Grub2/Troubleshooting> for details.

Hope this helps.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
