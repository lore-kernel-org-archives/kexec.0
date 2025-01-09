Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B918E77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 05:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0TfaGrdmaLKsDN+gqpbMDvokvQkCFmzIItORCHqt/hE=; b=fVZm6C/amaV2gT6F7s9phmAYIQ
	5+7ASHKaEH8JxNXoWRUTIGmZaLw6znAaqfN5XWwwlJuj4zuTQfNQRlwodZp+q26KxBbC3QeEwfxbb
	HZmaFXY+3grsmRVam5XKwOQE9/wdjtLfKJDzl+YLFUMw/WaaKH+mZwH8lb5W8izFpHZ0d/kO7PTHX
	cSVcNWtKQ6ekIVEWKa9ybuBH86t4fDF029rRpasrTcMWo6lKq/LTWUjRIjA/JRst//cbUFUN+udvs
	JXfvjo2dVNfZtUTKqJDGYOTbbKLxnnRcfTSHYa0Szw3klGgaAdLPRQzIlxHM0W71vHRWkQrEK6gU1
	j4nvABBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVl5e-0000000Ao3y-3ZQp;
	Thu, 09 Jan 2025 05:28:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVl5b-0000000Ao3A-1aOD
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 05:28:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B48EE5C55C3;
	Thu,  9 Jan 2025 05:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C924C4CED2;
	Thu,  9 Jan 2025 05:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736400494;
	bh=JMzL7Jny9Qk/AWUNPZhjwmy7z3WhByQRQQvBVP0BM5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U+PgSr7tNogufpsgUKvrA3Lefa/H9gboswSYdrD6N96CPWFnk+1a6tF0Q0Ii9oUVE
	 rvn1vkeI/CGuw+cMXoTOn9Iostx/N1URp4FtNDQ//DJvW2BBO0NSNPaHocyTeqeILZ
	 n1/Z++kM5D2KOg0G0eVgwQvL1PPSIoUnB6WqMKjI=
Date: Wed, 8 Jan 2025 21:28:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Baoquan he <bhe@redhat.com>, ebiederm@xmission.com, Hari Bathini
 <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Initialize ELF lowest address to ULONG_MAX
Message-Id: <20250108212813.ebc0014e384e9996ab72db40@linux-foundation.org>
In-Reply-To: <ea2d2f5d-5410-4f7e-a3f5-258c432e9be9@linux.ibm.com>
References: <20241210091314.185785-1-sourabhjain@linux.ibm.com>
	<Z1pQoh7IwtERIWe5@MiWiFi-R3L-srv>
	<ea2d2f5d-5410-4f7e-a3f5-258c432e9be9@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_212815_592463_3F99CE42 
X-CRM114-Status: GOOD (  24.41  )
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

On Thu, 9 Jan 2025 09:42:14 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Hello Baoquan and Eric,
> 
> 
> On 12/12/24 08:25, Baoquan he wrote:
> > On 12/10/24 at 02:43pm, Sourabh Jain wrote:
> >> kexec_elf_load() loads an ELF executable and sets the address of the
> >> lowest PT_LOAD section to the address held by the lowest_load_addr
> >> function argument.
> >>
> >> To determine the lowest PT_LOAD address, a local variable lowest_addr
> >> (type unsigned long) is initialized to UINT_MAX. After loading each
> >> PT_LOAD, its address is compared to lowest_addr. If a loaded PT_LOAD
> >> address is lower, lowest_addr is updated. However, setting lowest_addr
> >> to UINT_MAX won't work when the kernel image is loaded above 4G, as the
> >> returned lowest PT_LOAD address would be invalid. This is resolved by
> >> initializing lowest_addr to ULONG_MAX instead.
> >>
> >> This issue was discovered while implementing crashkernel high/low
> >> reservation on the PowerPC architecture.
> >>
> >> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> >> Cc: Baoquan he <bhe@redhat.com>
> >> Cc: Hari Bathini <hbathini@linux.ibm.com>
> >> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: kexec@lists.infradead.org
> >> Cc: linuxppc-dev@lists.ozlabs.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> >> ---
> >>   kernel/kexec_elf.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
> >> index d3689632e8b9..3a5c25b2adc9 100644
> >> --- a/kernel/kexec_elf.c
> >> +++ b/kernel/kexec_elf.c
> >> @@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
> >>   			 struct kexec_buf *kbuf,
> >>   			 unsigned long *lowest_load_addr)
> >>   {
> >> -	unsigned long lowest_addr = UINT_MAX;
> >> +	unsigned long lowest_addr = ULONG_MAX;
> > Great catch.
> >
> > Acked-by: Baoquan He <bhe@redhat.com>
> Thank you for the Ack! The upcoming two patch series, which aim to 
> enable generic crashkernel reservation, depends on this fix. One of them 
> is already posted for upstream review: 
> https://lore.kernel.org/all/20250108101458.406806-1-sourabhjain@linux.ibm.com/ 
> I was wondering if you could guide us on how to get this fix pushed to 
> the mainline tree.

Please include this patch (with Baoquan's ack) in whichever tree
contains the powerpc patches which depend upon it.

