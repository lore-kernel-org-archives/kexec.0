Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA6CEC873A
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Lq5tTJFEqp3/JmWv3GWiIcUs9Vtrh8sCM4Yfcz4huU=; b=TVExixx0R1jBYw
	Du00DIUsEINZMmJaJlX6CErlrZJ4MFyymvXWLd3zB0K/Tky8wxrpLlmPpVviRliSA4m2zTwkpwt9U
	GKn728XeJxql9+fODovM4+B5KlKrbhxqhzxcVpxk/OiVdH0KuhKUTv5ZsZsdPUoWhAAHvCe/JscLg
	1r5MwtZsv/G8EvqKrMT58dhXzWKX9Led7H2x643T3L1DL85Pouk9Z5Cg4Dmitl/eaHLb3xF6zdOP9
	S1j9Swr7YxFYxSTme05y5Ls00fgjDG1IE1tM5Gf88uIcfOhXO+gscXDz5fUfe/kYT0/I9/K4B7G/Q
	GxUCjCIC4jIy7veXzz1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeH3U-00CIdF-1H;
	Thu, 07 Sep 2023 15:36:28 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeH3R-00CIcw-2B
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 15:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100985; x=1725636985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gAFNTJqAbOYf7VH/NCFNgTzEP7NzuWW3ie9UYXuVLIw=;
  b=dwAu0HaLoAx4fBObplHhm0PMbVx9+3coP6REZ2tUURwOCThrfBoTMLOF
   5hdDcEmINayvBPu5YlZdQ+mbjgKjnaztJCOmOBO3dN2Xya5NfEsi/ckPu
   fSqnBxCQOHZ3OFT/WUkq/aSZX40Y05bMbgAXM3E/fit62Nj5vutlkCSoh
   pMlhcyWu2XYwUvPQY7SPy+p6Cd0XyIz6oL2CRIJ7EWwezkZ7Va6ROFrNl
   Rn7E9Gb5vqhYV6eKiKzHMWbDhHAl7t3X4mzNlze5P5t6elsZlRWF5+Wy6
   ipyBnrSTWuany7wt5xKJ0ZFiXQrjR/SjL0srdctPkcR7rFojRsyYncG9x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357698698"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="357698698"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="691833951"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="691833951"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:36:18 -0700
Message-ID: <651365aa-389c-6465-1ad4-49b40036ac38@intel.com>
Date: Thu, 7 Sep 2023 08:36:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] proc/kcore: Do not map unaccepted memory
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
 <20230906073902.4229-3-adrian.hunter@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230906073902.4229-3-adrian.hunter@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_083625_742323_82AE1739 
X-CRM114-Status: UNSURE (   8.54  )
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
> +static bool pfn_is_unaccepted_memory(unsigned long pfn)
> +{
> +	phys_addr_t paddr = pfn << PAGE_SHIFT;
> +
> +	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
> +}

Please just add this as an inline helper to common code rather than
copying and pasting two copies around the tree.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
