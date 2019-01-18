Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f65.google.com ([209.85.166.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkSYe-0008L0-Dc
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 11:43:33 +0000
Received: by mail-io1-f65.google.com with SMTP id b23so10431584ios.10
 for <kexec@lists.infradead.org>; Fri, 18 Jan 2019 03:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20190118111310.29589-1-kasong@redhat.com>
 <20190118111310.29589-3-kasong@redhat.com>
 <20190118112628.GC622@zn.tnic>
In-Reply-To: <20190118112628.GC622@zn.tnic>
From: Kairui Song <kasong@redhat.com>
Date: Fri, 18 Jan 2019 19:43:20 +0800
Message-ID: <CACPcB9dTm_2UCRord01oW+mmoPYY7dFTHj7qFrMxOnhPx3Ov3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec usage
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
To: Borislav Petkov <bp@alien8.de>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Baoquan He <bhe@redhat.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, the arch/x86 maintainers <x86@kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, Len Brown <lenb@kernel.org>

On Fri, Jan 18, 2019 at 7:26 PM Borislav Petkov <bp@alien8.de> wrote:

> No, this is getting completely nuts: there's a bunch of functions which
> all end up returning boot_params's field except pvh_get_root_pointer().
>
> And now you're adding a late variant. And the cmdline paramater
> acpi_rsdp is in a CONFIG_KEXEC wrapper, and and...
>
> Wait until Chao Fan's stuff is applied, then do your changes ontop
> an drop all that ifdeffery. We will make this RDSP thing enabled
> unconditionally so that there's no need for ifdeffery and function
> wrappers.
>
> Also, after Chao's stuff, you won't need to call
> acpi_os_get_root_pointer() because the early code would've done that.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

Good suggestion, will wait for Chao's update then.


--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
