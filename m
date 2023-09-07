Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF32EC8733
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DG65rOVJQEk0CE7TM4dyW4zUIVomu+QHKHP/WS9JUWw=; b=VfKeb9kSrnbeal
	OINcjA2ffQkVyvGPAKhpUteGdP1h6T/m/4eBZP4Bl8w4bVChw1luwfdTugJEwFMXKWqT75OCrFoJA
	xs2J4UUXkWcnDlwRih2bY/L5HIC5ZTCNkN7xLTwNyksWYDNmJXhybcpVoF6bil+LFsLYmzyN4qlmC
	ATTEqxHaIaqQio52hYkRdf5/tI7hsjB5NEhY9caoeKg1X2MWuM+vjHOz/KwlpZGyxv3u+yzyGP1es
	RnW3uuJpzsV15gImiiLdI5hq+WcKoww4g8D0y1Zacw/N4M0saUqMTBF1AnUBm/Vw2tAMfg3IUeJVd
	2JtEg8Fa4jRmUIQFOmTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeFwz-00CCC5-1L;
	Thu, 07 Sep 2023 14:25:41 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeFww-00CCBc-22
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 14:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694096738; x=1725632738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLkgQjdozZeu2blgME5D5x7Y7mxXeqbdwxTIXoD6yOY=;
  b=QiQv9nBj+YNdMJ7AdIzT1Z6seT3/2hO3tcCZTJjVrWb08iHPTVyDaZNA
   Cow+r7/nVKtejNxo4+rYsXGxJfJ+PHZzSgt4n2csluzk/x9kVlsJmTiqw
   +Id8Hkc9wte2gtRYoYlwjRJkWIy6ycdrkL77SvrHkvnenSCcTRtvP3LH+
   2IrPVUQfieWuGJIVcrkOGrs8vMme7wlSseUQKRw6KvKmaKxreRWfySzNL
   qi6bF+Y5tOn6q5Z5eyiRXERHlTb5KYE+LLAqkVL9aGx9fO2rnC+udY/VN
   cgCuUE5BIWpgpPhzKjvzbLg6hoBXAbHODoGkVVpx2xUr6sWRt3h2xdNL7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357679643"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="357679643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735520927"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="735520927"
Received: from oshragax-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.215.248])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:25:14 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 7882D104860; Thu,  7 Sep 2023 17:25:10 +0300 (+03)
Date: Thu, 7 Sep 2023 17:25:10 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Message-ID: <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_072538_683100_34D98C71 
X-CRM114-Status: GOOD (  13.31  )
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

On Thu, Sep 07, 2023 at 07:15:21AM -0700, Dave Hansen wrote:
> On 9/6/23 00:39, Adrian Hunter wrote:
> > Support for unaccepted memory was added recently, refer commit
> > dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> > a virtual machine may need to accept memory before it can be used.
> > 
> > Do not map unaccepted memory because it can cause the guest to fail.
> 
> Doesn't /dev/mem already provide a billion ways for someone to shoot
> themselves in the foot?  TDX seems to have added the 1,000,000,001st.
> Is this really worth patching?

Is it better to let TD die silently? I don't think so.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
