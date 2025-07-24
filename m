Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D05C83F26
	for <kexec@archiver.kernel.org>; Thu, 24 Jul 2025 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C2VkXjr1vmtMoAwGuzNgZ6GgP6+IF/LpC6JdENa6i7Q=; b=wuSUDbmozorii/
	8qCgqa4AsQ13EcVenPQ49htTSb7514LgjesqYBatrh2QStCH0BBE7q9PDHl2vcMZfKNNwsQpUBb+Y
	/EdsC139v2/AkxOvUvsa3ykjlUEWFkiA80/VJldclecB8ntq13dBMWOZiOritsat6xYTUGQeEUCzy
	MrzR5VFK4j58nLbeKW+o4PK6tDnbXMgnS8ZIPjFcGkWIGK13Gxp6gklCUNVTv/fojoO8m5lfgb7Oj
	yICXkd43d4vzl7rCO9gzouqWUBWo/9hScKqtfbi4LFGCxkZsnYTkv6YRuzwUjmGZLV+DUmy/zKaHn
	eWdXLPnSkuP51yPxaB4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uerqh-00000006yZR-1B0l;
	Thu, 24 Jul 2025 09:02:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueoqd-00000006Xxo-0q2D;
	Thu, 24 Jul 2025 05:50:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F59C601DF;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA19C4CEF4;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753336230;
	bh=XE3wpC5OKAVRvxdPiqi/2WsaLPvDes1ay28krOB8Nyg=;
	h=From:To:Cc:Subject:Date:From;
	b=d0/TMlHJD3g/KJWGAgQ/f/vsSu6dz+U/wQhw7RJ+hpjI1X/Sb0vKcWNoCHtrHbwiT
	 fH44GGf8Ya+PkaTReniUuYLdOVN2Z7VZtAILtvfvcjiAgUuEzQ5NtxiABxovHh0dhh
	 CjjXTbcKODbX01+IxIuANaBudNKSlp4sTNUtj/Dm700M2Xeul+T3LNAq2Cwpvn93hM
	 3mtHpKM4dxgJplW4BiyL41PLzD8gk1AUnlrUjfa7EyvQF15EPpx30bWI4LoLGEpTl8
	 AnYSr9DuaqtX57N9wGYm/6ZnjhE8O4TTw5SsPmlN/kayzZrdvOKdlCPjUMa8a9ErZI
	 bpYkRhkl38Olg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 0/4] stackleak: Support Clang stack depth tracking
Date: Wed, 23 Jul 2025 22:50:24 -0700
Message-Id: <20250724054419.it.405-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439; i=kees@kernel.org; h=from:subject:message-id; bh=XE3wpC5OKAVRvxdPiqi/2WsaLPvDes1ay28krOB8Nyg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNJxc5mZrpNj5K4tORy/7TeZXhw9upF18pr/M4P+mO0 qJ1Zxv/dZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkx3ZGhj3Lo9RPfd61sO3K 6ZOX39cZ7GLmn/6vehbf2xvW83qXM01nZOhJWph/qli05kP325oNd1z3S2krH/3OsOnxZQ05w52 HynkB
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
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

 v4:
  - rebase on for-next/hardening tree (took subset of v3 patches)
  - improve commit logs for x86 and arm64 changes (Mike, Will, Ard)
 v3: https://lore.kernel.org/lkml/20250717231756.make.423-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20250523043251.it.550-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20250507180852.work.231-kees@kernel.org/

Hi,

These are the remaining changes needed to support Clang stack depth
tracking for kstack_erase (nee stackleak).

Thanks!

-Kees

Kees Cook (4):
  arm64: Handle KCOV __init vs inline mismatches
  x86: Handle KCOV __init vs inline mismatches
  init.h: Disable sanitizer coverage for __init and __head
  kstack_erase: Support Clang stack depth tracking

 security/Kconfig.hardening      | 5 ++++-
 scripts/Makefile.kstack_erase   | 6 ++++++
 arch/arm64/include/asm/acpi.h   | 2 +-
 arch/x86/include/asm/acpi.h     | 4 ++--
 arch/x86/include/asm/init.h     | 2 +-
 arch/x86/include/asm/realmode.h | 2 +-
 include/linux/acpi.h            | 4 ++--
 include/linux/bootconfig.h      | 2 +-
 include/linux/efi.h             | 2 +-
 include/linux/init.h            | 4 +++-
 include/linux/memblock.h        | 2 +-
 include/linux/smp.h             | 2 +-
 arch/x86/kernel/kvm.c           | 2 +-
 arch/x86/mm/init_64.c           | 2 +-
 kernel/kexec_handover.c         | 4 ++--
 15 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.34.1


