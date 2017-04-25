Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3ALV-0005Y5-5D
 for kexec@lists.infradead.org; Tue, 25 Apr 2017 23:58:15 +0000
Received: by mail-ua0-x244.google.com with SMTP id 110so19739267uas.1
 for <kexec@lists.infradead.org>; Tue, 25 Apr 2017 16:57:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <tip-640e1b38b00550990cecd809021cd37716e45922@git.kernel.org>
References: <tip-640e1b38b00550990cecd809021cd37716e45922@git.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 25 Apr 2017 16:57:50 -0700
Message-ID: <CAE9FiQXzX7H-2=nyt=5fb+7q0ti5-c1bhPYBNOJLGU_AXUAcGA@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/boot/e820: Basic cleanup of e820.c
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
To: Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Denys Vlasenko <dvlasenk@redhat.com>, athorlton@sgi.com, jgross@suse.com, Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Paul Jackson <pj@sgi.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>

On Tue, Apr 11, 2017 at 12:37 AM, tip-bot for Ingo Molnar
<tipbot@zytor.com> wrote:
> Commit-ID:  640e1b38b00550990cecd809021cd37716e45922
> Gitweb:     http://git.kernel.org/tip/640e1b38b00550990cecd809021cd37716e45922
> Author:     Ingo Molnar <mingo@kernel.org>
> AuthorDate: Sat, 28 Jan 2017 11:13:08 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Sat, 28 Jan 2017 14:42:27 +0100
>

> x86/boot/e820: Basic cleanup of e820.c
....
> @@ -951,49 +924,42 @@ void __init finish_e820_parsing(void)
>  static const char *__init e820_type_to_string(int e820_type)
>  {
>         switch (e820_type) {
> -       case E820_RESERVED_KERN:
> -       case E820_RAM:  return "System RAM";
> -       case E820_ACPI: return "ACPI Tables";
> -       case E820_NVS:  return "ACPI Non-volatile Storage";
> -       case E820_UNUSABLE:     return "Unusable memory";
> -       case E820_PRAM: return "Persistent Memory (legacy)";
> -       case E820_PMEM: return "Persistent Memory";
> -       default:        return "reserved";
> +       case E820_RESERVED_KERN: /* Fall-through: */
> +       case E820_RAM:           return "System RAM";
> +       case E820_ACPI:          return "ACPI Tables";
> +       case E820_NVS:           return "ACPI Non-volatile Storage";
> +       case E820_UNUSABLE:      return "Unusable memory";
> +       case E820_PRAM:          return "Persistent Memory (legacy)";
> +       case E820_PMEM:          return "Persistent Memory";
> +       default:                 return "Reserved";
>         }
>  }
>
...

Hi Ingo,

The reserved ==> Reserved change cause kexec warning.

Unknown type (Reserved) while parsing /sys/firmware/memmap/18/type.
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/16/type.
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/14/type.
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/22/type.
Please report this as bug. Using RANGE_RESERVED now.
Unknown type (Reserved) while parsing /sys/firmware/memmap/9/type.
Please report this as bug. Using RANGE_RESERVED now.
add_buffer: base:43fff6000 bufsz:80e0 memsz:a000
add_buffer: base:43fff1000 bufsz:44ce memsz:44ce
add_buffer: base:43c000000 bufsz:f4c5c0 memsz:3581000
add_buffer: base:439d0d000 bufsz:22f2060 memsz:22f2060
add_buffer: base:43fff0000 bufsz:70 memsz:70
add_buffer: base:43ffef000 bufsz:230 memsz:230
10:~/k # cat /sys/firmware/memmap/14/type
Reserved

also /proc/iomem have that changed too.

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
