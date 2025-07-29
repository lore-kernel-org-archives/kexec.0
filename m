Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED15FC83F26
	for <kexec@archiver.kernel.org>; Tue, 29 Jul 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n85pmn0u6Z+c4iXgUXsS+36jAK4nq/BZyup+CKlkXI4=; b=A1V/L8up/+jsYOJ9QwRTimzmwO
	tlDmj6P1pZOGI4MInM//1gGbmekXruB9dZT5LWdE0fksNUV3walzcIJt7WZspG76WUWY+b/sVMUHQ
	D/WGOoZ5lDKdBYuG2t6BCIKoW8MwircbMpUCej89gY8BmYS0c30+8GnaRyXHRAnrmiQmt6glj2ksA
	n5us67zOl8xMpX91ZUIjvjl8HPvuh7Es+qzzH73tUCSk4ZaV1sKqKx1piIqfUXluCVqKNpszS4mDf
	sEJscwaCqE0dAo9gjtW+g8HzmRH7y7xwXbYUglgWnUdFbevd3ugUMPPzzURBnjha92ViqDKoPVWDQ
	+IQNQr9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugjz2-0000000Gm6z-2Jr2;
	Tue, 29 Jul 2025 13:03:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfhS-0000000GFuV-3iay;
	Tue, 29 Jul 2025 08:28:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 90E9A5C5B7A;
	Tue, 29 Jul 2025 08:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D23CC4CEEF;
	Tue, 29 Jul 2025 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777721;
	bh=P+RKJolWrlScvE03/wuLDUcQEOrpyiH5p1dHdVtXVqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKsDX+KRLzAFuf1kLKdAmDj9dggFsRzjLIQ05RDsi+xPOxdHLALkhNkurvUosgFfb
	 ftJlhmN/pjoAT4/au8qTUftIBkqDaJhrJ9SmRZi3Ve7JVy7Eg31DCCYSekcyfaaJNQ
	 JbMb4DIBM9PPiwPI8OZcRcytRu3/nqoGHVDzvP77YimImLNlQUbkZujH5O0JN2T+nM
	 BtsmRo4XDjlCw0KnWSDM6rk+MZk6QP0uSqf7QW3w7lmJVVGYAkgz4EWZXggXy7tATT
	 HSfQX1ig9jgw3cwDIYjp+vOlzwygxMw47ojEswZF9ZVaUkapQqAqU4ht2sNRBTvD+l
	 uIGHhOPpyE+nA==
Date: Tue, 29 Jul 2025 11:28:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 2/4] x86: Handle KCOV __init vs inline mismatches
Message-ID: <aIiGHmw8IJb9vsM5@kernel.org>
References: <20250724054419.it.405-kees@kernel.org>
 <20250724055029.3623499-2-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724055029.3623499-2-kees@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_012843_004341_4FA3A7CD 
X-CRM114-Status: GOOD (  17.61  )
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
Cc: "Kirill A. Shutemov" <kas@kernel.org>, linux-efi@vger.kernel.org, Gavin Shan <gshan@redhat.com>, Jan Beulich <jbeulich@suse.com>, kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev, Marco Elver <elver@google.com>, Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, Usama Arif <usama.arif@bytedance.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Wendling <morbo@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-security-module@vger.kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>, Baoquan He <bhe@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Oza Pawandeep <quic_poza@quicinc.com>, Sami Tolvanen <samitolvanen@google.com>, Changyuan Lyu <changyuanl@google.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Len Brown <lenb@kernel.org>, Thomas Huth <thuth@redhat.com>, Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-kbuild@vger.kernel.org, Brian Gerst <brgerst@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, James Morris <jmorris@namei.org>, Bibo Mao <maobibo@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, "Serge E. Hallyn" <serge@hallyn.com>, Nicolas Schier <nicolas.schier@linux.dev>, Paul Moore <paul@paul-moore.com>, ibm-acpi-devel@lists.sourceforge.net, kexec@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, James Morse <james.morse@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Justin Stitt <justinstitt@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, Roger Pau Monne <roger.pau@citrix.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jul 23, 2025 at 10:50:26PM -0700, Kees Cook wrote:
> GCC appears to have kind of fragile inlining heuristics, in the
> sense that it can change whether or not it inlines something based on
> optimizations. It looks like the kcov instrumentation being added (or in
> this case, removed) from a function changes the optimization results,
> and some functions marked "inline" are _not_ inlined. In that case,
> we end up with __init code calling a function not marked __init, and we
> get the build warnings I'm trying to eliminate in the coming patch that
> adds __no_sanitize_coverage to __init functions:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: xbc_exit+0x8 (section: .text.unlikely) -> _xbc_exit (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: real_mode_size_needed+0x15 (section: .text.unlikely) -> real_mode_blob_end (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: __set_percpu_decrypted+0x16 (section: .text.unlikely) -> early_set_memory_decrypted (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: memblock_alloc_from+0x26 (section: .text.unlikely) -> memblock_alloc_try_nid (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: acpi_arch_set_root_pointer+0xc (section: .text.unlikely) -> x86_init (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: acpi_arch_get_root_pointer+0x8 (section: .text.unlikely) -> x86_init (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: efi_config_table_is_usable+0x16 (section: .text.unlikely) -> xen_efi_config_table_is_usable (section: .init.text)
> 
> This problem is somewhat fragile (though using either __always_inline
> or __init will deterministically solve it), but we've tripped over
> this before with GCC and the solution has usually been to just use
> __always_inline and move on.
> 
> For x86 this means forcing several functions to be inline with
> __always_inline.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

For memblock bit:

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

