Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SnAs4-0005Vi-IU
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 15:55:08 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
 (dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
 id S1614602Ab2GFPy5 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Fri, 6 Jul 2012 17:54:57 +0200
Date: Fri, 6 Jul 2012 17:54:57 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: Re: incorrect layout of globals from head_64.S during kexec boot
Message-ID: <20120706155457.GA3733@router-fw-old.local.net-space.pl>
References: <20120705210607.GA26908@aepfle.de>
 <20120706084120.GA31219@router-fw-old.local.net-space.pl>
 <20120706120750.GA8970@aepfle.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120706120750.GA8970@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>

On Fri, Jul 06, 2012 at 02:07:50PM +0200, Olaf Hering wrote:
> On Fri, Jul 06, Daniel Kiper wrote:
>
> > Copy is done a few times durnig kexec/kdump but the most important
> > in this case, I think, is in relocate_kernel() function (look for
> > rep movsl or rep movsq and code around it). But I am a bit surprised
> > that kernel is decompressing itself. I always thought that it is done
> > during kexec/kdump load phase but maybe I am wrong. Could you send

I am wrong.

> > me more info about your Linux Kernel version, kexec-tools version
> > and exact commands which you are using to load/exececute kernel?
>
> Its kexec-tools and kernel mainline, but it happens also with older
> versions of both. kexec works fine with the forward ported version of
> xenlinux.
>
> kexec -l bzImage --ramdisk=/boot/initrd-3.5.0-rc5-bug694863+ '--command-line=root=/dev/disk/by-label/sles11sp1_full
> sysrq=yes
> panic=9
> oops=panic
> console=ttyS0,115200
> log_buf_len=16M
> ignore_loglevel
> initcall_debug
> debug earlyprintk=serial,ttyS0,115200' -t bzImage --console-serial --serial=ttyS0 --serial-baud=115200 --debug
> kexec -e

Nothing special. But try also ELF loader.

> As Jan pointed out, the copying is done in
> arch/x86/boot/compressed/misc.c. But adding some debug to inspect
> *output in parse_elf() shows that the second entry in program headers is
> already shifted by 44 bytes in my testing, the others are shifted by the
> same amount.
>
> Program Headers:
>   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
>   LOAD           0x200000 0xffffffff81000000 0x0000000001000000 0xa3b000 0xa3b000 R E 0x200000
>   LOAD           0xe00000 0xffffffff81c00000 0x0000000001c00000 0x05b0e8 0x05b0e8 RW  0x200000
>   LOAD           0x1000000 0x0000000000000000 0x0000000001c5c000 0x012c40 0x012c40 RW  0x200000
>   LOAD           0x106f000 0xffffffff81c6f000 0x0000000001c6f000 0x087000 0x702000 RWE 0x200000
>   NOTE           0x82d5bc 0xffffffff8162d5bc 0x000000000162d5bc 0x00017c 0x00017c     0x4
>
> That makes me wonder wether kexec-tools is the culprit.

Is it relocatable kernel? If not please try use not relocatable one.
Then kernel will be always in the same place.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
