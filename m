Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dD4Cm-0005Z0-Fj
 for kexec@lists.infradead.org; Tue, 23 May 2017 07:26:10 +0000
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id A2F05AC009A
 for <kexec@lists.infradead.org>; Tue, 23 May 2017 16:25:38 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate
 page_offset from pt_load"
Date: Tue, 23 May 2017 07:25:36 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20D2060C9@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E20D205C05@G01JPEXMBYT03>
 <681cf021-74c0-25d2-a173-23ba50c38cab@redhat.com>
 <449aaa2b-0058-8b4d-227b-df97256b5674@redhat.com>
In-Reply-To: <449aaa2b-0058-8b4d-227b-df97256b5674@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: 'Pratyush Anand' <panand@redhat.com>
Cc: "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>, "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'bhe@redhat.com'" <bhe@redhat.com>

Pratysh,

> -----Original Message-----
> From: Pratyush Anand [mailto:panand@redhat.com]
> Sent: Tuesday, May 23, 2017 1:12 PM
> To: Hatayama, Daisuke <d.hatayama@jp.fujitsu.com>;
> 'ats-kumagai@wm.jp.nec.com' <ats-kumagai@wm.jp.nec.com>
> Cc: 'kexec@lists.infradead.org' <kexec@lists.infradead.org>;
> 'bhe@redhat.com' <bhe@redhat.com>
> Subject: Re: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate page_offset
> from pt_load"
> 
> 
> 
> On Tuesday 23 May 2017 08:53 AM, Pratyush Anand wrote:
> > Hi Hatayama,
> >
> > On Tuesday 23 May 2017 08:24 AM, Hatayama, Daisuke wrote:
> >> This reverts commit 0c9dd01d8ee2e4ec1821a11f5e174fdba56012b8 because
> >> the logic works well only on the kdump ELF format. It doesn't work
> >> well on sadump vmcores and qemu/KVM guest vmcores created by virsh
> >> dump --memory-only command where info->page_offset results in 0. These
> >> formats have to depend on kernel version dependency in the current
> >> situation.
> >
> > I do not think that we should just revert it. Revert will break things on
> > KASLR enabled kernel.
> >
> > I have already posted a patch to calculate page_offset when pt_load is not
> > available.
> >
> > http://lists.infradead.org/pipermail/kexec/2017-May/018747.html
> >
> > Probably,I can improve that patch in next version so that it takes care of
> > sadump case as well.
> >
> 
> Can you please try following patches from
> https://github.com/pratyushanand/makedumpfile.git : devel
> 
> https://github.com/pratyushanand/makedumpfile/commit/ba93c349ac5d097a51c22
> 1e39816da5fef2e5f58

strtoul() is better than strtol() because info->kaslr_offset is of unsigned long,
though there's no runtime error in this case.
 
> https://github.com/pratyushanand/makedumpfile/commit/241ecc6d96afbf7be6e02
> f51e882ce5e1e2eb9d0

This patch works fine on sadump vmcores, but doesn't look good on virsh dump --memory-only.
The vmcore created by virsh dump --memory-only command is written in ELF format.
Virtual addresses assigned into it differs from the kdump one, not reflecting
kernel runtime virtual addresses.

Here is a sample readelf output:

# LANG=C readelf -l /root/vmcore-by-virsh-dump

Elf file type is CORE (Core file)
Entry point 0x0
There are 7 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x00000000000001c8 0x0000000000000000 0x0000000000000000
                 0x0000000000000650 0x0000000000000650         0
  LOAD           0x0000000000000818 0x0000000000000000 0x0000000000000000
                 0x00000000000a0000 0x00000000000a0000         0
  LOAD           0x00000000000a0818 0x0000000000000000 0x00000000000a0000
                 0x0000000000010000 0x0000000000010000         0
  LOAD           0x00000000000b0818 0x0000000000000000 0x00000000000c0000
                 0x0000000000020000 0x0000000000020000         0
  LOAD           0x00000000000d0818 0x0000000000000000 0x00000000000e0000
                 0x0000000000020000 0x0000000000020000         0
  LOAD           0x00000000000f0818 0x0000000000000000 0x0000000000100000
                 0x000000003ff00000 0x000000003ff00000         0
  LOAD           0x000000003fff0818 0x0000000000000000 0x00000000f0000000
                 0x0000000001000000 0x0000000001000000         0

How about using QEMU or VMCOREINFO to distinguish QEMU ELF vmcore from
kdump ELF vmcore?

I think you know what VMCOREINFO is, and here is QEMU note information example:

# LANG=C readelf -n /root/vmcore

Displaying notes found at file offset 0x000001c8 with length 0x00000650:
  Owner                 Data size       Description
  CORE                 0x00000150       NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150       NT_PRSTATUS (prstatus structure)
  QEMU                 0x000001b0       Unknown note type: (0x00000000)
  QEMU                 0x000001b0       Unknown note type: (0x00000000)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
