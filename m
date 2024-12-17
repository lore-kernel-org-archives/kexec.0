Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B85E7717F
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3LJ9jVtSnUzYn38GgyZZFJOJM2V+Yx1QbIrz1xmbgjM=; b=HWsgbw7z/Jm6lJGzuE4yg1a3ar
	8Zmiuctdf/LYbKqEj3/g931JzbxJ4RfathxS8kJRgDnh15fUQh2ksHA7EqWbAdkZqJYaT5HN3srNn
	acJEPDEyXmnYy8dbBGxi0FQuexl2VVE2P65ttS07tBJWGtD3BC8zHVg3oRkSXUvhTxoxmxYnCJCli
	APIVXuE38kHIkc3BQw1ktt1r/TUb77iFJ5wIDvVeZVUJixZqJWhQQ1Z7D6UYXZLce9el5bxeItlT8
	NwbFi2g9Qdha1hC6Qdp9+ax9dZ/SpoDETSWR1YMJQ50PMgNZgkMsNxQv6tuGMtCyE1Pei5JrYAytx
	X/5rMgrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNWfE-0000000DNnD-170r;
	Tue, 17 Dec 2024 12:27:00 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNWeE-0000000DNgD-0N5c
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 12:25:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734438358; x=1765974358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=irWJtZet4nlk1elBNcwjR/8G5fL9vEkmSHNUYwPwAiU=;
  b=Nn5ey3/skgEAmvNmNlxjIxdn9ryCbFPQB+IYsqAnme95fA2IAMODhicI
   blo/eBFyHLc1zsA8dux+aKdSFlMqEqyzsgO7dtd+4Hh0EOznT6Vnx8IzH
   uiqerr06gyuKTBBAWAR+YnZ+ofAncYxDmg32tn7+Mt4YzGqnHztNYBwhx
   D3sWTGMN1V4kNNNh4Z7d+cjuNxxsee7+wHIJdQ4xRfe5r2t/pKnyjjGiE
   ETd6GHAzb/adK9MIrTuvVVhIfSCvI9DsvKkUWK5MFMwPn0oQGg3gtFwCF
   r77zSjmW6G6u4Oi2vNCElS45uhI3/7jZuiOGlvbiPk3l8Fp4pId1G0BHs
   w==;
X-CSE-ConnectionGUID: 1ZeLogmpSxqH7yU4nvBdqQ==
X-CSE-MsgGUID: tpEXMLToTOm1JBiyyV2TyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22450898"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="22450898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 04:25:57 -0800
X-CSE-ConnectionGUID: QYHr+ej4RxOao6V6hGXinw==
X-CSE-MsgGUID: UNAwxd+fTq2kNQwoGSFrpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101661627"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 17 Dec 2024 04:25:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E99273B7; Tue, 17 Dec 2024 14:25:48 +0200 (EET)
Date: Tue, 17 Dec 2024 14:25:48 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, 
	David Kaplan <david.kaplan@amd.com>, Tao Liu <ltao@redhat.com>, Kai Huang <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: Re: [PATCH 1/9] x86/kexec: Disable global pages before writing to
 control page
Message-ID: <tksesvqt266x6a6mnoi5aqa3fhsoyo7mbp277elrrft5eieoba@7ospdizq22y6>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
 <20241216233704.3208607-2-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216233704.3208607-2-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_042558_171496_C1614971 
X-CRM114-Status: GOOD (  20.28  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Dec 16, 2024 at 11:24:08PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The kernel switches to a new set of page tables during kexec. The global
> mappings (_PAGE_GLOBAL==1) can remain in the TLB after this switch. This
> is generally not a problem because the new page tables use a different
> portion of the virtual address space than the normal kernel mappings.
> 
> The critical exception to that generalisation (and the only mapping
> which isn't an identity mapping) is the kexec control page itself —
> which was ROX in the original kernel mapping, but should be RWX in the
> new page tables. If there is a global TLB entry for that in its prior
> read-only state, it definitely needs to be flushed before attempting to
> write through that virtual mapping.
> 
> It would be possible to just avoid writing to the virtual address of the
> page and defer all writes until they can be done through the identity
> mapping. But there's no good reason to keep the old TLB entries around,
> as they can cause nothing but trouble.
> 
> Clear the PGE bit in %cr4 early, before storing data in the control page.

It worth noting that flipping CR4.PGE triggers TLB flush. I was not sure
if CR3 write is required to make it happen.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

