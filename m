Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD729C87FD1
	for <kexec@archiver.kernel.org>; Sat, 26 Jul 2025 08:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1sAzsEOvW+OhZvMm5Zu/ODZB3aFKVogO7ESRBoesTkU=; b=TUVWt+LC3/zK8Ip+TO7t9F+vV9
	TWKClumglZTi2dZFqBgfCmZ6qtJoIhqBIB1/o7A/gUfst03YfIgW9rv09NEwWTmyD3cLS7OEddLWC
	i26WwERm48QVLruIy6P7fvcRVz8wJ3QPLBu8bpdN0Q//xuM9VJPgGSjsdSHCjuKSuA5kxqc1i6KZN
	H3kPK8C3sppnNd1nVPvQ3RD7YYGXkXULnlViXQFWEG1I9wxuOfSUyDkbdOAS83SNNjxqn7PRa/QY7
	SKj/Mgcf5lTjXuPrjoLOTfrfAq2Q0hkfuWLH3nA58HKYz6z5esLmYPjc2ukZzIZpAfiEdFvgNT7lY
	zWtKslJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufabL-0000000BHYR-1Zx8;
	Sat, 26 Jul 2025 08:49:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufT0e-0000000Aygn-1pql;
	Sat, 26 Jul 2025 00:43:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 31FE3A567D6;
	Sat, 26 Jul 2025 00:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1170C4CEE7;
	Sat, 26 Jul 2025 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753490610;
	bh=FRa9xY4x5DiJRX0obptGEWaAk44wN8I8KzUTZYrUCjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBaBfcy8cvOEOsPzmxHVilPiLtCGr+TDf8X/qOm2ye9g94waAiMThV6LQwkD5mGES
	 PDjLL+F1jsLeU64wJNGH2USu78DXOVIauVdSn5Za3ug6EyGqMkDWY68qx6CO1Gpj84
	 N2fKc/oxH+okv+yKP2JrlydnIbTVzpb6w9fxjXPvPbNQT1zbh2x+enrj7WanGNqURj
	 oluIdS5LRKkHy5qC/5rWJa6TJsIQMsqWbSs6k1imrXOBgatcUYq26mfwhTEKJwXKN7
	 wK8GX+boueI26+UPx4/MDOH6NBVBpUuOSwVrQlpds5FDuUw13v4g1+lMsu+qwH3eh6
	 5w2Rudv02W7cA==
Date: Fri, 25 Jul 2025 17:43:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 0/4] stackleak: Support Clang stack depth tracking
Message-ID: <20250726004313.GA3650901@ax162>
References: <20250724054419.it.405-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724054419.it.405-kees@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_174332_608105_7294EC02 
X-CRM114-Status: GOOD (  16.68  )
X-Mailman-Approved-At: Sat, 26 Jul 2025 01:49:53 -0700
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
Cc: "Kirill A. Shutemov" <kas@kernel.org>, linux-efi@vger.kernel.org, Gavin Shan <gshan@redhat.com>, Jan Beulich <jbeulich@suse.com>, kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Usama Arif <usama.arif@bytedance.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Wendling <morbo@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Oza Pawandeep <quic_poza@quicinc.com>, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-security-module@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Baoquan He <bhe@redhat.com>, linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, James Morris <jmorris@namei.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Changyuan Lyu <changyuanl@google.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, Brian Gerst <brgerst@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Paul Moore <paul@paul-moore.com>, "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, Nicolas Schier <nicolas.schier@linux.dev>, ibm-acpi-devel@lists.sourceforge.net, kexec@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, James Morse <james.morse@arm.com>, Mike Rapoport <rppt@kernel.org>, Justin Stitt <justinstitt@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, Hans de Goede <hansg@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Kees,

On Wed, Jul 23, 2025 at 10:50:24PM -0700, Kees Cook wrote:
>  v4:
>   - rebase on for-next/hardening tree (took subset of v3 patches)
>   - improve commit logs for x86 and arm64 changes (Mike, Will, Ard)
>  v3: https://lore.kernel.org/lkml/20250717231756.make.423-kees@kernel.org/
>  v2: https://lore.kernel.org/lkml/20250523043251.it.550-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20250507180852.work.231-kees@kernel.org/
> 
> Hi,
> 
> These are the remaining changes needed to support Clang stack depth
> tracking for kstack_erase (nee stackleak).

A few build issues that I see when building next-20250725, which seem
related to this series.

1. I see

  ld.lld: error: undefined symbol: __sanitizer_cov_stack_depth
  >>> referenced by atags_to_fdt.c
  >>>               arch/arm/boot/compressed/atags_to_fdt.o:(atags_to_fdt)
  make[5]: *** [arch/arm/boot/compressed/Makefile:152: arch/arm/boot/compressed/vmlinux] Error 1

when building ARCH=arm allmodconfig on next-20250725. The following diff appears to cure that one.

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index f9075edfd773..f6142946b162 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -9,7 +9,6 @@ OBJS		=
 
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
-CFLAGS_decompress.o += $(DISABLE_KSTACK_ERASE)
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 AFLAGS_head.o += -DDEBUG
@@ -96,7 +95,7 @@ KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
 	     -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
-	     -I$(obj)
+	     -I$(obj) $(DISABLE_KSTACK_ERASE)
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
 asflags-y := -DZIMAGE
 
--

2. I see

  kernel/kstack_erase.c:168:2: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]
    168 |         BUILD_BUG_ON(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE > KSTACK_ERASE_SEARCH_DEPTH);
        |         ^
  include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        |         ^
  include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^
  include/linux/compiler_types.h:568:2: note: expanded from macro 'compiletime_assert'
    568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^
  include/linux/compiler_types.h:556:2: note: expanded from macro '_compiletime_assert'
    556 |         __compiletime_assert(condition, msg, prefix, suffix)
        |         ^
  include/linux/compiler_types.h:549:4: note: expanded from macro '__compiletime_assert'
    549 |                         prefix ## suffix();                             \
        |                         ^
  <scratch space>:97:1: note: expanded from here
     97 | __compiletime_assert_521
        | ^
  kernel/kstack_erase.c:168:2: note: '__compiletime_assert_521' declared here
  include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        |         ^
  include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^
  include/linux/compiler_types.h:568:2: note: expanded from macro 'compiletime_assert'
    568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^
  include/linux/compiler_types.h:556:2: note: expanded from macro '_compiletime_assert'
    556 |         __compiletime_assert(condition, msg, prefix, suffix)
        |         ^
  include/linux/compiler_types.h:546:26: note: expanded from macro '__compiletime_assert'
    546 |                 __noreturn extern void prefix ## suffix(void)           \
        |                                        ^
  <scratch space>:96:1: note: expanded from here
     96 | __compiletime_assert_521
        | ^
  kernel/kstack_erase.c:172:11: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]
    172 |         if (sp < current->lowest_stack &&
        |                  ^
  arch/x86/include/asm/current.h:28:17: note: expanded from macro 'current'
     28 | #define current get_current()
        |                 ^
  arch/x86/include/asm/current.h:20:44: note: 'get_current' declared here
     20 | static __always_inline struct task_struct *get_current(void)
        |                                            ^
  kernel/kstack_erase.c:173:37: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]
    173 |             sp >= stackleak_task_low_bound(current)) {
        |                                            ^
  arch/x86/include/asm/current.h:28:17: note: expanded from macro 'current'
     28 | #define current get_current()
        |                 ^
  arch/x86/include/asm/current.h:20:44: note: 'get_current' declared here
     20 | static __always_inline struct task_struct *get_current(void)
        |                                            ^

when building ARCH=i386 allmodconfig.

3. I see

  In file included from kernel/fork.c:96:
  include/linux/kstack_erase.h:29:37: error: passing 'const struct task_struct *' to parameter of type 'struct task_struct *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     29 |         return (unsigned long)end_of_stack(tsk) + sizeof(unsigned long);
        |                                            ^~~
  include/linux/sched/task_stack.h:56:63: note: passing argument to parameter 'p' here
     56 | static inline unsigned long *end_of_stack(struct task_struct *p)
        |                                                               ^

when building ARCH=loongarch allmodconfig, which does not support
CONFIG_THREAD_INFO_IN_TASK it seems.

Cheers,
Nathan

