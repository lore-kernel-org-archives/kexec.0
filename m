Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvX7S-0004KY-Ne
 for kexec@lists.infradead.org; Thu, 08 Aug 2019 01:21:32 +0000
Date: Thu, 8 Aug 2019 09:20:54 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/4] x86/smp: send capped cpus to a stable state when
 smp_init()
Message-ID: <201908080938.Rjv1ILYn%lkp@intel.com>
References: <1564995539-29609-4-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1564995539-29609-4-git-send-email-kernelfans@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Dave Hansen <dave.hansen@linux.intel.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, kbuild-all@01.org, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Masami Hiramatsu <mhiramat@kernel.org>

Hi Pingfan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc3 next-20190807]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/x86-mce-protect-nr_cpus-from-rebooting-by-broadcast-mce/20190806-101748
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   arch/x86/kernel/cpu/common.c:70:16: sparse: sparse: symbol '__cpu_capped_mask' was not declared. Should it be static?
>> arch/x86/kernel/cpu/common.c:72:16: sparse: sparse: symbol '__cpu_capped_done_mask' was not declared. Should it be static?
   arch/x86/kernel/cpu/common.c:138:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:139:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:140:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:141:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:168:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)
   arch/x86/kernel/cpu/common.c:169:43: sparse: sparse: cast truncates bits from constant value (fffff becomes ffff)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
