Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9213C87FCA
	for <kexec@archiver.kernel.org>; Sat, 26 Jul 2025 08:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DWe1h6lAgsNkrVeizukL0vDDaalZ++F813ABZF5oc44=; b=tlNEgv8TgqqgAHQkAV/hmZdBG0
	gOF+UgGHWepH+UmIXAvDGmYCyi3pCbtDhZb9NR+IEZLQjy2PUhjTTNXohixuZKofwAW3/fBUwBSFz
	1bKyt+Yx7m5xohelzDZVnd4fsCGzS+PhJkD2kI3JS/+MdYXAhN2pVaIQtSIJ8Rs2FHdlSwrBmKdhK
	pae/ZCKxVEmFy3Oq11ntslMRCo3WJlYkJU1RgCiUVfJ3McCm9G8xEjBLYE6+BHxIFPbY/Q5E5Fcb6
	zhBzTimd10IWLuHB8EiACEUhYAdOrRCava2B/L1NYQZfxX9ZdNA17Vp/f9ks8dcY3UCNeV8MLpobV
	y/hnzM1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufabL-0000000BHYX-369y;
	Sat, 26 Jul 2025 08:49:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufYNM-0000000BBkH-0msS;
	Sat, 26 Jul 2025 06:27:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 664B5A4E0E0;
	Sat, 26 Jul 2025 06:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7054C4CEED;
	Sat, 26 Jul 2025 06:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753511238;
	bh=LlIMTFVzXwdSlzjowza5NRuahl7DloIjtQs9FFDcY/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fq2xnjNp2Rnf6iAlZuKY1DeL5Taz3Wd30zVOYss8rTdrQFYNsNc7QchDwyboJt8MO
	 GyBnduAMMlNsE8pFM+5ks4z6k6V1Q2RKNUvUebb8ez9Dk91IZbgcxkBTqATFe8mruT
	 F99Rn3HFLCaODcvN0/FwBjHEpq31Kn5eyDzW/dj5r5P0sUBxDUJYgOFUF2H+2OXMD+
	 b0uHv/EensaRP3baa7pQtYIuc8JXI/UQX+u/sHXMOJv7/rcSM6jN0iAiHQTQj5ULlP
	 XjDMcwoXUT3oMirM6oHEboAxIgl2XJlfJ7zAX534y/jxfcJsjtNnBZ1ScfFvhmh9Hi
	 n1Xg4NOsRzPeQ==
Date: Fri, 25 Jul 2025 23:27:18 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4 0/4] stackleak: Support Clang stack depth tracking
Message-ID: <202507252322.8774CA6FCF@keescook>
References: <20250724054419.it.405-kees@kernel.org>
 <20250726004313.GA3650901@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726004313.GA3650901@ax162>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_232720_367246_4B4A9F7A 
X-CRM114-Status: GOOD (  16.19  )
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

On Fri, Jul 25, 2025 at 05:43:13PM -0700, Nathan Chancellor wrote:
> A few build issues that I see when building next-20250725, which seem
> related to this series.

AH! Thank you for letting me know!

> 1. I see
> 
>   ld.lld: error: undefined symbol: __sanitizer_cov_stack_depth
>   >>> referenced by atags_to_fdt.c
>   >>>               arch/arm/boot/compressed/atags_to_fdt.o:(atags_to_fdt)
>   make[5]: *** [arch/arm/boot/compressed/Makefile:152: arch/arm/boot/compressed/vmlinux] Error 1
> 
> when building ARCH=arm allmodconfig on next-20250725. The following diff appears to cure that one.

Ah-ha perfect. Yes, that matches what I was expecting to fix it, I was
just about to start working on it, but you beat me to it. :) The same
was reported here:
https://lore.kernel.org/all/CA+G9fYtBk8qnpWvoaFwymCx5s5i-5KXtPGpmf=_+UKJddCOnLA@mail.gmail.com

> 2. I see
> 
>   kernel/kstack_erase.c:168:2: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]
> [...]
> when building ARCH=i386 allmodconfig.

Oh, hm, I will figure that out.

> 3. I see
> 
>   In file included from kernel/fork.c:96:
>   include/linux/kstack_erase.h:29:37: error: passing 'const struct task_struct *' to parameter of type 'struct task_struct *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>      29 |         return (unsigned long)end_of_stack(tsk) + sizeof(unsigned long);
>         |                                            ^~~
>   include/linux/sched/task_stack.h:56:63: note: passing argument to parameter 'p' here
>      56 | static inline unsigned long *end_of_stack(struct task_struct *p)
>         |                                                               ^
> 
> when building ARCH=loongarch allmodconfig, which does not support
> CONFIG_THREAD_INFO_IN_TASK it seems.

Oh, eek. Yeah, I'll need to make an explicit dependency I guess? ("How
did this ever work?")

Thanks again!

-- 
Kees Cook

