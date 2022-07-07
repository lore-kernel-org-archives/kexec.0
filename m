Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EF0C43334
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 04:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOg5BPdKbkN61eqEpVIi7ja3NZyAmTU5Ihbg7y9DBOg=; b=heCmNj0XevPFQC
	KHRcADilC5f59azpVw1kgBoGH3DLzXdCk5pMsbQfU4+ZauLjTKZOH5sa0bNCpPHqgxXG9fnIHdtaC
	baljscQjniUGOqBTvIGUU6+ULvppdJLvWi2NMWHQxCheFZmpe/SQlVftBuI+45kOglV1NeYzChkyU
	RJE0TrqnEdxSFoOg/k3J/fXlZVWdYR8740g2L8z324re5qB4RSW1TKlZXUZFDpoxAmqNCU9ZlVDOj
	b/2/Tyvfwi9J3qSljlxH8g7TXEMMgiLTrgMamrp5U8opVc0KPs4s9T7z7TjV5o/eAJmLCzRjeZoJ0
	Pn2J8TIMECEVyl74eJBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9J61-00DUAa-Mw; Thu, 07 Jul 2022 04:26:33 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9J5y-00DU8z-7P
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 04:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657167990; x=1688703990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0UKCDk+QO7Jju1w2FSJQYoZZKRQ/VlNP3afiUk2ofuU=;
  b=QHIuZGp7Tih3YLkMa9UOhYp/0zhWWbxFBJF7JxQ9EBizjREpDVhpnqg5
   SAdaAwT6VUCRJmIyvTtjVDUgxeCmYb7WeXwNeH6yrH9APRloQVDzmUwCR
   pdx5yq0DAfoSyF5NyzYAPZpD6HAdo3m5QytOvX4aQ2XHT858a8bm76Cih
   ld6wsoLcqdTSlfG3sS7LGiLXl7ZSWEZ7lQtRcLKnOnvNUOVvT/+pcKeo5
   BJtiKvmdBuZWjibVeEzTxAHAhdMIPEWWdRB9/EIdCEtIwsd0Vs0fel0gD
   osoI42OyOA8/PyqS9Nr+d1p8SdRg0qi8Lbu/hzZbcpdiHSmpwxKijmTxH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="283951455"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="283951455"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 21:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="683173227"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2022 21:26:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o9J5p-000LXY-Rr;
	Thu, 07 Jul 2022 04:26:21 +0000
Date: Thu, 7 Jul 2022 12:25:53 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, mpe@ellerman.id.au,
	Stefan Berger <stefanb@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 6/6] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202207071217.lAHS2W7R-lkp@intel.com>
References: <20220706152329.665636-7-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220706152329.665636-7-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_212630_355129_9C50D4A4 
X-CRM114-Status: GOOD (  12.13  )
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

Hi Stefan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 03c765b0e3b4cb5063276b086c76f7a612856a9a]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec-ppc64/20220706-232658
base:   03c765b0e3b4cb5063276b086c76f7a612856a9a
config: s390-randconfig-r015-20220706 (https://download.01.org/0day-ci/archive/20220707/202207071217.lAHS2W7R-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/d5d97eac90ae272727cc71409e88360b7024b343
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec-ppc64/20220706-232658
        git checkout d5d97eac90ae272727cc71409e88360b7024b343
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/kexec_file.o: in function `__se_sys_kexec_file_load':
>> kexec_file.c:(.text+0xee2): undefined reference to `tpm_add_kexec_buffer'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0x1e4): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: fsl-edma.c:(.text+0x32a): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0xbe): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `ccree_probe':
   cc_driver.c:(.text+0xd4c): undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
   cc_debugfs.c:(.text+0x1b0): undefined reference to `debugfs_create_regset32'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: cc_debugfs.c:(.text+0x390): undefined reference to `debugfs_create_regset32'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
