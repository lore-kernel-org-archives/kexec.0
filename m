Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDD606A31C
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nT+pwoT1;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=cZ4+u6Jz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pwQQKjzpx2jY8Nn28JUzibuPtYLtnAE8dhSFzqvQDEE=; b=nT+pwoT1Y7v91NWYWJMHWZSm3m
	6JZ0mTIh3OyHaHMCdQ4l6rxZZgvLMFCZrHhhz0k32Ydp8pBERLWl4H6Cs7cCAskCycZ4PxxB12vMt
	7OZbhXJ9QR+SNA9ywk/IpczIXce3tM71LPprrltMk8JS+WaAcXGJtETvTSNL9+7QR3CAZAfA4rjFL
	fc4SD2cBnmMZnJxMH5ZPfofNwH3ra4zwMt1whdM4c1XTeQWNDuSwUbvvErdBpBtMalC1YaJ9ohSsM
	BTuuvDAi020dJQ3PjlvAnJbRHAx33I6rFHnPoIE/hhN4Htb/X8gNXfCDrIERmnNM636hD1wRSqVUN
	PP9t8wMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXDel-00000000WWh-2abp;
	Sat, 28 Nov 2026 08:19:39 +0000
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXDef-00000000WV4-3Pdh;
	Sat, 28 Nov 2026 08:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795853961; bh=pwQQKjzpx2jY8Nn28JUzibuPtYLtnAE8dhSFzqvQDEE=;
	h=From:To:Cc:Subject:Date;
	b=cZ4+u6JzESm4KvXt9ufmE9s6jI79fJtPvOCSIDqvGEW8QJW6woUCpU8Uk1HlMTs/2
	 deNJe9YZPUBCGPreiIJK5PfMgy5/Icnx1NmGRKY9cU0yVrW3enVk3PxJuVHudxdP1d
	 uoxFrvt66LqadI9bQLcfyQG8RUOPvgFA41Ys7ga8=
Received: from DESKTOP-6LNKCJL.localdomain ([111.199.66.152])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4CB19228; Sat, 28 Nov 2026 16:19:11 +0800
X-QQ-mid: xmsmtpt1795853951tfvwicj2s
Message-ID: <tencent_0EE98A1C2110785434DE9692533FF737DD07@qq.com>
X-QQ-XMAILINFO: Oe8iJ2SlZYdbx+3ASzNGTEGG4DyReHdvcZ3nTMPZ28KrcPjGEXlv7Eh0WDzWDK
	 vYqJEg0JfhY1SVJ3TE08snY3hwSXWqDozn5h2zOBVkyX669wfek8JeT9WDaYIqH2F9pmHGbXEZfo
	 /v47PGiSLb/DzRq1RTMK9urbh67YEI+kEx8fZl2tH0zWrHK7Ew6+XEbI1GdbAlD/Ky1X178sp76G
	 RTIZpFcIAxt+Xu3GpVe/keqKW6H3kKicE6OBMlsbO/3BqDDZuUChhMjnnfJq0th1hcV1KfI4sr6+
	 8SKx7kaiki5BMLWQdiNKVjKJOEUs/iRmbMrC1K7gblhICBrDEN1pGKMe0iitwZ5DBzhwp4XctuSX
	 sD3cUcm+NvZd/lsd6FUg2n1JwI+OdGcPqceI/8/pQc3CRfs2Fe04jtb+aPsgsjusmH9RA/aHjCt/
	 COfigsAJR04qRQmVI4G/znxPit0lzLWdyWF6e7dY4K0UVVwEyEvH4c22kzNVGUGMggYw1vorQXiw
	 2jT5ytuZrHHf5sTpIHu+vuqb9Qopmg92Gu2ygxDpK+1Me6prKsipPtXAUUn7ip92zrHrs6mU0CdW
	 jGaOW9KzEgxqi+59UFsnvX0PPZ7qWSDj3nAwvVzZ6fX2/5I2Jc3AJHdb2LVunyjm5GK4KZqbTqwb
	 KY46KPVNt8mPc7aSUHPL2bY30bRwErcoeabM+Jk2O0kVk7GPv3FbGxLSCLLqu0agojSbmeSmFZ5X
	 ACZoTmVo89CRYiPshxg5e/c2OlPPpFfOgXQFBzZPgpx5NSTaVUj7Z06d11w8PU+tRNPlLGk2klbL
	 B/TEoBAtzprla4sASXFBqZMsnjQnKq9DGp7nFc0E+nZp84gYjg+41Uy1DXsExU3nvxirEnGZrKtF
	 OM8tdqXKF0TSKSCYDJTuYSgwPyRiajmADXD3/8n2FBplXKxsq/26xldlsQwlE18dvXuyk5WQAm9S
	 TPdE6pEfjaR6maQ/367GssaLj010OZtsRmvwGlGkfYZSX15NmS6EDexT95SbtjHPb3vqCP7oFTR7
	 6JSY+iY76xMo30fjRgvgsHRGpWb9JxWhnlcyfJ9xXa6cpnc2Lu+IO8DR0Q5KlDQGBYhLDSiDnk95
	 LpVvbmu+VaI7RJXb9YABnF5ZWKIJiJMjspBu66c9xYQGtCqBNLVTXHvJXoFw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Jingyi Sun <1045704958@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Thomas Huth <thuth@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	Jingyi Sun <1045704958@qq.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] kexec: use phys_addr_t in generic crash_free_reserved_phys_range()
Date: Sat, 28 Nov 2026 16:19:03 +0800
X-OQ-MSGID: <20261128081908.391-1-1045704958@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261128_001936_175793_F2FED082 
X-CRM114-Status: GOOD (  10.20  )
X-Spam-Score: -1.8 (-)
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The generic crash_free_reserved_phys_range() takes the range as
unsigned long, but its only caller, __crash_shrink_memory(), passes
resource_size_t values from crashk_res / crashk_low_res. On 32-bit
architectures with a 64-bit phys_addr_t that do not provide their own
helper (e.g. ARM with LPAE), a crash kernel region above 4GiB is then
truncated to its low 32 bits when /sys/kernel/kexec_crash_size is
shrunk: free_reserved_page() is called on unrelated low-memory pages,
while the pages that were actually released from the reservation stay
reserved forever.

This was observed on QEMU (virt, cortex-a15, ARM_LPAE, 6G) with
"mem=1G@0x40000000 mem=512M@0x140000000 crashkernel=64M@0x150000000":
after "echo 0 > /sys/kernel/kexec_crash_size" the HighMem zone's
managed page count stayed unchanged, while the low-memory zone grew by
16384 pages (64MiB), i.e. the pages at 0x50000000-0x53ffffff were
"freed" instead of 0x150000000-0x153ffffff. x86_64 with the same layout
behaves correctly.

Use phys_addr_t for the range and the loop variable, and PHYS_PFN() to
derive the PFN.

Fixes: c0bb9e45f3a7 ("kdump: Allow shrinking of kdump region to be overridden")
Signed-off-by: Jingyi Sun <1045704958@qq.com>
---
 include/linux/kexec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index bac11e940e74..e21dcc316bf9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -484,12 +484,12 @@ static inline phys_addr_t boot_phys_to_phys(unsigned long boot_phys)
 #endif
 
 #ifndef crash_free_reserved_phys_range
-static inline void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
+static inline void crash_free_reserved_phys_range(phys_addr_t begin, phys_addr_t end)
 {
-	unsigned long addr;
+	phys_addr_t addr;
 
 	for (addr = begin; addr < end; addr += PAGE_SIZE)
-		free_reserved_page(boot_pfn_to_page(addr >> PAGE_SHIFT));
+		free_reserved_page(boot_pfn_to_page(PHYS_PFN(addr)));
 }
 #endif
 

base-commit: 7cd8495c0f16275c4f9abe1cef09a7b5fcd6d046
-- 
2.43.0


