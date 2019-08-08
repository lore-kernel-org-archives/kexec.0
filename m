Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvX7U-0004KY-GP
 for kexec@lists.infradead.org; Thu, 08 Aug 2019 01:21:33 +0000
Date: Thu, 8 Aug 2019 09:20:55 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] x86/smp: __cpu_capped_done_mask can be static
Message-ID: <20190808012055.dl3ay6ksmpkja7z4@48261080c7f1>
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


Fixes: 946eeafe59c7 ("x86/smp: send capped cpus to a stable state when smp_init()")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1a62b37a36256..00374883fb842 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -69,7 +69,7 @@ cpumask_var_t cpu_callin_mask;
 /* size of NR_CPUS is required. */
 struct cpumask __cpu_capped_mask __initdata;
 struct cpumask *cpu_capped_mask;
-struct cpumask __cpu_capped_done_mask __initdata;
+static struct cpumask __cpu_capped_done_mask __initdata;
 struct cpumask *cpu_capped_done_mask;
 
 /* representing cpus for which sibling maps can be computed */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
