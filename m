Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43AFC369DC
	for <kexec@archiver.kernel.org>; Sun,  4 May 2025 06:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVBwqX1ezH0Mhh86/HBxu1j453riIZ+vJy3Ey/WMQ18=; b=SXhvAm/I4GWw89ZLqXuRU19IA8
	MKdpKY6Ja24jdp56bVCMBh1lkvBYXzsXEyUv8WHRi1k6fGRbup+eNVvv5B7HUCo47g3amsv5r6cJE
	StCss5eEeRCBubDo+o3DOsGBcfmh0o47ckGN6ubHNXLKlv86i8e0PPVqBpna6BXYGt4FDBMT+H6xJ
	OiamYs2LliF/cl6xxugL30Z7AVkUOMBimeew3pz9WpLYCt01QUDs6c8kuGxsduUn4Dk83bYebfsEa
	uAe+5flrzhG3E09nmXOOSl1DVGnotflFkjYfxHMtgFpz5cW5AZIk91B1DjZCKA1aoEZ5+ddf9wd0W
	kEngkQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBT75-00000004vkc-0LkQ;
	Sun, 04 May 2025 06:46:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBT72-00000004vji-3rRL
	for kexec@lists.infradead.org;
	Sun, 04 May 2025 06:46:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8AFD445380;
	Sun,  4 May 2025 06:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439FDC4CEE7;
	Sun,  4 May 2025 06:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746341167;
	bh=51T2H+nV5meAOaX2rZBwkpSKfRUq+Iq+o3fb3uLam0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sSm6QIs7UUo//Vxcje3XenbcCi8K+Bk9507Ht37AzXBePl9BkbNmB1OvxBuYw68OB
	 Pjsz3aaG/49dZjGQDIUnqf3+Jz7Q71EnMTy4Oq9VQt1nrM3ujGw/IFpcbkkRXEpoGQ
	 NB1u8Rr105CD0o1NGvGChLprqnRMyZRaaw00obR0=
Date: Sat, 3 May 2025 23:46:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, Milan
 Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, Daniel P .
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Kairui Song
 <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, Baoquan He
 <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen
 <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud
 Lefebvre <arnaud.lefebvre@clever-cloud.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH v9 6/8] Revert
 "x86/mm: Remove unused __set_memory_prot()"
Message-Id: <20250503234605.94d954b6ca70ea09c0aa8004@linux-foundation.org>
In-Reply-To: <20250502011246.99238-7-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
	<20250502011246.99238-7-coxu@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_234608_969769_2A5AE8E8 
X-CRM114-Status: GOOD (  11.41  )
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

On Fri,  2 May 2025 09:12:40 +0800 Coiby Xu <coxu@redhat.com> wrote:

> This reverts commit 693bbf2a50447353c6a47961e6a7240a823ace02 as kdump
> LUKS support (CONFIG_CRASH_DM_CRYPT) depends on __set_memory_prot.
> 

x86_64 allmodconfig:

In file included from drivers/gpu/drm/i915/gt/intel_ggtt.c:6:
./arch/x86/include/asm/set_memory.h:40:57: error: unknown type name 'pgprot_t'
   40 | int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
      |                                                         ^~~~~~~~

I did this:


From: Andrew Morton <akpm@linux-foundation.org>
Subject: revert-x86-mm-remove-unused-__set_memory_prot-fix
Date: Sat May  3 11:38:32 PM PDT 2025

x86 set_memory.h needs pgtable_types.h for pgprot_t.  Obtain it via the
higher-level pgtable.h.

Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jan Pazdziora <jpazdziora@redhat.com>
Cc: Liu Pingfan <kernelfans@gmail.com>
Cc: Milan Broz <gmazyland@gmail.com>
Cc: Ondrej Kozina <okozina@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/include/asm/set_memory.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/set_memory.h~revert-x86-mm-remove-unused-__set_memory_prot-fix
+++ a/arch/x86/include/asm/set_memory.h
@@ -4,6 +4,7 @@
 
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
+#include <asm/pgtable.h>
 
 #define set_memory_rox set_memory_rox
 int set_memory_rox(unsigned long addr, int numpages);
_


