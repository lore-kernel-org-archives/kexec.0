Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA7DD3A661
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4mWW557/WeBKASoE6ZXqCwwBmYI18eNI9LapOjJEEKI=; b=ClPbl3edrDtqxx
	Av9C8boRpPIBfFW2Y854yt6yqX6xXlIpDDf/xjhbg0DlXBZRJ+RmZ4O9VKgmgMgY9pD8J58oMl/vL
	oTRUEFQ5GmC383yqrwt+rPcaaBd0Mfdwncl/FuBvDwqvybpEcJaINhe6mqZ0/8ruGr0K2lXwcJQtl
	IFlCeq2P7TVwr8x2pTSM+C/52EpS5AWcIT+h/DkPSkBfMbU6Oin7BhpwRzW28P8YRwOKm1xM8xbUx
	SLvLmHOtCQau8JBL9041BnOx4nbV4KXF1OSJvOBLpiaswJBkwLfXkcuBz/Mhg+Dk/Duhq1S9Eif/B
	M15GqtDGQMG51HeDcJ7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5nQR-0000000El2s-2HNi;
	Tue, 29 Oct 2024 14:42:27 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5nQC-0000000Ekzn-3101
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 14:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730212933; x=1761748933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eb4/agc7lIp7xggxiMeKGEgevS+k7MTVTxFox6avOPg=;
  b=CloLA43oXXYgo1OUT86Lzsa2Lisgi74a0PdeFutOuazSstDK+DbMVS2i
   l91EeD/WPxGi8ZM6KNZUauo5YVNzTavq236M/g+N5plADpyohajD5qobp
   cZgh966W6ttQyP2tt4fQJJWGb9TzixdD5BeABXiZfozzLWfn7ihJtDMMp
   S0SnsF6w94KsARnwaXMIqhGrkpoDEwq1NGLJBSCQhvHKVC1MaQegPpVSi
   2CXWGpLFaqdWejHtQfPiet04EV8q30NLgITloeqic7hQzap4tCQOcinLi
   a02p6nud+8YaQZvLfNygj6VEcqEngRKgRzhx2X80e5EN8BAJet9DxZgPi
   Q==;
X-CSE-ConnectionGUID: I2OLBJDIRLOHGNi0vw1TPQ==
X-CSE-MsgGUID: aNwBhz5IRRK7i0NbDGqCLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33653769"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33653769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:42:11 -0700
X-CSE-ConnectionGUID: 7F9LJjzHQE+8h7YADA97jA==
X-CSE-MsgGUID: CvtmaoCmQDCpmSam6J0E5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82794215"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Oct 2024 07:42:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5nQ3-000dmO-09;
	Tue, 29 Oct 2024 14:42:03 +0000
Date: Tue, 29 Oct 2024 22:41:50 +0800
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
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved
 memory
Message-ID: <202410292237.HA9vMqbC-lkp@intel.com>
References: <20241029055223.210039-4-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-4-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_074212_839706_3D974744 
X-CRM114-Status: GOOD (  16.36  )
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

[auto build test ERROR on e42b1a9a2557aa94fee47f078633677198386a52]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20241029-135449
base:   e42b1a9a2557aa94fee47f078633677198386a52
patch link:    https://lore.kernel.org/r/20241029055223.210039-4-coxu%40redhat.com
patch subject: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved memory
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241029/202410292237.HA9vMqbC-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410292237.HA9vMqbC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410292237.HA9vMqbC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_keys':
>> kernel/crash_dump_dm_crypt.c:221:16: error: variable 'kbuf' has initializer but incomplete type
     221 |         struct kexec_buf kbuf = {
         |                ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:222:18: error: 'struct kexec_buf' has no member named 'image'
     222 |                 .image = image,
         |                  ^~~~~
>> kernel/crash_dump_dm_crypt.c:222:26: warning: excess elements in struct initializer
     222 |                 .image = image,
         |                          ^~~~~
   kernel/crash_dump_dm_crypt.c:222:26: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:223:18: error: 'struct kexec_buf' has no member named 'buf_min'
     223 |                 .buf_min = 0,
         |                  ^~~~~~~
   kernel/crash_dump_dm_crypt.c:223:28: warning: excess elements in struct initializer
     223 |                 .buf_min = 0,
         |                            ^
   kernel/crash_dump_dm_crypt.c:223:28: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:224:18: error: 'struct kexec_buf' has no member named 'buf_max'
     224 |                 .buf_max = ULONG_MAX,
         |                  ^~~~~~~
   In file included from include/linux/limits.h:7,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/loongarch/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rbtree.h:24,
                    from include/linux/key.h:15,
                    from kernel/crash_dump_dm_crypt.c:2:
>> include/vdso/limits.h:13:25: warning: excess elements in struct initializer
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:224:28: note: in expansion of macro 'ULONG_MAX'
     224 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
   include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:224:28: note: in expansion of macro 'ULONG_MAX'
     224 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:225:18: error: 'struct kexec_buf' has no member named 'top_down'
     225 |                 .top_down = false,
         |                  ^~~~~~~~
   kernel/crash_dump_dm_crypt.c:225:29: warning: excess elements in struct initializer
     225 |                 .top_down = false,
         |                             ^~~~~
   kernel/crash_dump_dm_crypt.c:225:29: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:226:18: error: 'struct kexec_buf' has no member named 'random'
     226 |                 .random = true,
         |                  ^~~~~~
   kernel/crash_dump_dm_crypt.c:226:27: warning: excess elements in struct initializer
     226 |                 .random = true,
         |                           ^~~~
   kernel/crash_dump_dm_crypt.c:226:27: note: (near initialization for 'kbuf')
>> kernel/crash_dump_dm_crypt.c:221:26: error: storage size of 'kbuf' isn't known
     221 |         struct kexec_buf kbuf = {
         |                          ^~~~
>> kernel/crash_dump_dm_crypt.c:246:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
     246 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:246:20: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/crash_dump_dm_crypt.c:247:13: error: implicit declaration of function 'kexec_add_buffer' [-Wimplicit-function-declaration]
     247 |         r = kexec_add_buffer(&kbuf);
         |             ^~~~~~~~~~~~~~~~
>> kernel/crash_dump_dm_crypt.c:221:26: warning: unused variable 'kbuf' [-Wunused-variable]
     221 |         struct kexec_buf kbuf = {
         |                          ^~~~


vim +/kbuf +221 kernel/crash_dump_dm_crypt.c

   218	
   219	int crash_load_dm_crypt_keys(struct kimage *image)
   220	{
 > 221		struct kexec_buf kbuf = {
 > 222			.image = image,
 > 223			.buf_min = 0,
 > 224			.buf_max = ULONG_MAX,
 > 225			.top_down = false,
 > 226			.random = true,
   227		};
   228		int r;
   229	
   230	
   231		if (key_count <= 0) {
   232			kexec_dprintk("No dm-crypt keys\n");
   233			return -EINVAL;
   234		}
   235	
   236		image->dm_crypt_keys_addr = 0;
   237		r = build_keys_header();
   238		if (r)
   239			return r;
   240	
   241		kbuf.buffer = keys_header;
   242		kbuf.bufsz = get_keys_header_size(key_count);
   243	
   244		kbuf.memsz = kbuf.bufsz;
   245		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 > 246		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 > 247		r = kexec_add_buffer(&kbuf);
   248		if (r) {
   249			kvfree((void *)kbuf.buffer);
   250			return r;
   251		}
   252		image->dm_crypt_keys_addr = kbuf.mem;
   253		image->dm_crypt_keys_sz = kbuf.bufsz;
   254		kexec_dprintk(
   255			"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
   256			kbuf.bufsz, kbuf.bufsz);
   257	
   258		return r;
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
