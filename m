Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E1DCA0EEB
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 04:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNtzbCsa7aOfIC5Gdn6wetnJOechkqdWHkZln3UfyA8=; b=0BwNB8Bo6XDrdTU8DiWLwo6NfA
	HOwg9njWojwSVG045hGdQHQ1mB7HmtFK7XJq39sOxNCh1Z/6j43NXugx87JPbjczLcO8bQ3yXLmle
	E6MyJ/o3laE2hoOxQK3QMS6NCZ8RaIXolR5ePcB+jIo8X4Ra1MjeAYUbC1i7Z3fwG4Z8pyrZgTnvZ
	86vocJhT8KCrV0p3EoUnPOWNqgxntv1liyD8j/DUXGkWxeQq97bqnVW3Q6NQKSLXWfT2IFNPokGTg
	iZwlwM8n6r9jZVkglRoOChQ1ffBCcnHuss/urS870pSm35+zoKbHBcbmIkBW+Hh5Vemfw+NrrOoT6
	ybzniSwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoxDV-0000000Fp5h-0WVm;
	Thu, 21 Aug 2025 04:48:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoxDU-0000000Fp5K-1o1j
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 04:48:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A5FB261444;
	Thu, 21 Aug 2025 04:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FCEC4CEF4;
	Thu, 21 Aug 2025 04:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755751678;
	bh=s9beO2CbS4BGY4VluAibPH2xkOmXO0+zZTnWtdDIyoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CvDA5XY4aN67rGgi2OSdyrOpEVOn7NxmxoH2uDjIDpSs8anlTLBTKbRMz/iHchRzO
	 W6HmgQ39fV65HHE0el8KyLHwXTIPh7kS0RAZieQaiD55oz40iINm/BZdX57b3cSsit
	 soo/PqlghcS5IlzQDrxA+Pkb6MtHp/z7ntLDFpzo=
Date: Wed, 20 Aug 2025 21:47:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brian Mak <makb@juniper.net>
Cc: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Alexander
 Graf <graf@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 <x86@kernel.org>, <kexec@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Message-Id: <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
In-Reply-To: <20250805211527.122367-2-makb@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
	<20250805211527.122367-2-makb@juniper.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 5 Aug 2025 14:15:26 -0700 Brian Mak <makb@juniper.net> wrote:

> Commit 07d24902977e ("kexec: enable CMA based contiguous allocation")
> introduces logic to use CMA-based allocation in kexec by default. As
> part of the changes, it introduces a kexec_file_load flag to disable the
> use of CMA allocations from userspace. However, this flag is broken
> since it is missing from the list of legal flags for kexec_file_load.
> kexec_file_load returns EINVAL when attempting to use the flag.
> 
> Fix this by adding the KEXEC_FILE_NO_CMA flag to the list of legal flags
> for kexec_file_load.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")

A description of the userspace-visible runtime effects of this bug
would be very helpful, please.  A lot more than "is broken"!

Also, could we please have some reviewer input on this change?

Thanks.

> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -460,7 +460,8 @@ bool kexec_load_permitted(int kexec_image_type);
>  
>  /* List of defined/legal kexec file flags */
>  #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
> -				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
> +				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | \
> +				 KEXEC_FILE_NO_CMA)
>  
>  /* flag to track if kexec reboot is in progress */
>  extern bool kexec_in_progress;
> -- 
> 2.25.1
> 

