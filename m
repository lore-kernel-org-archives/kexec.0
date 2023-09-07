Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16A0EC873A
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yDPvGaGG8AHAz2CMFcQqG5P+7/avg6XsuYWTJ8oFL5E=; b=n+67KxIszMi43j
	abck0mkULwyHVoDvcHnH9d+8DfrLQ4O/kuymaRwQuVk9UyFzjs+WtOaD/y+p9rPnUic0tO/v03k4K
	rMODDCHa4N7yKj41LXblC4H8nWe8nFhgkWv0EDH/5Zd3dbgeo4awsD28DQ+fFhdSDMpjAJ91fF3B7
	9CqCnjElzlaJ7pMkyZdDXLKcZpDSu63bCQNrlXIzGa5/qcoq/JQR51aj1rQtJp/HuRCs5F724QkmH
	oxSv0erldqzcUy/fjziE7USOJYikoBOMD2QilzG1YlIlgijnzcSqoyst8JY0HzVBD0IpGcZxM/odY
	Guo056bG00ajvdbM8JkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHA3-00CJLr-2q;
	Thu, 07 Sep 2023 15:43:15 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHA1-00CJLT-0j
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 15:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694101393; x=1725637393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nvAw9m6A6x9DDVOWLkP+zkRHDGaDC+Y39YscRQTquf0=;
  b=kI9PmkyXVlTjf3xyYP+oaVTxG/gKVYRuQ50e74NL6/pTw0v7pX0d7/RR
   +i27VywFtemY+BMIfn0FgV5UacuTyS6FURF8cspubDmjty7D5gS6vRYSt
   MwQ4H3k+LaneW+FNptsO1vNI/wl7X82dJYgLXYA5Bmhi39zFJToEuDjsu
   ocHq6WIdA4Dm6gMoMeUpq39LUpD2uZs9+N6hHt0tdcbdlC45QD8/jjqTQ
   KHw3eFxfQDXxUjVH9IxijF3gbneX/zwRDBfxZF9eZcfWl+870Q1KQSyOT
   Ou668pFOB1/ds9KqRW3Tb1QpFjBET7ioZTegj2aIBGPHNe+umRtTElew1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="463769149"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="463769149"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735563105"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735563105"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:43:07 -0700
Message-ID: <523020c5-87fe-6aa3-4c30-c0ca94d36f8f@intel.com>
Date: Thu, 7 Sep 2023 08:43:07 -0700
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
X-CRM114-CacheID: sfid-20230907_084313_511121_9B0D40FC 
X-CRM114-Status: UNSURE (   8.11  )
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
> Do not map unaccepted memory because it can cause the guest to fail.
> 
> For /proc/kcore, which is read-only and does not support mmap, this means a
> read of unaccepted memory will return zeros.

I'm confused by this changelog and subject.

What is getting "mapped" here if mmap() isn't in play?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
