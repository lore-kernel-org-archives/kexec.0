Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89D7C07CA9
	for <kexec@archiver.kernel.org>; Sun, 26 Nov 2023 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ADD4EfER8m14MlLMQyvXZxTc8YoIH1tQtArX/lQ7VOk=; b=HiL3G/gAR0mVE4
	6hhihz3kMV/5KUSyzVBEYhJRxKcvgyvdFjvqEEy29v18jjM0K0qdb2zUKeNeUqXyCdLw54P6C9eWR
	LohGpvnj9Q60OYOOS3gD6DroWBU4nhZeGjyvDbbCHs8dlZO2bsZfV9ktwke0S/ao62PABd4rFCeFa
	aZXiriDIs1x2epZ8HV/iraTLO8QPbW2m7UEEFyuRrdMYTRS6MotslDvLX8YGyTbRjiRUdvizeVqy9
	2W0vM3VJHxyzAdKguHkPqm6Hpe9NsIxQ4ui+Msv5avWhYkNfRKAbxAkGcX02wmxhYNKgN2XdcmL34
	DEQNbiBudZXZsydBSXBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Dk1-00AwDV-3B;
	Sun, 26 Nov 2023 11:56:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Djt-00Aw9G-13
	for kexec@lists.infradead.org;
	Sun, 26 Nov 2023 11:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700999750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10f/Bul9KbIaMsjeanbNOmm62BHIxQH0eftSF3zeoHA=;
	b=IXiDeKM6E1pRz0aHXANjgB3J97HfSg2MI8kj1Qbv7ixMTk5kvOshWSH+1nfBzG9StVSS4L
	rx26h/szJb9S2etl8A60o5/n/QXs0LxaRslobBpTAlxWyK/mw1rNSIvbUJchrJKmPWu9F9
	CKfipjWZa3Nlz54iZdbEKhyDw31CuCw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-n79wBA5hOnSAQHO1OAsXyg-1; Sun,
 26 Nov 2023 06:55:45 -0500
X-MC-Unique: n79wBA5hOnSAQHO1OAsXyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90DF23C0C88A;
	Sun, 26 Nov 2023 11:55:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8B1340C6EB9;
	Sun, 26 Nov 2023 11:55:43 +0000 (UTC)
Date: Sun, 26 Nov 2023 19:55:40 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
	joe@perches.com, nathan@kernel.org, yujie.liu@intel.com
Subject: Re: [PATCH v2 4/7] kexec_file, arm64: print out debugging message if
 required
Message-ID: <ZWMyPB6HjxAczLzZ@MiWiFi-R3L-srv>
References: <20231124033642.520686-5-bhe@redhat.com>
 <202311260548.1HaxcDnE-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202311260548.1HaxcDnE-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_035553_586121_725BD078 
X-CRM114-Status: GOOD (  19.39  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/26/23 at 05:26am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc2 next-20231124]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231124-113942
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20231124033642.520686-5-bhe%40redhat.com
> patch subject: [PATCH v2 4/7] kexec_file, arm64: print out debugging message if required
> config: arm64-randconfig-001-20231126 (https://download.01.org/0day-ci/archive/20231126/202311260548.1HaxcDnE-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311260548.1HaxcDnE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311260548.1HaxcDnE-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm64/kernel/machine_kexec.c:35:2: error: implicit declaration of function 'kexec_dprintk' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>            kexec_dprintk("%s:%d:\n", func, line);
>            ^
>    1 error generated.

Thanks for reporting. It has below kexec related config items, whereas
the kexec_drpintk() is only defined in CONFIG_KEXEC_FILE ifdeffery
scope, moving it to CONFIG_KEXEC_CORE iddeffery scope in <linux/kexec.h>
can fix it as below draft code. Will update patch 1 to include the code
change.

===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
===

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 66997efe36f1..b457b0d70f3f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -265,13 +265,6 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 }
 #endif
 
-extern bool kexec_file_dbg_print;
-
-#define kexec_dprintk(fmt, ...)					\
-	printk("%s" fmt,					\
-	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
-	       ##__VA_ARGS__)
-
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
@@ -508,6 +501,13 @@ static inline int crash_hotplug_memory_support(void) { return 0; }
 static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 #endif
 
+extern bool kexec_file_dbg_print;
+
+#define kexec_dprintk(fmt, ...)					\
+	printk("%s" fmt,					\
+	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
+	       ##__VA_ARGS__)
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..bddba29a1557 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -52,6 +52,8 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
+bool kexec_file_dbg_print;
+
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 7ae1b0901aa4..8f87644b4eec 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,8 +38,6 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
-bool kexec_file_dbg_print;
-
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
