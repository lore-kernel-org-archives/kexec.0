Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF58EC873A
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GFuI9l4a8Y7Yc1JXNML7ZLJAHxPIMt6MF12AddlU8RQ=; b=cmV/t/3nZgbVB4
	YPEHFLl4plKJNKhXoY1cmxhTUuecWyJHubZAAyMjpkZzvAK6CawETxnQy8V2JL94pytvqd5L8dOS5
	cj04hoWncttWYvhuev7oS5NPXzYV6o8LipnNvEWGx4ub/F/bSkOKF5/pyF2/Al1x3SLEL116RnTM2
	HqnU3PtKrNzAsCRXeiaHlwsccaLw/HM2G5W9XE4oa3NmPKp/D6EzrZtocN4BfOpBHhNFVXgNReNMF
	Yddhlk/c+DDyMZs92+0h+Tk8ZAMNE11VpIW6kCaBsvjiTTpDzynDhM6Zg6ySY1qiFgB5kscEYtjkA
	i52JWsuQoZxWSlpUuKtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHEe-00CKOd-09;
	Thu, 07 Sep 2023 15:48:00 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHEa-00CKMd-27
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 15:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694101676; x=1725637676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fFdJWlOfOQFNWE/wQ1sARfEDpEEqtJd3bE+CeaqxZ+s=;
  b=Y0hMq92iBjA84Nr2ja57uNk9gjI/pBzlSiBBUuxlDkKarGy0bSaKy5oQ
   QFkiFL5dibO44SiJHMvk2N4tQCzCkBFT+c8O4Vukm8R8Ii1nMTt+fZLYu
   f4WXz2mEDgTuTlH0rjsNbLdodc+N1bBgJstTo4ty+145zfmhXJjH0djYD
   axPshedfuCHn1cTQ2qAOLZi1rndPBNpo3WFBNnoVkENeRxBlWqVBxhbqC
   mxt+1+A3f3Hk6zILgAehPj47AKoOtrWVMN9YMpdCquIP5NY+UbUKZMHh+
   BRagKASaQdzk291/aoyHRL+qHLLsFQuXInUFBvWCNLIeeLhvdMcyIHIv8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="443807588"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="443807588"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="988818775"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="988818775"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.181])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:44:11 -0700
Message-ID: <30d0cebb-13f9-572e-9baa-b7450fec9108@intel.com>
Date: Thu, 7 Sep 2023 18:44:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@linux.ibm.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <21bf2e44-3316-2372-44cb-1488f88650f5@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <21bf2e44-3316-2372-44cb-1488f88650f5@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_084756_751553_BE10C6ED 
X-CRM114-Status: GOOD (  10.87  )
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

On 7/09/23 18:39, Dave Hansen wrote:
> On 9/6/23 00:39, Adrian Hunter wrote:
>> @@ -559,7 +567,8 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
>>  	 * pages without a reason.
>>  	 */
>>  	idx = srcu_read_lock(&vmcore_cb_srcu);
>> -	if (!list_empty(&vmcore_cb_list))
>> +	if (!list_empty(&vmcore_cb_list) ||
>> +	    range_contains_unaccepted_memory(paddr, paddr + size))
>>  		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
>>  	else
>>  		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);
> 
> The whole callback mechanism which fs/proc/vmcore.c::pfn_is_ram()
> implements seems to be in place to ensure that there aren't a billion
> different "ram" checks in here.
> 
> Is there a reason you can't register_vmcore_cb() a callback to check for
> unaccepted memory?

Someone asked for the change to be in arch-independent code... ;-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
