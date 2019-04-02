Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBFNq-0006of-24
 for kexec@lists.infradead.org; Tue, 02 Apr 2019 09:07:09 +0000
Date: Tue, 2 Apr 2019 11:06:52 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190402090652.GD6826@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190329123914.20939-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Fri, Mar 29, 2019 at 08:39:13PM +0800, Lianbo Jiang wrote:
> -static int __ioremap_check_desc_other(struct resource *res)
> +/*
> + * Originally, these areas described as IORES_DESC_NONE are not mapped
> + * as encrypted when using ioremap(), for example, E820_TYPE_{RESERVED,
> + * RESERVED_KERN,RAM,UNUSABLE}, etc. It checks for a resource that is
> + * not described as IORES_DESC_NONE, which can make sure the reserved
> + * areas are not mapped as encrypted when using ioremap().
> + *
> + * Now IORES_DESC_RESERVED has been created for the reserved areas so
> + * the check needs to be expanded so that these areas are not mapped
> + * encrypted when using ioremap().
> + */
> +static int __ioremap_check_desc_none_and_reserved(struct resource *res)
>  {
> -	return (res->desc != IORES_DESC_NONE);
> +	return ((res->desc != IORES_DESC_NONE) &&

Why is this still checking IORES_DESC_NONE when the idea is to have this
specific IORES_DESC_RESERVED for all marked as *reserved* regions in
e820 which should not be mapped encrypted?

IOW, which regions are still marked as IORES_DESC_NONE and should not be
mapped encrypted?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
