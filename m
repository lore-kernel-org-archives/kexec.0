Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB964C87FCF
	for <kexec@archiver.kernel.org>; Sat, 26 Jul 2025 08:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ne/XcgrgO/KJ5Vpn5Kmd1KTfFMh8OZxebN5iFuDYEM8=; b=zYY2patNOrTvtbH6UPrdfwn7aC
	6CJLeDT15MMX62Szsq/QajFErMNuZ5e5IysB2Td+mI1j2+xFm0u/oBLrtUNjweLN6RUVEcAiDA/Vw
	nZ0W7rFx3TTXwgE5Oyo2B76fkdJ+rM3Z5ayOWs3k4vXgBKoK7SZU9FQLlXplekMn+B0wOLjtoEdEV
	whMY6KoVkmVbKJyk6gc2xa2mTjIg4+zkkh7m1EpaNTJBePhFPtzrcvvNWZ48l5G44gfpdQsV+7r4z
	Is3KXjyU1oQOoKc2zbCOZYoRvOk1gFWWkV2t6NFzzkE/Ht48/wXqrMkqwTlLpKgTIzd5irfrBwlzy
	HWk20Smg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufabL-0000000BHYL-09ct;
	Sat, 26 Jul 2025 08:49:55 +0000
Received: from mail.avm.de ([212.42.244.120])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uevh7-00000007TtX-2EwH;
	Thu, 24 Jul 2025 13:09:11 +0000
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 6882306d-0380-7f0000032729-7f000001eb7c-1
	for <multiple-recipients>; Thu, 24 Jul 2025 15:09:01 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 24 Jul 2025 15:09:01 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 09A4980AA3;
	Thu, 24 Jul 2025 15:09:02 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id 6DAEF184464;
	Thu, 24 Jul 2025 15:09:00 +0200 (CEST)
Date: Thu, 24 Jul 2025 15:08:58 +0200
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 4/4] kstack_erase: Support Clang stack depth tracking
Message-ID: <20250724-optimistic-armadillo-of-joviality-e59222@l-nschier-aarch64>
References: <20250724054419.it.405-kees@kernel.org>
 <20250724055029.3623499-4-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250724055029.3623499-4-kees@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1753362541-3C575E1C-2FB622E2/0/0
X-purgate-type: clean
X-purgate-size: 870
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_060909_711564_352FD8F1 
X-CRM114-Status: UNSURE (   7.91  )
X-CRM114-Notice: Please train this message.
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
Cc: "Kirill A. Shutemov" <kas@kernel.org>, x86@kernel.org, Gavin Shan <gshan@redhat.com>, Jan Beulich <jbeulich@suse.com>, kvm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, "Peter Zijlstra \(Intel\)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev, Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Usama Arif <usama.arif@bytedance.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-hardening@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Oza Pawandeep <quic_poza@quicinc.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Baoquan He <bhe@redhat.com>, linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, James Morris <jmorris@namei.org>, kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Changyuan Lyu <changyuanl@google.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, Marco Elver <elver@google.com>, Alexander Graf <graf@amazon.com>, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, Brian Gerst <brgerst@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Paul Moore <paul@paul-moore.com>, "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, "Serge E. Hallyn" <serge@hallyn.com>, ibm-acpi-devel@lists.sourceforge.net, kexec@lists.infradead.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, James Morse <james.morse@arm.com>, Hans de Goede <hansg@kernel.org>, Justin Stitt <justinstitt@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Bill Wendling <morbo@google.com>, David Woodhouse <dwmw@amazon.co.uk>, Mike Rapoport <rppt@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jul 23, 2025 at 10:50:28PM -0700, Kees Cook wrote:
> Wire up CONFIG_KSTACK_ERASE to Clang 21's new stack depth tracking
> callback[1] option.
>=20
> Link: https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-stack-de=
pth [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas.schier@linux.dev>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: <linux-kbuild@vger.kernel.org>
> Cc: <kasan-dev@googlegroups.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---

Acked-by: Nicolas Schier <n.schier@avm.de>

