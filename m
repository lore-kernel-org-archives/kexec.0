Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C74C46CD2
	for <kexec@archiver.kernel.org>; Tue, 30 Jan 2024 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g2+fq2jI2OTKxgek17DOginCAL7aVbaFE/cz/1VIi/M=; b=mi9hM5ie11dwfN
	McKJtWNnkfHV8ZD7Z5tE8gEKxesoZy76GXXN95qq6S2+W14sGCanQpqiUs3a2oIzAp8lkNaCYlCQi
	rqh+kZtr5ofi8NaWFohHEor1VLnkh1e0Mquh1R8ADEaD75+9BQ1X7V9gSy+PyfFhJ4fR0LFecjqVI
	78yVdJQt8IUECe3uBrsV3W3XlS4+JFqmXz7Ji4fP3dXnPwVaTTiUWTVtZS0auBA6w1BFtQ1JqEnKR
	goZ63tA0tkScSlb2zR+lR3sI59Ge4LZNd6hbMfXnce0Ox0bljE3dy/UpiWh1sP4MaNywlwsxi5YMA
	CgrgH/KY/QsGtB1RiLpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpBz-0000000GzSg-0FrO;
	Tue, 30 Jan 2024 14:34:27 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUpBw-0000000GzRc-1EWB
	for kexec@lists.infradead.org;
	Tue, 30 Jan 2024 14:34:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706625264; x=1738161264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eXnTC9Z2V42A4QwsNLM6X9tA1dlLLPk9DhFjZa7uZJw=;
  b=cXsgtPjrzvSjuzsfYchtCDWBTd7nO/ManFaeyt2acinPaEOb3tmUAw5Y
   uYWhpy9ZHgP1hWewERNDyto/qNYcuDtI/9e5k95e4E5JtDknkf+cLHrlI
   mvNKK2GA2Pr9pUXU5Xf90CiGjfF7Seayz0G7gVeNLf3L6XPedYHQnA/ju
   iNcyoHATrXyICKtAVGitYfSgg3yD5hCRgdVrU5XK8UPwwYp4yHFBDyQAs
   KYc1eVwBqtbmEUTxTl8msF3PcralGJbG/W8d1PMl5XZq7m+0XfyQa84dW
   aUYgMqAUxefmFFRgXxVlnVyS/uYTV1RGcxpnyixIEEhF2r6138Z+AHNLg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2231363"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2231363"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961297757"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="961297757"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2024 06:34:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 59D49E6; Tue, 30 Jan 2024 15:55:57 +0200 (EET)
Date: Tue, 30 Jan 2024 15:55:57 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_063424_889658_1E2BD37C 
X-CRM114-Status: GOOD (  15.77  )
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

On Tue, Jan 30, 2024 at 02:43:15PM +0100, Paolo Bonzini wrote:
> On 1/24/24 13:55, Kirill A. Shutemov wrote:
> > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > TDX guest.
> > 
> > The last patch implements CPU offlining according to the approved ACPI
> > spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> > kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> > 2nd kernel with single CPU.
> > 
> > Please review. I would be glad for any feedback.
> 
> Hi Kirill,
> 
> I have a very basic question: is there a reason why this series does not
> revert commit cb8eb06d50fc, "x86/virt/tdx: Disable TDX host support when
> kexec is enabled"?

My patchset enables kexec for TDX guest. The commit you refer blocks kexec
for host. TDX host and guest have totally different problems with handling
kexec. Kai looks on how to get host kexec functional.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
