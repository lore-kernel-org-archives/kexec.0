Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A14D70E09
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 02:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hk9zMoDcE5wyq5i77c/JybahqCDfXnjy6iN9kcroPaI=; b=vcXzk4yzRwplox5F4iaDTSAxlf
	PQyfYF3pk9Q2WUf3OgqewhyK/ZjEvmKOfYnuesUB7oJz+DL0vXY/CfnOWo3DOG4B0sozSbuPOMgjG
	AhZMjgOMT2QCC1ech4eBsCvQx3v1kAX8i0ZNpqZwxp4vF5SBLetaom2oap/c4OJCGshwyDzojwu7K
	rsfwjrUe7qV9khFzhIjrhaAwtIMAOp/CdMcPu2mRacGDG/zz1hlFdvQ/maaWo0fcIuIg7PWHssqjn
	ZZKOPPPw/c46MKf25FdzntinqcHAfuEj/IE1+i+PZCUfbi4KtCRFs6INqjw6O5vG2HcX425E13ktv
	Ms4b4tSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGr3C-0000000GlU7-16pB;
	Fri, 29 Nov 2024 02:48:10 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGr2B-0000000GlLG-3Pb0;
	Fri, 29 Nov 2024 02:47:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732848428; x=1764384428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iyi+W+JKz0EAQaKtqkrUOsmAFLfBMZSMkSfcKblxaS8=;
  b=EfR79ps/Zq19V7DvvfS32GHvgNoZVclNdj80OyTQOlBgEhsjEs79PUK7
   UhywD7O+RVAf+T9r5ex0rpavz3lUbSPvZWYpGEENqJPCvm6Sks+bBgIr0
   aRImfe3eryW6rosatUhR0MExuR0aLdRxh6wwzVIRkNDIE2Q982rwFLg7Z
   +KLAykMCVbzz+8MPYNJY0hg9AEQW9n9YsVIo3Ecy1L+9BSuMbf4Qjz1de
   YS9MT0X11gjxLV/uqaxVftW90q+BPSwxxFWNaDTovx51Fj5XvyqdrxSPq
   YIA5ZjA9VfqsZKcRub0mV2r0jedB1IE1syCwJ6DAFZbMLgdFTmdPE+OSq
   Q==;
X-CSE-ConnectionGUID: DZ4DLcERRWmpApC1BSdRDg==
X-CSE-MsgGUID: BiKnfxbhSmGjFUL4m6Ko+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33137820"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33137820"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 18:47:04 -0800
X-CSE-ConnectionGUID: OcwmjXnURpODgunOkehPOg==
X-CSE-MsgGUID: eL24zCVPSSGLJuhXw/TONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92554387"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Nov 2024 18:46:57 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGr1y-000AGR-2s;
	Fri, 29 Nov 2024 02:46:54 +0000
Date: Fri, 29 Nov 2024 10:46:18 +0800
From: kernel test robot <lkp@intel.com>
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
	maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, tglx@linutronix.de, ebiederm@xmission.com,
	akpm@linux-foundation.org, bhe@redhat.com, hbathini@linux.ibm.com,
	sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
	songshuaishuai@tinylab.org, takakura@valinux.co.jp,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, jonnyc@amazon.com
Subject: Re: [PATCH v3 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
Message-ID: <202411291047.R9P698b2-lkp@intel.com>
References: <20241128201027.10396-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128201027.10396-2-farbere@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_184707_901957_6AFC74CE 
X-CRM114-Status: GOOD (  13.19  )
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

Hi Eliav,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes tip/irq/core arm64/for-next/core linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eliav-Farber/kexec-Consolidate-machine_kexec_mask_interrupts-implementation/20241129-041259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20241128201027.10396-2-farbere%40amazon.com
patch subject: [PATCH v3 1/2] kexec: Consolidate machine_kexec_mask_interrupts() implementation
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20241129/202411291047.R9P698b2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411291047.R9P698b2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291047.R9P698b2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/kexec_core.c: In function 'machine_kexec_mask_interrupts':
>> kernel/kexec_core.c:1085:24: error: implicit declaration of function 'irq_desc_get_chip' [-Werror=implicit-function-declaration]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                        ^~~~~~~~~~~~~~~~~
>> kernel/kexec_core.c:1085:22: warning: assignment to 'struct irq_chip *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                      ^
>> kernel/kexec_core.c:1097:38: error: invalid use of undefined type 'struct irq_chip'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                      ^~
>> kernel/kexec_core.c:1097:51: error: implicit declaration of function 'irqd_irq_inprogress' [-Werror=implicit-function-declaration]
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                   ^~~~~~~~~~~~~~~~~~~
>> kernel/kexec_core.c:1097:76: error: invalid use of undefined type 'struct irq_desc'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                                            ^~
   kernel/kexec_core.c:1098:29: error: invalid use of undefined type 'struct irq_chip'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1098:44: error: invalid use of undefined type 'struct irq_desc'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                                            ^~
   kernel/kexec_core.c:1100:25: error: invalid use of undefined type 'struct irq_chip'
    1100 |                 if (chip->irq_mask)
         |                         ^~
   kernel/kexec_core.c:1101:29: error: invalid use of undefined type 'struct irq_chip'
    1101 |                         chip->irq_mask(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1101:45: error: invalid use of undefined type 'struct irq_desc'
    1101 |                         chip->irq_mask(&desc->irq_data);
         |                                             ^~
   kernel/kexec_core.c:1103:25: error: invalid use of undefined type 'struct irq_chip'
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                         ^~
   kernel/kexec_core.c:1103:43: error: implicit declaration of function 'irqd_irq_disabled'; did you mean 'arch_irqs_disabled'? [-Werror=implicit-function-declaration]
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                                           ^~~~~~~~~~~~~~~~~
         |                                           arch_irqs_disabled
   kernel/kexec_core.c:1103:66: error: invalid use of undefined type 'struct irq_desc'
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                                                                  ^~
   kernel/kexec_core.c:1104:29: error: invalid use of undefined type 'struct irq_chip'
    1104 |                         chip->irq_disable(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1104:48: error: invalid use of undefined type 'struct irq_desc'
    1104 |                         chip->irq_disable(&desc->irq_data);
         |                                                ^~
   cc1: some warnings being treated as errors


vim +/irq_desc_get_chip +1085 kernel/kexec_core.c

  1075	
  1076	void machine_kexec_mask_interrupts(void)
  1077	{
  1078		unsigned int i;
  1079		struct irq_desc *desc;
  1080	
  1081		for_each_irq_desc(i, desc) {
  1082			struct irq_chip *chip;
  1083			int check_eoi = 1;
  1084	
> 1085			chip = irq_desc_get_chip(desc);
  1086			if (!chip)
  1087				continue;
  1088	
  1089			if (IS_ENABLED(CONFIG_ARM64)) {
  1090				/*
  1091				 * First try to remove the active state. If this fails, try to EOI the
  1092				 * interrupt.
  1093				 */
  1094				check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
  1095			}
  1096	
> 1097			if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

