Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A20DC77B78
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 19:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cyh19pj/4m2ExKa7EauYAiNPXwVUPAm4AtAXxC+6X0M=; b=O7AXDhqox4E525
	z4YUmumtx/J9CObFjn28hB9DDh6W9G7J2mQU+ARA5j55wUTHVa/bmzuzmpgkLEWwFZH++CF/HZIo4
	DW7I6izBnjM1TadpBI7iGAsMjRFYhpVfy0+ZjR0Yq0BCAx8rQrLyn0AZ2PCwiHN4Vcc9bwD/NiThh
	QkgCwO9m8hw4s0OBDjMavOgYGHWnvfwHaAVSacAIG8hcgSZvNpwDe+nxJZ2emdduZRdnnb/+1K9lC
	d93vVWZN7naKc0HlXTsQGgWCplPFeR0uwmY3btipnZHjzTUhlCK+TE+d70DXaLJ14dJ51bNDFlfTJ
	6i49ti9ehfxUHXX7CD6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poqlO-0039z5-1f;
	Tue, 18 Apr 2023 19:13:14 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poqlL-0039xw-1V
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 19:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681845191; x=1713381191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hi5rDPKAiKO3dkrZvNzmcu1W3or/62oMJmUKhJ71JxI=;
  b=Djtj3HN3k8nw54V8RcVTmnntcbYPAorOoCcQd5rEKSiP/xywiGa9axh3
   2gjRUEbUh59lhQvvf8sXq621U53atEdoCZIBFK/7y9Ae6VYqDqhVttzdl
   pPlWAZqDz72DNsTILR4mSd+jFFAipLFymak/Q+d+CNi0XOdMplz49QtZg
   Cl0hj/nw4Hz9+Lw8qHXYs4g37IhtC2nIgizekddKL40itBpHxW0kn43Vp
   2mYHd/OJgftdEwR6fly5P3L3TRwr96QHXxbbpNeKB2LdcsHklzMEpgyRF
   FCzvhgSyB59Sj51CTypQOvuR9hqqogx6fDrdjzkIbHOF43AZTX+Ndt3C4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325599461"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="325599461"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="641481107"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="641481107"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2023 12:13:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1poqlD-000dwL-1q;
	Tue, 18 Apr 2023 19:13:03 +0000
Date: Wed, 19 Apr 2023 03:12:35 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
	Stefan Berger <stefanb@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v9 4/4] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202304190215.d0zwo1ni-lkp@intel.com>
References: <20230418134409.177485-5-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-5-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_121311_517118_AC2F7BC6 
X-CRM114-Status: GOOD (  12.25  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6a8f57ae2eb07ab39a6f0ccad60c760743051026]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/drivers-of-kexec-ima-Support-32-bit-platforms/20230418-214600
base:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
patch link:    https://lore.kernel.org/r/20230418134409.177485-5-stefanb%40linux.ibm.com
patch subject: [PATCH v9 4/4] tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
config: x86_64-randconfig-a013-20230417 (https://download.01.org/0day-ci/archive/20230419/202304190215.d0zwo1ni-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/16a833d47b9aca53a1b099dea4066b76b7f14ee1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/drivers-of-kexec-ima-Support-32-bit-platforms/20230418-214600
        git checkout 16a833d47b9aca53a1b099dea4066b76b7f14ee1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mailbox/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190215.d0zwo1ni-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mailbox/mailbox.c:18:
   In file included from include/linux/mailbox_client.h:10:
>> include/linux/of.h:1664:48: warning: declaration of 'struct kimage' will not be visible outside of this function [-Wvisibility]
   static inline void tpm_add_kexec_buffer(struct kimage *image) { }
                                                  ^
   1 warning generated.


vim +1664 include/linux/of.h

  1660	
  1661	#if defined(CONFIG_KEXEC_FILE) && defined(CONFIG_OF_FLATTREE)
  1662	void tpm_add_kexec_buffer(struct kimage *image);
  1663	#else
> 1664	static inline void tpm_add_kexec_buffer(struct kimage *image) { }
  1665	#endif
  1666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
