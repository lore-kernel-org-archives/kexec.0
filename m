Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIOBB-000832-15
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 18:56:06 +0000
Received: by mail-pb0-f44.google.com with SMTP id wz12so1598581pbc.3
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 11:56:03 -0700 (PDT)
Date: Wed, 20 Mar 2013 11:56:01 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: linux-next: Tree for Mar 20 (vmcore)
In-Reply-To: <5149E813.8060307@infradead.org>
Message-ID: <alpine.DEB.2.02.1303201153330.17761@chino.kir.corp.google.com>
References: <20130320160536.54e62fc11a3651494b710e3b@canb.auug.org.au>
 <5149E813.8060307@infradead.org>
MIME-Version: 1.0
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
To: Randy Dunlap <rdunlap@infradead.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 20 Mar 2013, Randy Dunlap wrote:

> on x86_64:
> 
> fs/proc/vmcore.c: In function 'merge_note_headers_elf64':
> fs/proc/vmcore.c:349:22: error: 'VMCOREINFO_NOTE_NAME' undeclared (first use in this function)
> fs/proc/vmcore.c:349:22: note: each undeclared identifier is reported only once for each function it appears in
> fs/proc/vmcore.c: In function 'merge_note_headers_elf32':
> fs/proc/vmcore.c:470:22: error: 'VMCOREINFO_NOTE_NAME' undeclared (first use in this function)
> make[3]: *** [fs/proc/vmcore.o] Error 1
> 
> 
> Needs to #include <linux/kexec.h>
> 

I don't think that's it, linux/kexec.h already gets included indirectly.  
The problem is that CONFIG_KEXEC isn't set so the definition in kexec.h is 
meaningless.

This comes from "vmcore: check NT_VMCORE_PAD as a mark indicating the end 
of ELF note buffer" merged through the -mm tree.  I've added the patch's 
author and Andrew to the cc.

How can this be protected by CONFIG_KEXEC?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
