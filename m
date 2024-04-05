Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C42CD11C2
	for <kexec@archiver.kernel.org>; Fri,  5 Apr 2024 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3pURZmsRxSdVBJQgHY5PfXuoaJQhCR6n30INeRig+R0=; b=bdtogFYtdoMCmS
	E/XLcYAFr3Q0ZMNTw259ukuONEF2+vKKp2iN3zMUvYFAoYuwDPexnWt1IFajJTYzBOjhgWBOcibFm
	nD3p7oTQ/W8NF8YgFy4da5legilQCuXCm06XjZBv8N/jJGGAWG2MI0nwRhcFyAXJ5B+KhXkCU82tj
	HsPxibE5hK6vbAJHEdcqN/mDH17ZpOTDS9nFv0/rTdNQhXS3ouNbu0sDZtdpCw5bNfafYeFpRh8MF
	AQubuT1zLLv47KgTlVDcTbAPCVgpRsWqSxf4D/h3UxFRF5brGLJNqF141sbaK/K8l/H3HBtP+3UQZ
	PLaQp/OLgbPcZwfB0sUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsmyG-0000000881m-0pim;
	Fri, 05 Apr 2024 17:03:20 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsmyC-0000000880R-3rfs
	for kexec@lists.infradead.org;
	Fri, 05 Apr 2024 17:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712336597; x=1743872597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A2gJT9MPNiiRXZ3I1nDIIjh5qrMf6fMPCrzE1goQE7g=;
  b=L+Z8/UQ2QJ3h2s9a0bybRlZrhJKUJ8lppTlamJui3RbGN760oP0ARIDC
   tfeVRDwSzz3qkm9QCsOyrw18pvR+/EZDO11VnNRhnpj1yyk1Jm8dztghJ
   r2Eaj4U8CG4IbCc51zuYGObwPR8xMmXcsUE4z4K5llS+IXvbFN75kiFFj
   xgkNvNK7pzlJaUiefKcjbvCU32UC4EE31Fzx10wdLiH3/TsVohTobiEJi
   pfOtMlY6ZXOgr0yx8Pj0JYAkOeSo4U24sY1+dA90DmTcBUPO94NwoooyB
   z5sltL95/Fu7jlz8cvKJ4o06GWI6r4Hep1WKDww5LKAfFkbHaVDYjx9WN
   A==;
X-CSE-ConnectionGUID: 8JwpkZjlRmCs9Nylo7luGQ==
X-CSE-MsgGUID: WR/3eRUWTLKQaXKoBdyXRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="33075458"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="33075458"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:03:16 -0700
X-CSE-ConnectionGUID: FR0NuFbmTRaj/tKSyh8wNA==
X-CSE-MsgGUID: 4MeI8IxHSqy4FTP2KXFNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23941500"
Received: from twwright-mobl1.amr.corp.intel.com (HELO [10.209.65.212]) ([10.209.65.212])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:03:15 -0700
Message-ID: <9322f040-d2f9-4bdc-a85a-edf0082aea46@linux.intel.com>
Date: Fri, 5 Apr 2024 10:03:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] x86/sev: add sev_es_enabled() function.
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <cover.1712270975.git.ashish.kalra@amd.com>
 <e14edff1b22705de6b66f4cbde5df3dc68eb10c1.1712270976.git.ashish.kalra@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e14edff1b22705de6b66f4cbde5df3dc68eb10c1.1712270976.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_100317_118458_8AF79A7C 
X-CRM114-Status: GOOD (  12.38  )
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


On 4/4/24 4:11 PM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Add sev_es_enabled() function to detect if SEV-ES
> support is enabled.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/boot/compressed/sev.c | 5 +++++
>  arch/x86/boot/compressed/sev.h | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index ec71846d28c9..4ae4cc51e6b8 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -134,6 +134,11 @@ bool sev_snp_enabled(void)
>  	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>  }
>  
> +bool sev_es_enabled(void)
> +{
> +	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
> +}
> +
>  static void __page_state_change(unsigned long paddr, enum psc_op op)
>  {
>  	u64 val;
> diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
> index fc725a981b09..5008c80e66e6 100644
> --- a/arch/x86/boot/compressed/sev.h
> +++ b/arch/x86/boot/compressed/sev.h
> @@ -11,11 +11,13 @@
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
>  bool sev_snp_enabled(void);
> +bool sev_es_enabled(void);
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>  
>  #else
>  
>  static inline bool sev_snp_enabled(void) { return false; }
> +static inline bool sev_es_enabled(void) { return false; }
>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>  
>  #endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
