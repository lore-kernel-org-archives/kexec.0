Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929C6C47DD3
	for <kexec@archiver.kernel.org>; Sun, 21 Jan 2024 01:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6q0fzCNuzQFBke02sUg7ahZGt2+xJdAV6pLjor136I8=; b=2koGweuoFlma4p
	Y1mdGwREDP80oZpzoNnoTCp5+MxDCPpZdSJl07zmu9O09mhqA3Z7Xhs/66EC/0++Zs87SBBVVOHMx
	bsHjoSPdYX4rOghYFSs5qIG61Sc7ZH3bNepgGgPrU5FSjyS/mi5o/5wJxncQ0QkCLO+SjM5jIXyEz
	RlGebIQtB/7wkxu3QGGNZOVA/hrbUEc1Gas0/XbEdpZ8cY8NZiUQVaj3h98rogDaBl2Dvv85s4k+R
	HM2KiAUvVslT3GHWlc6Is4/iSr4LuYHbV03oz7SdmvrnGLJmYMNzKB0bq4mMMhZewk3hEc6hx5Dqo
	12RogAbnb5dKUZeypr2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRN3v-008lbx-2Y;
	Sun, 21 Jan 2024 01:55:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRN3m-008la9-2E
	for kexec@lists.infradead.org;
	Sun, 21 Jan 2024 01:55:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705802141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn2lkxxGrsi3E9Vcx5NFx8RtBRe4v7W5psgsNCHmDng=;
	b=d07LVNOn7WUDixCOfE29g2Ra3e7B/3lI0av/u94OEiZXbhcjZIScgVsaLpMp7JYnzRhBmq
	GbEJbwZodTiRH24elrwDcF7NJ1QJnegywMgWANsuVJpj03PhxOqiJck8VsdYrgEsTmDH6X
	OkewgkWWyxNa6zClF4yF+8r7NufiA5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-1HnnZH15OaydAjxT0WE9tA-1; Sat, 20 Jan 2024 20:55:35 -0500
X-MC-Unique: 1HnnZH15OaydAjxT0WE9tA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A53885A588;
	Sun, 21 Jan 2024 01:55:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B83D651D5;
	Sun, 21 Jan 2024 01:55:33 +0000 (UTC)
Date: Sun, 21 Jan 2024 09:55:29 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	akpm@linux-foundation.org, ebiederm@xmission.com,
	hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 11/14] arm, crash: wrap crash dumping code into crash
 related ifdefs
Message-ID: <Zax5kXfiREk2bDbu@MiWiFi-R3L-srv>
References: <20240119145241.769622-12-bhe@redhat.com>
 <202401202057.aPg08Eh8-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202401202057.aPg08Eh8-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240120_175542_799679_F3004EB1 
X-CRM114-Status: GOOD (  21.14  )
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

On 01/20/24 at 08:13pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to tip/x86/core arm64/for-next/core powerpc/next powerpc/fixes v6.7 next-20240119]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec-split-crashkernel-reservation-code-out-from-crash_core-c/20240119-225820
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20240119145241.769622-12-bhe%40redhat.com
> patch subject: [PATCH v2 11/14] arm, crash: wrap crash dumping code into crash related ifdefs
> config: arm-randconfig-001-20240120 (https://download.01.org/0day-ci/archive/20240120/202401202057.aPg08Eh8-lkp@intel.com/config)
> compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d92ce344bf641e6bb025b41b3f1a77dd25e2b3e9)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401202057.aPg08Eh8-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401202057.aPg08Eh8-lkp@intel.com/

Thanks for reporting this, I can reproduce it.

In the provided config, it has:

# CONFIG_MMU is not set
and all kexec/kdump related config items are unset. 

The if (!IS_ENABLED(CONFIG_CRASH_RESERVE)) checking will cause funciton
reserve_crashkernel() is compiled, but not built in. With CONFIG_MMU=no,
SECTION_SIZE is undefined on arm. So fix it by wrapping up
reserve_crashkernel() inside CONFIG_CRASH_RESERVE ifdeffery scope.


From d580b65f6aa042233e228aab45609c3de88ab29e Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Mon, 15 Jan 2024 22:32:19 -0500
Subject: [PATCH] arm, crash: wrap crash dumping code into crash related ifdefs
Content-type: text/plain

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on arm with some adjustments.

Here use CONFIG_CRASH_RESERVE ifdef to replace CONFIG_KEXEC ifdef.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ff2299ce1ad7..7b33b157fca0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -979,7 +979,7 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_CRASH_RESERVE
 /*
  * The crash region must be aligned to 128MB to avoid
  * zImage relocating below the reserved region.
@@ -1066,7 +1066,7 @@ static void __init reserve_crashkernel(void)
 }
 #else
 static inline void reserve_crashkernel(void) {}
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_CRASH_RESERVE*/
 
 void __init hyp_mode_check(void)
 {
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
