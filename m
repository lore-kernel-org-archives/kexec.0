Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xo9v6-0005s2-Dx
 for kexec@lists.infradead.org; Tue, 11 Nov 2014 11:47:37 +0000
Received: by mail-lb0-f170.google.com with SMTP id p9so4309165lbv.1
 for <kexec@lists.infradead.org>; Tue, 11 Nov 2014 03:47:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5461F18C.2080400@redhat.com>
References: <5461F18C.2080400@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Nov 2014 11:46:52 +0000
Message-ID: <CAFEAcA86kxVXG6uW2mt3Er8s8zjcVBLE7AM0UEWKF-nTuSjm9w@mail.gmail.com>
Subject: Re: [Qemu-devel] uniquely identifying KDUMP files that originate from
 QEMU
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Wen Congyang <wency@cn.fujitsu.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, kexec@lists.infradead.org, qemu devel list <qemu-devel@nongnu.org>, Qiao Nuohan <qiaonuohan@cn.fujitsu.com>, Dave Anderson <anderson@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp, crash-utility@redhat.com

On 11 November 2014 11:22, Laszlo Ersek <lersek@redhat.com> wrote:
> For this reason, the kdump preparation logic in QEMU hardcodes a number
> of fields in the kdump header. The direct issue is the "phys_base"
> field. Refer to dump.c, functions create_header32(), create_header64(),
> and "include/sysemu/dump.h", macro PHYS_BASE (with the replacement text
> "0").
>
> http://git.qemu.org/?p=qemu.git;a=blob;f=dump.c;h=9c7dad8f865af3b778589dd0847e450ba9a75b9d;hb=HEAD
>
> http://git.qemu.org/?p=qemu.git;a=blob;f=include/sysemu/dump.h;h=7e4ec5c7d96fb39c943d970d1683aa2dc171c933;hb=HEAD
>
> This works in most cases, because the guest Linux kernel indeed tends to
> be loaded at guest-phys address 0. However, when the guest Linux kernel
> is booted on top of OVMF (which has a somewhat unusual UEFI memory map),
> then the guest Linux kernel is loaded at 16MB, thereby getting out of
> sync with the phys_base=0 setting visible in the KDUMP header.

Presumably this is also not going to work for machines other
than the x86 PC, where physical memory may well not start at
address zero...

-- PMM

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
