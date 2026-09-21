Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5384C982F6
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gl9dOVAVG56ScS9MwUOL4momh5UtqrFy6pN1ShFcuZM=; b=dz84ZrAgiS9M4TecZ9woqEMXnm
	WSj7JKspIrcooYPJ4o7AuMIm/dBDZf4GDzoCAvPXKBy1fyd9nXSXKaRWaOP3Ct3L1jAIG0UcNW2g2
	UftETso5q5ZY7eavbXYeht+0ELEQie8OK0KqZlIYcWzvz3S4pXQqg3qNUZTbNUKecw4aEy8TJ1sQh
	y3TW41f8TbrDg3T0ExnglpJa+avR99LfqM8Sm8JWk/StO4uOqMl1o5pwANzaGyU884gavdKYXBeBM
	nSVm66rDePYxSELzPxJKgn6bTqGVx63rlaaIEMs9LyC79eb+p9UlBeJforqtMwonLK1XHG3l9DZtw
	wVtphmWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad6-00000001ZUA-4B5K;
	Mon, 21 Sep 2026 09:48:08 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Zwj-00000001ROe-3mC5;
	Mon, 21 Sep 2026 09:04:23 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gl9dOVAVG56ScS9MwUOL4momh5UtqrFy6pN1ShFcuZM=;
	b=wVs/Hs9Gq6VG/cWAMpWvzJmy/oIAMsdmFRrHLaMN8dhT/208NNm+Jy57C8JdLMxP37J0PUlpB
	GvTnqbaNF3Y1buLGfFQc0tAbMgmC9XUKdLppSMLKPgLCRodGAQm9QZNfIEVZADGVfpSUfrMTgAo
	355Yjh2Bx4bZrE0WgEv0YQ0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hpH6N5yyJzRhjW;
	Mon, 21 Sep 2026 16:52:12 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F7142011D;
	Mon, 21 Sep 2026 17:04:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:04:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 09/14] x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
Date: Mon, 21 Sep 2026 17:04:45 +0800
Message-ID: <20260921090450.807575-10-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_020422_253402_8261B94C 
X-CRM114-Status: GOOD (  13.58  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
4KB page. However, the elfcorehdr segment can span several pages (up to
hundreds of kilobytes).

The original code blindly copies 'elfsz' bytes at once via
memcpy_flushcache(), overwriting adjacent fixmap entries or critical
virtual addresses.

Fix this by copying the new elfcorehdr page by page.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Chao Gao <chao.gao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e681ec9cf1dc..3c9f4fbbe7ff 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -447,9 +447,10 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
  */
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
-	void *elfbuf = NULL, *old_elfcorehdr;
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long done;
 
 	/*
 	 * As crash_prepare_elf64_headers() has already described all
@@ -484,21 +485,20 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 
 	/*
 	 * Copy new elfcorehdr over the old elfcorehdr at destination.
-	 */
-	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
-	if (!old_elfcorehdr) {
-		pr_err("mapping elfcorehdr segment failed\n");
-		goto out;
-	}
-
-	/*
-	 * Temporarily invalidate the crash image while the
-	 * elfcorehdr is updated.
+	 * The segment is physically contiguous but can span several pages.
+	 * On 32-bit Highmem architectures, kmap_local_page() maps only a
+	 * single page at a time, so copy page by page.
 	 */
 	xchg(&kexec_crash_image, NULL);
-	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	for (done = 0; done < elfsz; ) {
+		size_t chunk = min_t(size_t, PAGE_SIZE, elfsz - done);
+		void *dst = kmap_local_page(pfn_to_page((mem + done) >> PAGE_SHIFT));
+
+		memcpy_flushcache(dst, elfbuf + done, chunk);
+		kunmap_local(dst);
+		done += chunk;
+	}
 	xchg(&kexec_crash_image, image);
-	kunmap_local(old_elfcorehdr);
 	pr_debug("updated elfcorehdr\n");
 
 out:
-- 
2.34.1


