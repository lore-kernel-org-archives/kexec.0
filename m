Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7CCC47077
	for <kexec@archiver.kernel.org>; Thu, 18 Jan 2024 05:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OxxRw9J7YjPG0AeTENW1oUTQO9dVwnM+PaTbK5sxDsk=; b=KBLeRIhw4TcPcY
	BxSINe0Xva0tP80Sp6dPQnm3gbs3RoNCaSIkz/JISEUbL45VAzPvJ2ko8ePfbVJh02Fk+OmbIyyEu
	ZKjWQ2Xre87qcJxvDF0A1uZZScAVICW8J6iikiF/5SsSkvVbZeLgZp4DSgtGDa5pqYAEERTmcq7PF
	J+hNw4FFV2ZIEWx4YY4pnz0CnGj8UhhnaLSHvLv4r6mPkugQHTrFP1xOfeYY1aaNq2odMPBRPjG7q
	KiV1fIfTpQ7ssxG8y1cBOw1t0Snsp7YHE8Y5HgAY4t2C/hPMWKhW0SRQIBDeozZ+DZQEGOkNJ74Lp
	gW5AmFLXK3Lj8flIi5tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQKsJ-001hEk-1x;
	Thu, 18 Jan 2024 05:23:35 +0000
Received: from mgamail.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQKsF-001h8R-1V;
	Thu, 18 Jan 2024 05:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705555411; x=1737091411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/6No842LSfCPrLeri6/s3ezEv75k2+9QtC8rEcULB8=;
  b=gTuL7a/WvglxvfeKBk75BGnjM9aST0mCtVlPJh72H+vyWjW6m0e3VL+O
   Xpj+YuHsCBzFe/K8Fs95nhqHB3Y46fvlWwu/38lNSvWjmeXuSLY5LZZ14
   lkzB0ivc4e93OWNuCKLNcMvcEO/msVEqhTf5uTWZDnovXAgFW9a5nalb1
   eNrNeIUyeDzM/ZZv8T2XtKD5EBC/Q1j2SNhPxDwKjRAvxq1ywYSafyUe4
   AVBrooZli0WFoehjeO3BEP928A20U/xUpaFAjjnD1wMyBgi9sX2p1jrsa
   OVJZOT1gyAdWb36aCqksMNkZ6UvJp6MQ3Dzzv2rWBUf9BrMITKlPSx4dt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="390802151"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="390802151"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 21:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031539496"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="1031539496"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2024 21:23:14 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQKrw-0002g1-2H;
	Thu, 18 Jan 2024 05:23:12 +0000
Date: Thu, 18 Jan 2024 13:23:03 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 14/17] tracing: Add kho serialization of trace events
Message-ID: <202401181352.qC85XHgx-lkp@intel.com>
References: <20240117144704.602-15-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117144704.602-15-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_212331_547445_BCEFAF12 
X-CRM114-Status: GOOD (  15.96  )
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

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[cannot apply to tip/x86/core arm64/for-next/core akpm-mm/mm-everything v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20240117-225136
base:   linus/master
patch link:    https://lore.kernel.org/r/20240117144704.602-15-graf%40amazon.com
patch subject: [PATCH v3 14/17] tracing: Add kho serialization of trace events
config: i386-randconfig-141-20240118 (https://download.01.org/0day-ci/archive/20240118/202401181352.qC85XHgx-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401181352.qC85XHgx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401181352.qC85XHgx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_output.c:731:12: warning: unsequenced modification and access to 'count' [-Wunsequenced]
     731 |                 map[count++] = (struct trace_event_map) {
         |                          ^
     732 |                         .crc32 = count,
         |                                  ~~~~~
   1 warning generated.


vim +/count +731 kernel/trace/trace_output.c

   710	
   711	static int __maybe_unused _trace_kho_write_events(void *fdt)
   712	{
   713		struct trace_event_call *call;
   714		int count = __TRACE_LAST_TYPE - 1;
   715		struct trace_event_map *map;
   716		int err = 0;
   717		int i;
   718	
   719		down_read(&trace_event_sem);
   720		/* Allocate an array that we can place all maps into */
   721		list_for_each_entry(call, &ftrace_events, list)
   722			count++;
   723	
   724		map = vmalloc(count * sizeof(*map));
   725		if (!map)
   726			return -ENOMEM;
   727	
   728		/* Then fill the array with all crc32 values */
   729		count = 0;
   730		for (i = 1; i < __TRACE_LAST_TYPE; i++)
 > 731			map[count++] = (struct trace_event_map) {
   732				.crc32 = count,
   733				.type = count,
   734			};
   735	
   736		list_for_each_entry(call, &ftrace_events, list) {
   737			struct trace_event *event = &call->event;
   738	
   739			map[count++] = (struct trace_event_map) {
   740				.crc32 = event2fp(event),
   741				.type = event->type,
   742			};
   743		}
   744		up_read(&trace_event_sem);
   745	
   746		/* And finally write it into a DT variable */
   747		err |= fdt_property(fdt, "events", map, count * sizeof(*map));
   748	
   749		vfree(map);
   750		return err;
   751	}
   752	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
