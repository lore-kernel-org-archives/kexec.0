Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B74D70E16
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 04:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WwLFk5CqyIuUQmMOH/w1oY/zTQnSk8WmSXQVFZhD9LQ=; b=ywcJvy7Ob5/TVnR2LBQ0+WJcLy
	vdI5PXH3rMYOFXsR8pdmUdBXwE1f5pCNf/T8S1iLNGb3VfAaCMQQTQqekhZAq2e0D4/h5/3M4q74h
	PNDwCsX4N0Z4LY3DinlzKtANC8mDYCXTPhs8MH1a9hDhAGUHWtny5hGocLPe21UV8FmJ6sDt6MP54
	c9ux/l88uGKzz3Y9nWCuODcdRmHLbnjqfWnSZuloUHhnscLoGCGV6sFy9RgmSncvvT8V9uz7DBTEM
	sajrFas+l2QaGBF+p/YmS5Zux3+W5rdL0P+Wc0ltYZxSBx9aZs6UDrpQfm0SI6uy/+G9r9yI/Fsie
	QmKHNSAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGsrd-0000000Gsl2-3adq;
	Fri, 29 Nov 2024 04:44:21 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGsqd-0000000Gseb-124H;
	Fri, 29 Nov 2024 04:43:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732855400; x=1764391400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9j9UtBCv2PeFtRp7xh7w5s2/nPgIOCo2sIEPHBxiREU=;
  b=MIbmk71rauHLnz8nC26DdOTYMG88pQfGXKseIvYS8+ot9oOFm4YMjEEp
   uOv+6Gon+NjF3L6iTJN88O6pCgSoFh5cuHvVe1qNHF506NcQjZEgt+e+2
   DT8WBm2pqNwDWPFNy4liIpC/2h7guRyQ2mf/wfL8VM7kSfWLR+IUIp/qr
   fXmlTk27DtK095gXxJPr2kMXEjn2Eyem+45ZrdwLhvxxY0r1LNzEf0SfO
   K5Hn4qq+lY+43aBahF0H4kQNTWZUxqa6050g5Q6cvmk57D29gXbargRKT
   vWauZnAxN99UGCDvpENYwwYGexLlEA/tO9pGx1iBXNsQ0hwpa6vWHlrkt
   Q==;
X-CSE-ConnectionGUID: sPmoZgW3ROWmw3lsefdnQA==
X-CSE-MsgGUID: Hb3WcTfuR1SjmAg6Zr1QTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="44460425"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="44460425"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:43:18 -0800
X-CSE-ConnectionGUID: Jp79vHlZQie9htAmyJEFWA==
X-CSE-MsgGUID: L0PTf+eMTSqbkmvDig1DjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92710199"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Nov 2024 20:43:11 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGsqT-000ALf-0C;
	Fri, 29 Nov 2024 04:43:09 +0000
Date: Fri, 29 Nov 2024 12:42:13 +0800
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
Subject: Re: [PATCH v3 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
Message-ID: <202411291251.RwA1dKZL-lkp@intel.com>
References: <20241128201027.10396-3-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128201027.10396-3-farbere@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_204319_549897_55C29F9F 
X-CRM114-Status: GOOD (  13.33  )
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
patch link:    https://lore.kernel.org/r/20241128201027.10396-3-farbere%40amazon.com
patch subject: [PATCH v3 2/2] kexec: Prevent redundant IRQ masking by checking state before shutdown
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20241129/202411291251.RwA1dKZL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411291251.RwA1dKZL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291251.RwA1dKZL-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/kexec_core.c: In function 'machine_kexec_mask_interrupts':
   kernel/kexec_core.c:1085:24: error: implicit declaration of function 'irq_desc_get_chip' [-Werror=implicit-function-declaration]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                        ^~~~~~~~~~~~~~~~~
   kernel/kexec_core.c:1085:22: warning: assignment to 'struct irq_chip *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                      ^
>> kernel/kexec_core.c:1086:31: error: implicit declaration of function 'irqd_is_started' [-Werror=implicit-function-declaration]
    1086 |                 if (!chip || !irqd_is_started(&desc->irq_data))
         |                               ^~~~~~~~~~~~~~~
   kernel/kexec_core.c:1086:52: error: invalid use of undefined type 'struct irq_desc'
    1086 |                 if (!chip || !irqd_is_started(&desc->irq_data))
         |                                                    ^~
   kernel/kexec_core.c:1097:38: error: invalid use of undefined type 'struct irq_chip'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                      ^~
   kernel/kexec_core.c:1097:51: error: implicit declaration of function 'irqd_irq_inprogress' [-Werror=implicit-function-declaration]
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                   ^~~~~~~~~~~~~~~~~~~
   kernel/kexec_core.c:1097:76: error: invalid use of undefined type 'struct irq_desc'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                                            ^~
   kernel/kexec_core.c:1098:29: error: invalid use of undefined type 'struct irq_chip'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1098:44: error: invalid use of undefined type 'struct irq_desc'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                                            ^~
>> kernel/kexec_core.c:1100:17: error: implicit declaration of function 'irq_shutdown'; did you mean 'timer_shutdown'? [-Werror=implicit-function-declaration]
    1100 |                 irq_shutdown(desc);
         |                 ^~~~~~~~~~~~
         |                 timer_shutdown
   cc1: some warnings being treated as errors


vim +/irqd_is_started +1086 kernel/kexec_core.c

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
  1085			chip = irq_desc_get_chip(desc);
> 1086			if (!chip || !irqd_is_started(&desc->irq_data))
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
  1097			if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
  1098				chip->irq_eoi(&desc->irq_data);
  1099	
> 1100			irq_shutdown(desc);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

