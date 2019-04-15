Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hG3mJ-0001GI-87
 for kexec@lists.infradead.org; Mon, 15 Apr 2019 15:44:18 +0000
Date: Mon, 15 Apr 2019 17:41:55 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190415154155.GH29317@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
 <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
 <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
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
To: lijiang <lijiang@redhat.com>, Thomas.Lendacky@amd.com
Cc: x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Apr 15, 2019 at 08:22:22PM +0800, lijiang wrote:
> They are different problems.

Aha, so we're getting closer. You should've lead with that!

> The first problem is that passes the e820 reserved ranges to the second kernel,

Passes or *doesn't* pass?

Because from all the staring, it wants to pass the reserved ranges.

> for this case, it is good enough to use the IORES_DESC_RESERVED, which
> can ensure that exactly matches the reserved resource ranges when
> walking through iomem resources.

Ok.

> The second problem is about the SEV case. Now, the IORES_DESC_RESERVED has been
> created for the reserved areas, therefore the check needs to be expanded so that
> these areas are not mapped encrypted when using ioremap().
> 
> +static int __ioremap_check_desc_none_and_reserved(struct resource *res)

That name is crap. If you need to add another desc type, it becomes
wrong again. And that whole code around flags->desc_other is just silly:

Make that machinery around it something like this:

struct ioremap_desc {
        u64 flags;
};

instead of "struct ioremap_mem_flags" and that struct ioremap_desc is an
ioremap descriptor which will carry all kinds of settings. system_ram
can then be a simple flag too.

__ioremap_caller() will hand it down to __ioremap_check_mem() etc
and there it will set flags like IOREMAP_DESC_MAP_ENCRYPTED or
IOREMAP_DESC_MAP_DECRYPTED and this way you'll have it explicit and
clear in __ioremap_caller():

        if ((sev_active() &&
	    (io_desc.flags & IOREMAP_DESC_MAP_ENCRYPTED)) ||
	    encrypted)
                prot = pgprot_encrypted(prot);

But that would need a pre-patch which does that conversion.

> Maybe i should split it into two patches. The change of
> __ioremap_check_desc_none_and_reserved() should be a separate patch.
> Any idea?

See above and yes, definitely separate patches.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
