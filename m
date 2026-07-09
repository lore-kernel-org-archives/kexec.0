Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159B4C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egEQegkzVd6qWuiMRf57t7zF7MyRk5jNUn1HniJAO8k=; b=myA90Mh4dJjTPrda4KljJwPef6
	OAHoHQGODiM3LYdY4iQLJneAc2r5YhNc2uQR33fXbbk5yZWZpdUBuR674nd1WFYS8XRhMNnyorGNG
	Ylujatm7uPIXZ7/5CWhqNG4VVYv7PEVxjBZBg0q5qCRrcGvvyog66bTz4fPeU1MdSRuP3cLf/cgeP
	dPHN4PlX/fNBRY2zu3R8MI+775NdisckEh1/9T3t+0RsWmPqIco1P66L4xSX8VsKdeONLX5UZYPj0
	O++FaVPQ1K6KUXCK8xObj1waqpLC9iO+0gFHwkqfXiuDAzjyUOCsI210W6fZb3BUM4KLtoomEUBsr
	dJZRNbGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoBd-00000002Sg1-3Neo;
	Thu, 09 Jul 2026 12:49:05 +0000
Received: from out-179.mta0.migadu.com ([2001:41d0:1004:224b::b3])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoBa-00000002SfF-320t
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 12:49:04 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783601334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egEQegkzVd6qWuiMRf57t7zF7MyRk5jNUn1HniJAO8k=;
	b=Iycg/KIVqDMfLX8Xy+tVV/5u6vC42kFOn0WbRUUEikqUEe+PnvXScKlmERZNC+QZDq/4l9
	mJztvFMEpgk1ET9hT3h2VfL9kJwZhtygo99555KQ6Vyk05NJLziCH3xjbLtzs6Tk4c2jQx
	0CqbzLokzg0DSOA7mnIWVA4lJ1+bCx4=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: maobibo@loongson.cn,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH v4 0/2] LoongArch: kexec: avoid clobbering the QEMU FDT
Date: Thu,  9 Jul 2026 20:48:30 +0800
Message-ID: <20260709124830.15417-1-dongtai.guo@linux.dev>
In-Reply-To: <CAAhV-H7S9_hPDFoCtzgfY9TeH_koN9NfKq9mo8y9BmLA5-7how@mail.gmail.com>
References: <CAAhV-H7S9_hPDFoCtzgfY9TeH_koN9NfKq9mo8y9BmLA5-7how@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_054903_059740_C5962AFC 
X-CRM114-Status: GOOD (  15.40  )
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

Hi Huacai,

Thanks for the correction, and I am sorry for the way I handled this.

> Who told you the trampoline is dead code? All non-boot CPUs are
> running in the trampoline, you can use maxcpus=1 to go to the new
> kernel, and do something, and then hotplug the non-boot CPUs at any
> time.

You are right, and I was wrong to call the trampoline dead once the new
kernel starts.  The non-boot CPUs spin in kexec_smp_wait inside the
trampoline buffer and only leave it when the new kernel brings them
online, so with maxcpus=1 they stay there until a later CPU hotplug.
The buffer has to stay valid the whole time.

That breaks my patch 1.  control_code_page is allocated by the kexec
core and is not reserved in the new kernel, so the new kernel can reuse
that page while the non-boot CPUs are still spinning in it, and small
memory makes that more likely.  The fixed KEXEC_CONTROL_CODE at 0x100000
avoided this because the first 2MB is memblock_reserve()d in both
kernels; its only problem was that it overlaps QEMU's machine FDT at
0x100000.  So my Q2 answer in the cover letter was also wrong, and "as
arm64/riscv do" does not apply here.

So the trampoline still needs to live in the cross-kexec reserved first
2MB, just not on top of the FDT.  The FDT declares fdt_totalsize 1MB and
covers [0x100000, 0x200000), so the room left is below 0x100000.

Do you have a different fix in mind? I would like to agree on the
direction with you before I send anything.

> BTW,  you have never replied to my comments, all you have done is
> submit new versions again and again.

That is fair, and it was my mistake.  I should have replied to your
review in the thread and discussed it before sending a new version,
instead of putting my answers in a cover letter.  I will reply to
comments first from now on.

I will hold the series until we settle the trampoline approach.

Thanks,
George

