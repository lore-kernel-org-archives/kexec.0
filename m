Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25D4C4706C
	for <kexec@archiver.kernel.org>; Sat, 13 Jan 2024 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ATDMyyB0Wgkz0Llt8lxvSKGq+tb5AQNv4pYkQE4G/pM=; b=1sCdSr1JpVY6da
	a+9UxCXKMLDdu6sKcZDDkA5cwOmHrUTW8kCDyUkho3ZuMWR/LPmSTVEIAq//Sef+lkkQpYuHN16+m
	waYXX4AalNa5UzeeMvMVyN1UAFBqsof1HMGesYqSe34MevHZnIomz/y6pag0/t3UZAtUfpAUzXWyX
	wzMAqfvuLvCWG82GnzQ34IIONuak/ZSjqqXuJGO6OIYy3GZJNh1ptXQdBBaKlsfl5WoJyyKDKrzO0
	OWe9In/K07tF9grP48OR1Qhd9DnnNt4ySQ6kmdc9LB46LsZ1ZforR4RJA0krXER87un5V3932Cg4O
	0GDnE97fhyJ4RSJZyAYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOlnP-005kae-3C;
	Sat, 13 Jan 2024 21:44:03 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOlnM-005kZb-0l
	for kexec@lists.infradead.org;
	Sat, 13 Jan 2024 21:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705182240; x=1736718240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bBcS14m9y6v0leXUixwYnMiFcxzv1qlwb01Nb1b8Cq0=;
  b=b1pHCASFvMrp+zt5vfau7K8h/r07jpzytjM+xeAz9VlbQbXBdU0DVuWW
   UHQPChHSTBzvx+vCw5loVQyUFD47hGBVuzQaJtNUw42qN6ZOxv0Rln1mL
   4VwVEQDgK+lOPvdmM/Kd835t6xdk4H0aCJIvYeMLX9kxX6ty2DWzONXmR
   7pQ3egOHfglBRy84Hlbj81U49oHWrXb8DSRxBKlN1fDFrSzr1mq6Qwalo
   8acgcFZNFSAmoGf1RDTpqUYbT6ElcQu2HMBEivl3vzKfm7dkP6oOkNsvg
   enskiZgJUyGX1TdTgp36pCun036DEdFhQAqe6JzDNQY9aZNNffud2eqNZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="485575129"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="485575129"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 13:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="783404768"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="783404768"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2024 13:43:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOlnB-000Avo-0b;
	Sat, 13 Jan 2024 21:43:49 +0000
Date: Sun, 14 Jan 2024 05:43:09 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
Message-ID: <202401140506.JQu60mgM-lkp@intel.com>
References: <20240110071522.1308935-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240110071522.1308935-3-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240113_134400_349955_8BBBFBE6 
X-CRM114-Status: GOOD (  11.75  )
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

Hi Coiby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on v6.7]
[cannot apply to linus/master next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240110-151859
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240110071522.1308935-3-coxu%40redhat.com
patch subject: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
config: x86_64-randconfig-123-20240114 (https://download.01.org/0day-ci/archive/20240114/202401140506.JQu60mgM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401140506.JQu60mgM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140506.JQu60mgM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/crash_dump_dm_crypt.c:8:6: sparse: sparse: symbol 'wipe_dm_crypt_key' was not declared. Should it be static?
   kernel/crash_dump_dm_crypt.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/wipe_dm_crypt_key +8 kernel/crash_dump_dm_crypt.c

     7	
   > 8	void wipe_dm_crypt_key(void)
     9	{
    10		if (dm_crypt_key) {
    11			memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
    12			kfree(dm_crypt_key);
    13			dm_crypt_key = NULL;
    14		}
    15	}
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
