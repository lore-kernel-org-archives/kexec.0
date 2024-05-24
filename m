Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A4C25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 03:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JomYTzhwcBnQF5DNGPLSvv9Bh+SEqrhxfW0d8M941Iw=; b=sAfAnEDrOLVbKn
	9bJiaQGnOoeCbG5QORddnJDLIe91JGaTdEhCm4X/5r0ytxtddpNRC+QIt+vlXeiXv6X3sLtGwWIez
	xkPUFR7GPZc0ZAw9IbmZ8HvwwF54S19hzXTmJ+2x3JyR9luR5qoleRRmRFXmWtgOORVNkNxPxeZI1
	w+ZhB7KV5EWZMGoRRvS9Ws3js38ehepSdI6eCw+GUsZwwZlekeV93dFsaeKRqLNcUeVRB71PfO9DZ
	XI+SfBMQn1WgfdyrpGr84Pcc4KArwP4F8c5LvwUL0kgamhkrU1CnlLW2NXvQsG86Ibvdp2ZT1T2OS
	aKRiKP443bSfN1fDW8AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sALSB-00000007ulB-42ra;
	Fri, 24 May 2024 03:18:47 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sALS7-00000007ukA-2mU5
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 03:18:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716520724; x=1748056724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmwkT08Wml58wAZ0fufhXC4LR6Vf2WvUoVrYuKBhHUY=;
  b=Zp/+us2/v1QnbytPgEErk6PUo1TMzCUh3FJzrMOm8JvdHUG82fMmDV/X
   k6QRAIMiwnsX20/01NGysQkFUyd8gPhv7/dNkGze72vQMP7104wg9QoTB
   gAxOX/sbdViZrcyZ4DdKIuDdj6XuOeS0ewEHdKOsc8C1aIT4zVsIUhCUe
   jVGeFEaPcCSrQYsoRTujFOW9tetUz2iPQGwKDsVt6CqKWOF5yWIZYWp7b
   QYKqx+m5Mzds03PH9QSvNb6zxpmY9WzW8Prxg8++7Ezb3W2oAou2+jPKs
   CJaAzaNbGwZDqMPWwQ/+x9cI0M11IU8wWZe7RDq1SEU0GEZ51mfFem+8a
   Q==;
X-CSE-ConnectionGUID: dnjtIh/zROWeqy4qEHjYDA==
X-CSE-MsgGUID: WjjgHBvdTbaO53MAob1mVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12997738"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12997738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 20:18:14 -0700
X-CSE-ConnectionGUID: 8rBYzwWGRWyGrPd9329P8w==
X-CSE-MsgGUID: dyWvMqt8QVSPk+xJ1pnCjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="34487139"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 May 2024 20:18:08 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sALRH-0003ml-0P;
	Fri, 24 May 2024 03:17:55 +0000
Date: Fri, 24 May 2024 11:17:08 +0800
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
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
Message-ID: <202405241012.KlmCbp77-lkp@intel.com>
References: <20240523050451.788754-4-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-4-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_201843_782884_404957D0 
X-CRM114-Status: GOOD (  15.67  )
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

[auto build test ERROR on de7e71ef8bed222dd144d8878091ecb6d5dfd208]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240523-130727
base:   de7e71ef8bed222dd144d8878091ecb6d5dfd208
patch link:    https://lore.kernel.org/r/20240523050451.788754-4-coxu%40redhat.com
patch subject: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241012.KlmCbp77-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_keys':
>> kernel/crash_dump_dm_crypt.c:158:16: error: variable 'kbuf' has initializer but incomplete type
     158 |         struct kexec_buf kbuf = {
         |                ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:159:18: error: 'struct kexec_buf' has no member named 'image'
     159 |                 .image = image,
         |                  ^~~~~
   kernel/crash_dump_dm_crypt.c:159:26: warning: excess elements in struct initializer
     159 |                 .image = image,
         |                          ^~~~~
   kernel/crash_dump_dm_crypt.c:159:26: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:160:18: error: 'struct kexec_buf' has no member named 'buf_min'
     160 |                 .buf_min = 0,
         |                  ^~~~~~~
   kernel/crash_dump_dm_crypt.c:160:28: warning: excess elements in struct initializer
     160 |                 .buf_min = 0,
         |                            ^
   kernel/crash_dump_dm_crypt.c:160:28: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:161:18: error: 'struct kexec_buf' has no member named 'buf_max'
     161 |                 .buf_max = ULONG_MAX,
         |                  ^~~~~~~
   In file included from include/linux/limits.h:7,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rbtree.h:24,
                    from include/linux/key.h:15,
                    from kernel/crash_dump_dm_crypt.c:2:
   include/vdso/limits.h:13:25: warning: excess elements in struct initializer
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
     161 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
   include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
     161 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:162:18: error: 'struct kexec_buf' has no member named 'top_down'
     162 |                 .top_down = false,
         |                  ^~~~~~~~
   kernel/crash_dump_dm_crypt.c:162:29: warning: excess elements in struct initializer
     162 |                 .top_down = false,
         |                             ^~~~~
   kernel/crash_dump_dm_crypt.c:162:29: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:163:18: error: 'struct kexec_buf' has no member named 'random'
     163 |                 .random = true,
         |                  ^~~~~~
   kernel/crash_dump_dm_crypt.c:163:27: warning: excess elements in struct initializer
     163 |                 .random = true,
         |                           ^~~~
   kernel/crash_dump_dm_crypt.c:163:27: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:158:26: error: storage size of 'kbuf' isn't known
     158 |         struct kexec_buf kbuf = {
         |                          ^~~~
>> kernel/crash_dump_dm_crypt.c:187:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
     187 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:187:20: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/crash_dump_dm_crypt.c:188:13: error: implicit declaration of function 'kexec_add_buffer' [-Werror=implicit-function-declaration]
     188 |         r = kexec_add_buffer(&kbuf);
         |             ^~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:158:26: warning: unused variable 'kbuf' [-Wunused-variable]
     158 |         struct kexec_buf kbuf = {
         |                          ^~~~
   cc1: some warnings being treated as errors


vim +/kbuf +158 kernel/crash_dump_dm_crypt.c

   155	
   156	int crash_load_dm_crypt_keys(struct kimage *image)
   157	{
 > 158		struct kexec_buf kbuf = {
 > 159			.image = image,
 > 160			.buf_min = 0,
 > 161			.buf_max = ULONG_MAX,
 > 162			.top_down = false,
 > 163			.random = true,
   164		};
   165	
   166		int r;
   167	
   168		if (state == FRESH)
   169			return 0;
   170	
   171		if (key_count != keys_header->key_count) {
   172			pr_err("Only record %u keys (%u in total)\n", key_count,
   173			       keys_header->key_count);
   174			return -EINVAL;
   175		}
   176	
   177		image->dm_crypt_keys_addr = 0;
   178		r = build_keys_header();
   179		if (r)
   180			return r;
   181	
   182		kbuf.buffer = keys_header;
   183		kbuf.bufsz = keys_header_size;
   184	
   185		kbuf.memsz = kbuf.bufsz;
   186		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 > 187		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 > 188		r = kexec_add_buffer(&kbuf);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
