Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625C5C4707B
	for <kexec@archiver.kernel.org>; Thu, 18 Jan 2024 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BsiSw62Uxpd/SsP753gOBHyMJ4kj+vN4Vf+2Q59BdDc=; b=o2FO3K8TJNQEQc
	BsuGQBU96l5+yUvR/v+Uib5IVSCdRp+/GIZL8vPRSTc44MqhBwWxKbc2F0H0AiICXmffJBZns5kWk
	sLncQrr/7x4W8iJAHlqUeS2AuG8XPzLOBoU+HYed2IyWAWLx73a6ujIO1JVuM/2xxgYGtjKwglO6J
	31diTyCNp34R19qtylqILmEAdWXwRQzTYgCoAM6857lklKiFq2zV/cp07thh7dzyGvyIcC8ZuLWRC
	xEvYqlSzrdUZNzNi0Hv9L1l2BgUBE1Z3/wsheoQbQb7vX41oxyf5OgZ13MSPjPwfElMTbbFY41Br2
	2NqxUJ2d7WmzR3fXY13w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQMBd-001pEe-1o;
	Thu, 18 Jan 2024 06:47:37 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQMBZ-001pDP-0u;
	Thu, 18 Jan 2024 06:47:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705560453; x=1737096453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWREub8VuUlUODzLU8q34Rk02UcISqoTmL/dacBll1w=;
  b=iD3rPjPV/Jwidlyv/hDcVnj88YlrBFstDFekUmd8L8zpOq7KBwmkkWLs
   p2f24bmqYc+4rAz1nJM/4bsaysi61PVkxMU7SqP0OtmgOxPU65pHGi1Ic
   EOBYgAlnIn9avkKOpefyBygsz7CS+Qrz3gx+HpfVnc4Z7Cmp8fdvoDoLf
   VIqwlOmMxRdzeACh0aGoWbJhH7wti42p0FqJX73FsekxPAHL3fiUIU5SK
   9GUvF2wD/sGAYXnLUUqGWr2k6v6tfTc2TO+ERbV1Spey0WwCKiE/U3Jh/
   uCLnL8fI8FLjCjU6pYJs1ihb7uUXzghrWVl7JcBuHQ0XhIjpY6xjK1NVD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7459415"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7459415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 22:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="204921"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jan 2024 22:47:22 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQMBL-0002jI-0y;
	Thu, 18 Jan 2024 06:47:19 +0000
Date: Thu, 18 Jan 2024 14:46:57 +0800
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
Subject: Re: [PATCH v3 13/17] tracing: Recover trace buffers from kexec
 handover
Message-ID: <202401181457.dzB2femp-lkp@intel.com>
References: <20240117144704.602-14-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117144704.602-14-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_224733_379602_7B2DDACB 
X-CRM114-Status: GOOD (  18.63  )
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
patch link:    https://lore.kernel.org/r/20240117144704.602-14-graf%40amazon.com
patch subject: [PATCH v3 13/17] tracing: Recover trace buffers from kexec handover
config: arc-defconfig (https://download.01.org/0day-ci/archive/20240118/202401181457.dzB2femp-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401181457.dzB2femp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401181457.dzB2femp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/ring_buffer.c: In function 'rb_kho_replace_buffers':
>> kernel/trace/ring_buffer.c:5936:66: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    5936 |                         cpu_buffer->head_page->list.prev->next = (struct list_head *)
         |                                                                  ^
   kernel/trace/ring_buffer.c:5939:44: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    5939 |                         bpage->list.next = (struct list_head *)((ulong)new_lhead | rb_page_head);
         |                                            ^
--
>> kernel/trace/ring_buffer.c:1783: warning: Function parameter or struct member 'tr_off' not described in '__ring_buffer_alloc'


vim +5936 kernel/trace/ring_buffer.c

  5896	
  5897	static int rb_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
  5898					     struct rb_kho_cpu *kho)
  5899	{
  5900		bool first_loop = true;
  5901		struct list_head *tmp;
  5902		int err = 0;
  5903		int i = 0;
  5904	
  5905		if (!IS_ENABLED(CONFIG_FTRACE_KHO))
  5906			return -EINVAL;
  5907	
  5908		if (kho->nr_mems != cpu_buffer->nr_pages * 2)
  5909			return -EINVAL;
  5910	
  5911		for (tmp = rb_list_head(cpu_buffer->pages);
  5912		     tmp != rb_list_head(cpu_buffer->pages) || first_loop;
  5913		     tmp = rb_list_head(tmp->next), first_loop = false) {
  5914			struct buffer_page *bpage = (struct buffer_page *)tmp;
  5915			const struct kho_mem *mem_bpage = &kho->mem[i++];
  5916			const struct kho_mem *mem_page = &kho->mem[i++];
  5917			const uint64_t rb_page_head = 1;
  5918			struct buffer_page *old_bpage;
  5919			void *old_page;
  5920	
  5921			old_bpage = __va(mem_bpage->addr);
  5922			if (!bpage)
  5923				goto out;
  5924	
  5925			if ((ulong)old_bpage->list.next & rb_page_head) {
  5926				struct list_head *new_lhead;
  5927				struct buffer_page *new_head;
  5928	
  5929				new_lhead = rb_list_head(bpage->list.next);
  5930				new_head = (struct buffer_page *)new_lhead;
  5931	
  5932				/* Assume the buffer is completely full */
  5933				cpu_buffer->tail_page = bpage;
  5934				cpu_buffer->commit_page = bpage;
  5935				/* Set the head pointers to what they were before */
> 5936				cpu_buffer->head_page->list.prev->next = (struct list_head *)
  5937					((ulong)cpu_buffer->head_page->list.prev->next & ~rb_page_head);
  5938				cpu_buffer->head_page = new_head;
  5939				bpage->list.next = (struct list_head *)((ulong)new_lhead | rb_page_head);
  5940			}
  5941	
  5942			if (rb_page_entries(old_bpage) || rb_page_write(old_bpage)) {
  5943				/*
  5944				 * We want to recycle the pre-kho page, it contains
  5945				 * trace data. To do so, we unreserve it and swap the
  5946				 * current data page with the pre-kho one
  5947				 */
  5948				old_page = kho_claim_mem(mem_page);
  5949	
  5950				/* Recycle the old page, it contains data */
  5951				free_page((ulong)bpage->page);
  5952				bpage->page = old_page;
  5953	
  5954				bpage->write = old_bpage->write;
  5955				bpage->entries = old_bpage->entries;
  5956				bpage->real_end = old_bpage->real_end;
  5957	
  5958				local_inc(&cpu_buffer->pages_touched);
  5959			} else {
  5960				kho_return_mem(mem_page);
  5961			}
  5962	
  5963			kho_return_mem(mem_bpage);
  5964		}
  5965	
  5966	out:
  5967		return err;
  5968	}
  5969	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
