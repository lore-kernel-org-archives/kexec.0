Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADBBEC873A
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TInG2D9Qchx3dgm9304RFfiUQ+QDkco9FActXX7xNzA=; b=povZNwp38KJn9j
	K66KqpjrD8c3zXZU7MedOtAQmDW9oOrW+w0zUGw10BqZOeSsTXpbA4BaZMsFJh/bd+5ZMZ9tTdoBS
	rms3AxE/ny5PLAuW7ab2JkwcR1eHRWHBkYBHnfTnNmXYl//l4iDDmTQxZ9dZfu/TFzsjWUibePnAm
	MDjC/4/PSN5yqrDu263vzJ8YPNnJdrDNqolhICadKlXEgQm34Czw9Q7XDutiBaP75yN5FFXgajY1g
	AKMXyF/5tQmnR3kxFDw1beChAkquuatJoxis1c12CEj3CDuUseN14KFpYqX4B3jteF5nOjaqPjVgn
	m16vf3SqLe/zyj+6zc9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeH6J-00CInF-19;
	Thu, 07 Sep 2023 15:39:23 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeH6G-00CIlj-2T
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 15:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694101160; x=1725637160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gc47Wmv9yvPizcQSt3RG5ZLyHOAm3FccQUQk5XxXERw=;
  b=kxBRNphsNPgu3n1QOBQLRYDcoGx+R2S4qbBiMrB2yBoCJv+pLqfckwoe
   1U2NNELIwibyAS/e8bV51kezIu9pII6EQKhkFRkM4InG22tKNCkirN6sr
   83CbBfPSvQkJ3mwH50k5ttmznN+dQFT/VAnL0ObHW9pwgoaxeNtzjP90u
   ajFDqyvyF951QfToh+3GY/2o57lMs1b462NynOHC91PnbbVni4rT24cLW
   ioL4j3+w9hEV0T9N6ugY/HPQZzG2Z9rCXfG5sGqz1WBY4p+kBtEZ/TYfV
   dP29h49v2wlH8j6wvZwl7dnACCxOmyeku1hr3mG52T+2fwG/hLw2RtlNq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="463768154"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="463768154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="865686230"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="865686230"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:39:13 -0700
Message-ID: <21bf2e44-3316-2372-44cb-1488f88650f5@intel.com>
Date: Thu, 7 Sep 2023 08:39:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>,
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
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230906073902.4229-2-adrian.hunter@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_083920_816943_4F8894F0 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
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

On 9/6/23 00:39, Adrian Hunter wrote:
> @@ -559,7 +567,8 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
>  	 * pages without a reason.
>  	 */
>  	idx = srcu_read_lock(&vmcore_cb_srcu);
> -	if (!list_empty(&vmcore_cb_list))
> +	if (!list_empty(&vmcore_cb_list) ||
> +	    range_contains_unaccepted_memory(paddr, paddr + size))
>  		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
>  	else
>  		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);

The whole callback mechanism which fs/proc/vmcore.c::pfn_is_ram()
implements seems to be in place to ensure that there aren't a billion
different "ram" checks in here.

Is there a reason you can't register_vmcore_cb() a callback to check for
unaccepted memory?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
