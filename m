Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F95CC021AA
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 01:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yiROOGsPFz5rwEeLJe1TLQ22RO0GluBTtR8afx3Fbck=; b=WFaujOnBBB3IPEMN9odiXeGN0V
	RY3Hir3MT5JEHu/h1t1Sy/fYMQ5EvCnDgq7fuq/Sp210wH/GEQwjOK7T9e/ABj63DbzseD1lS8XH0
	6gch6OCHAE9SKnP3RdSfyVUI6e+OOjttfZb57FiWpIAAa5K4F1wM8riJDpXr7C/ckgNOOFma9u1Mh
	YarScqzZIZCSuk27ispG3a+tQHvU0U5Og3FcdJ3WnghdipUXqrBlXEbQ46SGD4uGRh8dcGZ+rceIx
	3Fp/BPUGIF2A65zRtcyBwMyVZkL3fdZPXpVHR29ziOZeXXCUih8GhvPKNl4uBNfvaAD4+hZ8XzVMH
	sjm2fZ5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkvkE-0000000GDCi-0YeV;
	Thu, 20 Feb 2025 01:52:54 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkvTg-0000000G9Ba-3qUd
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 01:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740015349; x=1771551349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6zmoCVN+tM70IALjoYFIvZaT00kAmX8foq6e3TRZLYA=;
  b=nfOuZSCGZ2p/9c02wJoNwjdoqh946AK828T0CwFKsU/4kF2q0aFiR/LP
   dhOwnxPPNJP1ttDMBLt2d1yaSFcMTe1pLCREAY9mLREw33JyYX+A8PkxO
   CM7969kYlQU7PvGr4giRKYxRcPAVb3S9k8DuX6uq0oKFAgDtOzxGsNHHl
   HlDCRDGHleDECFjBtWsLpJUqOWiQAqlgss2pC8bgRLPqgjE09xlgasbhm
   T2BgO1soeS8azln44QRuIfSwPYLnoLKljI1cf1aJLCsvxp+JvtH6SRC9X
   DrgaKrq/4XLkpxPY5TaxyKfSBL5wvnVLHRu5rjnhhswrUDwX6gTXwYDdD
   g==;
X-CSE-ConnectionGUID: nE/kpjlbTXWcdIwg86m0aQ==
X-CSE-MsgGUID: YGSSmg+mQ0yWpOtQ+ZwuxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63256307"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63256307"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:35:45 -0800
X-CSE-ConnectionGUID: /CSaJmWzSfmHu8r7w0K3Sg==
X-CSE-MsgGUID: kf6Hjk7XR6md3lqe5LyxTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114622753"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 19 Feb 2025 17:35:41 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkvTW-0003jb-0R;
	Thu, 20 Feb 2025 01:35:38 +0000
Date: Thu, 20 Feb 2025 09:35:19 +0800
From: kernel test robot <lkp@intel.com>
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com, eric.snowberg@oracle.com,
	ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
	bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v8 5/7] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <202502200920.rOyK1770-lkp@intel.com>
References: <20250218225502.747963-6-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218225502.747963-6-chenste@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_173549_029072_AF80B8F5 
X-CRM114-Status: GOOD (  11.23  )
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

Hi steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc3 next-20250219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-define-and-call-ima_alloc_kexec_file_buf/20250219-065931
base:   linus/master
patch link:    https://lore.kernel.org/r/20250218225502.747963-6-chenste%40linux.microsoft.com
patch subject: [PATCH v8 5/7] ima: kexec: move IMA log copy from kexec load to execute
config: x86_64-buildonly-randconfig-001-20250220 (https://download.01.org/0day-ci/archive/20250220/202502200920.rOyK1770-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502200920.rOyK1770-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502200920.rOyK1770-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/kexec_file.c: In function 'kimage_file_post_load':
>> kernel/kexec_file.c:206:9: error: implicit declaration of function 'ima_kexec_post_load'; did you mean 'machine_kexec_post_load'? [-Werror=implicit-function-declaration]
     206 |         ima_kexec_post_load(image);
         |         ^~~~~~~~~~~~~~~~~~~
         |         machine_kexec_post_load
   cc1: some warnings being treated as errors


vim +206 kernel/kexec_file.c

   203	
   204	static void kimage_file_post_load(struct kimage *image)
   205	{
 > 206		ima_kexec_post_load(image);
   207	}
   208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

