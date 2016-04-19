Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1asQJL-00068s-H5
 for kexec@lists.infradead.org; Tue, 19 Apr 2016 07:43:04 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: fix module core base and size offset for
 kernel v4.5
Date: Tue, 19 Apr 2016 07:41:11 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E3BBCE@BPXM01GP.gisp.nec.co.jp>
References: <ff5f22b5595d3801e8334a4e6b486838d499edc7.1460955261.git.panand@redhat.com>
In-Reply-To: <ff5f22b5595d3801e8334a4e6b486838d499edc7.1460955261.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Pratyush,

>Following commit in kernel v4.5 changed struct module, which affects offset
>calculation of core layout's base and size.
>
>commit 7523e4dc5057e157212b4741abd6256e03404cf1
>Author: Rusty Russell <rusty@rustcorp.com.au>
>Date:   Thu Nov 26 09:44:08 2015 +1030
>
>    module: use a structure to encapsulate layout.
>
>This patch fixes makedumpfile code to cater above kernel modification.
>
>Signed-off-by: Pratyush Anand <panand@redhat.com>

This patch fixes only the path for -x, but the symbols are only used for
--config(erase command) which requires vmlinux.
So we don't need to fix the VMCOREINFO path, I got it.

I'll merge this patch into v1.6.0, thanks.

Regards,
Atsushi Kumagai

>---
> makedumpfile.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 94c969c16ccc..12227ea1fbd8 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -1669,7 +1669,25 @@ get_structure_info(void)
> 	OFFSET_INIT(module.list, "module", "list");
> 	OFFSET_INIT(module.name, "module", "name");
> 	OFFSET_INIT(module.module_core, "module", "module_core");
>+	if (OFFSET(module.module_core) == NOT_FOUND_STRUCTURE) {
>+		/* for kernel version 4.5 and above */
>+		long core_layout;
>+
>+		OFFSET_INIT(module.module_core, "module", "core_layout");
>+		core_layout = OFFSET(module.module_core);
>+		OFFSET_INIT(module.module_core, "module_layout", "base");
>+		OFFSET(module.module_core) += core_layout;
>+	}
> 	OFFSET_INIT(module.core_size, "module", "core_size");
>+	if (OFFSET(module.core_size) == NOT_FOUND_STRUCTURE) {
>+		/* for kernel version 4.5 and above */
>+		long core_layout;
>+
>+		OFFSET_INIT(module.core_size, "module", "core_layout");
>+		core_layout = OFFSET(module.core_size);
>+		OFFSET_INIT(module.core_size, "module_layout", "size");
>+		OFFSET(module.core_size) += core_layout;
>+	}
> 	OFFSET_INIT(module.module_init, "module", "module_init");
> 	OFFSET_INIT(module.init_size, "module", "init_size");
>
>--
>2.5.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
