Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21577C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CLyuYPLrQnGMQFElqty8pHB+XLtP6UmUFIRxhIecTEI=; b=gAFob/4OZW5M9S
	agzryDXlmU7Gg5JqszJ5SLFHHUqlVGTvzpvriUoto8GCRCbmT5qJzLhlWoQKu4H/A+sNHw01DKPyu
	JNP3GBb9vL6gAG40p8PoW7O8MSAfPHvb2sqrY2xkme+bo5UFr6Rot08Omcl8Y3UWxXOo1EbaEG84a
	jZQ7Few2jZr+MUmfk0g4I4g1j7NKNt8V9LT6mG3tiu1J7Z/lfw40HMhATvwpIyrXsP4XAISoADQem
	ZIX+b7h0GKUFh5uKyMKTENaUeDvZzbuD7TwYKgOOoiKy0VpxXTFGPDQ4IWEWJqp4cZkHBB1pPlK6K
	JYzU2+R54CrMXZumR7lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0LMH-0000000Cakv-2M3h;
	Fri, 26 Apr 2024 13:11:21 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0LM1-0000000CaZt-1YYv
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 13:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137066; x=1745673066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8Bo2pBp4CBzrWEGtBurDTewnj7beNkSoEBY6dW1Z5Q=;
  b=RDPp9+kf13gCl8wkrUbM6jQUh0w+G4r0mVRc5mWts0BdF0FGE0AX1vrU
   oiXGRjlxMF58jT58paHyJQVF3Aa1eZ6qn5XmE5HJL2apwcdk7RMxBb6wR
   e5ypTP4pUwEFsayf0hgGcLgJo3WOZflSRYsyJdOdtk4ROjEb4BVT6g/Il
   wsE/JZjHkNSbs43NnfNnKUWPDT/QRm8kFSLaPqOsB+6x7/y/7lRY2XUe8
   Sd68a/dncOKVZQhTup89fwvLaZuoZuzdwugM1yLGYo5T0LXTocLiReKa5
   8nCunOdbMPC5ZBWUkuviX/dsWYxhN94ZKiNRf2Y8F7YQUahGz6KxksExm
   g==;
X-CSE-ConnectionGUID: oSv/sSb3QWiKxYdBHIGMMA==
X-CSE-MsgGUID: +ni8N6RITJeD1bMIcu/89A==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="32369085"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="32369085"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:10:54 -0700
X-CSE-ConnectionGUID: I91opZe0QOCYr6k80Mwxlg==
X-CSE-MsgGUID: 7AYKl2cjT4Kk9lDltl+iZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="29863132"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Apr 2024 06:10:49 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0LLj-0003jK-0O;
	Fri, 26 Apr 2024 13:10:47 +0000
Date: Fri, 26 Apr 2024 21:10:43 +0800
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
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <202404262003.qsWvGwZU-lkp@intel.com>
References: <20240425100434.198925-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-3-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_061105_459522_97C89618 
X-CRM114-Status: GOOD (  10.63  )
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

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc5 next-20240426]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240425-180836
base:   linus/master
patch link:    https://lore.kernel.org/r/20240425100434.198925-3-coxu%40redhat.com
patch subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
config: x86_64-randconfig-r113-20240426 (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404262003.qsWvGwZU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/crash_dump_dm_crypt.c:31:3: sparse: sparse: symbol 'keys_header' was not declared. Should it be static?

vim +/keys_header +31 kernel/crash_dump_dm_crypt.c

    27	
    28	struct keys_header {
    29		unsigned int key_count;
    30		struct dm_crypt_key keys[] __counted_by(key_count);
  > 31	} *keys_header;
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
