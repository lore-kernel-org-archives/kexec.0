Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9098AD70E1A
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 04:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UiTCs9a6bPWqF5tTiyYU4MQJTIvdFyz65sv8/TMAMhc=; b=VAPOIPjbWgwNT09Sb6vdehwLdr
	cSnY/XJS5rEj1VhkfDEcY25cgbzuCqIScTVrtkhTXBdXx5W76xQ2csMgoi+tSfv40vnkIMz0M3g2g
	KmO8WdPWPs89sScPGi8bm7SY34dqNLWN3JFwOvwd+vbiAm3hGPSW8F0L05Ot0hO9TF+wTcMacnsAn
	ZN0nYKUsiPJ0FIMQVU23NiEazIqceGFLwvTi6pOboXG15yTFhJr5W8Dy4MWsbjBG5Pja/Jus88g+9
	HRWoIzCn+ddY07sxrlBrX9zFtev0l4mU4zPppjnclQHAcukok+GoF+XwxT9rpb/nc4QyPRh0ktUpA
	fkLh/HiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGsg4-0000000GrsV-1f9u;
	Fri, 29 Nov 2024 04:32:24 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGsf3-0000000Grlo-3ugl;
	Fri, 29 Nov 2024 04:31:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732854681; x=1764390681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nhVJ2KsFTU6vdZyrFjJy+CpqJVuOIfZcG0UnLygKl20=;
  b=bGMNGHiyF6CV/wxdYjIn0HaTpf/JRt6T37G1u2jKJ7WaURoJA747NaJ7
   6ZaJG32+rqSFqWyFDiA7OxJiycVX4GzhwNdJ2azBS5k6bD4CbaiaqInFZ
   cUCumSkzvn0DMFQKzELXkROhyuEae+BlRK0gOcooTUZmF/cVxElgAE6b7
   TrTDLLW2XEAwnL4gC+j43AP+RexBGGz/rf04/iT8dzqHD7hbeJu6sIUzS
   CNEBu6hP2f7mCIbOlp4Z0Ho1cY8lyDj5DtYdqtFpgIPYdjm1/fCEiEFf3
   tTlNISmyPJdzlnAbAWdAmEuOf9DScTUr2RNWcSZgKOGLaoESbm9dcH0wO
   w==;
X-CSE-ConnectionGUID: wtCjyDhdQsm0ffSoBHSSrA==
X-CSE-MsgGUID: AXmQEnVsSoa3STS0IN5Qww==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="58495749"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="58495749"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:31:15 -0800
X-CSE-ConnectionGUID: 7+ctehuyTaqXPs1MF1yt2g==
X-CSE-MsgGUID: 8udd5Dm+TGClDUig78Zgfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92193838"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Nov 2024 20:31:09 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGsep-000AL9-0P;
	Fri, 29 Nov 2024 04:31:07 +0000
Date: Fri, 29 Nov 2024 12:30:58 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jonnyc@amazon.com
Subject: Re: [PATCH v3 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
Message-ID: <202411291225.18ZMjZcQ-lkp@intel.com>
References: <20241128201027.10396-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128201027.10396-2-farbere@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_203121_989475_A33F4DF5 
X-CRM114-Status: GOOD (  14.16  )
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241129/202411291225.18ZMjZcQ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411291225.18ZMjZcQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291225.18ZMjZcQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/kexec_core.c:9:
   In file included from include/linux/btf.h:8:
   In file included from include/linux/bpfptr.h:6:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> kernel/kexec_core.c:1085:10: error: call to undeclared function 'irq_desc_get_chip'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                        ^
>> kernel/kexec_core.c:1085:8: error: incompatible integer to pointer conversion assigning to 'struct irq_chip *' from 'int' [-Wint-conversion]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                      ^ ~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/kexec_core.c:1097:24: error: incomplete definition of type 'struct irq_chip'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                  ~~~~^
   kernel/kexec_core.c:1082:10: note: forward declaration of 'struct irq_chip'
    1082 |                 struct irq_chip *chip;
         |                        ^
>> kernel/kexec_core.c:1097:37: error: call to undeclared function 'irqd_irq_inprogress'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                   ^
>> kernel/kexec_core.c:1097:62: error: incomplete definition of type 'struct irq_desc'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                                        ~~~~^
   include/linux/irqnr.h:10:15: note: forward declaration of 'struct irq_desc'
      10 | extern struct irq_desc *irq_to_desc(unsigned int irq);
         |               ^
   kernel/kexec_core.c:1098:8: error: incomplete definition of type 'struct irq_chip'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                         ~~~~^
   kernel/kexec_core.c:1082:10: note: forward declaration of 'struct irq_chip'
    1082 |                 struct irq_chip *chip;
         |                        ^
   kernel/kexec_core.c:1098:23: error: incomplete definition of type 'struct irq_desc'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                                        ~~~~^
   include/linux/irqnr.h:10:15: note: forward declaration of 'struct irq_desc'
      10 | extern struct irq_desc *irq_to_desc(unsigned int irq);
         |               ^
   kernel/kexec_core.c:1100:11: error: incomplete definition of type 'struct irq_chip'
    1100 |                 if (chip->irq_mask)
         |                     ~~~~^
   kernel/kexec_core.c:1082:10: note: forward declaration of 'struct irq_chip'
    1082 |                 struct irq_chip *chip;
         |                        ^
   kernel/kexec_core.c:1101:8: error: incomplete definition of type 'struct irq_chip'
    1101 |                         chip->irq_mask(&desc->irq_data);
         |                         ~~~~^
   kernel/kexec_core.c:1082:10: note: forward declaration of 'struct irq_chip'
    1082 |                 struct irq_chip *chip;
         |                        ^
   kernel/kexec_core.c:1101:24: error: incomplete definition of type 'struct irq_desc'
    1101 |                         chip->irq_mask(&desc->irq_data);
         |                                         ~~~~^
   include/linux/irqnr.h:10:15: note: forward declaration of 'struct irq_desc'
      10 | extern struct irq_desc *irq_to_desc(unsigned int irq);
         |               ^
   kernel/kexec_core.c:1103:11: error: incomplete definition of type 'struct irq_chip'
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                     ~~~~^
   kernel/kexec_core.c:1082:10: note: forward declaration of 'struct irq_chip'
    1082 |                 struct irq_chip *chip;
         |                        ^
   kernel/kexec_core.c:1103:29: error: call to undeclared function 'irqd_irq_disabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                                           ^
   kernel/kexec_core.c:1103:29: note: did you mean 'arch_irqs_disabled'?
   arch/x86/include/asm/irqflags.h:145:28: note: 'arch_irqs_disabled' declared here
     145 | static __always_inline int arch_irqs_disabled(void)
         |                            ^
   kernel/kexec_core.c:1103:52: error: incomplete definition of type 'struct irq_desc'
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                                                              ~~~~^
   include/linux/irqnr.h:10:15: note: forward declaration of 'struct irq_desc'
      10 | extern struct irq_desc *irq_to_desc(unsigned int irq);
         |               ^
   kernel/kexec_core.c:1104:8: error: incomplete definition of type 'struct irq_chip'
    1104 |                         chip->irq_disable(&desc->irq_data);
         |                         ~~~~^
   kernel/kexec_core.c:1082:10: note: forward declaration of 'struct irq_chip'
    1082 |                 struct irq_chip *chip;
         |                        ^
   kernel/kexec_core.c:1104:27: error: incomplete definition of type 'struct irq_desc'
    1104 |                         chip->irq_disable(&desc->irq_data);
         |                                            ~~~~^
   include/linux/irqnr.h:10:15: note: forward declaration of 'struct irq_desc'
      10 | extern struct irq_desc *irq_to_desc(unsigned int irq);
         |               ^
   4 warnings and 15 errors generated.


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

