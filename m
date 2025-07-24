Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC77C87FC5
	for <kexec@archiver.kernel.org>; Thu, 24 Jul 2025 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tWEmAXSsSqp0aOqLizAGvUyWWzoVjGCWN3V0l/bYucM=; b=Cs92V3AHSA4UKJ
	I12DHfArH/A4Lgnn8HbXvSadGtOwVEZCUmIvcz4gKujTbfsZxd1SNJQgJ9YWoFgiMbjKOG3Vmeb84
	ZAkDIBKfzLYA+KaPBGZJG9ENiYCgZimdpWXFkXFlOfNZghzu+2O+WsAWVvielTPo/0DA8L8JYQDs9
	TJMOLSMKfilhogcna2F4Wnd5EcCLvmh1y6UL2fL7cH1bJig4KU/wGAIk1ecH+UhLSxm5XVO+079KH
	URb27bLc/Cy8mssjwd3CpQBKUinXTAiO+rAMVf4HbkOF6fsHH83V7T+VDgaShaMDMNoCKviaA2+Fo
	OhU8TLk0sXsZe5LAWIzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uerqh-00000006yZX-2gUN;
	Thu, 24 Jul 2025 09:02:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueoqd-00000006Xxp-3WTR;
	Thu, 24 Jul 2025 05:50:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ABA9B5C41BA;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C87FC4CEF6;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753336230;
	bh=HjxWaeaCv8M/oL9GQSiYPTHDkhtk+DTRYh358m2uH3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s29zubuefnI+LBjVqZ9vpCGlu5Y5WvluYyoGkQGyTns5h1ASI0ONXsaMz96AIkRXI
	 cZ6ofUY5AV/ts56FD7h4Y1bDIuQLpyBShwLCqHUW8DfnoPw2vQJCqzlbBvLEe9bAOI
	 kxQ0p30UKRiDezURaIGb+gVISD37zXrkYV5ryEw6lEsNnY69EOXcRhYpYb1D80YLxn
	 I+zACitAelI7J9mGOrR/C6kNqZ5T5TmrV+gQX0mkg7goDAphZEna6azIrtOhh7fcjB
	 Z+KIemqogOSqAlWLzBYa9uUGf/kIwnqbXHcE1N7vHH7V81ftidRhNtlb3B2IzsvdA6
	 8adJrtZ2w9B2Q==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 1/4] arm64: Handle KCOV __init vs inline mismatches
Date: Wed, 23 Jul 2025 22:50:25 -0700
Message-Id: <20250724055029.3623499-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724054419.it.405-kees@kernel.org>
References: <20250724054419.it.405-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=kees@kernel.org; h=from:subject; bh=HjxWaeaCv8M/oL9GQSiYPTHDkhtk+DTRYh358m2uH3A=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNJxevUIqUu+2x4F/fOofGOacvWqgmvnqeLJv0JeJDL usnHfXgjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIn41TAyrHh499h001Vid05L Nkw14RZx7siKejb92THeWXEx6x9PFmT4K1OTc6Ms/eTviZ93fAuV7N800326HO/5hfY1V14Gh4a 0MAEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250723_225031_956827_779EA15F 
X-CRM114-Status: GOOD (  16.12  )
X-Mailman-Approved-At: Thu, 24 Jul 2025 01:12:22 -0700
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
Cc: "Kirill A. Shutemov" <kas@kernel.org>, linux-efi@vger.kernel.org, Gavin Shan <gshan@redhat.com>, Jan Beulich <jbeulich@suse.com>, kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Usama Arif <usama.arif@bytedance.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Wendling <morbo@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Oza Pawandeep <quic_poza@quicinc.com>, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Baoquan He <bhe@redhat.com>, linux-acpi@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, James Morris <jmorris@namei.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Changyuan Lyu <changyuanl@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Alexander Graf <graf@amazon.com>, "Paul E. McKenney" <paulmck@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Brian Gerst <brgerst@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Paul Moore <paul@paul-moore.com>, "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, Nicolas Schier <nicolas.schier@linux.dev>, ibm-acpi-devel@lists.sourceforge.net, kexec@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, James Morse <james.morse@arm.com>, Mike Rapoport <rppt@kernel.org>, Justin Stitt <justinstitt@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, Hans de Goede <hansg@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

GCC appears to have kind of fragile inlining heuristics, in the
sense that it can change whether or not it inlines something based on
optimizations. It looks like the kcov instrumentation being added (or in
this case, removed) from a function changes the optimization results,
and some functions marked "inline" are _not_ inlined. In that case,
we end up with __init code calling a function not marked __init, and we
get the build warnings I'm trying to eliminate in the coming patch that
adds __no_sanitize_coverage to __init functions:

WARNING: modpost: vmlinux: section mismatch in reference: acpi_get_enable_method+0x1c (section: .text.unlikely) -> acpi_psci_present (section: .init.text)

This problem is somewhat fragile (though using either __always_inline
or __init will deterministically solve it), but we've tripped over
this before with GCC and the solution has usually been to just use
__always_inline and move on.

For arm64 this requires forcing one ACPI function to be inlined with
__always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: James Morse <james.morse@arm.com>
Cc: Oza Pawandeep <quic_poza@quicinc.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm64/include/asm/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index a407f9cd549e..c07a58b96329 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -150,7 +150,7 @@ acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
 {}
 #endif
 
-static inline const char *acpi_get_enable_method(int cpu)
+static __always_inline const char *acpi_get_enable_method(int cpu)
 {
 	if (acpi_psci_present())
 		return "psci";
-- 
2.34.1


