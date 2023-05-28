Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE9CC77B7E
	for <kexec@archiver.kernel.org>; Sun, 28 May 2023 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mQ+F1K4DRJ4JRp2AtEot4rviKERFhoXsnCN0E9HSeOg=; b=QKa2k7a8viHt/D
	/D5Wf9k+tARHJiejt/AM8mO37hQ2Nx2RLXU5cBt4SvjZt/h9P5lYVl7ijxQxDi9YICItToKlnHIvt
	We4uu9o97BPHjhWzKpeJ0x2DqrUlbnER0GMwXtrlPNZMTmx4UfM6mOgXpKqfOsknOxsmfHL3Frfcp
	DPm7x3DSbgSWRBqiIVVrpP+EKJvkWUFj9+QxmJh0PexDcumUz6lhJbh3uMynfRoO8Kk31YUWew6B7
	On7uBg5XVBvNvrCONLM4Jq8rpNrY9YK599SJRCEPqNAS5nn7PpzOEwgr9XkdamO+NLvaXvL+CmC91
	roIjyodyJNhPEs1pwwBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q35Sx-006jjf-33;
	Sun, 28 May 2023 01:45:03 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q35Su-006jiQ-1m
	for kexec@lists.infradead.org;
	Sun, 28 May 2023 01:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685238300; x=1716774300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gll6v8zxfLENN56Xlc2FVXBXa2vDekhM1BJGuQkgYbQ=;
  b=WuDe3ECEtNm6mLLmBeqOjzIy9MWli8hxRIIckmRgEYDqVqJDAXr4WtdT
   N1EdknyGjzCUTiL789chQPzDs1Q3hs1nXVmHIAP4SwWK7eBOlVypmCffs
   EGgDs6jT7uDCyfDsZB6d06h6HFSVaKV0ZGLHAvwUN6z7Guj36aKs+2QWo
   1VVfcpZgEihFV31myUadMUWa/+YP0E/9UZlzmFkyQWZ2Ll7Uct0Ik2QuZ
   jMUQIj2+CY6HmhYuZ/IjBuAULu3pk9vsd75H10dhDoTbcAhvAL1PFi2Z7
   RTTxOk6QOyxVLEtboNOgZRgv23zM8WuWCQRz15QBxzcnQKXAxG8HnUsOT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="343968776"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="343968776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 18:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="736420199"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="736420199"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2023 18:44:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q35Sl-000KMu-0y;
	Sun, 28 May 2023 01:44:51 +0000
Date: Sun, 28 May 2023 09:44:10 +0800
From: kernel test robot <lkp@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Amerigo Wang <amwang@redhat.com>
Subject: Re: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
Message-ID: <202305280949.yYtbjy5B-lkp@intel.com>
References: <20230527123439.772-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-6-thunder.leizhen@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_184500_689721_1333B3A9 
X-CRM114-Status: GOOD (  13.92  )
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

Hi Zhen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230527123439.772-6-thunder.leizhen%40huawei.com
patch subject: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
config: mips-randconfig-r012-20230528 (https://download.01.org/0day-ci/archive/20230528/202305280949.yYtbjy5B-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dea97cef503d26e05d0e11818ae44176056ddf64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
        git checkout dea97cef503d26e05d0e11818ae44176056ddf64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305280949.yYtbjy5B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec_core.c:1108:5: warning: no previous prototype for '__crash_shrink_memory' [-Wmissing-prototypes]
    1108 | int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/__crash_shrink_memory +1108 kernel/kexec_core.c

  1107	
> 1108	int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
  1109	{
  1110		struct resource *ram_res;
  1111	
  1112		ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
  1113		if (!ram_res)
  1114			return -ENOMEM;
  1115	
  1116		ram_res->start = old_res->start + new_size;
  1117		ram_res->end   = old_res->end;
  1118		ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
  1119		ram_res->name  = "System RAM";
  1120	
  1121		if (!new_size) {
  1122			release_resource(old_res);
  1123			old_res->start = 0;
  1124			old_res->end   = 0;
  1125		} else {
  1126			crashk_res.end = ram_res->start - 1;
  1127		}
  1128	
  1129		crash_free_reserved_phys_range(ram_res->start, ram_res->end);
  1130		insert_resource(&iomem_resource, ram_res);
  1131	
  1132		return 0;
  1133	}
  1134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
