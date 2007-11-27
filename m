Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Iwwt0-0000sF-SF
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 09:37:53 +0000
Message-Id: <474BE583.2080000@mxs.nes.nec.co.jp>
Date: Tue, 27 Nov 2007 18:38:11 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] Fix the configuration dependencies
References: <473CFE14.3010400@mxs.nes.nec.co.jp>	<473D0170.1060304@mxs.nes.nec.co.jp>
	<20071125235843.69440d4a.akpm@linux-foundation.org>
In-Reply-To: <20071125235843.69440d4a.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1735099709=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>

--===============1735099709==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Andrew,

Andrew Morton wrote:
>> diff -rpuN a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> --- a/arch/x86/kernel/machine_kexec_64.c	2007-11-14 15:39:19.000000000 +0900
>> +++ b/arch/x86/kernel/machine_kexec_64.c	2007-11-14 15:39:33.000000000 +0900
>> @@ -235,7 +235,7 @@ void arch_crash_save_vmcoreinfo(void)
>>  {
>>  	VMCOREINFO_SYMBOL(init_level4_pgt);
>>  
>> -#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
>> +#ifdef CONFIG_NUMA
>>  	VMCOREINFO_SYMBOL(node_data);
>>  	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
>>  #endif
>> _
>>
> 
> x86_64-make-sparsemem-vmemmap-the-default-memory-model-v2.patch removes the
> `VMCOREINFO_SYMBOL(node_data);' from arch/x86/kernel/machine_kexec_64.c
> altogether, so I dropped that part of your patch.

The above part is necessary for a NUMA kernel.
Could you please merge the attached patch ?

I guess that Christoph Lameter deleted the above part (which is added
by the attached patch again) with the other part of discontigmem lines,
because it depended on CONFIG_ARCH_DISCONTIGMEM_ENABLE.
But the dependency was wrong, and it should depend on CONFIG_NUMA.
The part is necessary for a NUMA kernel even if sparsemem.


Thanks
Ken'ichi Ohmichi

---
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
--- a/arch/x86/kernel/machine_kexec_64.c	2007-11-27 13:36:32.000000000 +0900
+++ b/arch/x86/kernel/machine_kexec_64.c	2007-11-27 13:37:37.000000000 +0900
@@ -234,5 +234,10 @@ NORET_TYPE void machine_kexec(struct kim
 void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_SYMBOL(init_level4_pgt);
+
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
 }
 
_


--===============1735099709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1735099709==--
