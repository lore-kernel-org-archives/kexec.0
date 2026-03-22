Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E9FC72AF
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 07:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fl6Vo0CZ6glcVLyy4yu619dgSiIfKOAp/m+BURB5CJU=; b=sDWpj0l0bI1+5Ie2W271zBVdhH
	UW6PANUPPfrXe9Zm+MoekiP9pRHQn1VxJK33sGUNCXSaV+WPLOJc/sv0hb++i82agEYjbDPOWeSqP
	Y3nHjXhKjw6ftV/n7GVqjxd6S0+cgjRE37RfHOsJVAY2ILE9IaNLQZG6pgHLT1qM11pfWrmxj2axQ
	yDqC2EvGHt9P3PjOwovg97f7FSXo3BqGOcM0MhrcTnDBhlOoPaFii6JrMeQwh/NayUtNlGG6OvARb
	Mb7pQdjKbqjBIkvq+eijbwcx4DCr+0K0uCEhca5EomIappXFwW7m4OsmeJq6VUFjih8hgJtdyebS4
	ZsL/oPDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4DQq-0000000FA7s-3Pt7;
	Sun, 22 Mar 2026 07:41:08 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4DQm-0000000FA77-1nVj
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 07:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774165264; x=1805701264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bb4QyRenZ7daQTIah7HNDKj8CLKXNag8jCu6QnIEdBg=;
  b=O49xhhTxl069ZoyKC/pqyAK3iWIlFrdw4IHU5r65bTuCIrKGPEcFed3G
   dT6Kwb0Rka9dOMKE8fC8tM6xOZyK1xfk2kQU8e1GYUIUaFS8QPu50U9bM
   7xs9uBhDCRg1UngXXz/xFeQCxgVW7r7MTU+YomHC9YpjpyBwUHyM7O/gx
   D6/dCFkX7udEZrLZC61WAb+mQ2KnSZTY7XzDo2TjfUP3i4wFemr1oNeZn
   qkTkw46p4+THHKs20s622rcODn2lWfqs/R2K8T1vQXyhYhrbopuQfm+iM
   b/BbkBpQSOYgHYYx1j05Rz4Jy314+kzdY20HvGsXJMjvAiyWlKkQMe3H8
   A==;
X-CSE-ConnectionGUID: bgQwl+SxROaZREr7fqk6Mg==
X-CSE-MsgGUID: skRqiJQcT6e9a5FoFRZ8ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="74218071"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="74218071"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 00:41:02 -0700
X-CSE-ConnectionGUID: aubtGZfvTP64cXi8tj3R7Q==
X-CSE-MsgGUID: iuwTwHhqRGKMtknP2CxQOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="223749971"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 22 Mar 2026 00:40:59 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4DQb-000000001pJ-1PUq;
	Sun, 22 Mar 2026 07:40:55 +0000
Date: Sun, 22 Mar 2026 15:40:06 +0800
From: kernel test robot <lkp@intel.com>
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Subject: Re: [PATCH 1/5] liveupdate: block outgoing session updates during
 reboot
Message-ID: <202603221537.TfoAS2LD-lkp@intel.com>
References: <20260320163720.100456-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320163720.100456-1-oskar@gerlicz.space>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_004104_481639_4C911922 
X-CRM114-Status: GOOD (  11.40  )
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

Hi Oskar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc4 next-20260320]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oskar-Gerlicz-Kowalczuk/kexec-abort-liveupdate-handover-on-kernel_kexec-unwind/20260322-071016
base:   linus/master
patch link:    https://lore.kernel.org/r/20260320163720.100456-1-oskar%40gerlicz.space
patch subject: [PATCH 1/5] liveupdate: block outgoing session updates during reboot
config: x86_64-randconfig-161-20260322 (https://download.01.org/0day-ci/archive/20260322/202603221537.TfoAS2LD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603221537.TfoAS2LD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603221537.TfoAS2LD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/liveupdate/luo_session.c:99 struct member 'reboot_waitq' not described in 'luo_session_header'
>> Warning: kernel/liveupdate/luo_session.c:99 struct member 'rebooting' not described in 'luo_session_header'
>> Warning: kernel/liveupdate/luo_session.c:99 struct member 'reboot_waitq' not described in 'luo_session_header'
>> Warning: kernel/liveupdate/luo_session.c:99 struct member 'rebooting' not described in 'luo_session_header'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

