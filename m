Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30BFC48BF6
	for <kexec@archiver.kernel.org>; Thu,  7 Mar 2024 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lCQ4ANvKVLyvJGn11rXjyRV6Znw/StUFObWfdV8BK+o=; b=XTfNgqqqeW86dq
	MmBQuIhWniL7P++MxGk9j2eqr929N5X/VruYgM6pVhvplV46ji0DRJc4kFhLSmFsOnbupAGRPOghm
	A/4G2z1QWqsVL76gTdx3Ka2Q2JkD9x4cfnDL9ZU/jlFLWKeWUP4BIHxw4ogJV8w/HrDg9K9FhU/u8
	2NQwY7PASOUTEUZj3n8duG/zXMihjSTE0CbJJW3ejbQ14F4n25yPrODyhaDZfqxUQ2RK5Xb5+4QHs
	iqh2ejmNj6r6dXblB2Wp0tpcIMw0DlX4FzXqCzpzf5kz2lnvCOPp1PxH9Kyl1QwRV4jZiIHhkq+gl
	F8LXpc6gLIFBAEuM17sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8oK-00000003YZB-1qXE;
	Thu, 07 Mar 2024 08:09:04 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8oG-00000003YYo-3xTR
	for kexec@lists.infradead.org;
	Thu, 07 Mar 2024 08:09:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709798941; x=1741334941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HVF1QL6dIrEmmMOhlW6bZs0Fosep5KDcBrH9OkjV5KQ=;
  b=S5ZRKskJEhSWZkBj3/xOcYb+TYsgpzoITNyOvQNtE6etlUneMGbqIfzQ
   93nRqTRlWMWQhBlqmZtgxzglapVkW/lY5TdvKJ0ufpY+J3xyAmB9eQIkW
   uc3xbN3iwYBQSmK+0zaSP4IGWUmc+y7tIB+WyNyytWq506pd3av5ZEzgG
   hSxYRzPGQqib6AYZIGWt+RULIJHJyKSrsfJFUT4E2PtVM8FEDXUWl82d4
   0pg3Vjvjc+XUj+xmF7E4jH0D6ceKyYdd2pZ84TSQaLaySovmf2m/IWeur
   DMd2PVi32A4Xl+g4gxgrMAMr21IunHCCzaLGFn4WJg+TJslrD0vPTREoz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15863036"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="15863036"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:07:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="41012691"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Mar 2024 00:07:50 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ri8n5-0004yj-2O;
	Thu, 07 Mar 2024 08:07:47 +0000
Date: Thu, 7 Mar 2024 16:07:09 +0800
From: kernel test robot <lkp@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, x86@kernel.org, kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 3/7] nvdimm: pmem: assign a parent resource for
 vmemmap region for the fsdax
Message-ID: <202403071558.83GY9NwT-lkp@intel.com>
References: <20240306102846.1020868-4-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240306102846.1020868-4-lizhijian@fujitsu.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_000901_039503_1A38D464 
X-CRM114-Status: GOOD (  16.75  )
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

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on nvdimm/libnvdimm-for-next]
[also build test ERROR on tip/x86/core linus/master v6.8-rc7]
[cannot apply to akpm-mm/mm-everything nvdimm/dax-misc next-20240306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhijian/mm-memremap-register-unregister-altmap-region-to-a-separate-resource/20240306-183118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
patch link:    https://lore.kernel.org/r/20240306102846.1020868-4-lizhijian%40fujitsu.com
patch subject: [PATCH v3 3/7] nvdimm: pmem: assign a parent resource for vmemmap region for the fsdax
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240307/202403071558.83GY9NwT-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 325f51237252e6dab8e4e1ea1fa7acbb4faee1cd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240307/202403071558.83GY9NwT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403071558.83GY9NwT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/nvdimm/pmem.c:10:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/nvdimm/pmem.c:501:2: error: call to undeclared function 'pgmap_parent_resource'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     501 |         pgmap_parent_resource(&pmem->pgmap, parent);
         |         ^
   1 warning and 1 error generated.


vim +/pgmap_parent_resource +501 drivers/nvdimm/pmem.c

   448	
   449	static int pmem_attach_disk(struct device *dev,
   450			struct nd_namespace_common *ndns)
   451	{
   452		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
   453		struct nd_region *nd_region = to_nd_region(dev->parent);
   454		int nid = dev_to_node(dev), fua;
   455		struct resource *res = &nsio->res, *parent;
   456		struct range bb_range;
   457		struct nd_pfn *nd_pfn = NULL;
   458		struct dax_device *dax_dev;
   459		struct nd_pfn_sb *pfn_sb;
   460		struct pmem_device *pmem;
   461		struct request_queue *q;
   462		struct gendisk *disk;
   463		void *addr;
   464		int rc;
   465	
   466		pmem = devm_kzalloc(dev, sizeof(*pmem), GFP_KERNEL);
   467		if (!pmem)
   468			return -ENOMEM;
   469	
   470		rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
   471		if (rc)
   472			return rc;
   473	
   474		/* while nsio_rw_bytes is active, parse a pfn info block if present */
   475		if (is_nd_pfn(dev)) {
   476			nd_pfn = to_nd_pfn(dev);
   477			rc = nvdimm_setup_pfn(nd_pfn, &pmem->pgmap);
   478			if (rc)
   479				return rc;
   480		}
   481	
   482		/* we're attaching a block device, disable raw namespace access */
   483		devm_namespace_disable(dev, ndns);
   484	
   485		dev_set_drvdata(dev, pmem);
   486		pmem->phys_addr = res->start;
   487		pmem->size = resource_size(res);
   488		fua = nvdimm_has_flush(nd_region);
   489		if (!IS_ENABLED(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) || fua < 0) {
   490			dev_warn(dev, "unable to guarantee persistence of writes\n");
   491			fua = 0;
   492		}
   493	
   494		parent = devm_request_mem_region(dev, res->start, resource_size(res),
   495					dev_name(&ndns->dev));
   496		if (!res) {
   497			dev_warn(dev, "could not reserve region %pR\n", res);
   498			return -EBUSY;
   499		}
   500	
 > 501		pgmap_parent_resource(&pmem->pgmap, parent);
   502	
   503		disk = blk_alloc_disk(nid);
   504		if (!disk)
   505			return -ENOMEM;
   506		q = disk->queue;
   507	
   508		pmem->disk = disk;
   509		pmem->pgmap.owner = pmem;
   510		pmem->pfn_flags = PFN_DEV;
   511		if (is_nd_pfn(dev)) {
   512			pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
   513			pmem->pgmap.ops = &fsdax_pagemap_ops;
   514			addr = devm_memremap_pages(dev, &pmem->pgmap);
   515			pfn_sb = nd_pfn->pfn_sb;
   516			pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
   517			pmem->pfn_pad = resource_size(res) -
   518				range_len(&pmem->pgmap.range);
   519			pmem->pfn_flags |= PFN_MAP;
   520			bb_range = pmem->pgmap.range;
   521			bb_range.start += pmem->data_offset;
   522		} else if (pmem_should_map_pages(dev)) {
   523			pmem->pgmap.range.start = res->start;
   524			pmem->pgmap.range.end = res->end;
   525			pmem->pgmap.nr_range = 1;
   526			pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
   527			pmem->pgmap.ops = &fsdax_pagemap_ops;
   528			addr = devm_memremap_pages(dev, &pmem->pgmap);
   529			pmem->pfn_flags |= PFN_MAP;
   530			bb_range = pmem->pgmap.range;
   531		} else {
   532			addr = devm_memremap(dev, pmem->phys_addr,
   533					pmem->size, ARCH_MEMREMAP_PMEM);
   534			bb_range.start =  res->start;
   535			bb_range.end = res->end;
   536		}
   537	
   538		if (IS_ERR(addr)) {
   539			rc = PTR_ERR(addr);
   540			goto out;
   541		}
   542		pmem->virt_addr = addr;
   543	
   544		blk_queue_write_cache(q, true, fua);
   545		blk_queue_physical_block_size(q, PAGE_SIZE);
   546		blk_queue_logical_block_size(q, pmem_sector_size(ndns));
   547		blk_queue_max_hw_sectors(q, UINT_MAX);
   548		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
   549		blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, q);
   550		if (pmem->pfn_flags & PFN_MAP)
   551			blk_queue_flag_set(QUEUE_FLAG_DAX, q);
   552	
   553		disk->fops		= &pmem_fops;
   554		disk->private_data	= pmem;
   555		nvdimm_namespace_disk_name(ndns, disk->disk_name);
   556		set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
   557				/ 512);
   558		if (devm_init_badblocks(dev, &pmem->bb))
   559			return -ENOMEM;
   560		nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
   561		disk->bb = &pmem->bb;
   562	
   563		dax_dev = alloc_dax(pmem, &pmem_dax_ops);
   564		if (IS_ERR(dax_dev)) {
   565			rc = PTR_ERR(dax_dev);
   566			goto out;
   567		}
   568		set_dax_nocache(dax_dev);
   569		set_dax_nomc(dax_dev);
   570		if (is_nvdimm_sync(nd_region))
   571			set_dax_synchronous(dax_dev);
   572		rc = dax_add_host(dax_dev, disk);
   573		if (rc)
   574			goto out_cleanup_dax;
   575		dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
   576		pmem->dax_dev = dax_dev;
   577	
   578		rc = device_add_disk(dev, disk, pmem_attribute_groups);
   579		if (rc)
   580			goto out_remove_host;
   581		if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
   582			return -ENOMEM;
   583	
   584		nvdimm_check_and_set_ro(disk);
   585	
   586		pmem->bb_state = sysfs_get_dirent(disk_to_dev(disk)->kobj.sd,
   587						  "badblocks");
   588		if (!pmem->bb_state)
   589			dev_warn(dev, "'badblocks' notification disabled\n");
   590		return 0;
   591	
   592	out_remove_host:
   593		dax_remove_host(pmem->disk);
   594	out_cleanup_dax:
   595		kill_dax(pmem->dax_dev);
   596		put_dax(pmem->dax_dev);
   597	out:
   598		put_disk(pmem->disk);
   599		return rc;
   600	}
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
