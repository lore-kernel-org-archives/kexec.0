Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85661EE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mnlEJ3r6RV62/BAgwPrQNtM5tl3v45b89f3KofF7jok=; b=a1IXiBvj7xDFrV
	4sjvdtpgjQg0g6gPceZ2ddD7ds0vSW4Y4WRn2CbHked8zVi78BifJTjEn5Y/oun/t5JUhyMEqa4Bw
	6F0VmKZCfv5KNGwVtrrChaescG6wozfZb9rggivPv4MveWgkv5fflhj0IgwosZJRw68pesnugC1fg
	77Si2SPFQzEPeBgcdnX6rUi+wxyXDLPVZCoexXNChqV88Dj8QVCVSZMrRfkE5OKvBwmPZBUj12jNV
	jYSstykAQjMXqRsMGd1dvGQCwbfehLcbLoUUW37rxJg2BYPW0qUQwgRo6rmOtposSXV1jBl2Zqs2X
	SReojOGv7opJKPTTIfdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfdo0-0005rW-0A;
	Mon, 11 Sep 2023 10:06:08 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfdnx-0005qt-32
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 10:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426765; x=1725962765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lNlcOiZRhunRghkzUThcrr1D7ym3FdZ/wyvyoGKtnUY=;
  b=d0YhcQNwvEj627JcNOVBoK3nhI/UE7kl1lH3JB8jHVRipRqYNly1Sp+s
   d1T84UQdlFB/o+HwHys5VHRHEzOibgmU6e005B2NLGXe21/J/GrOlQ9KX
   n1Zh1YHHjlhL+73JU3kMp/pjuEWH6uCEPxiLNN7K3ON2GLta3mEeZICm7
   wRvaW6MkkLY6sxHNlPjZfFARCVqKyVsTWlLWWXX49h2Y24Su1LI32vPgG
   LzstWHAynWS5rGJxhgIUlYns+WUSXJGzGQOkDkOt3JBIkSwAUmaim5FIy
   tEiLQBVwUjdPXTNljs8RaEFr+mVHtJZVeruJ3wfCwTSvN2XdFPkGrUzy0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381843787"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="381843787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="813308505"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="813308505"
Received: from aabuleil-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.192])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:05:58 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id ED55210940E; Mon, 11 Sep 2023 13:05:55 +0300 (+03)
Date: Mon, 11 Sep 2023 13:05:55 +0300
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
Message-ID: <20230911100555.mjjnx3ujnjlaxgsy@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
 <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
 <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
 <20230911092712.2ps55mylf7elfqp6@box.shutemov.name>
 <476456e1-ac50-8e48-260d-5cbe5e8b085e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <476456e1-ac50-8e48-260d-5cbe5e8b085e@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_030606_021015_B5DC2457 
X-CRM114-Status: GOOD (  27.14  )
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

On Mon, Sep 11, 2023 at 11:50:31AM +0200, David Hildenbrand wrote:
> On 11.09.23 11:27, Kirill A. Shutemov wrote:
> > On Mon, Sep 11, 2023 at 10:42:51AM +0200, David Hildenbrand wrote:
> > > On 11.09.23 10:41, Kirill A. Shutemov wrote:
> > > > On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
> > > > > On 06.09.23 09:39, Adrian Hunter wrote:
> > > > > > Support for unaccepted memory was added recently, refer commit
> > > > > > dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> > > > > > a virtual machine may need to accept memory before it can be used.
> > > > > > 
> > > > > > Do not map unaccepted memory because it can cause the guest to fail.
> > > > > > 
> > > > > > For /proc/vmcore, which is read-only, this means a read or mmap of
> > > > > > unaccepted memory will return zeros.
> > > > > 
> > > > > Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
> > > > > to the information whether memory of the first kernel is unaccepted (IOW,
> > > > > not its memory, but the memory of the first kernel it is supposed to expose
> > > > > via /proc/vmcore)?
> > > > 
> > > > There are few patches in my queue to few related issue, but generally,
> > > > yes, the information is available to the target kernel via EFI
> > > > configuration table.
> > > 
> > > I assume that table provided by the first kernel, and not read directly from
> > > HW, correct?
> > 
> > The table is constructed by the EFI stub in the first kernel based on EFI
> > memory map.
> > 
> 
> Okay, should work then once that's done by the first kernel.
> 
> Maybe include this patch in your series?

Can do. But the other two patches are not related to kexec. Hm.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
