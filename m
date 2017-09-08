Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dq95k-0004mM-QC
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 02:32:26 +0000
Received: by mail-pg0-x233.google.com with SMTP id m9so2612443pgd.3
 for <kexec@lists.infradead.org>; Thu, 07 Sep 2017 19:32:04 -0700 (PDT)
Date: Fri, 8 Sep 2017 11:33:47 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 03/14] resource: add walk_system_ram_res_rev()
Message-ID: <20170908023347.GB17186@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-4-takahiro.akashi@linaro.org>
 <5b6a0f9a-839a-ed57-e78e-88dbc9a7361c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b6a0f9a-839a-ed57-e78e-88dbc9a7361c@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Thu, Aug 31, 2017 at 08:04:51AM +0530, Pratyush Anand wrote:
> 
> 
> On Thursday 24 August 2017 01:48 PM, AKASHI Takahiro wrote:
> >This function, being a variant of walk_system_ram_res() introduced in
> >commit 8c86e70acead ("resource: provide new functions to walk through
> >resources"), walks through a list of all the resources of System RAM
> >in reversed order, i.e., from higher to lower.
> >
> >It will be used in kexec_file implementation on arm64.
> >
> >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >Cc: Vivek Goyal <vgoyal@redhat.com>
> >Cc: Andrew Morton <akpm@linux-foundation.org>
> >Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >---
> >  include/linux/ioport.h |  3 +++
> >  kernel/resource.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> >
> >diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> >index 6230064d7f95..9a212266299f 100644
> >--- a/include/linux/ioport.h
> >+++ b/include/linux/ioport.h
> >@@ -271,6 +271,9 @@ extern int
> >  walk_system_ram_res(u64 start, u64 end, void *arg,
> >  		    int (*func)(u64, u64, void *));
> >  extern int
> >+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> >+			int (*func)(u64, u64, void *));
> >+extern int
> >  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
> >  		    void *arg, int (*func)(u64, u64, void *));
> >diff --git a/kernel/resource.c b/kernel/resource.c
> >index 9b5f04404152..1d6d734c75ac 100644
> >--- a/kernel/resource.c
> >+++ b/kernel/resource.c
> >@@ -23,6 +23,7 @@
> >  #include <linux/pfn.h>
> >  #include <linux/mm.h>
> >  #include <linux/resource_ext.h>
> >+#include <linux/vmalloc.h>
> >  #include <asm/io.h>
> >@@ -469,6 +470,53 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
> >  	return ret;
> >  }
> >+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> >+				int (*func)(u64, u64, void *))
> >+{
> >+	struct resource res, *rams;
> >+	u64 orig_end;
> >+	int count, i;
> >+	int ret = -1;
> >+
> >+	count = 16; /* initial */
> >+again:
> >+	/* create a list */
> >+	rams = vmalloc(sizeof(struct resource) * count);
> >+	if (!rams)
> >+		return ret;
> >+
> >+	res.start = start;
> >+	res.end = end;
> >+	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >+	orig_end = res.end;
> >+	i = 0;
> >+	while ((res.start < res.end) &&
> >+		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> >+		if (i >= count) {
> >+			/* unlikely but */
> >+			vfree(rams);
> >+			count += 16;
> >+			goto again;
> 
> Wounld't it be better to re-alloc a bigger space,copy previous values and
> free the previous pointer, instead of going *again*.

Okey, I will do that.

Thanks,
-Takahiro AKASHI

> >+		}
> >+
> >+		rams[i].start = res.start;
> >+		rams[i++].end = res.end;
> >+
> >+		res.start = res.end + 1;
> >+		res.end = orig_end;
> >+	}
> >+
> >+	/* go reverse */
> >+	for (i--; i >= 0; i--) {
> >+		ret = (*func)(rams[i].start, rams[i].end, arg);
> >+		if (ret)
> >+			break;
> >+	}
> >+
> >+	vfree(rams);
> >+	return ret;
> >+}
> >+
> >  #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
> >  /*
> >
> 
> -- 
> Regards
> Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
