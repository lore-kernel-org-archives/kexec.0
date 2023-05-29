Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BA3C7EE23
	for <kexec@archiver.kernel.org>; Mon, 29 May 2023 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=m6PwSbQChScDaLDNlYv2nNzsxtC0tPkXr8FT7W5R+Mc=; b=LN6eCxQtB4mrwCveTL+MYZrj8r
	iuU4if1GaX2dgnAnK7AyDCS5BKyEC4b5UKUJ/l8re58fWhtUxxiDJ0Gmn7p1WPeJVKMphB1v3XUpY
	67kuvUEj7lkhty9mJNIK720cp/l3i1F5aIWqkfQEiLXYbhztA9QBtUeWi95rOv4jw4qNGu3S6Tjve
	a+YKVP0mmoTXgFYo/rke/yEavV/kZdtfbcZdPp+3YxGY2OSdaR0zy54MyuvVJa2CjZwb9USu3wUhf
	l49nXdpBCFppdDYFL6AmgDRAmsKz/bmVAqj2OoVyMsOdDcS4C9vKpg49NWsQ3uR7ua25eneC/bpDQ
	+IJpcdcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3QtP-008k89-29;
	Mon, 29 May 2023 00:37:47 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3QtK-008k6P-2G
	for kexec@lists.infradead.org;
	Mon, 29 May 2023 00:37:44 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QTxM44DJyz18Lc8;
	Mon, 29 May 2023 08:32:48 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 08:37:23 +0800
Subject: Re: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
To: kernel test robot <lkp@intel.com>, Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, Michael Holzheu
	<holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Amerigo Wang
	<amwang@redhat.com>
References: <20230527123439.772-6-thunder.leizhen@huawei.com>
 <202305280717.Pw06aLkz-lkp@intel.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <acf92c83-ca7b-0931-505f-9b8735be18f6@huawei.com>
Date: Mon, 29 May 2023 08:37:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202305280717.Pw06aLkz-lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230528_173743_081693_610BE541 
X-CRM114-Status: GOOD (  18.52  )
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



On 2023/5/28 8:08, kernel test robot wrote:
> Hi Zhen,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.4-rc3 next-20230525]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230527123439.772-6-thunder.leizhen%40huawei.com
> patch subject: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
> config: riscv-randconfig-r042-20230526 (https://download.01.org/0day-ci/archive/20230528/202305280717.Pw06aLkz-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
> reproduce (this is a W=1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/dea97cef503d26e05d0e11818ae44176056ddf64
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
>         git checkout dea97cef503d26e05d0e11818ae44176056ddf64
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305280717.Pw06aLkz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> kernel/kexec_core.c:1108:5: warning: no previous prototype for function '__crash_shrink_memory' [-Wmissing-prototypes]
>    int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
>        ^
>    kernel/kexec_core.c:1108:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
>    ^
>    static 
>    1 warning generated.

Yes, thanks, a 'static' should be added.

> 
> 
> vim +/__crash_shrink_memory +1108 kernel/kexec_core.c
> 
>   1107	
>> 1108	int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
>   1109	{
>   1110		struct resource *ram_res;
>   1111	
>   1112		ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
>   1113		if (!ram_res)
>   1114			return -ENOMEM;
>   1115	
>   1116		ram_res->start = old_res->start + new_size;
>   1117		ram_res->end   = old_res->end;
>   1118		ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>   1119		ram_res->name  = "System RAM";
>   1120	
>   1121		if (!new_size) {
>   1122			release_resource(old_res);
>   1123			old_res->start = 0;
>   1124			old_res->end   = 0;
>   1125		} else {
>   1126			crashk_res.end = ram_res->start - 1;
>   1127		}
>   1128	
>   1129		crash_free_reserved_phys_range(ram_res->start, ram_res->end);
>   1130		insert_resource(&iomem_resource, ram_res);
>   1131	
>   1132		return 0;
>   1133	}
>   1134	
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
