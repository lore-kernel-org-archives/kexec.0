Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dMB9r-0007By-Vi
 for kexec@lists.infradead.org; Sat, 17 Jun 2017 10:40:51 +0000
Subject: Re: [PATCH v7 32/36] xen/x86: Remove SME feature in PV guests
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185554.18967.82909.stgit@tlendack-t1.amdoffice.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <8dac5656-3d54-8b14-46ca-50072b507be3@suse.com>
Date: Sat, 17 Jun 2017 12:40:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170616185554.18967.82909.stgit@tlendack-t1.amdoffice.net>
Content-Language: de-DE
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
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, "Michael S. Tsirkin" <mst@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Paolo Bonzini <pbonzini@redhat.com>

On 16/06/17 20:55, Tom Lendacky wrote:
> Xen does not currently support SME for PV guests. Clear the SME cpu
> capability in order to avoid any ambiguity.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

> ---
>  arch/x86/xen/enlighten_pv.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index f33eef4..e6ecf42 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -294,6 +294,7 @@ static void __init xen_init_capabilities(void)
>  	setup_clear_cpu_cap(X86_FEATURE_MTRR);
>  	setup_clear_cpu_cap(X86_FEATURE_ACC);
>  	setup_clear_cpu_cap(X86_FEATURE_X2APIC);
> +	setup_clear_cpu_cap(X86_FEATURE_SME);
>  
>  	if (!xen_initial_domain())
>  		setup_clear_cpu_cap(X86_FEATURE_ACPI);
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
