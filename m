Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB383CD80D2
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hCJ6KAh7KdonwFHTRmPOpPf44OgDPv7pMcS5s6Q/HMc=; b=oVAigQ6fWIlvT6
	RMtTp+02PW+Ie96cLzy89vVfaZyIAGrgDR+WxHa3b8wfd08LHg/naQo6A3yZDKv1YWKm2r2W1tldi
	YUVLL5EQc05A8JFDHVIcQ5QB5vUPdjxZodC6E0q+DWJffls9KK5lVUv1lU1nSOH+95hgJ0QFAU+nV
	KIXgcNOi9CENcDk5JogWvZPpmzKO2zbKTHSrKWvAsiXIMfkZIPT2PLj9NidMP54iaF1fSP+oK26D+
	gByCGm0wIp7dAsItoWtozeJT/GmP76rI3mdU7iQ3cKHiLEquSPZOsRVHq/EPg06jjb/IPcFIEaTTp
	GAFPgz5m26oBrrSZY9Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCvg-00DSV6-2d;
	Tue, 10 Oct 2023 13:37:44 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCvd-00DSTa-2Q
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 13:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945061; x=1728481061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XxupxmtyB6MfsqYIPevKjc8Mkmjyag2c1qs/SolrDdo=;
  b=NcaBTHCaJnFpf/KRspbxJx6yxaw7m+ElYXQS2qJDzdUimfaD8YUX88lA
   IQcYKtqqXMCM59DPKQAfCESEZufOaysmI+Cl0iMlYheIKhweR9tiGOChq
   J4P1kKwOqsDbjC9dCWAkQwR3qnMBF/XUZbczoR0n+L/zGKXfH9pOOr308
   VVIJ/Rznmgo3fA0eNQm+8bzc0VwGN7h7oZ5Qjg8vofla/qxpCBbA+Kk+P
   v5t7IDI8whCId1bbKFKjEbxcRdj4IUzJiNpf/YXTB900YoSpFq/aX3RJM
   6IcBlSy5Fe5NZKQTAfIKA+ze8B6mLS/HiZfTA7DFSnctlGt3GaIxaxOEj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384250794"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="384250794"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747072144"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747072144"
Received: from patinira-mobl.amr.corp.intel.com (HELO [10.212.128.216]) ([10.212.128.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:35:59 -0700
Message-ID: <dcf9317e-5557-4fe7-889c-1a02783fa894@linux.intel.com>
Date: Tue, 10 Oct 2023 06:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] kernel/cpu: Add support for declaring CPU hotplug
 not supported
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_063741_839222_91471780 
X-CRM114-Status: GOOD (  23.42  )
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



On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> The function cpu_hotplug_not_supported() can be called to indicate that
> CPU hotplug should be disabled. It does not prevent the initial bring up
> of the CPU, but it stops subsequent offlining.
> 
> This function is intended to replace CC_ATTR_HOTPLUG_DISABLED.
> 

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/cpu.h |  2 ++
>  kernel/cpu.c        | 17 ++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index f19f56501809..aab3887cadbc 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -132,6 +132,7 @@ extern void cpus_read_lock(void);
>  extern void cpus_read_unlock(void);
>  extern int  cpus_read_trylock(void);
>  extern void lockdep_assert_cpus_held(void);
> +extern void cpu_hotplug_not_supported(void);
>  extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
> @@ -147,6 +148,7 @@ static inline void cpus_read_lock(void) { }
>  static inline void cpus_read_unlock(void) { }
>  static inline int  cpus_read_trylock(void) { return true; }
>  static inline void lockdep_assert_cpus_held(void) { }
> +static inline void cpu_hotplug_not_supported(void) { }
>  static inline void cpu_hotplug_disable(void) { }
>  static inline void cpu_hotplug_enable(void) { }
>  static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6de7c6bb74ee..cf536fe1a88a 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -484,6 +484,9 @@ static int cpu_hotplug_disabled;
>  
>  DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
>  
> +/* Cleared if platform declares CPU hotplug not supported */
> +static bool cpu_hotplug_supported = true;
> +
>  void cpus_read_lock(void)
>  {
>  	percpu_down_read(&cpu_hotplug_lock);
> @@ -543,6 +546,18 @@ static void lockdep_release_cpus_lock(void)
>  	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
>  }
>  
> +/*
> + * Declare CPU hotplug not supported.
> + *
> + * It doesn't prevent initial bring up of the CPU, but stops offlining.
> + */
> +void cpu_hotplug_not_supported(void)
> +{
> +	cpu_maps_update_begin();
> +	cpu_hotplug_supported = false;
> +	cpu_maps_update_done();
> +}

Since this function is not used in this patch, do you need to add __maybe_unused to
avoid warnings?

> +
>  /*
>   * Wait for currently running CPU hotplug operations to complete (if any) and
>   * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
> @@ -1507,7 +1522,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	 * If the platform does not support hotplug, report it explicitly to
>  	 * differentiate it from a transient offlining failure.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
> +	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) || !cpu_hotplug_supported)
>  		return -EOPNOTSUPP;
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
