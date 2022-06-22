Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD2AC43334
	for <kexec@archiver.kernel.org>; Wed, 22 Jun 2022 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VrFq9Yih36qQJHJiRLvu32xzMmnTWZUBrBCDGvsh2SQ=; b=gvwkmOEFZkUZQ5
	Pnw0/+n7C8Q9YS5AF7nkQdGUYaQ+t7OUSqwcZ+acPY1jmLNJwjTHgpZKo3VXvwpXgdyWZCeTDFv9T
	UnTmm1L/oSuoy9FwT0v+Aau8PTpmkPUcflNBesinqwVCML/MA2Iqk6xBchUqQrsAhwuyurOfKV69G
	zy6SJvAaFkVjkyYmL2mvUgeASHgdAAINr/7S8NXPJxRBJFDekkyqZ9PYnpL7rFANC0K71oNRHbUaY
	aUhZPWBpPf+99wBqNmkzJtgXFLZQOUadefALhvIxhqdpvYvVBqM3JGxWsb8SrygKsPspIZJpGNF0K
	hHqzi3HL4VlnC0vXpf8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Up-00BEOe-S4; Wed, 22 Jun 2022 15:42:23 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o42Um-00BEKv-4S
	for kexec@lists.infradead.org; Wed, 22 Jun 2022 15:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655912540; x=1687448540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asHJVhWeV+R8cmVwvDLScqFgc1cDRCkZ63VeXkC61AY=;
  b=QMyOC/LSpk3sYyYONjHBPSlidTuo8xHr+TWEH+5eGExKziSf144ST8VS
   uZqd35UJcC6huvHENBKq6wWhZs0W3Y5GgDCpGTHGyzNb4Dw2AOF/zkoU6
   tMkqcoQQJDweZDzP5744btyhSwjkw1DxWVljSqiLn4yITwJXR8pPDqW9q
   6zeTgZ+6LB6Rw9hyKKJc6nKp/SaY0jP46213/H86X5Nle86zaoa8hEyf+
   CsZIHAMddcHVPgRXqF74dpmY+/f8vlQo4en28CyRsVh0gX6d4U8SAix7h
   hmIEdL1VKiPohEWW4OpKdWwSxpIUwrvRnTuMfDomioIXvOa+RWc78EIGJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279220694"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="279220694"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 08:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="538513263"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 08:34:51 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o42NW-0001QG-QX;
	Wed, 22 Jun 2022 15:34:50 +0000
Date: Wed, 22 Jun 2022 23:34:47 +0800
From: kernel test robot <lkp@intel.com>
To: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-rt-users@vger.kernel.org
Cc: kbuild-all@lists.01.org, Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <202206222322.WsTIFQGo-lkp@intel.com>
References: <20220616123709.347053-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616123709.347053-1-vschneid@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_084220_259848_E6470953 
X-CRM114-Status: GOOD (  13.64  )
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

Hi Valentin,

I love your patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v5.19-rc3 next-20220622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Valentin-Schneider/panic-kexec-Don-t-mutex_trylock-in-__crash_kexec/20220616-203915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: riscv-randconfig-c024-20220622 (https://download.01.org/0day-ci/archive/20220622/202206222322.WsTIFQGo-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d05873bf87d81eb3ddfa1fe20b3743cc4a1ab259
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Valentin-Schneider/panic-kexec-Don-t-mutex_trylock-in-__crash_kexec/20220616-203915
        git checkout d05873bf87d81eb3ddfa1fe20b3743cc4a1ab259
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_crash_copy_vmcoreinfo':
   kernel/kexec_core.c:502: undefined reference to `machine_kexec_cleanup'
   riscv64-linux-ld: kernel/kexec_core.o: in function `clear_bit':
>> arch/riscv/include/asm/bitops.h:129: undefined reference to `machine_crash_shutdown'
   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_free_pages':
   kernel/kexec_core.c:337: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_free':
   kernel/kexec_core.c:651: undefined reference to `riscv_crash_save_regs'
   riscv64-linux-ld: kernel/kexec_core.o: in function `__nr_to_section':
   include/linux/mmzone.h:1403: undefined reference to `machine_shutdown'
   riscv64-linux-ld: include/linux/mmzone.h:1403: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_file.o: in function `__section_mem_map_addr':
   include/linux/mmzone.h:1434: undefined reference to `machine_kexec_prepare'


vim +129 arch/riscv/include/asm/bitops.h

fab957c11efe2f Palmer Dabbelt 2017-07-10  117  
fab957c11efe2f Palmer Dabbelt 2017-07-10  118  /**
fab957c11efe2f Palmer Dabbelt 2017-07-10  119   * clear_bit - Clears a bit in memory
fab957c11efe2f Palmer Dabbelt 2017-07-10  120   * @nr: Bit to clear
fab957c11efe2f Palmer Dabbelt 2017-07-10  121   * @addr: Address to start counting from
fab957c11efe2f Palmer Dabbelt 2017-07-10  122   *
fab957c11efe2f Palmer Dabbelt 2017-07-10  123   * Note: there are no guarantees that this function will not be reordered
fab957c11efe2f Palmer Dabbelt 2017-07-10  124   * on non x86 architectures, so if you are writing portable code,
fab957c11efe2f Palmer Dabbelt 2017-07-10  125   * make sure not to rely on its reordering guarantees.
fab957c11efe2f Palmer Dabbelt 2017-07-10  126   */
fab957c11efe2f Palmer Dabbelt 2017-07-10  127  static inline void clear_bit(int nr, volatile unsigned long *addr)
fab957c11efe2f Palmer Dabbelt 2017-07-10  128  {
fab957c11efe2f Palmer Dabbelt 2017-07-10 @129  	__op_bit(and, __NOT, nr, addr);
fab957c11efe2f Palmer Dabbelt 2017-07-10  130  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  131  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
