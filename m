Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTL9o-0004a0-RB
 for kexec@lists.infradead.org; Thu, 14 Jun 2018 05:50:54 +0000
Received: by mail-lf0-f46.google.com with SMTP id j13-v6so7410756lfb.13
 for <kexec@lists.infradead.org>; Wed, 13 Jun 2018 22:50:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5e99ff9a-cc16-ba15-3391-909253046ae5@sigfox.com>
References: <5e99ff9a-cc16-ba15-3391-909253046ae5@sigfox.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 14 Jun 2018 11:20:40 +0530
Message-ID: <CACi5LpM9E0OfCZaeMDUc_eC5uqM=0dBpZ1ouTVQcBrH+TK=WmA@mail.gmail.com>
Subject: Re: [RFC] fitImage support on ARM64
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
To: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
Cc: Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>

Hello Arnaud,

On Tue, Jun 12, 2018 at 7:05 PM, Arnaud Ferraris
<arnaud.ferraris.external@sigfox.com> wrote:
> Hi,
>
> I started working on implementing fitImage support in kexec.

FIT is a u-boot construct - so one question to understand the
background better - are you using u-boot bootloader to boot the Linux
kernel on your arm64 platforms?

If yes, can you please confirm that it is not a product targeting
server markets? As for the server markets, the ARM SBBR requires one
to use a UEFI compliant firmware as the boot and system firmware (see
[1] for details).

For EFI opensource implementations like Tianocore EDK2 firmware, we
decided against using the FIT format (see [2] for details)

> Regarding image parsing & loading, things are going quite well, but I
> realized the only way to load a device tree and/or initramfs for now was to
> have them stored in files separated from the kernel.
>
> I came up with a solution that requires appending new fields to the
> kexec_info structure (see attached patch), and wonder if that sounds right
> to you ? I guess other architectures might benefit from this support, so I
> didn't want an ARM64-specific solution.
>
> Any comment will be welcome !

For the normal kexec -p operation (i.e. not the kexec file_load
operation), we rely on passing the device tree to the crashkernel via
dtb= option (which is done by kexec-tools), so how do you plan to
handle the same?

If we need to bring out the dtb from the FIT image to support the
current design, do we really require the piecemeal FIT image support
in kexec-tools?

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0044c/Server_Base_Boot_Requirements_v1_1_Arm_DEN_0044C.pdf
[2] https://www.mail-archive.com/search?l=edk2-devel@lists.01.org&q=subject:%22Re%5C%3A+%5C%5Bedk2%5C%5D+%5C%5BPATCH%5C%5D+ArmVirtPkg%5C%3A+align+ARM+BDS+build+with+LinuxLoader%09changes%22&o=newest&f=1

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
