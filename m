Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B9606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=15zT+DqZ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GFiJ47CT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ai6yw3OuibhURm/WO66vXn3DXBjDe0k2rnzBv97yR0A=; b=15zT+DqZb7Q1cQnY5qJYciVzm5
	mo9ZnpDQgebclm4uTo2LBdqwqrQ9/2qdQnBHs8sNc3uOdDpDM2j9WeZAW6S9CVv0fbXjXEW/7nPpi
	e+PgakJw+r6ocPOihwL1jyyQJZgX2WBvhgwNb984OPljlUA3+3zhg30cqi09O4UjlywjY3AXQTUTP
	oFZ7kaYQ7MEHC2aH877jwprsA0zPQyH68GXR7rC81K1/4pmySeqhF5FNnM8nyYjzL0pmH2608xyF6
	GM9aQ3xaw7TBWw/SdgYEnA0WUxOirRgbg0jyAQtcENZeF77HDGWB04SUrg9ulLEAqHCrpwpyF9ioY
	ffBZ5KWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLZMO-00000003lEt-2tbj;
	Tue, 27 Oct 2026 05:04:32 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLZMM-00000003lEG-0d4U
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 05:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793077471; x=1824613471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HAhrArfOGx4d2m+iNXRk5VLLSvyuYaHbyyD0xEP12kY=;
  b=GFiJ47CTZ2tawNhetlPvkTTR2Y/jq1Bj9VR/qitD5Yu8/5LgHZprPmNo
   3y9yk2U8yTHki6wvOtZ65gYX9If17UGwtsMltNDg3HuLrI5eNpXNAX80C
   Y/KqXVtNJ5k5ZPx3cNNtbI5XP35ry84d5pTiwtAsgYq5YP4y/fyQNnOEO
   OWH5JzSeUvGgQzRqlWGAHTl9UG5nrB3Pd3dxoqlfC9/PpaX+oHufzEMeh
   O++1y+xuwmU8hm6A87ERaLLno1ybY5VkewJX+x1Ek+nq5BAUTXADGf/nm
   duRegiE98PPwm5y2xxkmezhVYM+wKXtzWny6kdvIdqxOhCACeHy6BRmgD
   Q==;
X-CSE-ConnectionGUID: Cj9XOvAnS8yF7IjkemXsWg==
X-CSE-MsgGUID: w44FQUnBQGGlJ8gjZ42Ryg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1800155"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1800155"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 22:04:26 -0700
X-CSE-ConnectionGUID: GCpDDQhAQtuGSgdOwwRe2g==
X-CSE-MsgGUID: mzaicXv/SACWC/OGO9hrOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4843596"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Oct 2026 22:04:20 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLZM8-00000000WrA-3Kg9;
	Tue, 27 Oct 2026 05:04:16 +0000
Date: Tue, 27 Oct 2026 13:04:14 +0800
From: kernel test robot <lkp@intel.com>
To: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2 07/10] mm/shmem_luo: Retrieve tmpfs files onto a tmpfs
 mount chosen by userspace
Message-ID: <202610271253.yDB2IOkw-lkp@intel.com>
References: <20261022225035.377445-8-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022225035.377445-8-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_220430_264497_CEC983A0 
X-CRM114-Status: GOOD (  13.35  )
X-Spam-Score: -4.7 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 80cf37169daef112b6bea9ae7d9808355a045475]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Matlack/liveupdate-Pass-user-argument-to-file-preserve-and-retrieve/20261022-225026
base:   80cf37169daef112b6bea9ae7d9808355a045475
patch link:    https://lore.kernel.org/r/20261022225035.377445-8-dmatlack%40google.com
patch subject: [PATCH v2 07/10] mm/shmem_luo: Retrieve tmpfs files onto a tmpfs mount chosen by userspace
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20261027/202610271253.yDB2IOkw-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261027/202610271253.yDB2IOkw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610271253.yDB2IOkw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shmem.c:5867:6: warning: no previous prototype for function 'shmem_inode_on_internal_mount' [-Wmissing-prototypes]
    5867 | bool shmem_inode_on_internal_mount(const struct inode *inode)
         |      ^
   mm/shmem.c:5867:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    5867 | bool shmem_inode_on_internal_mount(const struct inode *inode)
         | ^
         | static 
   1 warning generated.


vim +/shmem_inode_on_internal_mount +5867 mm/shmem.c

  5862	
  5863	/*
  5864	 * Whether @inode is on the internal shmem mount, which is used by
  5865	 * shmem_file_setup() and thus by memfd_create().
  5866	 */
> 5867	bool shmem_inode_on_internal_mount(const struct inode *inode)
  5868	{
  5869		return inode->i_sb == shm_mnt->mnt_sb;
  5870	}
  5871	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

