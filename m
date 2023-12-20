Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4716DC3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 05:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5lDNpxbBg3AZ5HGcM/cj95c9pIuYaunGcWBVVr+ZG7U=; b=qrhz9/sSU5eSAR
	qk3phfkDFNV7CQyhh9UHjB0nNIsTZSwCPABNTv9dVaMcNk8BNH7MEQDv1gxjM0xWkiBJKk0QkFp6n
	L2iBkeFexKkHKxCvSM1ZsYpSUSLlN0zG2ygjOapUuGJ5lWVhm/AOyqEeuM99gmNeT2CVOylsnZhD+
	tI1ZtwO9uoCodsfJe5AJoNacRuhCiHmSoYZ3Ow07QBE2HTdqzlyPAC0n6KBH5J2qxnyHrbJs+NAz3
	mDrdkbr8esQmKoNd/kic2AYyzGw7oaqwm7k3Aguf3GJdetIsNOrFjGtpclbQfDcTcd/8dvK2z+f64
	LRB8qYh5VasANBTMIsTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpc4-00GEhW-15;
	Wed, 20 Dec 2023 05:59:24 +0000
Received: from mail-m12789.qiye.163.com ([115.236.127.89])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpc1-00GEgQ-1A
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 05:59:23 +0000
Received: from fedora.. (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 7353926010E;
	Wed, 20 Dec 2023 13:57:40 +0800 (CST)
From: fuqiang wang <fuqiang.wang@easystack.cn>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] kexec: fix potential cmem->ranges out of bounds
Date: Wed, 20 Dec 2023 13:57:30 +0800
Message-ID: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSxgfVkhLShoZSRkZTR1IGlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c85cd1f610276kunm7353926010e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Qgw4VjE*SlEcDAwDCw4M
	MRYwC0NVSlVKTEtIS05KQ01JTEtCVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJSk1ONwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_215921_568333_19730951 
X-CRM114-Status: UNSURE (   7.34  )
X-CRM114-Notice: Please train this message.
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

This series tries to fix the potential cmem->ranges out of bounds.

On the v1 version, there are still some issues that need to be
discussed, as follows:

1) Whether we need have the cmem->ranges[] partly changed, or keep it
unchanged when OOB happened. Previously discussed link:[1].

2) Set cmem->max_nr_ranges in crash_setup_memmap_entries() to 1 or 2.
Previously discussed link:[2].

3) To enhance crash_setup_memmap_entries() readability, how to move
code. Previously discussed link:[2].

v2:
  - Fix potential out of bounds in crash_setup_memmap_entries().
  - Add a comment in fill_up_crash_elf_data() to explain why the array
    size do not need to be changed.

v1:
  Link: https://lore.kernel.org/all/20231127025641.62210-1-fuqiang.wang@easystack.cn/

[1]: https://lore.kernel.org/all/ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv/
[2]: https://lore.kernel.org/all/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/

fuqiang wang (2):
  x86/kexec: Fix potential out of bounds in crash_setup_memmap_entries()
  kexec: Fix potential out of bounds in crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 20 ++++++++++++++------
 kernel/crash_core.c     |  7 +++----
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
