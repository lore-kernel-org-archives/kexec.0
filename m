Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tu4Y6-0007qA-J6
 for kexec@lists.infradead.org; Sat, 12 Jan 2013 17:07:15 +0000
Received: by mail-bk0-f43.google.com with SMTP id jf20so1360902bkc.16
 for <kexec@lists.infradead.org>; Sat, 12 Jan 2013 09:07:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4068140.Uym9gOXymC@hammer82.arch.suse.de>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <CAE9FiQWEan4Vq-pbp6sgMWVFHwWygQ4Hq2wRsPH166+7w7L2yg@mail.gmail.com>
 <50F08F43.7080604@zytor.com>
 <4068140.Uym9gOXymC@hammer82.arch.suse.de>
Date: Sat, 12 Jan 2013 09:07:12 -0800
Message-ID: <CAE9FiQWNRS6rBzx+fbX+O9_L+Z-4T-oBWZUdzR0sS=P22ctZ0w@mail.gmail.com>
Subject: Re: [PATCH] x86 e820: only void usable memory areas in
 memmap=exactmap case
From: Yinghai Lu <yinghai@kernel.org>
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
To: Thomas Renninger <trenn@suse.de>
Cc: horms@verge.net.au, Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Sat, Jan 12, 2013 at 3:31 AM, Thomas Renninger <trenn@suse.de> wrote:
>         memmap=exactmap [KNL,X86] Enable setting of an exact
> -                       E820 memory map, as specified by the user.
> -                       Such memmap=exactmap lines can be constructed based on
> -                       BIOS output or other requirements. See the memmap=nn@ss
> -                       option description.
> +                       E820 usable memory map, as specified by the user.
> +                       All unusable (reserved, ACPI, NVS,...) ranges from the
> +                       original e820 table are preserved.
> +                       But the usable memory regions from the original e820
> +                       table are removed.
> +                       This parameter is explicitly for kdump usage:
> +                       The memory the kdump kernel is allowed to use must
> +                       be passed via below memmap=nn[KMG]@ss[KMG] param.
> +                       All reserved regions the kernel may use for ioremapping
> +                       and similar are still considered.
> +
> +       memmap=voidmap  [KNL,X86] Do not use any e820 ranges from BIOS or
> +                       bootloader. Instead you have to pass regions via
> +                       below memmap= options.

I would suggest to keep memmap=exactmap meaning not changed, and add
memmap=exactusablemap
instead.

kexec-tools could be updated to support exactusablemap with
kernelversion checking for kdump.

also we need to double check to make sure:
1. exactmap should override exactusablemap, even the out of order sequence.
2. when exactusablemap is used, not just remove old usable type range,
also need to remove overlapped range
with new usable range.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
