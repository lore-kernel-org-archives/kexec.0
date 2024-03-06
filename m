Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23C9C5475B
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t+eJHWMKR0Z5RSBgSXHEOZgesN6jdGemE/ok9AgIdac=; b=RgtisGkcjJQu+X
	dM6+LgUSCcxo30NYjae7+edv5yGYEo/iS6OcsKR/daLfqICYORpOL/JV9NbM14ttZDkDL2mj61BAF
	NZ5ZNdsraQTVWPr3DQzEbPqKbxbXih3tXzQ/iykaVkWpQoe3vDw7gwzrkB7Xd2C23J5Mf19ZgVMOG
	OdHQyJsD9CT3xOiCET+0fMHMa+KkyohqRRrCTSw1y5JpHbdcoiG720/EM3cf9z158hfLvkZFH8Y5i
	c5raFabjPewxU1uin6hWldo8dIHkK7o/cz1lKFUXIO6hgb44utHyQq4u6Lx1q0r2z+JeJWyhHIfHY
	WrloCpBraJDy/yOrwQXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsnK-00000000guS-00jU;
	Wed, 06 Mar 2024 15:02:58 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsnG-00000000gtK-1Z8a
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 15:02:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709737374; x=1741273374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0YlQcNDY2yZmAytkOmvFnpG2SeB7XydxVJMOyJgBm2U=;
  b=MsTKRiMObdNAfl3tQ9+GLT8NYplkd2cphOciTc5ZFvQtxXYdOohTX4JQ
   S8ntR0MkpgbQlZS3aHyrozxnQrlmAvOgXht4Thcao1WKzeN0iG42BFgAt
   ajq3PBhpLlMWMyCkimSn6wx125OLR9jnf74umk7jlEBiOD1892yxRS3nF
   P1G1PJ3w6FiIyHe6Amqdef5AzaN8hCdB1rQ4RDuLQAHmSm/VLIFLRk0YS
   5mlH36G1BtN81H8XYQMFCWfa/h+YU7j9jeShlQsVRyKL9rhuZbbRBi79B
   r2sxYOwXDeO//LzFUqLwAj3b8iZT1tnj7ugWYriLf59Ho+QlOHVlfzbeD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4467266"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4467266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937045015"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="937045015"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2024 07:02:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B7F1D184; Wed,  6 Mar 2024 17:02:45 +0200 (EET)
Date: Wed, 6 Mar 2024 17:02:45 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/17, CORRECTED] x86/tdx: Add kexec support
Message-ID: <4iospuc5oxs7vbgm3driasjeyixvgz6yrmym3kzguzngngo7zm@c6ymrw52fn5v>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_070254_484802_9D1D055C 
X-CRM114-Status: GOOD (  13.59  )
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

On Tue, Feb 27, 2024 at 11:24:35PM +0200, Kirill A. Shutemov wrote:
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> TDX guest.
> 
> The last patch implements CPU offlining according to the approved ACPI
> spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> 2nd kernel with single CPU.
> 
> Please review. I would be glad for any feedback.

Thomas, Ingo, Borislav, Dave,

Any feedback?

Is there anything else I can do to get the patchset moving?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
