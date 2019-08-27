Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2Rl3-0006aD-1Q
 for kexec@lists.infradead.org; Tue, 27 Aug 2019 03:02:58 +0000
Received: by mail-pl1-x643.google.com with SMTP id bj8so11020642plb.4
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 20:02:56 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv2 1/4] x86/apic: correct the ENO in generic_processor_info()
Date: Tue, 27 Aug 2019 11:02:20 +0800
Message-Id: <1566874943-4449-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qian Cai <cai@lca.pw>, Dave Young <dyoung@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>

When capped by nr_cpu_ids, the current code return -EINVAL or -ENODEV. It
is better to return -EINVAL for both cases.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f529136..f4f603a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2346,7 +2346,7 @@ int generic_processor_info(int apicid, int version)
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
 		disabled_cpus++;
-		return -ENODEV;
+		return -EINVAL;
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
