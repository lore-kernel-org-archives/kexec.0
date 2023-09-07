Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C24EE14D4
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FwKDHAlWaItXGv/oZfHH1ZutJ2NTJVH9yxxm4PgCIR4=; b=N9L651TPlUEUAZ
	dQgEFEWmp/XeGMy1toHdjowKjg9Rk+5Ie2DsYSfV80+m3CuHJEOgi1W5pHKFht4w/T9PqKclDvQP0
	3BghTbRSthE7LUnsvF14cHZ3n/gGM/UR7GruU3RKeRyu2VNJa9Kzv3xh3/1F/RuM/IFFOdMI2spU0
	1vJT/r4vGAuT1nMOEZa5DgTQ6HUVrpNi/CqMyrauqy+rDJXoGvbnXi0gkUblP07STCCeensVGqDLD
	paum0G625nWMVA//WCKGAeSLhLnP9IPSXw77VkhKVzM5QqwZOjcCGJE1Apjbik51GrLAk9eat2Q6Q
	X10TmlU9ta+/PdWMhtAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBwl-00BkYC-0b;
	Thu, 07 Sep 2023 10:09:11 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeBwh-00BkX0-2n
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 10:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694081347; x=1725617347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vslREB8ROsaiDtOyMM59OVIoUOD6oP12DWv5XlYD9Hw=;
  b=BXfoyII4J/P2VEJYJ8vGngY2TRwjQRnLV+xldLVKMaD5PTuTZjrb6i0s
   w7Ch87yVLo+foINGeiBOiWDsw0nj3xQ5K5j8dSGQE6E0kvn/qOoS29uJG
   pGG7XDx8I6lKZkub1hJIFK/osHW7q5ClzuzcihmaiLvzAm9d+mvnyahss
   eyMSbgqk2nBUVI1uYzcQnBTlIkUCFQvK8K+OcC+XTvj6/Pc+qBh8hij0m
   N65fAK1kQaZTyNSapCsunbTuJf0+RVh+z6qOsbrAE8QEmTZLP5HCoB1Eh
   FNc/HKFUEGROdLsY99KcdQ3R3s0ilOIxMeqCcUDX2wUL+YtADw8JSfY8W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367538852"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="367538852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691725586"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="691725586"
Received: from rbhaumik-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.38])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:07:49 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id C66861042C5; Thu,  7 Sep 2023 13:07:46 +0300 (+03)
Date: Thu, 7 Sep 2023 13:07:46 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Do not map unaccepted memory
Message-ID: <20230907100746.42ujuj7brawxw322@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230906073902.4229-1-adrian.hunter@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_030907_947071_409215B9 
X-CRM114-Status: GOOD (  13.54  )
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

On Wed, Sep 06, 2023 at 10:38:59AM +0300, Adrian Hunter wrote:
> Hi
> 
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> a virtual machine may need to accept memory before it can be used.
> 
> Plug a few gaps where RAM is exposed without checking if it is
> unaccepted memory.

Thanks for catching this. Looks good to me.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
