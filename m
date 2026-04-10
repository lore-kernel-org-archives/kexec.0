Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654FEF36B9A
	for <kexec@archiver.kernel.org>; Fri, 10 Apr 2026 01:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y+ewA8RjY6nMAFwnoN35zZbuD8YUej+hPFsz1UPCe10=; b=KHFolhMClPxPNWCNrqiz4NiGY1
	PKJXJctaQwHS3BP1MfA6RX5JrWJDKBp0biFjnk/ELI/ZUNq9Ih8sfaexVXO+N4eSdvGvZYRvVv7sa
	i4zhCDERSjj0L+ETNg2DqhH3K7x826YvsegdTDNes3r9W5xxZQ2AlZwN7NG1cd3mvFEe14vZkH45f
	cMGnUReE1sVJUjlcfeCR5DAnXqV2bLFORNVmMPAaPSNlSr0OaGHpbCaydiBUbcDPDdPTxAhRozBcp
	jgFveIBcjO+grzH20aYISfpsU4T2DFc2BY2hB7UtD7BWiE0i3m4NBVxrKfMUUaZNmu0y1NIYf9wo/
	k05/cSSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB0U5-0000000BPIx-1ItH;
	Fri, 10 Apr 2026 01:16:33 +0000
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.68.102])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB0U1-0000000BPIc-3T2a
	for kexec@lists.infradead.org;
	Fri, 10 Apr 2026 01:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775783789; x=1807319789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y+ewA8RjY6nMAFwnoN35zZbuD8YUej+hPFsz1UPCe10=;
  b=DX3OOL6cU4ayaPBf6Gwu4hUK7aXzC77ueWDIO1ru5e8zt1eDfMDd4AIQ
   J8f2ADb/qXkQVQLe0eaqDHVVkHVFDpzgIeSDISysAjisbCtaPbkNRlfbb
   vEbIwDf3p/ZMs7vA8JD1TbKl/5S5eeB0coH/qHUcsixuIQ6pE6DLmEV9P
   xjZv2ulv6bJlATI9EfKdY+/K3SiSsSQQBmXCNlTJVP/TOhAtqPdEZvByl
   +CPCeMeYVWoMPNm8HpODXc+MKUOyOY9zXpYvUTIt1d10B4UdL9a+vh1au
   FGk/RV6j0yUlJaZUVD9NyQwd6LlzPkcJk3uNpLjwAn0xU+GusDs/UU8SI
   w==;
X-CSE-ConnectionGUID: DHa5mPRbRGqTlrLccv9+iA==
X-CSE-MsgGUID: Y8/JvhHsQZG4LF/ImZPAFg==
X-IronPort-AV: E=Sophos;i="6.23,170,1770595200"; 
   d="scan'208";a="16989540"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:16:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:31699]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.82:2525] with esmtp (Farcaster)
 id 0218addb-e3f2-4ce7-89d0-f199987a9e46; Fri, 10 Apr 2026 01:16:23 +0000 (UTC)
X-Farcaster-Flow-ID: 0218addb-e3f2-4ce7-89d0-f199987a9e46
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 01:16:22 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 10 Apr 2026
 01:16:20 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Alexander Graf
	<graf@amazon.com>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Changyuan
 Lyu <changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH v2] kho: skip KHO for crash kernel
Date: Fri, 10 Apr 2026 01:16:05 +0000
Message-ID: <20260410011609.1103-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_181629_942051_8F1556EA 
X-CRM114-Status: GOOD (  14.07  )
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

kho_fill_kimage() unconditionally populates the kimage with KHO
metadata for every kexec image type. When the image is a crash kernel,
this can be problematic as the crash kernel can run in a small reserved
region and the KHO scratch areas can sit outside it.
The crash kernel then faults during kho_memory_init() when it
tries phys_to_virt() on the KHO FDT address:

  Unable to handle kernel paging request at virtual address xxxxxxxx
  ...
    fdt_offset_ptr+...
    fdt_check_node_offset_+...
    fdt_first_property_offset+...
    fdt_get_property_namelen_+...
    fdt_getprop+...
    kho_memory_init+...
    mm_core_init+...
    start_kernel+...

kho_locate_mem_hole() already skips KHO logic for KEXEC_TYPE_CRASH
images, but kho_fill_kimage() was missing the same guard. As
kho_fill_kimage() is the single point that populates image->kho.fdt
and image->kho.scratch, fixing it here is sufficient for both arm64
and x86 as the FDT and boot_params path are bailing out when these
fields are unset.

Fixes: d7255959b69a ("kho: allow kexec load before KHO finalization")
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---

v2: Per Mike's review [1], move the guard into kho_fill_kimage() instead
    of patching the arch-level producers and consumers. This fixes
    both arm64 and x86 in one place and avoids redundant checks. Tested again.

Note regarding backporting
The offending commit was deployed with 6.19. The only other supported
kernel version with 6.18, unless I miss someting uses
```
if (!kho_out.finalized)
```
which in the case of crash kernel it shouldn't be finalised.


[1] https://lore.kernel.org/all/ade2ExpM8ROXV-vy@kernel.org/

 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cc68a3692905..1029fe8778f2 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1551,7 +1551,7 @@ int kho_fill_kimage(struct kimage *image)
 	int err = 0;
 	struct kexec_buf scratch;
 
-	if (!kho_enable)
+	if (!kho_enable || image->type == KEXEC_TYPE_CRASH)
 		return 0;
 
 	image->kho.fdt = virt_to_phys(kho_out.fdt);
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


