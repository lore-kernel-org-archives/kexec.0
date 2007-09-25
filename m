Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ia66n-0007lP-2O
	for kexec@lists.infradead.org; Tue, 25 Sep 2007 04:49:35 -0400
Message-Id: <46F8CB88.10905@mxs.nes.nec.co.jp>
Date: Tue, 25 Sep 2007 17:49:12 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH 5/4] [-mm patch] Rename macros returning the size.
References: <46E9F6A9.8060500@mxs.nes.nec.co.jp>	<46E9F942.5070007@mxs.nes.nec.co.jp>	<20070914190350.011cdadb.akpm@linux-foundation.org>	<46F204FD.6040303@mxs.nes.nec.co.jp>	<46F2056E.6080601@mxs.nes.nec.co.jp>
	<alpine.LFD.0.999.0709201746090.17093@enigma.security.iitk.ac.in>
In-Reply-To: <alpine.LFD.0.999.0709201746090.17093@enigma.security.iitk.ac.in>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Satyam Sharma <satyam@infradead.org>
Cc: Adrian Bunk <bunk@kernel.org>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>


Hi Satyam,

Satyam Sharma wrote:
> > On Thu, 20 Sep 2007, Ken'ichi Ohmichi wrote:
>> >> [PATCH 5/4] [-mm patch] Rename macros returning the size.
>> >>  The #define SIZE() should be renamed STRUCT_SIZE() since it's always 
>> >>  returning the size of the struct with a given name.  This would allow 
>> >>  TYPEDEF_SIZE() to simply become SIZE() since it need not be used 
>> >>  exclusively for typedefs. This idea is David Rientjes's.
>> >>  http://www.ussg.iu.edu/hypermail/linux/kernel/0709.1/1964.html
>> >>
>> >> Thanks
>> >> Ken'ichi Ohmichi
>> >>
>> >> ---
>> >> Signed-off-by: David Rientjes <rientjes@google.com>
> > 
> > Hmm, I think adding a s-o-b line for David here isn't quite correct.
> > When someone reviews a patch and gives a suggestion, you only need to
> > copy him on the next iteration (and he may ack it or whatever, if he
> > wants) -- but adding a s-o-b line like that ends up (incorrectly)
> > denoting that he came between the author-to-git-commit chain ...

Thank you for kind explanation.
I can understand s-o-b clearly.


>> >> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> > 
>> >> --- a/include/linux/kexec.h	2007-09-18 15:22:19.000000000 +0900
>> >> +++ b/include/linux/kexec.h	2007-09-18 15:23:22.000000000 +0900
>> >> @@ -131,10 +131,10 @@ unsigned long paddr_vmcoreinfo_note(void
>> >>  	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
>> >>  #define VMCOREINFO_SIZE(name) \
>> >>  	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
>> >> -			      (unsigned long)sizeof(struct name))
>> >> -#define VMCOREINFO_TYPEDEF_SIZE(name) \
>> >> -	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
>> >>  			      (unsigned long)sizeof(name))
>> >> +#define VMCOREINFO_STRUCT_SIZE(name) \
>> >> +	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
>> >> +			      (unsigned long)sizeof(struct name))
>> >>  #define VMCOREINFO_OFFSET(name, field) \
>> >>  	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
>> >>  			      (unsigned long)&(((struct name *)0)->field))
> > 
> > Please use %zu and lose all the ugly (unsigned long) casts here.

That sounds good.
I updated the patch according to your comment.


Thanks
Ken'ichi Ohmichi 

---
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Acked-by: David Rientjes <rientjes@google.com>

---
diff -rpuN a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
--- a/arch/ia64/kernel/machine_kexec.c	2007-09-21 09:25:35.000000000 +0900
+++ b/arch/ia64/kernel/machine_kexec.c	2007-09-21 09:26:13.000000000 +0900
@@ -137,7 +137,7 @@ void arch_crash_save_vmcoreinfo(void)
 
 	VMCOREINFO_SYMBOL(node_memblk);
 	VMCOREINFO_LENGTH(node_memblk, NR_NODE_MEMBLKS);
-	VMCOREINFO_SIZE(node_memblk_s);
+	VMCOREINFO_STRUCT_SIZE(node_memblk_s);
 	VMCOREINFO_OFFSET(node_memblk_s, start_paddr);
 	VMCOREINFO_OFFSET(node_memblk_s, size);
 #endif
diff -rpuN a/include/linux/kexec.h b/include/linux/kexec.h
--- a/include/linux/kexec.h	2007-09-21 09:25:32.000000000 +0900
+++ b/include/linux/kexec.h	2007-09-21 09:27:23.000000000 +0900
@@ -130,11 +130,9 @@ unsigned long paddr_vmcoreinfo_note(void
 #define VMCOREINFO_SYMBOL(name) \
 	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
 #define VMCOREINFO_SIZE(name) \
-	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
-			      (unsigned long)sizeof(struct name))
-#define VMCOREINFO_TYPEDEF_SIZE(name) \
-	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
-			      (unsigned long)sizeof(name))
+	vmcoreinfo_append_str("SIZE(%s)=%zu\n", #name, sizeof(name))
+#define VMCOREINFO_STRUCT_SIZE(name) \
+	vmcoreinfo_append_str("SIZE(%s)=%zu\n", #name, sizeof(struct name))
 #define VMCOREINFO_OFFSET(name, field) \
 	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
 			      (unsigned long)&(((struct name *)0)->field))
diff -rpuN a/kernel/kexec.c b/kernel/kexec.c
--- a/kernel/kexec.c	2007-09-21 09:25:27.000000000 +0900
+++ b/kernel/kexec.c	2007-09-21 09:26:13.000000000 +0900
@@ -1210,15 +1210,15 @@ static int __init crash_save_vmcoreinfo_
 #ifdef CONFIG_SPARSEMEM
 	VMCOREINFO_SYMBOL(mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
-	VMCOREINFO_SIZE(mem_section);
+	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
 #endif
-	VMCOREINFO_SIZE(page);
-	VMCOREINFO_SIZE(pglist_data);
-	VMCOREINFO_SIZE(zone);
-	VMCOREINFO_SIZE(free_area);
-	VMCOREINFO_SIZE(list_head);
-	VMCOREINFO_TYPEDEF_SIZE(nodemask_t);
+	VMCOREINFO_STRUCT_SIZE(page);
+	VMCOREINFO_STRUCT_SIZE(pglist_data);
+	VMCOREINFO_STRUCT_SIZE(zone);
+	VMCOREINFO_STRUCT_SIZE(free_area);
+	VMCOREINFO_STRUCT_SIZE(list_head);
+	VMCOREINFO_SIZE(nodemask_t);
 	VMCOREINFO_OFFSET(page, flags);
 	VMCOREINFO_OFFSET(page, _count);
 	VMCOREINFO_OFFSET(page, mapping);
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
