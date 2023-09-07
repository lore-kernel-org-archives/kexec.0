Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B9FEC8730
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I2GVLXNaLmh1cGR/zLUUDz4T9iI2y4Z2hQelb4X3APw=; b=2NIu21pb7yDP17
	M3cshsL3seFePDedm0wqlnCLTp08+BPa4mFOJ5jfFiJ+0BkOdf65ZcfIL7+Db7kFp92m961iefqT+
	EpI9zs3Emwgpo09/9OFyXGBokZru5DNzTPLC/qVeBjG51ETS9IaaugkjhD37ucvW0MPBNGCyHK6HS
	uB6+dzf3BGKSNNQzrNKZtRE+PK3G2QZyV4Mn/00u5e4hZgLuS4j4S+eOh/yBFS4dUnC679EsjKLAV
	mgLCC+3h1c7U5OlQZX/GL0OKTYxYwqZyxSjaQFt1/opQvun9GcbQci7Su8HZFJhYp7nmDr8s/889o
	NK4c3Q+bPYUb6z97RFPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeFng-00CBOa-1C;
	Thu, 07 Sep 2023 14:16:04 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeFne-00CBNM-02
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 14:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694096161; x=1725632161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Urz8J26AUOtbbaftdYy1+eG3zzf8pqaVITlpJ9CGDIc=;
  b=KqCLImUyv4OUbcQMvSQ4wE7gBgYMx+VaymItqHnSbyqCvRQ5QwaKLZQv
   t0F8PLXOUcsFlIe2winu6+SQjCX46ayP+20Tkt5mGms/nsMH1SbquQ6on
   8/1BduLHJeQxkrwVrlUgl45E15uSxMOQlr5N4IbYayfUBT2MwtpE9NRH+
   QeMfi7hUXejreblR06EtF6KQbZ3Zg7I1iK/OUZf0jQFbXmSy9eh6xyf70
   HPZIxaYjCSPCYQ/YE8ha7p0TMLuBCe8FzRmPF62bi69q7B+oOLOi6ffbi
   Ub19NuR/oR3c6LZzov3k7QqldEZoSJrUPrgqqcYdEoVKsGIV3v08hpSzB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357676563"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="357676563"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735516999"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735516999"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:15:21 -0700
Message-ID: <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
Date: Thu, 7 Sep 2023 07:15:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
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
 <20230906073902.4229-4-adrian.hunter@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230906073902.4229-4-adrian.hunter@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_071602_063358_5FDF3123 
X-CRM114-Status: UNSURE (   9.36  )
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
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> a virtual machine may need to accept memory before it can be used.
> 
> Do not map unaccepted memory because it can cause the guest to fail.

Doesn't /dev/mem already provide a billion ways for someone to shoot
themselves in the foot?  TDX seems to have added the 1,000,000,001st.
Is this really worth patching?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
