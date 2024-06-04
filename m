Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C21FC25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jTuWKChCESSN40LihVPEc8BSTO46/e6Y4wqlsLkVoDs=; b=H0AHLyAncWWl2G
	JEntIQXLa7VogmeCzJX7skazJFN0P5/twCXs6Kn+lnw5XcdgICrXd46EjF78jis53OeY6OmvrAls1
	WdqkaZGuEAiT+paN4TpZDVpoJQ66hkX6qcVr/Rfio+0hcuSzPFBokfN7TALRZtX3aTKUxgoYsukT9
	AJwjgBTlVTeuEs9QAQXXpemEiVK1sOcA2Y6oQ86HGmmTLX1yvYeydBeG7NpJwlkjWlkQWwI3RWKmL
	g6Z/CkLPsnklIclPe/2DITiSNgrbbasxA7t4X3WX7J904aKlTLYwqt6UC4Njf48q4ZgVEobPgciBs
	E6ylqaQ053yNmHa07VIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEW9j-00000002wSb-2tfH;
	Tue, 04 Jun 2024 15:32:59 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEW9f-00000002wQN-1T57
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 15:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717515175; x=1749051175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3T38p4+VBwHGHp1c1CCtvuA9p7YL8sLSDhZFZphLPY=;
  b=QbggursMTbp97knEPIsC/2IPrgVGnxZN7xP4+xcMKTlWuRgRlEfaWaje
   hL6Gyj62rY4p4Ppa6JxnoR3Cinhg3InEb9C9nWtKMrTov7MN9aZPOjmTx
   L8iMETl6fq+8UwxGx5kNDdUoAOLCLDP/lVyY1hfUjOu6hk2drL5MXZgRJ
   4Ffy70GB/YfYyeb4uS417txJO7/jB7qKJtNkqReiLCggELGunOKyU5QlM
   QqZPI5Zts+9B+cd3J6KpjfzX3CgFQEY0jq5/ueFAFCoPIpR9lUq3BdvoL
   9/Nx7ZVjqQB8+BUOg6wZ0kmTJIeF9/KFmWOiN3SmzO+nPMtwAri1S8C1x
   A==;
X-CSE-ConnectionGUID: 10863EQ2RNuaddb0cmCNaA==
X-CSE-MsgGUID: UtMKjFdcTFyWl7JN69yukA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13950190"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13950190"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:32:51 -0700
X-CSE-ConnectionGUID: oiWsV40YQ3upwnBy4jBHSA==
X-CSE-MsgGUID: vSlLFQjkSbWE+7x+vrrshQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41715766"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 04 Jun 2024 08:32:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 783202DC; Tue, 04 Jun 2024 18:32:44 +0300 (EEST)
Date: Tue, 4 Jun 2024 18:32:44 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: adrian.hunter@intel.com, ardb@kernel.org, ashish.kalra@amd.com, 
	bhe@redhat.com, dave.hansen@linux.intel.com, elena.reshetova@intel.com, 
	haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com, kai.huang@intel.com, 
	kexec@lists.infradead.org, kys@microsoft.com, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ltao@redhat.com, mingo@redhat.com, peterz@infradead.org, rafael@kernel.org, 
	rick.p.edgecombe@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_083255_405832_BFA125C2 
X-CRM114-Status: GOOD (  13.56  )
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

On Mon, Jun 03, 2024 at 10:37:54AM +0200, Borislav Petkov wrote:
> On Sun, Jun 02, 2024 at 05:23:03PM +0300, Kirill A. Shutemov wrote:
> > +			/*
> > +			 * The only thing one can do at this point on failure
> > +			 * is panic. It is reasonable to proceed.
> 
> It makes even less sense now: panic() means "all stops and we die" and
> you say it is reasonable to proceed.
> 
> I'm confused.

Right.

What about the comment below?

			/*
			 * One possible reason for the failure is if kexec raced
			 * with memory conversion. In this case shared bit in
			 * page table got set (or not cleared) during
			 * shared<->private conversion, but the page is actually
			 * private. So this failure is not going to affect the
			 * kexec'ed kernel.
			 *
			 * The only thing one can do at this point on failure
			 * at this point is panic. In absence of better options,
			 * it is reasonable to proceed, hoping the failure is a
			 * benign shared bit mismatch due to the race.
			 *
			 * Also, even if the failure is real and the page cannot
			 * be touched as private, the kdump kernel will boot
			 * fine as it uses pre-reserved memory. What happens
			 * next depends on what the dumping process does and
			 * there's a reasonable chance to produce useful dump
			 * on crash.
			 *
			 * Regardless, the print leaves a trace in the log to
			 * give a clue for debug.
			 */

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
