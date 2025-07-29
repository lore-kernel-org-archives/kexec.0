Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00AFC87FCA
	for <kexec@archiver.kernel.org>; Tue, 29 Jul 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9JlasXi5thdYj6KfusHycPKdfl+LKE1gmMwQIgNpXY=; b=GouEcF7YJusPeuH5MycJAS3BE5
	pU4kq9Y/IU1/3CmS6p3ukbL7Ejywd5rF7HNbRwZeOpBqdH3HXuHChh9iYKxZEbHt/4o9VklDp6B/w
	j/1qCYmrLHQRe8U0LXI3nkGY0IX0G0Av42tJ1eYDeKSC0ong8r9QTr/7Ze0G/8iZoCa6Q+6BywF8H
	tkj9wMdc/ohmuJHVAkDszK3V9JpMbvL/iWqamoHnEFTXQeCvulfnuIxT9s/0mGmfr5yQXhM1fujdy
	D0Ow5f+zFBawt8z+h3zMlVHEgZMapd1b/eAXFRNQqUFD3iMWrBqVOqf3prl7d8C1bHgLoLgXI1dQM
	6z8LCKUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugjz2-0000000Gm6g-0oql;
	Tue, 29 Jul 2025 13:03:08 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfQX-0000000GDGA-2anW;
	Tue, 29 Jul 2025 08:11:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 26C8FA54A2F;
	Tue, 29 Jul 2025 08:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46400C4CEEF;
	Tue, 29 Jul 2025 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753776671;
	bh=cWVIex8ZD7iLHUiFYdl7hALOOKwBmGPA9Eu9Lq5/ve4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+W04S5xBBcVSjTJ0lwCukWF0CUJoPlRJ5apOHIjcIp4Ir2h0WEtBfOZPNq9j6UIw
	 6fZP5IdfM5f5vLEjByzE5d1D4q0ntoXIKt1ZlaptYaMMJ/RbpgOJ4vi8j7m1REK/WE
	 cJzV6oM57CeEOUeuFXbdpRKe9ommavUNv3horhLZRAO6muGJhtumt9y36tBBk8z1p0
	 RcW8XEWXTvj+vpzKEBs29ORzEbWanrDmwe68O6LcUhBYBhNbsg7nJAYdHkL7mym1rZ
	 WuxIc0wxhAbBVU5BUD51GFHFqvaCN7R5JBhhYX7ZtWmQVYAe4Cx4MWw9LPH9S4UYr+
	 4hpI//0VngcyA==
Date: Tue, 29 Jul 2025 09:10:55 +0100
From: Will Deacon <will@kernel.org>
To: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 1/4] arm64: Handle KCOV __init vs inline mismatches
Message-ID: <aIiCD5V1MaI3ORqA@willie-the-truck>
References: <20250724054419.it.405-kees@kernel.org>
 <20250724055029.3623499-1-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724055029.3623499-1-kees@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_011113_794745_05F871F8 
X-CRM114-Status: GOOD (  24.89  )
X-Mailman-Approved-At: Tue, 29 Jul 2025 06:03:04 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: "Kirill A. Shutemov" <kas@kernel.org>, linux-efi@vger.kernel.org, Gavin Shan <gshan@redhat.com>, Jan Beulich <jbeulich@suse.com>, kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Usama Arif <usama.arif@bytedance.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Wendling <morbo@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Oza Pawandeep <quic_poza@quicinc.com>, kasan-dev@googlegroups.com, Ard Biesheuvel <ardb@kernel.org>, linux-security-module@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Baoquan He <bhe@redhat.com>, linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, James Morris <jmorris@namei.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Changyuan Lyu <changyuanl@google.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, Brian Gerst <brgerst@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Paul Moore <paul@paul-moore.com>, "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, Nicolas Schier <nicolas.schier@linux.dev>, ibm-acpi-devel@lists.sourceforge.net, kexec@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, James Morse <james.morse@arm.com>, Mike Rapoport <rppt@kernel.org>, Justin Stitt <justinstitt@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, Hans de Goede <hansg@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jul 23, 2025 at 10:50:25PM -0700, Kees Cook wrote:
> GCC appears to have kind of fragile inlining heuristics, in the
> sense that it can change whether or not it inlines something based on
> optimizations. It looks like the kcov instrumentation being added (or in
> this case, removed) from a function changes the optimization results,
> and some functions marked "inline" are _not_ inlined. In that case,
> we end up with __init code calling a function not marked __init, and we
> get the build warnings I'm trying to eliminate in the coming patch that
> adds __no_sanitize_coverage to __init functions:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: acpi_get_enable_method+0x1c (section: .text.unlikely) -> acpi_psci_present (section: .init.text)
> 
> This problem is somewhat fragile (though using either __always_inline
> or __init will deterministically solve it), but we've tripped over
> this before with GCC and the solution has usually been to just use
> __always_inline and move on.
> 
> For arm64 this requires forcing one ACPI function to be inlined with
> __always_inline.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Cc: James Morse <james.morse@arm.com>
> Cc: Oza Pawandeep <quic_poza@quicinc.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> ---
>  arch/arm64/include/asm/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index a407f9cd549e..c07a58b96329 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -150,7 +150,7 @@ acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
>  {}
>  #endif
>  
> -static inline const char *acpi_get_enable_method(int cpu)
> +static __always_inline const char *acpi_get_enable_method(int cpu)
>  {
>  	if (acpi_psci_present())
>  		return "psci";

Thanks for improving the commit message:

Acked-by: Will Deacon <will@kernel.org>

Will

