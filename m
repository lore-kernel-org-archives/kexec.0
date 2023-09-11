Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5EEEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XZ8RaccVg4QXwl+4ouhhQ+GXrqqrUwz7KJU3epYpxBc=; b=bn3gyCpvMdOgX1
	aNXTaQTxBRmDyz/UAAwkWz0fvZEaBSNee/fcoSCgc98DZxcujmL50WflKSjWjFi7MnX394YQOVhvz
	nEPRirOhtBbprcB0N2Rar6OR29SnAsaDzpDjuxNGsSHbx54prp2XTGFWzS6n34VGKs5T+RFhBd8QF
	GXV1J5cT86BmFmQnXlFWGrWifT3nYU8mJrqCx8CvJ8zJNhIBu9QGYX+bVw+VKAwksIHJmgngGUKXA
	43O7ErAhTE1dGVX2MzAHB1qkDE2XcWaghZKgHL2ZC4ebh7VZTeSrhS9s38QiFfOkrN0yuAmBE7PIr
	NCd5/fK/cQkhwsBLJlyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfcUY-00HYe2-0e;
	Mon, 11 Sep 2023 08:41:58 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfcUV-00HYdh-1s
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 08:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694421715; x=1725957715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uhPe1H2Fp1YDVYHUdP69YCF2k7+nQbNT9DvyyBH2lmY=;
  b=kI09s6e/ZM3koHQI3MdzBIHixUNhvXWXRUC7IicLTa4fT9L24sPAbQN1
   Mz9UMheeobLrGzIl0gS7OmXVy8+vl8e4Mzwewz33KjL3DN3HMUWEPCsVn
   qq4OcF0HtlKDz5HIC3wmQqtvywfmLg1KSg0D5ZqC53VKoBSdK3n1+pHw7
   aQImioOATVhNbwcCTxuQpg62kZT+O4idojkeI7Dj+/Xsks5NnakUYzof2
   id3FFgVOQLRkQBDLOhiakbuBCThWA6svuRFzlulMTl97IX5pPINgbCnHH
   Cwzdhxc85+mP2f5OdPFBwIzk6tkGx8IJ/h5FxXr4e6caYPoDbvncRByvH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="442024372"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="442024372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858242359"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="858242359"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:41:50 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 1DF6310940E; Mon, 11 Sep 2023 11:41:48 +0300 (+03)
Date: Mon, 11 Sep 2023 11:41:48 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Message-ID: <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_014155_676314_AF9DE6F7 
X-CRM114-Status: GOOD (  18.97  )
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

On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
> On 06.09.23 09:39, Adrian Hunter wrote:
> > Support for unaccepted memory was added recently, refer commit
> > dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> > a virtual machine may need to accept memory before it can be used.
> > 
> > Do not map unaccepted memory because it can cause the guest to fail.
> > 
> > For /proc/vmcore, which is read-only, this means a read or mmap of
> > unaccepted memory will return zeros.
> 
> Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
> to the information whether memory of the first kernel is unaccepted (IOW,
> not its memory, but the memory of the first kernel it is supposed to expose
> via /proc/vmcore)?

There are few patches in my queue to few related issue, but generally,
yes, the information is available to the target kernel via EFI
configuration table.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
