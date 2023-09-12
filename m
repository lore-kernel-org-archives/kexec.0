Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B0CA0EC3
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wLWhi4KZIMrmopVNXUtG3bMkQ8Wc39j57BcTDXvtNZc=; b=jv2q3ii2cVkIa7
	aJEkMjNsmyBiy4GPKZy2RALEg4wcm2Q0Eh6osQV7drv3ZnjtFJZWtQOxIue3GcqCEsZjkJXWTA7kf
	cIRNnY2vSES2wZFciAqI7iahFdn40OHYtM/L7s3l31pNHgnre+Dto8v9H/3Z2/tJVp45aOyetUO9R
	wF0u3OkRdpDufQjXLAs0sQL9udlxIf5f4mJc3fKs20STEfGm1CUlclBdBMHcugBHq+KI5/CMhOY/n
	4JrA3DmDAp2r+9VJdCT78bgzhjhotm6awMuvVXTX6zh/5b9dsYB57reBk4R9ntAUSs/INfVwyUMhY
	jZEVdAw/K7qR0tteYN7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfy7v-002Rfl-2k;
	Tue, 12 Sep 2023 07:48:03 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfy7s-002Rf1-2A
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 07:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694504880; x=1726040880;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=myILytDdutAkJHoVsjGJrHjJI0XRaM5nA9tqDHz8FOQ=;
  b=KKNF208pbGslTV36/o3vVKkU1+5DPrGO6mUBSzwVzc1UXU7Qf8fwuruf
   +HnElscS5akhh7YqfEnQw2eWnYeKTeWZ+y2em9OaxhIzA07axMCEQfRM9
   CwkKaV2X/fSZtPIYo/xXksMuVQNcVC0yqHyEEzZ6y6zZrBpCnrtGQpDiZ
   hgQJMaSnXZoGdG2/fZKtWdlmWWI0ssON7lYruztwD71i4RdYQ2Ui1jfda
   pBzP68ittFpS6Ds33/RZwfrwdh8vQBA0dfsKlYVzmuDl73sOVuDSUZ+gP
   yC30ELj28a6Tn/iXLk/qpCyjztVOyx1otiYp/2tn6C1sZFIDRwnoU1fCF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444742378"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="444742378"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867283368"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="867283368"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.45.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:47:53 -0700
Message-ID: <1c736ca3-36e2-3225-2f98-e51149c468ef@intel.com>
Date: Tue, 12 Sep 2023 10:47:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
 <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_004800_752444_CE4E8E41 
X-CRM114-Status: GOOD (  10.43  )
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

On 12/09/23 10:19, David Hildenbrand wrote:
> On 11.09.23 13:21, Adrian Hunter wrote:
>> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
>> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
>> need to accept memory before it can be used.
>>
>> Do not let /proc/vmcore try to access unaccepted memory because it can
>> cause the guest to fail.
> 
> Oh, hold on. What are the actual side effects of this?
> 
> Once we're in the kdump kernel, any guest is already dead. So failing a guest doesn't apply, no?
> 
Unaccepted Memory is used by virtual machines.  In this case the guest
has kexec'ed to a dump-capture kernel, so the virtual machine is still
alive and running the dump-capture kernel.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
