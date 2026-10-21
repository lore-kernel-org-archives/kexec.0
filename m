Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6B606A31E
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZW93xVZ2;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=kE5TXMBj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cOBRSbbL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=; b=ZW93xVZ2qSTwmQXN0k5Yf9bWbz
	TJ9Qf98ED8fSjMQdYAZKECO0ihjzZ6qsXwOMuNQl62CjEbdPytoz8hOb4DDjB13lz35I6hFGt4gTL
	FEQVDflRpwfTrBNajmLKs4Zk/MwNwN5Gxk3R7k04QaiQ8baMGlNoDBtMXqd49rEsGAwyucZfTZQYh
	xIUpfb7yEtsNs9oVxpfD7X37Pe9ZUzwcik6IlsdLiI/rg9TuqDMCdsOPumCRql7f2B1Gxda2KGxAT
	k0JWjNVUoTA04CCToqIuCUqmyo6jZNk+igIq0Xe7uYbf0xJ0bSjOou/EA0qVmh/tB4PP5yvCwV6Y9
	xCwaRgMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRjG-0000000BMU2-2VMq;
	Wed, 21 Oct 2026 08:31:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRjD-0000000BMSE-01RA
	for kexec@bombadil.infradead.org;
	Wed, 21 Oct 2026 08:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=; b=kE5TXMBjT5p0GIYzdHq2PH/Sx2
	l0B9UrNfK12qUMFjBIsz+xisbfdd8+diutumTNVpGeOu28WzP4ApkJnrvOpxtXcYNudTOQM+UW/KF
	FjZmL4OeSXCO6HH1bQNgW2REzGf6utHM+CAk8mh7hI9B3itEqA6dhWiVNPlIt9TOPrzUf7OpRbPbr
	SbU57UFFlu5gGMPysBLrtHdc/AdSY6vjg36SxGZKYd9Y/MsymovfI6DUjqJCXkykIpWL7vx7LbZat
	JOT3nrMsDqojMA3WXtdP8x7bI2CozB1XjB2X+6nqgdNKcFjKqwGVMl2CVGdJ5nNGOMzlWRgpRH3Ds
	vGXFpOFA==;
Received: from mail-pz2-x0a.google.com ([2607:f8b0:4864:3b::a])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJRj9-00000005b5b-2snR
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 08:31:17 +0000
Received: by mail-pz2-x0a.google.com with SMTP id 41be03b00d2f7-cd5cd8e8104so19941a12.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571473; x=1793176273; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=cOBRSbbLoZam2J2QqCZUNZ7A6cMrs+cqETxK4Z075SwMmBhguM0juJEaChAppJP+4y
         C1P9MJUXyxwjWNwv8R8izoxxsTJpRRSK0PegyPmcF5f7yt6+rmmHFuH0MbrbUUVLumxn
         rMJLXgW6QJdiz02tWiTvJ6X7A1yPxCP8j+TwHtBcogb6g4aRuH+yon9FIsHm0qHo8RqD
         teYuyk/W2oE0YKgESqya/lygSFEiP+0h0hv0aa3BgEccgvckh6DlFisokCkYg3tqX0Di
         9dSg5JfSnj8uj7+3oYc5blTUjVS19YD7zMoU84UKHuRNoAuAEqD9tfDdv6NUYFj8XTY6
         2hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571473; x=1793176273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=vhfqbF2LYeKOsTpa+30TWlwy60GF31jLEZfrNBQ+PYthwgPNgDN6lor1UrrjJkGvew
         UDHKByJpHWMugjHe1z93zbDMwySPdfOawj2CJ/DA2qw7Elymu/XKORFKx1Xf6t43H9t5
         ojQ+B1lrJjnNYVw0oZdSSvRvdfL47IVYwYj7paKzWmJk7sGFPftzJMtDafIPmoxiCRqW
         vjCSmOOGAHaWux8UAf1T3wd08Z9E4HOhLJvs/9y1cbWS0jGewcOiE+s7/skhfoD1zSvK
         ftj1WkCjGjbDKn44IKQ3CTdbOFBv8mba8J7kLPya6t3nEPlySr1OcnEX15CQGLzzocg1
         BxzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKq6yz5mPKzKN2Kj1JDlvehoj33vMhcvDlMb7bCIdSqYr7cmIghUgDeplP2fJJuwJbT41ggg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLxrdZhIeTk8ZB7lrXvmhEdVBSTaKaED+B9YQ2ytN962iSuTPLw
	Fycjh0yF1Z0JVHI9wUFuyjIPP6uEXmCUf0b2mIiayhgFeBfewhtigbzP
X-Gm-Gg: AYBFou0mVbMSLC4yDnr8V4vAyiAluvKS/yN0OYaFgbIfgNsKkbUFdQ0fr5j+uMpP2uY
	sklgKRrGSkF4HPSGO3B0lVke3MTComVi6j3Xybd+lLXxgUSKb2QeA018qVmm0HGKsAOBJciKazP
	ambmbO/+2RQiMosX1DSWFVDmt+/54+y4nU5tLVnJvRVrtZYbTxloXj2wg7fymCDZhcw28sJAH0e
	vgMVvS+72Ycq5xobiwJuDjcPQHDfC8xYLpEI+YBqGBAydH5hBYLVd6RZP3UYbi+6XpnxBi+LnzM
	sDT7pFfmxokDeIQiAdqdM3VWPYZkLuEFJdo1AcLKdzge0lADAoKOUUz5IqESwKfw0uauzX1Iisa
	gE5qhGDzKSjoTz9c6gQh0zl+mYCVbkjmQ/J4GYQMVCRFbXkB4Yv39YROFHcjFfitPYv96hbes2d
	GKH9w/qq+U+VMDzZ084QYaKeYCchY37OxtBcPjwcnTqNRuK99Dq1baDJcsC7hvFf5t/iRY4n8Fp
	6dtSXmupbl0OxH65hO3OVI47bxaDw8Rp2E//XvJBdhhzSE6TFyZp+oCD9vApHDMNrX8
X-Received: by 2002:a05:6a00:4b04:b0:89e:8242:f35f with SMTP id d2e1a72fcca58-8a089cf006cmr1210490b3a.13.1792571473289;
        Wed, 21 Oct 2026 01:31:13 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:31:12 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v9 3/8] crash_core: serialize crash header preparation against hotplug
Date: Wed, 21 Oct 2026 16:30:06 +0800
Message-ID: <20261021083011.2170525-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_093116_005643_768F11C0 
X-CRM114-Status: GOOD (  16.69  )
X-Spam-Score: 0.1 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wandun Chen <chenwandun@lixiang.com>

crash_prepare_headers() counts memory ranges before populating the
allocated crash_mem array. The weak implementation used by ARM64,
RISC-V and LoongArch walks memblock.memory, while x86 performs the same
two-pass operation over system RAM resources. Concurrent memory hotplug
can change range source between the two walks and make the populate
pass overflow cmem->ranges.

Take device_hotplug_lock when preparing crash headers during
kexec_file_load(). The x86/riscv memory hotplug path already takes
device_hotplug_lock, so call __crash_prepare_headers() directly
to avoid recursive locking.

Sashiko reported this issue in [1].

Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel.org [1]
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 arch/riscv/kernel/crash.c  |  2 +-
 arch/x86/kernel/crash.c    |  2 +-
 include/linux/crash_core.h |  2 ++
 kernel/crash_core.c        | 17 +++++++++++++++--
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
index fe5a4b306aae..ac8df2edf2a7 100644
--- a/arch/riscv/kernel/crash.c
+++ b/arch/riscv/kernel/crash.c
@@ -70,7 +70,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
+	if (__crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e6f23933a6df..bef008a0cb22 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -465,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
+	if (__crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index bc087124cd78..28e7a81cf263 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -61,6 +61,8 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
 				       void **addr, unsigned long *sz);
 extern int crash_prepare_headers(int need_kernel_map, void **addr,
 				 unsigned long *sz, unsigned long *nr_mem_ranges);
+int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			    unsigned long *nr_mem_ranges);
 extern int crash_exclude_core_ranges(struct crash_mem **cmem);
 
 struct kimage;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index faa0f22dbb41..8a861a946e26 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
+#include <linux/device.h>
 #include <linux/kmemleak.h>
 #include <linux/crash_core.h>
 #include <linux/reboot.h>
@@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
 	return 0;
 }
 
-int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
-			  unsigned long *nr_mem_ranges)
+int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			    unsigned long *nr_mem_ranges)
 {
 	unsigned int max_nr_ranges;
 	struct crash_mem *cmem;
@@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 	return ret;
 }
 
+int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			  unsigned long *nr_mem_ranges)
+{
+	int ret;
+
+	lock_device_hotplug();
+	ret = __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_ranges);
+	unlock_device_hotplug();
+
+	return ret;
+}
+
 /**
  * crash_exclude_mem_range - exclude a mem range for existing ranges
  * @mem: mem->range contains an array of ranges sorted in ascending order
-- 
2.43.0


