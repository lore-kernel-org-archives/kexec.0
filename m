Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC82C4707B
	for <kexec@archiver.kernel.org>; Sat, 13 Jan 2024 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k7zfngZW6e8sk3CO8kOIwMMwgmsTku4LvBt3Dt652qA=; b=JidqOfOUZd9y6D
	fXohe1lEpYe9WEJB7NDves2LORVSOBiavK7YVEWn4L/QCkWLktoEO6u4EPm53ZAABK6hVI7DvVi2c
	YyWZjidFiph4GFszWF9V6cLeUIqyLokyaYbqTkMQkWVpWysC0lX1KaaCzC4UIZWjFO9in8kCXyTKU
	5+SrlkKerqFU5PgQZq00gSIku8Fos75y/ppCtfiTMcrElzfJYMXD9RkjVfvlZY2Sn4KkG8S352Q9m
	J9zfNr/+Pf1IvLzI8GDaVAN/X1KHj5o0NKclNFvvD4f1kP1iorC2p0dM4NMrAg9DDrJ/MVA2h0Kl0
	NMmVmD5oTRqmd3h3tY0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOiAL-005TiW-1P;
	Sat, 13 Jan 2024 17:51:29 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOiAI-005ThH-1y
	for kexec@lists.infradead.org;
	Sat, 13 Jan 2024 17:51:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705168287; x=1736704287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6tMMVf1LXjFd2vcj/Sqweewo/s0ZpYMPQ6RCumJW+jY=;
  b=BWfMqqefnCm5bhTOpf0qGnhSZt7e5bUSynmcZnMuaPh2YcyN7QIPt9Em
   gQ54WPerKdb1CROo8Nt6UzgpVvY5w2fj7QkNxf0uC5RUcgCN+XnFZGkQc
   QkMbVEfFJEAPkFcJ4m7MrEBa8eNj2xvfGWTQqnHdiJ9grxAgiLyQyI4oL
   UJ0/7U2mNtekcnDTN21U8ysffDV5ZWDx2TPVZNbrP8MdMjq3gv3hgPNPG
   lKXVNlrifaURfVLjvFsguC4fVZIKJ0KTP4oAYPou6Nr3ODGoBq1pHrQVW
   HCuzG45BbSo5xJ3CU7ttiLsIfe7M0iFdcOVUfZSHfuVCZkqB8wsclETxg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="6760134"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="6760134"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 09:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="25342449"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 13 Jan 2024 09:51:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOiA2-000Am0-2l;
	Sat, 13 Jan 2024 17:51:10 +0000
Date: Sun, 14 Jan 2024 01:50:23 +0800
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
Message-ID: <202401140128.MBysmTaN-lkp@intel.com>
References: <20240110071522.1308935-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240110071522.1308935-3-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240113_095126_694675_19B6AD51 
X-CRM114-Status: GOOD (  10.54  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on v6.7]
[cannot apply to linus/master next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240110-151859
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240110071522.1308935-3-coxu%40redhat.com
patch subject: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
config: i386-buildonly-randconfig-002-20240113 (https://download.01.org/0day-ci/archive/20240114/202401140128.MBysmTaN-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401140128.MBysmTaN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140128.MBysmTaN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/ksysfs.o: in function `crash_dm_crypt_key_store':
>> ksysfs.c:(.text+0x2d0): undefined reference to `crash_sysfs_dm_crypt_key_write'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
