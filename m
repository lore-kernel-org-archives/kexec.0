Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTPt-007vcx-HX
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 12:05:47 +0000
Date: Thu, 8 Apr 2021 14:05:33 +0200
From: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v3 02/12] buildid: Stash away kernels build ID on init
Message-ID: <YG7xjbIEmrCco14F@gunter>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331030520.3816265-3-swboyd@chromium.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

+++ Stephen Boyd [30/03/21 20:05 -0700]:
[snipped]
>diff --git a/lib/buildid.c b/lib/buildid.c
>index 010ab0674cb9..b939bbc59233 100644
>--- a/lib/buildid.c
>+++ b/lib/buildid.c
>@@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
>
> #include <linux/buildid.h>
>+#include <linux/cache.h>
> #include <linux/elf.h>
> #include <linux/kernel.h>
> #include <linux/pagemap.h>
>@@ -171,3 +172,19 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
> {
> 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
> }
>+
>+unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
>+
>+/**
>+ * init_vmlinux_build_id - Get the running kernel's build ID
>+ *
>+ * Return: Running kernel's build ID
>+ */

Hm, init_vmlinux_build_id() doesn't return anything, so this comment is
not accurate - maybe "Get the running kernel's build ID and store it in
vmlinux_build_id"?

>+void __init init_vmlinux_build_id(void)
>+{
>+	extern const void __start_notes __weak;
>+	extern const void __stop_notes __weak;
>+	unsigned int size = &__stop_notes - &__start_notes;
>+
>+	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
>+}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
