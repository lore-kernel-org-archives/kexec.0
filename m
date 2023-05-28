Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C3DC77B73
	for <kexec@archiver.kernel.org>; Sun, 28 May 2023 00:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iWL66Y/fLlhXLFRUuGO7yANcDC5yE6OOE4TfPWZUKpY=; b=bUPSB/TXuA4uIg
	twFDvNdT4A0gzfdHcrxunPPstgXOYNVhK8PDqUKJ3ToQL8mler3f6KMh8jRudRrZRRYsy/JUXxmtu
	iDcThriolFDxf+2ahic6Ax9s0BSGtXiGxf27T4Wqm2MiO1fV6nmXTlJi0dhw/wcDYOhybbKy0MxjE
	YuMnCnkXKdcN+PVJHNlhGyrlNXEIqdfRVvVUl6mAygvGNbdezNoVKrQDVipgUcZIVuX5i0sUCDx+8
	uqJUUXCz4pTT8ogIAyca+C2Gr8LcXFIU0P7e45paNUxHdMcLAeBroO/hWu7Bz9UXahI1MplIW8rk9
	oRQCISNg6bKCT5yIrnTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q33yd-006ZcW-0Z;
	Sun, 28 May 2023 00:09:39 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q33yZ-006Zbx-0q
	for kexec@lists.infradead.org;
	Sun, 28 May 2023 00:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685232575; x=1716768575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a9gIudvxnsEuKt6ByRRnLGP+BwC0R1njnXJ4h3gya0I=;
  b=NSyuE1hT8GfUpvWMLK6z1w30JGA/iA/mxCjRtFzY3QfSq7uvyplfj41I
   ldQGP9ahV8CHKhn+mJhjCco59C38AB6L/dY9HBEEE1t9r+Xn+3R7/7K9A
   iVBVcZWjLRV9fNvXj7lgD66aXBJYM7DjvqjcbsmaZTgz1m3/+j5d86yCe
   O2/5K201gvF/8siXObHAf00V1+Ue2heq1lnU1a0xnAb0OMGoBL6NuGGFI
   dCoF+yDOLgiNSN7JqupMUiahBoAGziEQ3bTqbNYT4by2OtgneDt42tHHk
   i3qugzantRcA0KCJiXCpxcGFI0LK0SfyJRQiabyB1GCQIyY4I5QGazA2V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="334815484"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="334815484"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 17:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="849932954"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="849932954"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2023 17:09:29 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q33yS-000KGk-2t;
	Sun, 28 May 2023 00:09:28 +0000
Date: Sun, 28 May 2023 08:08:51 +0800
From: kernel test robot <lkp@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Amerigo Wang <amwang@redhat.com>
Subject: Re: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
Message-ID: <202305280717.Pw06aLkz-lkp@intel.com>
References: <20230527123439.772-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-6-thunder.leizhen@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_170935_363597_047ED38D 
X-CRM114-Status: GOOD (  14.78  )
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
config: riscv-randconfig-r042-20230526 (https://download.01.org/0day-ci/archive/20230528/202305280717.Pw06aLkz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/dea97cef503d26e05d0e11818ae44176056ddf64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
        git checkout dea97cef503d26e05d0e11818ae44176056ddf64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305280717.Pw06aLkz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec_core.c:1108:5: warning: no previous prototype for function '__crash_shrink_memory' [-Wmissing-prototypes]
   int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
       ^
   kernel/kexec_core.c:1108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
   ^
   static 
   1 warning generated.


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
