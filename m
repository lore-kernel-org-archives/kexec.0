Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DAEEC8735
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eJA/rd/jmyHG/zHcmHplf6pb90AYzLhRcWJAGT8QaeQ=; b=uT7SrJuGqphuF2
	xSDxlhVL4R2GUCr20VJV1tQ3W5RAmxWyX8pGuYUmlTy46i4BOav+32r0tAeLbI10tOEdYKYTaIiqs
	J2yJSt69A6yQdsq5daExz+qK8z4XooAprnT7ZYsDFax4/zWrRRGMgJKaphpOF99MpUF8WaJa9XAsy
	ESwNAEeyrLApLMJ8kZGatOMBL2JK6krZQ+bK4I64uJkRUqCihsocVOogcybuYJCZXicF7NkuLwDi7
	ibicnLrF7SSdAO7B/lrAEZsqAX2lear9ZjZ9ykhA3YB9vQDK5baVR+P1lb6wXNC9Owp9q5I4ZVWS3
	FNxSVlO0bW9FXGr6xBww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeGRD-00CDxb-1t;
	Thu, 07 Sep 2023 14:56:55 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeGRB-00CDwe-1Y
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 14:56:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694098613; x=1725634613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QrIByt2sivOlThJJJuIm95tWasheU6Saudv9SUBPsTs=;
  b=jKgptOaP0sklkN5mwrrT0qi9FWnUXlQvFtc0WV5TByhSiJ6h5CMsEAWY
   usuXqht8QZnjcX5F/vbsqc183J4QNwEfNZGW6/niY3zGQkeIu/fSS90sb
   yBe0LkdcZx5flMcv2mwEf0AflWdH5tU5s1Po4FZW3xdanHiuKx69YFTTq
   /DRBauZhA49Orm49ZV/1MpQiaj0V/sVBZut2E0fSx2IGy5SRJG9y6XMaG
   AnBvPJgEObu6iXmvMIRTYl1mUNgCAihOKpee15p7DVxRRYPg9XDtIKf9s
   xOi5ghvGkEpwtSzvyVlj9qclcRUtDNJCoI06oQ4vCYONFSmlfmltXsjk6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="441379002"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="441379002"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="856885283"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="856885283"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:46:55 -0700
Message-ID: <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
Date: Thu, 7 Sep 2023 07:46:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
 <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_075653_580485_DCFA55EA 
X-CRM114-Status: GOOD (  21.24  )
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

On 9/7/23 07:25, Kirill A. Shutemov wrote:
> On Thu, Sep 07, 2023 at 07:15:21AM -0700, Dave Hansen wrote:
>> On 9/6/23 00:39, Adrian Hunter wrote:
>>> Support for unaccepted memory was added recently, refer commit
>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>> a virtual machine may need to accept memory before it can be used.
>>>
>>> Do not map unaccepted memory because it can cause the guest to fail.
>> Doesn't /dev/mem already provide a billion ways for someone to shoot
>> themselves in the foot?  TDX seems to have added the 1,000,000,001st.
>> Is this really worth patching?
> Is it better to let TD die silently? I don't think so.

First, let's take a look at all of the distro kernels that folks will
run under TDX.  Do they have STRICT_DEVMEM set?

> config STRICT_DEVMEM
...
>           If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
>           file only allows userspace access to PCI space and the BIOS code and
>           data regions.  This is sufficient for dosemu and X and all common
>           users of /dev/mem.

Can a line of code in this patch even run in the face of IO_STRICT_DEVMEM=y?

I think basically everybody sets that option and has for over a decade.
If there are any distros out there _not_ setting this, we should
probably have a chat with them to find out more.

I suspect any practical use of this patch is limited to folks who:

1. Compile sensible security-related options out of their kernel
2. Go and reads random pages with /dev/mem in their "secure" VM

They get to hold the pieces, and they can and will get a notification
from their VMM that the VM did something nasty.

BTW, Ubuntu at least also sets HARDENED_USERCOPY which will *also*
enable STRICT_DEVMEM.  So someone would have to _really_ go to some
trouble to shoot themselves in the foot here.  If they're _that_
determined, it would be a shame to thwart their efforts with this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
