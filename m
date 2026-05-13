Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9EFCD4F21
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+0rsvj4XBFUxpheTwFF9OshvPBONT6mZ1jMx7PcfHlY=; b=cV235Dh9/UhSIe1ReBcwNJQASn
	qHh+EmoJgwfYgDCt4itkW7k27qX1XAe8SkSz15OynLX/MyxceGPTjtUN3be5ycc7ooppusPvYblTW
	8l7wQqxw463B983gdhMZrOfRBSMvPXeLx/GKlqGifHBZetvC5mKWCmHYXMeKMaQT3MwonhISdIDI/
	BOthgiHhkrHj+05NEdzAumVg8BfSYiBPQ1p61dDtLzpwdvUcIm7X2E54+d/sz1XagkZSlK9PCvkOu
	ziasoDeT2lyy7y9+S+L9ZYTmMnX6kPaUzWFm8MiuG0lodcAYNIOB+dmcf1TFg/Xos8Q/lrkj3ynMh
	eAxsVNIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNIg9-00000003zcC-05eR;
	Wed, 13 May 2026 23:07:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNIg8-00000003zbp-0dMr
	for kexec@bombadil.infradead.org;
	Wed, 13 May 2026 23:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+0rsvj4XBFUxpheTwFF9OshvPBONT6mZ1jMx7PcfHlY=; b=mYHwGfxnYMQBsZVDK0WCMlUf1a
	okL3Xeh6YjPPswbdE+rFlOg20nmXNl9Wv3vyJ2uiuLHA8BQmN8fS8NYIreqKKCMKZrxT5EO0ByJhZ
	sPL2wESOEO5yYRL541qUKiWxsTjZaCM2/LjkHGxhR3meXmWOoezIJJ7xvEzFJb8Cz27PmjsgfD0h7
	HFNfBajWz5MUE2/OtA6lQEe0r55IkNEV1Wbr0BY7r7CR8DfG8wRY0sy44d4BRLHPG9URPxrf2cS9/
	3WPqfniU+WbPoAfhBZG+6NvhqsdOEM1jSCGO3IhmUHS/mxDAp7A3vUARsiaoLoJVYEg2opm33qujX
	DJ7cALvQ==;
Received: from mgamail.intel.com ([192.198.163.10])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNIg4-00000001hbd-0Cn2
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 23:07:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778713664; x=1810249664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ALVwDDjok+OEdPpXRwF61S2YSUI5YuC2BZEzIYLQAj8=;
  b=aNc1iUP8muhwpilTv0upwTyYzjxgAeYMccM2oMc8drtvTtgc/Ag39O54
   5g9yFraHov+MjeIqU2JL7dct4S/Uk3glTS1ahcli1wSpmcUzIFLAKSDmN
   hjX7VfobCEs9DaC4l2aaJa6bA92byM2ac0HnCLi9+Bb06jN1JIukU8wY9
   GG3mGnea+jCR22Ky2eCyDC42G8epSL24aiwinKIf7vcXluAKgJAEGvdGZ
   vtMXQoEXg5FVhQHPqaghgM7NpEF5hhtgXNPa55IMO1DJ7MFNl2znetm/8
   8KE2x13S1dO8Q4jo+Tz0K22ZJaMzvHOVXFVubYi6x9TiuKzcPpqsMa+XP
   g==;
X-CSE-ConnectionGUID: Br1mNKyOSr+5oyoOlqKszA==
X-CSE-MsgGUID: DSZJUUseR+imbIRxtJ/cjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="91037817"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="91037817"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 16:07:41 -0700
X-CSE-ConnectionGUID: i0+kLsn+TGODubVr1B9qyw==
X-CSE-MsgGUID: 7wtMRLYHQ6Ow3/zWIrgT2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235557652"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 May 2026 16:07:40 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNIfx-000000005H1-21xG;
	Wed, 13 May 2026 23:07:37 +0000
Date: Thu, 14 May 2026 07:07:16 +0800
From: kernel test robot <lkp@intel.com>
To: hangej <hangej@amazon.com>, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dwmw2@infradead.org, kexec@lists.infradead.org, hangej@amazon.com
Subject: Re: [PATCH] pci_crash: capture PCI config space at panic time
Message-ID: <202605140714.yFl4KATZ-lkp@intel.com>
References: <20260512162402.1929687-1-hangej@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512162402.1929687-1-hangej@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_000744_949552_634BB390 
X-CRM114-Status: GOOD (  10.61  )
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

Hi hangej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hangej/pci_crash-capture-PCI-config-space-at-panic-time/20260514-000653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260512162402.1929687-1-hangej%40amazon.com
patch subject: [PATCH] pci_crash: capture PCI config space at panic time
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260514/202605140714.yFl4KATZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605140714.yFl4KATZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605140714.yFl4KATZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/pci_crash.c:74 cannot understand function prototype: 'void *pci_crash_buffer;'
>> Warning: kernel/pci_crash.c:80 cannot understand function prototype: 'size_t pci_crash_buffer_size;'
>> Warning: kernel/pci_crash.c:90 cannot understand function prototype: 'phys_addr_t pci_crash_pagemap_phys;'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

