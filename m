Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA53C87FCB
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DxjcecEI7phcRYjWyLkZSnGEJwCBjNTRZZccT/msDU8=; b=QTrnuWY7Tl0j2fLFJBaI1pZhC6
	98zkuaYjkML94Krf1RHovTUVpjh50yotvQ/5bre57F3ItMOyp8UKYzFmxOWHEi3UZnc89183pP16P
	QhdTol0TJxlFnRcN3ZzGvaf9YgEbmT1vuF3iogj79mfw8DTgNtDkJc3Lc7yHv72eOhv7NA+Hf7gFU
	inTsRYCTYcg/NZksLIXfWMIBOIaexwxF5LOPAY6pIeDCN5f84o5LWHs56m6ac4ptsQI6D41oiCdKX
	Y8plb93wY9WdSkeZI9U0dPgYfyeQBldLlLpoRIWd8NetviP41RmIs3CXLh5KHtmS7gK6hm4AOm0Yr
	G+yltcxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsLa-0000000BUYN-1nBg;
	Tue, 12 Aug 2025 16:59:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpDt-0000000Awwq-13UM
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 13:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755005968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxjcecEI7phcRYjWyLkZSnGEJwCBjNTRZZccT/msDU8=;
	b=e6PilLsAR7IC4ksgxACTmB8AgMdk6NxIjSG8tl7H7gETI+/cm6rtyjq6IwjRajydpPlWge
	Ko7qmAvwrjAJFPUgwAGkfzVAo6F3naCfHCLZZJclkCcQlP+iRmfyOhdj0zwqiWGA3xy5h7
	vCMTisUNyfWC4b4SB+nOC0qvzqe3DSE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-FY5fxrhNOyqPzbOI5L33kw-1; Tue,
 12 Aug 2025 09:39:22 -0400
X-MC-Unique: FY5fxrhNOyqPzbOI5L33kw-1
X-Mimecast-MFC-AGG-ID: FY5fxrhNOyqPzbOI5L33kw_1755005958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5149919560B3;
	Tue, 12 Aug 2025 13:39:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F8A819560AB;
	Tue, 12 Aug 2025 13:39:15 +0000 (UTC)
Date: Tue, 12 Aug 2025 21:39:11 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org, alexghiti@rivosinc.com, agordeev@linux.ibm.com,
	linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, christophe.leroy@csgroup.eu,
	x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
	linux-um@lists.infradead.org
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aJtD/8beAEHtm2/6@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_063929_363681_4A956518 
X-CRM114-Status: GOOD (  26.17  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Forgot adding related ARCH mailing list or people to CC, add them.

On 08/12/25 at 08:49pm, Baoquan He wrote:
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
> 
> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
> 
> Changelog:
> ====
> v1->v2:
> - Add __ro_after_init for __ro_after_init, and remove redundant blank
>   lines in mm/kasan/common.c. Thanks to Marco.
> - Fix a code bug in <linux/kasan-enabled.h> when CONFIG_KASAN is unset,
>   this is found out by SeongJae and Lorenzo, and also reported by LKP
>   report, thanks to them.
> - Add a missing kasan_enabled() checking in kasan_report(). This will
>   cause below KASAN report info even though kasan=off is set:
>      ==================================================================
>      BUG: KASAN: stack-out-of-bounds in tick_program_event+0x130/0x150
>      Read of size 4 at addr ffff00005f747778 by task swapper/0/1
>      
>      CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #8 PREEMPT(voluntary) 
>      Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
>      Call trace:
>       show_stack+0x30/0x90 (C)
>       dump_stack_lvl+0x7c/0xa0
>       print_address_description.constprop.0+0x90/0x310
>       print_report+0x104/0x1f0
>       kasan_report+0xc8/0x110
>       __asan_report_load4_noabort+0x20/0x30
>       tick_program_event+0x130/0x150
>       ......snip...
>      ==================================================================
> 
> - Add jump_label_init() calling before kasan_init() in setup_arch() in these
>   architectures: xtensa, arm. Because they currenly rely on
>   jump_label_init() in main() which is a little late. Then the early static
>   key kasan_flag_enabled in kasan_init() won't work.
> 
> - In UML architecture, change to enable kasan_flag_enabled in arch_mm_preinit()
>   because kasan_init() is enabled before main(), there's no chance to operate
>   on static key in kasan_init().
> 
> Test:
> =====
> In v1, I took test on x86_64 for generic mode, and on arm64 for
> generic, sw_tags and hw_tags mode. All of them works well.
> 
> In v2, I only tested on arm64 for generic, sw_tags and hw_tags mode, it
> works. For powerpc, I got a BOOK3S/64 machine, while it says
> 'KASAN not enabled as it requires radix' and KASAN is disabled. Will
> look for other POWER machine to test this.
> ====
> 
> Baoquan He (12):
>   mm/kasan: add conditional checks in functions to return directly if
>     kasan is disabled
>   mm/kasan: move kasan= code to common place
>   mm/kasan/sw_tags: don't initialize kasan if it's disabled
>   arch/arm: don't initialize kasan if it's disabled
>   arch/arm64: don't initialize kasan if it's disabled
>   arch/loongarch: don't initialize kasan if it's disabled
>   arch/powerpc: don't initialize kasan if it's disabled
>   arch/riscv: don't initialize kasan if it's disabled
>   arch/x86: don't initialize kasan if it's disabled
>   arch/xtensa: don't initialize kasan if it's disabled
>   arch/um: don't initialize kasan if it's disabled
>   mm/kasan: make kasan=on|off take effect for all three modes
> 
>  arch/arm/kernel/setup.c                |  6 +++++
>  arch/arm/mm/kasan_init.c               |  6 +++++
>  arch/arm64/mm/kasan_init.c             |  7 ++++++
>  arch/loongarch/mm/kasan_init.c         |  5 ++++
>  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
>  arch/riscv/mm/kasan_init.c             |  6 +++++
>  arch/um/kernel/mem.c                   |  6 +++++
>  arch/x86/mm/kasan_init_64.c            |  6 +++++
>  arch/xtensa/kernel/setup.c             |  1 +
>  arch/xtensa/mm/kasan_init.c            |  6 +++++
>  include/linux/kasan-enabled.h          | 18 ++++++-------
>  mm/kasan/common.c                      | 25 ++++++++++++++++++
>  mm/kasan/generic.c                     | 20 +++++++++++++--
>  mm/kasan/hw_tags.c                     | 35 ++------------------------
>  mm/kasan/init.c                        |  6 +++++
>  mm/kasan/quarantine.c                  |  3 +++
>  mm/kasan/report.c                      |  4 ++-
>  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
>  mm/kasan/sw_tags.c                     |  9 +++++++
>  21 files changed, 165 insertions(+), 47 deletions(-)
> 
> -- 
> 2.41.0
> 


