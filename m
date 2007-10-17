Return-path: <kexec-bounces@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.190])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IiCYg-0005wq-Vs
	for kexec@lists.infradead.org; Wed, 17 Oct 2007 18:19:56 +0100
Received: by rv-out-0910.google.com with SMTP id c24so1851639rvf
	for <kexec@lists.infradead.org>; Wed, 17 Oct 2007 10:19:19 -0700 (PDT)
Message-ID: <12c511ca0710171019t35cb1670k9e1bdcfb3bf99793@mail.gmail.com>
Date: Wed, 17 Oct 2007 10:19:18 -0700
From: "Tony Luck" <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] vmcoreinfo support for dump filtering
In-Reply-To: <20070822210838oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <20070822210838oomichi@mail.jp.nec.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

> This patch set frees the restriction that makedumpfile users should
> install a vmlinux file (including the debugging information) into
> each system.

This patch went from Andrew to Linus last night, and looks at first
glance to be the reason why the ia64 build is broken this morning
when using the arch/ia64/configs/tiger_defconfig configuration.

Here are the error messages:
arch/ia64/kernel/machine_kexec.c: In function `arch_crash_save_vmcoreinfo':
arch/ia64/kernel/machine_kexec.c:131: error: `pgdat_list' undeclared
(first use in this function)
arch/ia64/kernel/machine_kexec.c:131: error: (Each undeclared
identifier is reported only once
arch/ia64/kernel/machine_kexec.c:131: error: for each function it appears in.)
arch/ia64/kernel/machine_kexec.c:134: error: `node_memblk' undeclared
(first use in this function)
arch/ia64/kernel/machine_kexec.c:135: error: `NR_NODE_MEMBLKS'
undeclared (first use in this function)
arch/ia64/kernel/machine_kexec.c:136: error: invalid application of
`sizeof' to incomplete type `node_memblk_s'
arch/ia64/kernel/machine_kexec.c:137: error: dereferencing pointer to
incomplete type
arch/ia64/kernel/machine_kexec.c:138: error: dereferencing pointer to
incomplete type
make[1]: *** [arch/ia64/kernel/machine_kexec.o] Error 1

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
