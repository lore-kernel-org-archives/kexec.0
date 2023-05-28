Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394D2C7EE29
	for <kexec@archiver.kernel.org>; Sun, 28 May 2023 06:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gaDYZECcFonaWUB9UugtAfRPaMopmBsxks8muxogajU=; b=15SiJtobpDexmk
	kMc5sRME0b9fbt1nCE6eIWWxVJAbfNQiBNpC3KGrenNqisE/PQkDjUJDOTx6PAjk1Yo+fL0/2cOf4
	nw6cBYtWEaWpOKyEJFn0G5dET5jPx1AbEe7be7zzD2bEF3UWfGdz3Tbu9MUKY1BhiqKlx3oRnqFU+
	oQ477ABc7f9IGdpyogLZMsS+w0DTpQpE1a6iP1cB2em9lhkCCKdUbOHj2TL5QKlrxwblVK+xpfPvD
	oMl83DYZ4/JUnKUR1Y7LW6WEYD/dsudONf3EU/e7PmrJcmsLmNgnkbWawhv2cdXSFrj6q022avApL
	ubrU56YBJpMNmrqFtcFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q39rx-0071sc-2v;
	Sun, 28 May 2023 06:27:09 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q39rt-0071rK-30
	for kexec@lists.infradead.org;
	Sun, 28 May 2023 06:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685255225; x=1716791225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h1fX6J9MwHA4UhEIWnjjtlM/vEh0VODuOxy/W8XzQNw=;
  b=DkumObcKWXl5SBaQLJ+n8/p/bkxIOFo4OQxebqF8mGyCecNXRDINd6qa
   D99geRgCApK+JWO9NgEnTOu4qB1yY0Y7Ry4uUJ3lLysnpAGdfyMyazquZ
   dHhCupgDv8UWEw5slN4G1gWGV/lcBp12NBRuEhR9EGdw5v2PBnxbp1Jib
   Ahzuzgvbvs252E6IdTNHu8D3EGrNF80ml9Qbe/Yw2KYX3SQp59q0I8IOz
   VEkGQUpm25VighMz5GIbHOazWcgpgscVlLK7d8u9vB3tj3VBECrEhrtnc
   jWFQ96QqzZpXw9vDJ0/XcXWdjngMNRpxHW8ABa8yuuWd0NUP8zjMTg6Mp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="382742072"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="382742072"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 23:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="879980811"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="879980811"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2023 23:26:56 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q39rk-000KT0-0T;
	Sun, 28 May 2023 06:26:56 +0000
Date: Sun, 28 May 2023 14:26:51 +0800
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
Message-ID: <202305281410.FdGZvhsb-lkp@intel.com>
References: <20230527123439.772-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-6-thunder.leizhen@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_232706_016907_2FD3888E 
X-CRM114-Status: GOOD (  11.80  )
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
config: x86_64-randconfig-s033-20230528 (https://download.01.org/0day-ci/archive/20230528/202305281410.FdGZvhsb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/dea97cef503d26e05d0e11818ae44176056ddf64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
        git checkout dea97cef503d26e05d0e11818ae44176056ddf64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305281410.FdGZvhsb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/kexec_core.c:1108:5: sparse: sparse: symbol '__crash_shrink_memory' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
