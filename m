Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bL3ko-0000mL-E6
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 07:29:47 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: fix module init base and size offset for
 kernel v4.5
Date: Thu, 7 Jul 2016 07:26:33 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E50826@BPXM01GP.gisp.nec.co.jp>
References: <8140a1f8-55c9-b725-ba31-fc410527d201@linux.vnet.ibm.com>
In-Reply-To: <8140a1f8-55c9-b725-ba31-fc410527d201@linux.vnet.ibm.com>
Content-Language: ja-JP
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
To: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Guenther,

>Hello!
>
>This is a follow-up patch on the patch provided in post:
>
>"[PATCH] makedumpfile: fix module core base and size offset for kernel v4.5"
>by Pratyush Anand
>
>What is missing there is the changes that were done to the module_init entry
>of the struct module. The patch does basically the same as the patch for
>module_core adapted to module_init.

Thanks, I'll merge this patch into v1.6.1.

Regards,
Atsushi Kumagai

>Here is the patch:
>---
>Following commit in kernel v4.5 changed struct module, which affects offset
>calculation of core and init layout's base and size.
>
>commit 7523e4dc5057e157212b4741abd6256e03404cf1
>Author: Rusty Russell <rusty at rustcorp.com.au>
>Date:   Thu Nov 26 09:44:08 2015 +1030
>
>    module: use a structure to encapsulate layout.
>
>This patch fixes makedumpfile code to cater the module_init modification.
>
>Signed-off-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
>---
> makedumpfile.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 853b999..f33a90d 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -1689,7 +1689,25 @@ get_structure_info(void)
> 		OFFSET(module.core_size) += core_layout;
> 	}
> 	OFFSET_INIT(module.module_init, "module", "module_init");
>+	if (OFFSET(module.module_init) == NOT_FOUND_STRUCTURE) {
>+		/* for kernel version 4.5 and above */
>+		long init_layout;
>+
>+		OFFSET_INIT(module.module_init, "module", "init_layout");
>+		init_layout = OFFSET(module.module_init);
>+		OFFSET_INIT(module.module_init, "module_layout", "base");
>+		OFFSET(module.module_init) += init_layout;
>+	}
> 	OFFSET_INIT(module.init_size, "module", "init_size");
>+	if (OFFSET(module.init_size) == NOT_FOUND_STRUCTURE) {
>+		/* for kernel version 4.5 and above */
>+		long init_layout;
>+
>+		OFFSET_INIT(module.init_size, "module", "init_layout");
>+		init_layout = OFFSET(module.init_size);
>+		OFFSET_INIT(module.init_size, "module_layout", "size");
>+		OFFSET(module.init_size) += init_layout;
>+	}
>
> 	ENUM_NUMBER_INIT(NR_FREE_PAGES, "NR_FREE_PAGES");
> 	ENUM_NUMBER_INIT(N_ONLINE, "N_ONLINE");
>--
>2.6.6
>
>--
>Guenther Hutzl
>Linux on System z & Virtualization Development
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
