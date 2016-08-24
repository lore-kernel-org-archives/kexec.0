Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcgDW-0001te-Bi
 for kexec@lists.infradead.org; Wed, 24 Aug 2016 22:00:15 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7OLxl6E040972
 for <kexec@lists.infradead.org>; Wed, 24 Aug 2016 17:59:51 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 250pg9axjs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 24 Aug 2016 17:59:49 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 24 Aug 2016 18:59:28 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 70F0F3520072
 for <kexec@lists.infradead.org>; Wed, 24 Aug 2016 17:59:03 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7OLxP3W4882570
 for <kexec@lists.infradead.org>; Wed, 24 Aug 2016 18:59:25 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7OLxOow023572
 for <kexec@lists.infradead.org>; Wed, 24 Aug 2016 18:59:24 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [integrity:next-restore-kexec 21/31] kernel/kexec_core.c:780:10:
 warning: passing argument 1 of '__va' makes integer from pointer without a
 cast
Date: Wed, 24 Aug 2016 18:59:23 -0300
In-Reply-To: <201608232218.il5qUAgx%fengguang.wu@intel.com>
References: <201608232218.il5qUAgx%fengguang.wu@intel.com>
MIME-Version: 1.0
Message-Id: <14446997.EfN524sbRK@hactar>
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
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-ima-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, kexec@lists.infradead.org, kbuild-all@01.org

Am Dienstag, 23 August 2016, 22:44:19 schrieb kbuild test robot:
> tree:  
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> next-restore-kexec head:   62bc4b565254de4796a0835f6f67569eb4835f9f
> commit: d03a46a7730822305a2264c9defa21c06d4ff861 [21/31] kexec_file: Add
> mechanism to update kexec segments. config: m68k-sun3_defconfig (attached
> as .config)
> compiler: m68k-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget
> https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin
> /make.cross -O ~/bin/make.cross chmod +x ~/bin/make.cross
>         git checkout d03a46a7730822305a2264c9defa21c06d4ff861
>         # save the attached .config to linux build tree
>         make.cross ARCH=m68k
> 
> All warnings (new ones prefixed by >>):
> 
<snip>
>    kernel/kexec_core.c: In function 'kexec_update_segment':
> >> kernel/kexec_core.c:780:10: warning: passing argument 1 of '__va' makes
> >> integer from pointer without a cast
>        ptr = __va(addr);
>              ^
>    In file included from arch/m68k/include/asm/page.h:46:0,
>                     from arch/m68k/include/asm/thread_info.h:5,
>                     from include/linux/thread_info.h:54,
>                     from include/asm-generic/preempt.h:4,
>                     from ./arch/m68k/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:59,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/mmzone.h:7,
>                     from include/linux/gfp.h:5,
>                     from include/linux/mm.h:9,
>                     from kernel/kexec_core.c:12:
>    arch/m68k/include/asm/page_mm.h:105:21: note: expected 'long unsigned
> int' but argument is of type 'void *' static inline void *__va(unsigned
> long x)
>                         ^

This doesn't produce a warning on x86 and powerpc because on both arches 
__va is a macro which does a cast to unsigned long, but on m68k __va is a 
function expecting an unsigned long argument.

>    In file included from include/asm-generic/bug.h:13:0,
>                     from arch/m68k/include/asm/bug.h:28,
>                     from include/linux/bug.h:4,
>                     from include/linux/mmdebug.h:4,
>                     from include/linux/mm.h:8,
>                     from kernel/kexec_core.c:12:
>    include/linux/kernel.h:742:17: warning: comparison of distinct pointer
> types lacks a cast (void) (&_min1 == &_min2);  \
>                     ^
>    kernel/kexec_core.c:800:14: note: in expansion of macro 'min'
>         uchunk = min(bufsz, mchunk);
>                  ^

This is because bufsz is unsigned long but mchunk is size_t.

Both warnings are fixed by the changes below, which will be in my next 
revision of the kexec buffer hand-over series.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6ec09e85efd9..ea2e5a7b9b69 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -261,8 +261,8 @@ extern int kexec_purgatory_get_set_symbol(struct kimage *image,
 					  unsigned int size, bool get_value);
 extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 					     const char *name);
-int kexec_update_segment(const char *buffer, unsigned long bufsz,
-			 unsigned long load_addr, unsigned long memsz);
+int kexec_update_segment(const char *buffer, size_t bufsz,
+			 unsigned long load_addr, size_t memsz);
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3740235d6819..11ca5f8678df 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -732,8 +732,8 @@ static struct page *kimage_alloc_page(struct kimage *image,
  *
  * Return: 0 on success, negative errno on error.
  */
-int kexec_update_segment(const char *buffer, unsigned long bufsz,
-			 unsigned long load_addr, unsigned long memsz)
+int kexec_update_segment(const char *buffer, size_t bufsz,
+			 unsigned long load_addr, size_t memsz)
 {
 	int i;
 	unsigned long entry;
@@ -763,7 +763,7 @@ int kexec_update_segment(const char *buffer, unsigned long bufsz,
 			break;
 		}
 	if (i == kexec_image->nr_segments) {
-		pr_err("Couldn't find segment to update: 0x%lx, size 0x%lx\n",
+		pr_err("Couldn't find segment to update: 0x%lx, size 0x%zx\n",
 		       load_addr, memsz);
 		return -EINVAL;
 	}
@@ -777,7 +777,7 @@ int kexec_update_segment(const char *buffer, unsigned long bufsz,
 			dest = addr;
 			break;
 		case IND_INDIRECTION:
-			ptr = __va(addr);
+			ptr = __va(entry & PAGE_MASK);
 			break;
 		case IND_SOURCE:
 			/* Shouldn't happen, but verify just to be safe. */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
