Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A1606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rJuRO46f;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s06zv9MW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0dSKP4mzbhr4ZbEkscIx3I5WqNRn/Q7p4AbTndmod+Y=; b=rJuRO46f2HODMH
	NlNASqaf9yn61iGVRUgp2nbLZDGpW77C+N7cVrFQh76+przyJETwN8pqiSaX92fCoHbSpobek9yUm
	ZRVvlci+6OQmIUiqfVEDghWTCCDNCIk2Tua2xGyI6pjIjvhsoSoCct9NACMEpJaLQCvzPaR6L78UX
	yQb7sQNkxloDxvAM4gDUOmeQj2oBVGj+bGIrfAdyrsKDj8KOeA7Db5aUxoU1pyzqfYfJzye14QG2n
	MAvOR/tgex4VnIjn4grxLRaCRAzurUQSn4gREkzPhsBWpIF39aHZYr9Mrc0ktoxurQU2t+ul5tDoO
	Qy65ioh+yh4KV8BvADiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbnY-00000003vQA-1gDW;
	Tue, 27 Oct 2026 07:40:44 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbnT-00000003vE5-08sV
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 07:40:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793086835; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0dSKP4mzbhr4ZbEkscIx3I5WqNRn/Q7p4AbTndmod+Y=;
	b=s06zv9MWbwbi4uLqObJXwtSUh7wK4oHft9IifWlgbQkO/bXMWIslvNrHyVlbC/fCcbMrRlY01dg02lKz0YnqjH+lWmVnMP4/SjOHf3RQ5tBZCsharxd0GwF/DiZlB/lw7C2HoVCVpcm5564IwTpGG52gWq6iV0Io45Ri4fQb9V4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XDd6LIt_1793086828;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XDd6LIt_1793086828 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 15:40:34 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pratyush@kernel.org
Cc: graf@amazon.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	rppt@kernel.org
Subject: Re: [PATCH] kho: Skip zero-sized bootmem areas
Date: Tue, 27 Oct 2026 15:40:25 +0800
Message-ID: <20261027074028.13042-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2vxzld7kpmmi.fsf@kernel.org>
References: <20261026131851.9942-1-cp0613@linux.alibaba.com> <2vxzld7kpmmi.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_004039_299015_76B48538 
X-CRM114-Status: GOOD (  12.58  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Do you see zero sized lowmem or global scratch in practice? If yes,
> how? What's your setup?

Yes. Enabling KHO for riscv64 gave me three cases. They differ in which
size ends up 0 and in what it costs, and all three are measured:

  #  condition                     size    cost
  1  all memory below the limit    global  empty area kept
  2  no memory below the limit     lowmem  KHO off
  3  kho_bootmem= with explicit 0  either  empty area kept

Case 1, measured with a temporary pr_info(), not part of the patch.
riscv64 defconfig plus KEXEC_HANDOVER, cmdline "kho=on", four RAM sizes:

  mem   reserved_low   reserved_any   lowmem       global
  1G    0x32d3ea5      0x32d3ea5      0x6800000    0x0
  2G    0x4557164      0x4557165      0x8c00000    0x400000
  4G    0x4000000      0xa7116e5      0x8000000    0xd000000
  8G    0x4000000      0xed121e5      0x8000000    0x15c00000

riscv does not define ARCH_LOW_ADDRESS_LIMIT, so it uses the 0xffffffff
default and every reservation is below it; the two queries then agree
and the global size is a number scaled minus itself. The 1 GiB case is
exactly 0, and from 2 GiB up a single byte of difference between the two
queries is enough to leave the 4 MiB minimum after rounding up. The 0 is
recorded, not just computed - /sys/kernel/debug/kho/out/ on an
unpatched 1 GiB configuration reads

  bootmem_phys:  0xb6400000  0xbcc00000  0xa2c00000
  bootmem_len:   0x6800000   0x0         0x13800000

with the middle pair gone after the patch.

Case 2 is the one that actually costs something. On a riscv64 platform
whose memory all starts above the 0xffffffff default limit, unpatched
and with memblock=debug:

  memblock_phys_alloc_range: 0 bytes align=0x400000 from=0x0
                             max_addr=0x00000000ffffffff
  KHO: Failed to reserve lowmem bootmem
  KHO: Failed to reserve bootmem, disabling kexec handover

The size is 0 because nothing is reserved below a limit that has no
memory under it, and the range below the limit is empty as well, so the
allocation returns 0 and kho_enable is cleared. KHO ends up off on a
machine that needed no lowmem area at all, and /sys/kernel/debug/kho is
not there. With the skip the same machine comes up with two areas and no
error:

  bootmem_phys:  0x1000f3400000  0x1000ca000000
  bootmem_len:   0xdc00000       0x29400000

Case 3 is a cheap way to reproduce the recording of an empty area on any
architecture: the parser rejects the explicit sizes only when their sum
is 0, so "kho_bootmem=0,128M,128M" is accepted and the zero reaches the
allocator. On an unpatched kernel it gives

  bootmem_phys:  0xbcc00000  0xb4c00000  0xacc00000
  bootmem_len:   0x0         0x8000000   0x8000000

and with the patch it stops at the two real areas.

> Note that I already fixed this for per-node areas since those do end
> up with no allocations with movable_node set [0].

That one covers the per-node loop only; lowmem and global are still
unconditional in linux-next today, which is what cases 1, 2 and 3 above
are about. Is there anything I have not considered here? Please point
it out and I will follow up accordingly.

Best regards,
Chen

