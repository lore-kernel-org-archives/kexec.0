Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BEEC54EBC
	for <kexec@archiver.kernel.org>; Thu, 12 Jan 2023 07:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GYtXXPFt3oPodUHaB7RDkqsis+HuVGo/8h8kEp9qqyQ=; b=j6v78jHDmlxUG4
	GaLhDYLZaUeL65J7ERkH2OCxl4oD7kIfCY4CVZ8NwqQpq47VBSS2G/oV32PCo4t9J4I5OZ8WBE0YN
	aw7aqbxgu/VjOTmlZA20zfAk6A9sUD7pqaMz01Pb6Jr7LClBzrQmKQoOcJt4AIWNZC7ifUW1D6OR4
	4731iRL4BJtxWrB4vBtcy1elH82O+Ese7Bgi7s7ccgM/knPnNGr+EDiZx+LLaEO+jfUakI3Nqq5XK
	fxHTFeElYKkgj3Jw/rp5wr9CDk8bJwz6/F6+1weMMr8OQEhOFcxB2A1fTZ3eOhKGq1Totn8u0JerO
	gdLAO0ogSSa+KOHC1TOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFra9-00Dx5Q-5L; Thu, 12 Jan 2023 07:01:01 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFra5-00Dx4W-MB
	for kexec@lists.infradead.org; Thu, 12 Jan 2023 07:00:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673506857; x=1705042857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NKXVqw2VdPj0WisqK61X35RcspvxrMGsNhD4PdMki38=;
  b=RexsbE5N8z+srco81Y+DwH3C9CedxuozWGO4SqI6b6emy3/y8vwdZ77/
   keZCq0esx1GB1KH437MYtNGqCJyGKEMDE/7gTSr12lNhsWmhk53Lohwt4
   dTWLE3Rui13sd0BOl3FTOeiiD7/fg6GWBzupnPJ52bAIxBvqYp/0q0B4f
   pDauQYUbDVmmsxi2u7T0x7IfW7bfdloTZ+40ghn/WZSexnzbbG+Cisn4T
   gu74yZY9rEPemt25i5/Bk2I8BraCe5Uh/cE8uCsc8sJ6GmfpgEAZDLM5Y
   dmIneh4pjdRrrqQJeaU14eDDy9DOwnxMA+7xF8/4RgjgqJaVYNT2RtpmI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350856807"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350856807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:00:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765492049"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="765492049"
Received: from reillyco-mobl.amr.corp.intel.com (HELO desk) ([10.209.117.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:00:53 -0800
Date: Wed, 11 Jan 2023 23:00:37 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Breno Leitao <leitao@debian.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
	peterz@infradead.org, x86@kernel.org, cascardo@canonical.com,
	leit@meta.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20230112070037.q6cg23tn57onmxfi@desk>
References: <20221128153148.1129350-1-leitao@debian.org>
 <Y76wtwWN1+XPbnQx@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y76wtwWN1+XPbnQx@zn.tnic>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_230057_812190_4C974ADF 
X-CRM114-Status: GOOD (  28.32  )
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

On Wed, Jan 11, 2023 at 01:51:03PM +0100, Borislav Petkov wrote:
> On Mon, Nov 28, 2022 at 07:31:48AM -0800, Breno Leitao wrote:
> > Currently x86_spec_ctrl_base is read at boot time, and speculative bits
> > are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
> > CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
> > the mitigations are disabled.
> > 
> > This is a problem when kexec-ing a kernel that has the mitigation
> > disabled, from a kernel that has the mitigation enabled. In this case,
> > the MSR bits are carried forward and not cleared at the boot of the new
> > kernel. This might have some performance degradation that is hard to
> > find.
> > 
> > This problem does not happen if the machine is (hard) rebooted, because
> > the bit will be cleared by default.
> > 
> > Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  arch/x86/include/asm/msr-index.h |  4 ++++
> >  arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 4a2af82553e4..22986a8f18bc 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -54,6 +54,10 @@
> >  #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
> >  #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
> >  
> > +/* A mask for bits which the kernel toggles when controlling mitigations */
> > +#define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
> > +							| SPEC_CTRL_RRSBA_DIS_S)
> 
> SPEC_CTRL_RRSBA_DIS_S is a disable bit and I presume it needs to stay enabled.

The mitigation is enabled when this bit is set. When set, it prevents RET
target to be predicted from alternate predictors (BTB). This should stay
0, unless enabled by a mitigation mode.

> Only when spec_ctrl_disable_kernel_rrsba() runs. And I'd say perf-wise it
> doesn't cost that much...

I guess this doesn't matter now, because this patch is resetting it by
default that keeps the mitigation disabled with no perf impact.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
