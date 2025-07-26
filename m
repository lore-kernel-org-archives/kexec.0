Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EB7C87FCC
	for <kexec@archiver.kernel.org>; Tue, 29 Jul 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gpEW/IT9jhTobSNbCvdFZFzFslfquWaEscBQfdtNojw=; b=ku1IC66a17vBDQv8WuQETffByX
	TXXTY6eGnwxpkdACLetqlLc/rZsoF4sDK9f067w7b6SNdSSVAgtky+tb5XH9u1gOPaD18zY2oBl9P
	HmC6zyTVZ6DdHKWxctiA+L6DhSM3L7zH50BEY9RaryqWsOCWRBJzeFCPEkspnBWLUI1lP8pGLdAx7
	oOGzGhC6AZDtJh1+7Evkru9+GSs1yQxfqrd8ivj5tjKECileHUZmCnIc5w8SZV+yPSFSLkyQGUXgd
	NDGL0S7udyl8iYxGnbma4nDMVl0N6Qhz6tYOtzXPipp14QU9N508XROMWKgr+ib1Ha7wUxwFyQawH
	bjCAcASw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugjz1-0000000Gm6S-3VvZ;
	Tue, 29 Jul 2025 13:03:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufmkL-0000000Bxd7-0dyz;
	Sat, 26 Jul 2025 21:48:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BC184455AE;
	Sat, 26 Jul 2025 21:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF06C4CEF4;
	Sat, 26 Jul 2025 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753566479;
	bh=/eYVX8SoAB6x3E1/nt7tNV75VsKCSwlna2pvOjAdRkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLV+aIK/Vze5Yi37yRjGGquqtluZaj6oEyf8QVw+wrbGGLvpPqO/3VWgN6Q1uJ3EQ
	 QH0nRrCHz1m2MVaid0DwO/ZAreS3vZit+HvBLazabv8sPBvyPMeFsxbcwMrKLtctLL
	 j3NuYhUDBuP296I9Gm2LbU3o4w0jf03jgW1XCsrOoQO/rnS2XvncxSS5g/BxbXsPUY
	 cZFoUBccYezObyf23E1vFbZZhbN05/QUjpb9Nu6YNxWPCEvwX+Xct1jvhL6BlIkWyO
	 EQM6085jWFo3sxIkJ4QMkSe5eI9/li5cIvDNYY225Ouro0eBfYuV1C42m7ggGqabpt
	 /L2PyqAmEpzaQ==
Date: Sat, 26 Jul 2025 14:47:59 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4 0/4] stackleak: Support Clang stack depth tracking
Message-ID: <202507261446.8BDE8B8@keescook>
References: <20250724054419.it.405-kees@kernel.org>
 <20250726004313.GA3650901@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726004313.GA3650901@ax162>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_144801_237318_0B0FD825 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: "Kirill A. Shutemov" <kas@kernel.org>, linux-efi@vger.kernel.org, Gavin Shan <gshan@redhat.com>, Jan Beulich <jbeulich@suse.com>, kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Usama Arif <usama.arif@bytedance.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Wendling <morbo@google.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Oza Pawandeep <quic_poza@quicinc.com>, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-security-module@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Baoquan He <bhe@redhat.com>, linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, James Morris <jmorris@namei.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Changyuan Lyu <changyuanl@google.com>, Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, Brian Gerst <brgerst@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Paul Moore <paul@paul-moore.com>, "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, Nicolas Schier <nicolas.schier@linux.dev>, ibm-acpi-devel@lists.sourceforge.net, kexec@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, James Morse <james.morse@arm.com>, Mike Rapoport <rppt@kernel.org>, Justin Stitt <justinstitt@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, Hans de Goede <hansg@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jul 25, 2025 at 05:43:13PM -0700, Nathan Chancellor wrote:
>   ld.lld: error: undefined symbol: __sanitizer_cov_stack_depth
>   >>> referenced by atags_to_fdt.c

Proposed fix:
https://lore.kernel.org/lkml/20250726212945.work.975-kees@kernel.org/

>   kernel/kstack_erase.c:168:2: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]

Proposed fix:
https://lore.kernel.org/lkml/20250726212615.work.800-kees@kernel.org/

>   In file included from kernel/fork.c:96:
>   include/linux/kstack_erase.h:29:37: error: passing 'const struct task_struct *' to parameter of type 'struct task_struct *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>      29 |         return (unsigned long)end_of_stack(tsk) + sizeof(unsigned long);
>         |                                            ^~~
>   include/linux/sched/task_stack.h:56:63: note: passing argument to parameter 'p' here
>      56 | static inline unsigned long *end_of_stack(struct task_struct *p)
>         |                                                               ^

Proposed fix:
https://lore.kernel.org/lkml/20250726210641.work.114-kees@kernel.org/

Thanks for the reports! :)

-Kees

-- 
Kees Cook

