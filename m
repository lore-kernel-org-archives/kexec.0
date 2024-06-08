Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7296FC25B76
	for <kexec@archiver.kernel.org>; Sat,  8 Jun 2024 04:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/LVZGDK5vKth0Eal97j7YdfpZc2y3grMRxle2lznmAA=; b=LLkyr16/AyE4/4
	mD6U31+b0ssYm5NW3wqh5L3yc0dd7p8xWAYJ3f38yjndq2T1xPcfPvZs1hCMAvwRtoRgxAxfZQ93b
	grLBBuZbjBZZ9FYkvtETqcorM2cst277c4fFlL7IPTPripBxfACPIapVpvqG48TyH7fRAZAun6tmW
	0gJFPaQaiOa0DKLporvnKEgrbpFN58FuQKD7S89RomXkhjcMQGA9GMh/OJJSGTWIqHdrJ6Rtig39J
	4cNdg0nc5f8SelJsD//wiPGmiMjPj4joEeLtnRAMkxER25SLqPis6KJo4RErZM28T0/UTmOUnVO+s
	Ny/MTTqTZroTGcaHLJVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFncn-0000000GVny-3BRR;
	Sat, 08 Jun 2024 04:24:17 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFncj-0000000GVZe-2JiU
	for kexec@lists.infradead.org;
	Sat, 08 Jun 2024 04:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717820654; x=1749356654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=djyCoxwdB02mJxnU8dMa7DQUh1mSR9t7kFne7+MeAtI=;
  b=eVW+0AmZ27WphoKqmGubqYoUXtizQsPGeM6nErxxDCBtcjkmbONQtaIJ
   t4TDy7110mH19gwrFowcasUxQBeuLhA6mKUZ7BQTgoTctSlnmC7/a05ZX
   MUvCpQ5/Oy98OuFQQf/4bAKhWr/VGogEakRHrq5nn6CO4vGVG/jCEzgUX
   rwBaJUbyO93Dw1B/c3GKMStkdQk39q1viu6IPo5wBawTSqU0Mku3XNl+2
   2suLDvKYchp/FBxITruULfeCllW/5pU/I8Y0Oem8JRMsGFOcGcmhvLGFF
   UPXDwWqT0+gNcrL8WKvfw+AOlHj+cYoOq2NK+ecMErBFWjmYmIn+BRuBx
   Q==;
X-CSE-ConnectionGUID: 2sCMbZlITOSTW0Yp2u4XRA==
X-CSE-MsgGUID: fazZa8nNQwmiQZzd+WxaNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25970572"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="25970572"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 21:24:10 -0700
X-CSE-ConnectionGUID: NhCpHC2VTRGsG4BYleMG/Q==
X-CSE-MsgGUID: fnTx+2CBTLaD5CD5MbJziA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="43456635"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Jun 2024 21:24:06 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFncZ-0000yp-0Y;
	Sat, 08 Jun 2024 04:24:03 +0000
Date: Sat, 8 Jun 2024 12:23:35 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ondrej Kozina <okozina@redhat.com>,
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
Message-ID: <202406081214.kNbwlJWP-lkp@intel.com>
References: <20240607122622.167228-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-2-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_212413_772147_FA811630 
X-CRM114-Status: GOOD (  11.88  )
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240608/202406081214.kNbwlJWP-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081214.kNbwlJWP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081214.kNbwlJWP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/kexec_file.c:504:12: error: no member named 'random' in 'struct kexec_buf'
     504 |         if (kbuf->random)
         |             ~~~~  ^
>> kernel/kexec_file.c:505:16: error: call to undeclared function 'kexec_random_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     505 |                 temp_start = kexec_random_start(temp_start, end);
         |                              ^
   2 errors generated.


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
