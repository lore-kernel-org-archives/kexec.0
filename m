Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B276AC25B76
	for <kexec@archiver.kernel.org>; Sat,  8 Jun 2024 03:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1KvDH2Q7BGDvIzwKjt2J0Vl2iFJAXuBxDognfwFXPlY=; b=g6/70EiwVjpFeP
	UO0GqcLg8wRJISI47V2fbOtEgjWJCCkkM6vOYY9SNa43uJMhU8V8AwFRQh/3GDU1QDds0PQdXMpLH
	d6lK+4sDKtYErUYOUfCWJZPu0wq7b42G4odgV2JaPtw5/nfU4dPj0vAy1UmZbPuolFpsXkut9fiEF
	JmQq0IgbFGkOTyKDu5dcGlZptH+eSr5Gig+6g+/SAwbC1aTndLXKkj5AGC6h9P5mgcXd3ArAj4owr
	rlwRXCLe+cJp47+aGqkEqL5SaofVgNCndV75VSmWjbDb/CzRN+VXEcUmwfTE2dmsZnGMzyVGDnCI6
	tetSL/iUi52unn322kvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFn7m-0000000GRYT-44o2;
	Sat, 08 Jun 2024 03:52:14 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFn7j-0000000GRXm-2QUl
	for kexec@lists.infradead.org;
	Sat, 08 Jun 2024 03:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717818732; x=1749354732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Cm+CgN11GfmM/yX8tcb2ymAxLaz7HWIhehqxPB568k=;
  b=H7jgLx2EmLK95sD+sGtC6wek9Pq4HMQdGb8nD5kanVjyRwS2VzB05q3K
   IjIX/r+uk6w6VPiVdBGdLYSi740DN4bgaav2nPn7SBSF1TDJVC8KkEblu
   pfzbQWy4v+G+9f94+CHEfeaBW5Qmnj5MprX7D5OJ6cJc5lO1Qx0v0+WX/
   C/PNlEa6byufA0wgEpzWWcicgP75xiek1pWAwDJYRnALIPmfuZIp1IsuO
   bmvHPlIrs8zK/+uxRikgDTEf0LiBSHTJ8gYv0ybZUtww7tAZL7bcwC0QM
   1kxTB3uZp+898FzD3hYxbVqLn30fZII+lDkGHQhjl4mCTNdLttpzR8grp
   w==;
X-CSE-ConnectionGUID: 6waW6UXDT4eSiWrJroOCrQ==
X-CSE-MsgGUID: JWaHILuTRLWs4uYQDR7ekw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14396984"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="14396984"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:52:07 -0700
X-CSE-ConnectionGUID: PocEqOsSSZuzfGsnkzRjTw==
X-CSE-MsgGUID: Zf86QYu4R4+E8mvVViogMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="38462322"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Jun 2024 20:52:03 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFn7Z-0000wM-1I;
	Sat, 08 Jun 2024 03:52:01 +0000
Date: Sat, 8 Jun 2024 11:51:46 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Greg KH <greg@kroah.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <202406081124.hYZYvBL0-lkp@intel.com>
References: <20240607122622.167228-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-2-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_205211_702018_2B03332E 
X-CRM114-Status: GOOD (  12.09  )
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

[auto build test ERROR on 8a92980606e3585d72d510a03b59906e96755b8a]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240607-203154
base:   8a92980606e3585d72d510a03b59906e96755b8a
patch link:    https://lore.kernel.org/r/20240607122622.167228-2-coxu%40redhat.com
patch subject: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20240608/202406081124.hYZYvBL0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081124.hYZYvBL0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081124.hYZYvBL0-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/kexec_file.c: In function 'locate_mem_hole_bottom_up':
>> kernel/kexec_file.c:504:17: error: 'struct kexec_buf' has no member named 'random'
     504 |         if (kbuf->random)
         |                 ^~
>> kernel/kexec_file.c:505:30: error: implicit declaration of function 'kexec_random_start' [-Werror=implicit-function-declaration]
     505 |                 temp_start = kexec_random_start(temp_start, end);
         |                              ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +504 kernel/kexec_file.c

   496	
   497	static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
   498					     struct kexec_buf *kbuf)
   499	{
   500		struct kimage *image = kbuf->image;
   501		unsigned long temp_start, temp_end;
   502	
   503		temp_start = max(start, kbuf->buf_min);
 > 504		if (kbuf->random)
 > 505			temp_start = kexec_random_start(temp_start, end);
   506	
   507		do {
   508			temp_start = ALIGN(temp_start, kbuf->buf_align);
   509			temp_end = temp_start + kbuf->memsz - 1;
   510	
   511			if (temp_end > end || temp_end > kbuf->buf_max)
   512				return 0;
   513			/*
   514			 * Make sure this does not conflict with any of existing
   515			 * segments
   516			 */
   517			if (kimage_is_destination_range(image, temp_start, temp_end)) {
   518				temp_start = temp_start + PAGE_SIZE;
   519				continue;
   520			}
   521	
   522			/* We found a suitable memory range */
   523			break;
   524		} while (1);
   525	
   526		/* If we are here, we found a suitable memory range */
   527		kbuf->mem = temp_start;
   528	
   529		/* Success, stop navigating through remaining System RAM ranges */
   530		return 1;
   531	}
   532	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
