Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hHRma-0005Xy-G8
 for kexec@lists.infradead.org; Fri, 19 Apr 2019 11:34:17 +0000
Date: Fri, 19 Apr 2019 13:34:13 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419113413.GC10324@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On Fri, Apr 19, 2019 at 07:20:06PM +0800, Kairui Song wrote:
> Thanks for the declaration Bao, I can verify on the machine I have,
> the issue still exist without kaslr. Currently, we read rsdp in early
> code and fill in boot_params unconditional, so it will read from the
> systab anyway.

Yes, and in the future, info required by the kexec'ed kernel - like the
EFI systab address or even whether the kernel has been kexec'ed or comes
from cold boot - should be passed in boot_params. So that we don't have
to do all that ugly dancing in early code.

> Yes, kexec only cover RAM in the ident map it prepared for second
> kernel, but the systab could be in reserved region, so if it didn't
> fall into the 1G padding by accident it will fail when reading from
> it. Fix in early code could make sure 2nd kernel always work. Or
> should we treat it specially in kexec mapping prepare code?

Yes, we should. As I said, this is not early boot code's problem but the
kexec setup code's problem.

If the new kernel cannot get RSDP that early, then it should fail the
same way it failed before. That early RDSP parsing was added for the
movable regions thing working with KASLR.

If it can't get a RDSP for whatever reason, then if KASLR selects
a region overlapping with the movable regions, then it is the old
behavior.

Ok?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
