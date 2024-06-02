Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C256DC25B74
	for <kexec@archiver.kernel.org>; Sun,  2 Jun 2024 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hxIWLWU3T7aEGEi8EQ10gNhEq3T2TgwN08J1TU7Dyik=; b=Y6gj7qXLhqFjKV
	c0cf9l4mfjy5r40N3ARgbQjuAJvGkfbUArD448lwmncx/wtvy/Dj08C4NVoMdAtO38n7Pdf0dfJXz
	V7isCUlFMv25spNwB2d7/aAoF6zxQyAVARYrCLtUYYWcqvotgpdCVVckaMPKs89jq0OLUgmf2tf3V
	QJ4yqnwNlRzvmZCtp7KxruEZhQ84PsgmCC9irNVXltR3Giqc5F5odGohxx6u8rAYwnYd7q2BnHUDl
	69mCyM/2rzdd8ze8v00aK0ijgSJ3SO5+tVaeA6YibERwykh7HP7Qlga5loi9HtbH+A/DPeJCY0wRZ
	FRB1G+Jlrd9YjBATo7VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDkXb-0000000EFK2-3XnH;
	Sun, 02 Jun 2024 12:42:27 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDkXX-0000000EFJ5-3V1O
	for kexec@lists.infradead.org;
	Sun, 02 Jun 2024 12:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717332144; x=1748868144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bd0Ky3nJOVfEJZnsWoWRij0lx/SkCJKPs7DSSagkBwQ=;
  b=RfzJM7LG3j0jLeLEw/XLl339DPIr3mxSTt9rG8c1nRAK+zeIeqJr+Tr5
   nWiKt+9VjQyCGRZ2/lznUbUCDmf5UtI5kM+KEsD31YoSNyHF1jTz51M4m
   mlaosyDJl9eB9JgLZb8tO55Wo4nsXUfAEKiVxSX5DsCV34yTHjpjzorXu
   2eGyTpaMilCd2Ni89EJk1OmKFVSdheMq62j4lV76RHeOiXH0a7TeKeexP
   dO0s5juJ72IYWtlYUgKCfH8DW+DrLf/W0k06T2OyVUBEl42nKLlxyQnpC
   vg7O/DtR8Fh1tiJNdZn9oxqfSMLQsap2w4MDhsWhpnSwiHJnuR3iiXz5k
   Q==;
X-CSE-ConnectionGUID: 3Q2oUe69Rw2MF+bFG+EPig==
X-CSE-MsgGUID: VMoMQGotRQO2/Fwe/syXDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17624419"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="17624419"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 05:42:21 -0700
X-CSE-ConnectionGUID: tX8LoOEsRrWCzt7Ls4ZcdQ==
X-CSE-MsgGUID: UuebdpjSSvGjZhnGNfe2DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="41061427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 02 Jun 2024 05:42:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9CA1A1CB; Sun, 02 Jun 2024 15:42:13 +0300 (EEST)
Date: Sun, 2 Jun 2024 15:42:13 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: bp@alien8.de
Cc: adrian.hunter@intel.com, ardb@kernel.org, ashish.kalra@amd.com, 
	bhe@redhat.com, dave.hansen@linux.intel.com, elena.reshetova@intel.com, 
	haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com, kai.huang@intel.com, 
	kexec@lists.infradead.org, kys@microsoft.com, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ltao@redhat.com, mingo@redhat.com, nik.borisov@suse.com, peterz@infradead.org, 
	rafael@kernel.org, rick.p.edgecombe@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org
Subject: Re: [PATCHv11.1 10/19] x86/mm: Add callbacks to prepare encrypted
 memory for kexec
Message-ID: <wu34snwuytiwqp3scpxl7c7jw47jiywjlvommoenpsmbrp6c5k@con7h3pomdst>
References: <20240529104257.GIZlcGsTkJHVBblkrY@fat_crate.local>
 <20240602123903.2121883-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240602123903.2121883-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240602_054224_350594_6440BD92 
X-CRM114-Status: UNSURE (   3.80  )
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

Please disregard this. I failed to fold changes :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
