Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADC2C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EEFnB85jJ6rV/EGaHFQyxmivRsFLrXVV5ATI8CyWM4I=; b=CrQ0UnGSQzU1YA
	43sTemGQzwIQzGA5GmKfhp0SnT9mZP0izbnorLx2pqhsL0xHlTpu3lnl7AOeJQrHezjKfocGYDTIK
	4PW6hk5wmINFMftYVjir19GUaNG7KuVUHcwxmmOMYw+CZqsLhS7+oHM/hyQkQGAQ0egh2SX5ImsYg
	pELCFJ1bH9mIC35Xu6jqUbeQJdon5vEH7nqiu8a+DhRCBBLvmGRwl1i6HKadSaMrC0C5S4ZlK3HHJ
	yiCHC06TDRVPoFU8hHzz28RPc9aUbd2xaKdOSy4wZp0rLriR2kIdsckxT3IChj5XIv1u+FhpyFukQ
	GeKRnZaaL8EoBVA+k4Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEWNp-00000002z4T-07Ov;
	Tue, 04 Jun 2024 15:47:33 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEWNi-00000002z0q-3iHN
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 15:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717516047; x=1749052047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Id5s0PIaCRkCPJFLJmSoHhlSb8MaiixVnBKq2JDaGHw=;
  b=TW0OWvl/71j3SNT5lHoK/sPlGxYunKAl92aYRI+nTgHQiJ9cIUl0ihS5
   50W2E6u7mjR6zU/jf0R1/rqFzj0ewla67ONT8SmAlyTdhzJ289hV7hScr
   YYQ/21ImVFjqP85z/2l1HFIhH0zCPzc3XNS+4BbrCjVcBaTk/R9+CPM2z
   4G43a2JP6uZ5wEu5tSUVbovqWSXNpvQ8qxJd+twk9U9TMCz3+jJ50ul2T
   V7w2sglKNZdEDVfJqGo/3eIzVYTHL2p9mhnO8v5AC1gBmgx9N0YsBkfuy
   ZDKjtIBnrirSriij/mvMFpypwzpkZFMUjfJ2qG76KWI9U7ex/T8RNlLD/
   Q==;
X-CSE-ConnectionGUID: /CGzm5FITv6Q5MO9uDQePA==
X-CSE-MsgGUID: YSClIIQNRW2CTuvc/NQ5ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13880600"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13880600"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:47:25 -0700
X-CSE-ConnectionGUID: QXdAuQZmT2GFwoVISydTzw==
X-CSE-MsgGUID: X8E8y0NZTz2TgIvJMAAlKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37354255"
Received: from cdpresto-mobl2.amr.corp.intel.com.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:47:23 -0700
Message-ID: <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
Date: Tue, 4 Jun 2024 08:47:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to private
 on kexec
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: adrian.hunter@intel.com, ardb@kernel.org, ashish.kalra@amd.com,
 bhe@redhat.com, dave.hansen@linux.intel.com, elena.reshetova@intel.com,
 haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com,
 kai.huang@intel.com, kexec@lists.infradead.org, kys@microsoft.com,
 linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, ltao@redhat.com,
 mingo@redhat.com, peterz@infradead.org, rafael@kernel.org,
 rick.p.edgecombe@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
 x86@kernel.org
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_084726_993724_33611D95 
X-CRM114-Status: GOOD (  14.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 6/4/24 08:32, Kirill A. Shutemov wrote:
> What about the comment below?
> 
> 			/*
> 			 * One possible reason for the failure is if kexec raced
> 			 * with memory conversion. In this case shared bit in
> 			 * page table got set (or not cleared) during
> 			 * shared<->private conversion, but the page is actually
> 			 * private. So this failure is not going to affect the
> 			 * kexec'ed kernel.
> 			 *
> 			 * The only thing one can do at this point on failure
> 			 * at this point is panic. In absence of better options,
> 			 * it is reasonable to proceed, hoping the failure is a
> 			 * benign shared bit mismatch due to the race.
> 			 *
> 			 * Also, even if the failure is real and the page cannot
> 			 * be touched as private, the kdump kernel will boot
> 			 * fine as it uses pre-reserved memory. What happens
> 			 * next depends on what the dumping process does and
> 			 * there's a reasonable chance to produce useful dump
> 			 * on crash.
> 			 *
> 			 * Regardless, the print leaves a trace in the log to
> 			 * give a clue for debug.
> 			 */

It's rambling too much for my taste.

Let's boil this down to what matters:

 1. Failures to change encryption status here can lead a future kernel
    to touch shared memory with a private mapping
 2. That causes an immediate unrecoverable guest shutdown (right?)
 3. kdump kernels should not be affected since they have their own
    memory ranges and its encryption status is not being tweawked here
 4. The pr_err() may help make some sense out of #2 when it happens

I'm not sure the reason behind the failed conversion is important here.

I wouldn't mention panic().

We don't need to opine about what the next kernel might or might not do.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
