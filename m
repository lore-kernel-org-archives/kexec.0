Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coUj8-0007vI-48
 for kexec@lists.infradead.org; Thu, 16 Mar 2017 12:42:01 +0000
Received: by mail-wr0-x236.google.com with SMTP id u108so31038001wrb.3
 for <kexec@lists.infradead.org>; Thu, 16 Mar 2017 05:41:36 -0700 (PDT)
Date: Thu, 16 Mar 2017 12:41:32 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: kexec regression since 4.9 caused by efi
Message-ID: <20170316124132.GF6261@codeblueprint.co.uk>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com

On Mon, 13 Mar, at 03:37:48PM, Dave Young wrote:
> 
> Omar, could you try below patch? Looking at the efi_mem_desc_lookup, it is not
> correct to be used in efi_arch_mem_reserve, if it passed your test, I
> can rewrite patch log with more background and send it out:
> 
>         for_each_efi_memory_desc(md) {
> 		[snip]
>                 if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
>                     md->type != EFI_BOOT_SERVICES_DATA &&
>                     md->type != EFI_RUNTIME_SERVICES_DATA) {
>                         continue;
>                 }
> 
> In above code, it meant to get a md of EFI_MEMORY_RUNTIME of either boot
> data or runtime data, this is wrong for efi_mem_reserve, because we are
> reserving boot data which has no EFI_MEMORY_RUNTIME attribute at the
> running time. Just is happened to work and we did not capture the error.

Wouldn't something like this be simpler?

---

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 30031d5293c4..cdfe8c628959 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -201,6 +201,10 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 		return;
 	}
 
+	/* No need to reserve regions that will never be freed. */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	size += addr % EFI_PAGE_SIZE;
 	size = round_up(size, EFI_PAGE_SIZE);
 	addr = round_down(addr, EFI_PAGE_SIZE);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
