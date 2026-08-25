Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE14C61DB9
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=ZSHXCJLzvwBpnInvl72DddXnlMvclx4F9Tk/CUDHktU=; b=NBlhnDHBQ+eeMchNl+EudDwBLX
	H186F2N1vZvdY35d3BJrTxsfDtl2Rfc6PWPzqQ/uPDvN4sqxat13z1m4IhEftDfk6H5/iQ0mVjc/J
	H5XQJkvLIMk+80+tAZpUPynxwTsEv7mt/KRX/gbhooOW7GAKDPwfMTAXVitKieYzGVc9LGp3YodTb
	p0C8tLF0++t+y+khXvb3ORG1yu26iCFVZdcRwAyOdnCUlt0ODjufYCDmPlQzf3f2CLWjy3bYio/nP
	sbv2YscJnXn2IIirZU7faavF5cOh7hWFsxVxXLVtTVBsYex2bK9ijd2WJgWVbgNNt7GHUDsI9wdr4
	e2JDoGhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyqsE-00000000pK9-1vEn;
	Tue, 25 Aug 2026 13:07:30 +0000
Received: from confino.investici.org ([93.190.126.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyqs8-00000000pJX-1QIn
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 13:07:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787663237;
	bh=ZSHXCJLzvwBpnInvl72DddXnlMvclx4F9Tk/CUDHktU=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=a6VmVuuY96VKdz01smCcEA2RmZFuAZhu4aEzMwG9PWxGTt3AidVEebKXLdsjY73Fl
	 jTQCw/Kx7Zs/BpMKwwA9XHX+luPBc2MYHESj80DLcSM9Vf1Zqb7FOi0XafsVLVvpvV
	 NW78fNAkbiG+F1W0BTJR20K2y96/6TLNcRHq82aQ=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hTp392xYgz10sh;
	Tue, 25 Aug 2026 13:07:17 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hTp3907TMz10sH;
	Tue, 25 Aug 2026 13:07:16 +0000 (UTC)
Date: Tue, 25 Aug 2026 14:07:16 +0100
From: Bradley Morgan <include@grrlz.net>
To: ionut.nechita@windriver.com
CC: akpm@linux-foundation.org, baoquan.he@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, eric.devolder@oracle.com,
 hbathini@linux.ibm.com, hpa@zytor.com, include@grrlz.net,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, rppt@kernel.org,
 ruanjinjie@huawei.com, ruirui.yang@linux.dev, sourabhjain@linux.ibm.com,
 tglx@kernel.org, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_crash=3A_update_stale_NR=5FCPU?=
 =?US-ASCII?Q?S=5FDEFAULT_references_in_elfcorehdr_sizing_docs?=
In-Reply-To: <20260825075043.42041-3-ionut.nechita@windriver.com>
Message-ID: <C1D17DE0-405F-4460-AEB3-B9AD36CF7AB5@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_060724_829091_16D7D0E4 
X-CRM114-Status: GOOD (  12.95  )
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

On 25 August 2026 08:50:43 BST, "Ionut Nechita (Wind River)"
<ionut.nechita@windriver.com> wrote:
>From: Ionut Nechita <ionut.nechita@windriver.com>
>
>The elfcorehdr over-allocation for crash hotplug is now computed from
>CONFIG_NR_CPUS rather than CONFIG_NR_CPUS_DEFAULT, but two pieces of
>documentation still name the old symbol: the comment above
>crash_handle_hotplug_event() and the CRASH_MAX_MEMORY_RANGES help text.
>
>Update both so they describe what the code actually does and do not
>mislead people sizing CRASH_MAX_MEMORY_RANGES.
>
>Documentation only, no functional change.
>
>Suggested-by: Jinjie Ruan <ruanjinjie@huawei.com>
>Suggested-by: Bradley Morgan <include@grrlz.net>

Reviewed-by: Bradley Morgan <include@grrlz.net>

You shockingly didn't CC me!1!1

>Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
>---
> kernel/Kconfig.kexec | 2 +-
> kernel/crash_core.c  | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>index 15632358bcf7..a97ed9605602 100644
>--- a/kernel/Kconfig.kexec
>+++ b/kernel/Kconfig.kexec
>@@ -167,7 +167,7 @@ config CRASH_MAX_MEMORY_RANGES
> 	  memory regions that the elfcorehdr buffer/segment can accommodate.
> 	  These regions are obtained via walk_system_ram_res(); eg. the
> 	  'System RAM' entries in /proc/iomem.
>-	  This value is combined with NR_CPUS_DEFAULT and multiplied by
>+	  This value is combined with NR_CPUS and multiplied by
> 	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
> 	  segment size.
> 	  The value 8192, for example, covers a (sparsely populated) 1TiB system
>diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>index 2b36aa9fade0..d0bd2d0cf899 100644
>--- a/kernel/crash_core.c
>+++ b/kernel/crash_core.c
>@@ -648,7 +648,7 @@ int crash_check_hotplug_support(void)
>  * new list of CPUs and memory. To make changes to the elfcorehdr, it
>  * should be large enough to permit a growing number of CPU and Memory
>  * resources. One can estimate the elfcorehdr memory size based on
>- * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
>+ * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
>  * excluded from SHA verification by default if the architecture
>  * supports crash hotplug.
>  */
>


Thanks!

