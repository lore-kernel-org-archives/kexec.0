Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E2C3ABBE
	for <kexec@archiver.kernel.org>; Thu,  8 May 2025 06:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AtimId5pDfCa0P17z+yKqGN+T/wXuzamKNjHLQJC9BM=; b=G7MGnwpJzsME3aAevMRjmhIs19
	PnwG2EPaS0QWD69xfu4LFvzw3i7TKw+D8fJR7MGlRMPK/Nshw/Z05U+snK0mNx3uVdG9UWEkKTuh2
	/9O4F659TB82SA3q06f/RnZIIpksyG+Qeazpxb5RjLUROHvCcFmcgxN7xrbVt+OEk17wqrHmi4G4+
	dKJkLBDuJtiAmtJkiSCTa4wbXMUCN5vtepeahhLb64EbHkjXyEjmDsli476t2a6F12JgV0tq5E0+v
	fWW5bCFrv60iqRSqqCMAqd/FnfqqZdIQ2aJpOl0Y60Bp+a0wpPdp2MKJWg24DTbK3Miqs8+9HwPkh
	h8lyJjXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuJ4-0000000HPvt-3Mau;
	Thu, 08 May 2025 06:00:30 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuIb-0000000HPqe-3K0X
	for kexec@lists.infradead.org;
	Thu, 08 May 2025 06:00:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EEDC3A4D8BA;
	Thu,  8 May 2025 06:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C722C4CEEB;
	Thu,  8 May 2025 06:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746684000;
	bh=E5d+duO3ltOVFlc1q4h4MDAptrCchoZERkvmIbudXno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NshznGsuXnibeSmBtW+iybU3woiG100W7Gi8mM/4nuiZW2sA7gnjrMaN3n7E3BtlN
	 tMvEMijLcoToGeA6+EKJg2y8aGdpC1ct6+B9JucckvWMcbe216UswGM62FPsSsfKBo
	 R5IM44bxnzo0v8lVq/762HU3DhC23oN3fyz/gsys=
Date: Wed, 7 May 2025 22:59:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, fuqiang wang <fuqiang.wang@easystack.cn>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-Id: <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
In-Reply-To: <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
	<ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
	<4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_230002_010309_11D730C1 
X-CRM114-Status: GOOD (  22.02  )
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

On Thu, 8 May 2025 12:25:15 +0800 Coiby Xu <coxu@redhat.com> wrote:

> >
> >Acked-by: Baoquan He <bhe@redhat.com>
> 
> Hi Andrew,
> 
> It seems this patch was missed.

January 2024.  Yes, it's fair to assume that it was missed ;)

> Will you pick it up?

Sure.

> Without this patch,
> kdump kernel will fail to be loaded by the kexec_file_load,
> 
>   [  139.736948] UBSAN: array-index-out-of-bounds in arch/x86/kernel/crash.c:350:25
>   [  139.742360] index 0 is out of range for type 'range [*]'
>   [  139.745695] CPU: 0 UID: 0 PID: 5778 Comm: kexec Not tainted 6.15.0-0.rc3.20250425git02ddfb981de8.32.fc43.x86_64 #1 PREEMPT(lazy) 
>   [  139.745698] Hardware name: Amazon EC2 c5.large/, BIOS 1.0 10/16/2017
>   [  139.745699] Call Trace:
>   [  139.745700]  <TASK>
>   [  139.745701]  dump_stack_lvl+0x5d/0x80
>   [  139.745706]  ubsan_epilogue+0x5/0x2b
>   [  139.745709]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
>   [  139.745711]  crash_setup_memmap_entries+0x2d9/0x330
>   [  139.745716]  setup_boot_parameters+0xf8/0x6a0
>   [  139.745720]  bzImage64_load+0x41b/0x4e0
>   [  139.745722]  ? find_next_iomem_res+0x109/0x140
>   [  139.745727]  ? locate_mem_hole_callback+0x109/0x170
>   [  139.745737]  kimage_file_alloc_init+0x1ef/0x3e0
>   [  139.745740]  __do_sys_kexec_file_load+0x180/0x2f0
>   [  139.745742]  do_syscall_64+0x7b/0x160
>   [  139.745745]  ? do_user_addr_fault+0x21a/0x690
>   [  139.745747]  ? exc_page_fault+0x7e/0x1a0
>   [  139.745749]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [  139.745751] RIP: 0033:0x7f7712c84e4d
> 

Do we know why this has appeared at such a late date?  The reporter
must be doing something rare.

Baoquan, please re-review this?

A -stable backport is clearly required.  A Fixes: would be nice, but I
assume this goes back a long time so it isn't worth spending a lot of
time working out when this was introduced.

The patch needed a bit of work to apply to current code.  I did the
below.  It compiles.

--- a/arch/x86/kernel/crash.c~x86-kexec-fix-potential-cmem-ranges-out-of-bounds
+++ a/arch/x86/kernel/crash.c
@@ -165,8 +165,18 @@ static struct crash_mem *fill_up_crash_e
 	/*
 	 * Exclusion of crash region and/or crashk_low_res may cause
 	 * another range split. So add extra two slots here.
+	 *
+	 * Exclusion of low 1M may not cause another range split, because the
+	 * range of exclude is [0, 1M] and the condition for splitting a new
+	 * region is that the start, end parameters are both in a certain
+	 * existing region in cmem and cannot be equal to existing region's
+	 * start or end. Obviously, the start of [0, 1M] cannot meet this
+	 * condition.
+	 *
+	 * But in order to lest the low 1M could be changed in the future,
+	 * (e.g. [stare, 1M]), add a extra slot.
 	 */
-	nr_ranges += 2;
+	nr_ranges += 3;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -317,9 +327,16 @@ int crash_setup_memmap_entries(struct ki
 	 * split. So use two slots here.
 	 */
 	nr_ranges = 2;
-	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
+	/*
+	 * In the current x86 architecture code, the elfheader is always
+	 * allocated at crashk_res.start. But it depends on the allocation
+	 * position of elfheader in crashk_res. To avoid potential out of
+	 * bounds in future, add a extra slot.
+	 */
+	cmem = vzalloc(struct_size(cmem, ranges, 2));
 	if (!cmem)
 		return -ENOMEM;
+	cmem->max_nr_ranges = 2;
 
 	cmem->max_nr_ranges = nr_ranges;
 	cmem->nr_ranges = 0;
_


