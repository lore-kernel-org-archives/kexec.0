Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC7CC4332F
	for <kexec@archiver.kernel.org>; Mon, 30 Oct 2023 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Dle5u5uss81eElSuL6eYTjjlRXxTdyTAZb609nc09g=; b=GXGlJ7KGzXtCRV
	BkmBjS3nrqfT4y6POJqwqe3Aw0nKvUaYtrhUejN+OABPY8O2nYR6DqdAbAt2r/BSLULrgBQAv6S9S
	IX9GQiq8KXTGNUM0/kOdyh9U4jB2g4KQeosn4RH2MLP8bXrNBFm+47DgRYUIwDz3otQLiZ/7VHryp
	0C9rMQbw1pBOc6F1fwQ6MUsLmIx//nJEqZ4GPF9FmstnBRQHUQiEToCFxrDlKcSsRLn9kVZikF/Hl
	ZlVgYs3LbOoLqunQeTzQGMQqStPEHTbFVNPgrbr7z4epwjSrAZ291M8Hhxh2b7BC1gqYZ4y1VLdSl
	r0Bg5/LF6DoiMxU5FAag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxGNs-002Kdr-32;
	Mon, 30 Oct 2023 00:44:00 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxGNp-002Kcy-2n
	for kexec@lists.infradead.org;
	Mon, 30 Oct 2023 00:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698626637; x=1730162637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g1ypwRov0tzM3HEybZ/eYo/bLezi/zNSOOpCeGQJlxc=;
  b=QG+DqKzGlDYOXTkM+z26z/NQu5B3HTN+vbmDpUjZhZEE/5eQY/JeGoo8
   6gsKmD104/nhIQMqclW/49O6A1dTA/Bc9TAEx7TccXWwU8AD0/elGNVNv
   zOhcxQiCMJTnfTT+hPQaw3Ul6RnUTCd6ZMwgKB9rtr+RPFfhFbdhNCqEe
   QuZOlIdtyeXZ8fuRrsQTdLV5cOhXdacz7l6LFnhZhTyCc/Xm+LyqL4PxA
   n3IoS7iQRt+bFQnF2KD0qz0BQbIp/Arv/8NdAOc3VNZu7adIZg/O4ZOu7
   A86kHODrrRZbVJr8+YhP+HT7wLAJFD1pnfm7DQ0xqa4ZfGlpvg5X+R3Ze
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="474225181"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="474225181"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 17:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="933627203"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="933627203"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2023 17:43:45 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxGNa-000Cwh-1R;
	Mon, 30 Oct 2023 00:43:42 +0000
Date: Mon, 30 Oct 2023 08:43:22 +0800
From: kernel test robot <lkp@intel.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Baoquan He <bhe@redhat.com>, x86@kernel.org,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v12 6/6] powerpc: add crash memory hotplug support
Message-ID: <202310300812.yN6FuPcZ-lkp@intel.com>
References: <20231029124039.6158-7-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231029124039.6158-7-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_174357_915276_457F560E 
X-CRM114-Status: GOOD (  12.50  )
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

Hi Sourabh,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.6-rc7]
[cannot apply to powerpc/next powerpc/fixes tip/x86/core next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourabh-Jain/crash-forward-memory_notify-arg-to-arch-crash-hotplug-handler/20231029-213858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231029124039.6158-7-sourabhjain%40linux.ibm.com
patch subject: [PATCH v12 6/6] powerpc: add crash memory hotplug support
config: powerpc64-randconfig-001-20231029 (https://download.01.org/0day-ci/archive/20231030/202310300812.yN6FuPcZ-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310300812.yN6FuPcZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310300812.yN6FuPcZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: warning: discarding dynamic section .glink
   powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `add_opal_mem_range'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: arch/powerpc/kexec/core_64.o: in function `get_crash_memory_ranges':
   core_64.c:(.text+0x1010): undefined reference to `add_mem_range'
   powerpc64-linux-ld: core_64.c:(.text+0x1064): undefined reference to `sort_memory_ranges'
   powerpc64-linux-ld: core_64.c:(.text+0x1128): undefined reference to `add_rtas_mem_range'
   powerpc64-linux-ld: core_64.c:(.text+0x1140): undefined reference to `add_opal_mem_range'
   powerpc64-linux-ld: core_64.c:(.text+0x1160): undefined reference to `add_mem_range'
   powerpc64-linux-ld: core_64.c:(.text+0x1188): undefined reference to `sort_memory_ranges'
   powerpc64-linux-ld: core_64.c:(.text+0x11e0): undefined reference to `realloc_mem_ranges'
   powerpc64-linux-ld: arch/powerpc/kexec/core_64.o: in function `arch_crash_handle_hotplug_event':
>> core_64.c:(.text+0x1900): undefined reference to `remove_mem_range'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
