Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UChR3-0001aZ-QP
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 02:16:58 +0000
Date: Tue, 5 Mar 2013 11:16:54 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: fix some compiler warnings
Message-ID: <20130305021654.GJ16128@verge.net.au>
References: <50D96423.8000606@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50D96423.8000606@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Dec 25, 2012 at 04:30:27PM +0800, Zhang Yanfei wrote:
> I got the following warnings when I compiled kexec-tools:
> 
> kexec/kexec-elf-rel.c: In function 'elf_rel_load':
> kexec/kexec-elf-rel.c:367: warning: format '%lx' expects type 'long unsigned int', but argument 6 has type 'unsigned int'
> kexec/kexec-elf-rel.c:367: warning: format '%lx' expects type 'long unsigned int', but argument 7 has type 'long long unsigned int'
> kexec/kexec-elf-rel.c:367: warning: format '%lx' expects type 'long unsigned int', but argument 8 has type 'long long unsigned int'
> kexec/arch/i386/crashdump-x86.c: In function 'get_kernel_paddr':
> kexec/arch/i386/crashdump-x86.c:99: warning: format '%016Lx' expects type 'long long unsigned int', but argument 3 has type 'uint64_t'
> kexec/arch/i386/crashdump-x86.c: In function 'get_kernel_vaddr_and_size':
> kexec/arch/i386/crashdump-x86.c:171: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'long long unsigned int'
> kexec/arch/i386/crashdump-x86.c: In function 'get_crash_notes':
> kexec/arch/i386/crashdump-x86.c:781: warning: format '%Lx' expects type 'long long unsigned int', but argument 3 has type 'uint64_t'
> kexec/arch/i386/crashdump-x86.c: In function 'load_crashdump_segments':
> kexec/arch/i386/crashdump-x86.c:905: warning: 'nr_ranges' may be used uninitialized in this function
> 
> The patch fix above warnings.

Thanks! Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
