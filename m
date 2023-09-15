Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D19CEE645C
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jVodhvTms2OAtqZXnhMK0mZaeH12ON4bc1wZmZCBwCA=; b=trJyGX8ZWv/aSS
	Q/XXKlFhybD6PhmsIZHhKSxkryHv8w3Bf6gZqsTGkwCxzPSFZ4ke9TL6jRMeWPt8/LUZYbfADNTW2
	UF3wAMvTSZvOmhmCMchzfHTj8q+Qjwv8+io9ekxDhTbwXhQFH9aogRVPQOKmBftv4i2weh5qZM6F7
	teYGjOeCaPzWL4mzd0Swh6Kb2LtEJ06+qEbXGZAVhRPKtd7MCODW/IJubaBvNNI58g+mM8ngqWmT3
	M51Rv/wLcMMO9+zxyhiuXErelGbX+allTHf56K3S0gJ2cvAUZFMJdRgIcvICJjZrzyTBn1iqqYDoH
	92GkNZ2NU+l3I/6Hr/Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh8e6-00Amha-1k;
	Fri, 15 Sep 2023 13:14:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qh8e3-00Amgf-1t
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 13:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694783642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sb5wr0wfo93KZmmG9iONfAq+eRQpW+VSRFFBiRCmnG8=;
	b=ME90bPtPrqAK51sH/D1eRBecNBH8eVB0ed92BhbTjJtvNyzo2qzSR23+3TDqKtvhD7T038
	beKJ5wMpyOE94Saae2m2jTiqoKWOTrvw2pR4YPzu0eu8z4PPXgkpzes5D5HR5VwyZuUn4l
	dECaujLAGd/slmOscEP5wodgtWYwdJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-qPOpJlElMJyjGulFdS2cwQ-1; Fri, 15 Sep 2023 09:13:52 -0400
X-MC-Unique: qPOpJlElMJyjGulFdS2cwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1227858285;
	Fri, 15 Sep 2023 13:13:51 +0000 (UTC)
Received: from localhost (unknown [10.72.113.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 806C32026D68;
	Fri, 15 Sep 2023 13:13:50 +0000 (UTC)
Date: Fri, 15 Sep 2023 21:13:47 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	thunder.leizhen@huawei.com, catalin.marinas@arm.com,
	chenjiahao16@huawei.com, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 6/9] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <ZQRYixr2AtJtRFrh@MiWiFi-R3L-srv>
References: <20230914033142.676708-7-bhe@redhat.com>
 <202309141534.moH4dTcz-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202309141534.moH4dTcz-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_061403_743107_CAB399BE 
X-CRM114-Status: GOOD (  24.16  )
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

On 09/14/23 at 04:12pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on powerpc/fixes linus/master v6.6-rc1 next-20230914]
> [cannot apply to arm64/for-next/core tip/x86/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230914-113546
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> patch link:    https://lore.kernel.org/r/20230914033142.676708-7-bhe%40redhat.com
> patch subject: [PATCH v3 6/9] x86: kdump: use generic interface to simplify crashkernel reservation code
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309141534.moH4dTcz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kernel/setup.c:476:15: warning: no previous prototype for function 'crash_low_size_default' [-Wmissing-prototypes]
>    unsigned long crash_low_size_default(void)
>                  ^
>    arch/x86/kernel/setup.c:476:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    unsigned long crash_low_size_default(void)
>    ^
>    static 
>    1 warning generated.

Thanks for reporting this. I can reproduced this warning on x86_64
machine by retrieving the LKP's config and build it with below command:

	make ARCH=i386 -j128 W=1 arch/x86/kernel/

I can fix it by moving crash_low_size_default() into arch/x86/include/asm/crash_core.h 
and make it as static inline as below draft change.

Hi Andrew,

I should post v4 of the whole series or just v4 of this patch?

[PATCH v3 6/9] x86: kdump: use generic interface to simplify crashkernel reservation code


diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
index 5fc5e4f94521..76af98f4e801 100644
--- a/arch/x86/include/asm/crash_core.h
+++ b/arch/x86/include/asm/crash_core.h
@@ -18,6 +18,7 @@
  * no good way to detect the paging mode of the target kernel which will be
  * loaded for dumping.
  */
+extern unsigned long swiotlb_size_or_default(void);
 
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX     SZ_512M
@@ -29,6 +30,13 @@
 
 # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
 
-extern unsigned long crash_low_size_default(void);
+static inline unsigned long crash_low_size_default(void)
+{
+#ifdef CONFIG_X86_64
+	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+#else
+	return 0;
+#endif
+}
 
 #endif /* _X86_CRASH_CORE_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 0acc86587fc0..d7baa567c68e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -470,18 +470,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	}
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
-unsigned long crash_low_size_default(void)
-{
-#ifdef CONFIG_X86_64
-	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-#else
-	return 0;
-#endif
-}
-
 static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size, low_size = 0;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
