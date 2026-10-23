Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A360A2601
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ybmhTeKb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RC1vF3/M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=S6XKfn92IyUJY1cSUHMeiE49TgcbF+Rpj7AMk6zxFsI=; b=ybmhTeKbTtNWb6pIgDtZffu+XH
	OnDx1LFTWE8rJW2OTnpQ2sZNW+XM5PH8WeVZC8RyFmlJgSmCLUTKCrPTAcQ6LUgcxv0KuBhI6/ca9
	1Ir9dopbyVe41VU5hwVRn7T4BGZiRi/u3pmhKlkzgUO/sBrxXXd0SXI7yEfAiSPnh/pufD0rHTwK1
	O31eRWns/IA+roTmK7Pw7UWrgOJSMWRJvunUU+Qo0zRm1KEFEmqm612xaAm0D2hqjUgGCkhU7hkaA
	kawTFHbz9nwHjD+ZsLRotAFwQEeVYebhHj9G6ha5bCW2HuQzA64QiaWOz+T06FTEr8Ndh3Qy1R6PD
	bLjfgMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mE-0000000Fl75-3gsm;
	Fri, 23 Oct 2026 07:33:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mD-0000000Fl4l-0zvO;
	Fri, 23 Oct 2026 07:33:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC261602BA;
	Fri, 23 Oct 2026 07:33:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792740798;
	b=EX7r0MqEBQ3EKUMQVw6PNM62Gu25262KXddPBfIKvCPw6l5gt+J2XYSlUF7+IAK1X4EC
	 vIsZoM1lMS873yZa9FRiaoHUKdsEMs1HPeZWJD0830dbLfCvI7GyYBQoIAc84K31Y9cR8
	 Wj19OF2wYcRbCu7tJaVLNascvjDqstdXvdsfw9QsvlwhVJHspssaJ+leMRoZ4jKd6Or/0
	 qzK4TgNHZbApJvtnuIIlblwVy1vk9U7MIXiXGCETzM9J6o6LWu9xilosnKYhPV0Vg5NdO
	 KsIGt5Sb/FZVnyUvO3iSC4JDx4kPfjcmIlDgzzTB6ZBRcRnYr6pHJrtYcH/ulcjGtjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792740798;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=S6XKfn92IyUJY1cSUHMeiE49TgcbF+Rpj7AMk6zxFsI=;
	b=jjobU7+XIz2co1vB/y1gABkIsPGh0Mw+X7ahMcAVsTGk2f7wTAfwrvBoTZonVaDgxf+m
	 CbDg39WUyAyKr3c26nxh0WRl9q5wqXHveFIXhzF4BK2DIqUSg1ewNNynUEHd+3uKHnbEI
	 lydc9My8sagjem+e3Xr56jZ0dBImLlVeeeswpGldybTlYyUamBokBsulpMapLyy+XGk2w
	 ClfcuHNbuq5pECTdKoVwBEbvbOVZ0E4TkAYRW4ndvX3f3LRS64RwtNYgn0r4ks+jc/SGJ
	 BGBxNxMXHCcseKBs1OoGIdrmFHwfmnKnRcMLhiva6RzC0UiJ2basahpikd6A+WkORMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF4F01F031E3;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740798;
	bh=S6XKfn92IyUJY1cSUHMeiE49TgcbF+Rpj7AMk6zxFsI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=RC1vF3/MeAsKuTUVszHXQ5ECvxszAtQ9gABEdCdXJN6Yo3mq6naaPTPW5yxJ6ZDAL
	 Q1W8JtK4oJCPLRLFy6W9VWACqpoPhUssNCBIj2L5dpc0NkdDL8uEY5eowHAklPOkNW
	 NlRniTrMgX8sPizXhtmji753xvVBDlPIname+Y/5UBqIjfazbBzyu9qCSIkqpCuRgZ
	 EGs66NbTOc6uv+cFyj9yGD1gjeeUNDpWTgUrudmMxTwaCD+SUhLSYW/Twstu6vhvHs
	 1GgD6XY+XDSIlzGgYWuU2keYv1HJMkhIfrw9zY7P7X9CqmncFF6dmiKy/BEGLQbOjW
	 CjHuA+3IpadrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C65D443E6;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Subject: [PATCH 0/5] riscv: kexec: fix kexec_file with CMA-backed segments
Date: Fri, 23 Oct 2026 15:33:13 +0800
Message-Id: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqCQBCF4VeRuW5AV9S2V4ku1vGYU2SxkyKI7
 95qlx+H/6xkiAqjS7ZSxKym7zGhOGUkQxjvYO2SyeWuLnJXclSTmZ9YICyvwL0uMPat1L7x51B
 JT6n9RBxDSq+3v21qH5Dvfkbb9gOHEL0ueQAAAA==
X-Change-ID: 20261023-riscv-kexec-cma-fixes-9bc69798a5cf
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Yao Zi <me@ziyao.cc>
Cc: Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kexec@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792740795; l=1990;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=Thjxfmu56NJtgVUdSnPeX0m3Ki7icxN2HFTUo0uN07Y=;
 b=XDRVxrg/MPvhZsdxIHy3UA8cSlaAZoQOXZCJXfFOxKsAnZAwNXDEMiirk3dJXJ0NxyUn3KHzz
 ALTRjBPSRlUDwLRKSoyIDI9T86UgT2itnhAauIZ2jOmBuocOu7ukC1r
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: gaohan@iscas.ac.cn
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I ran into these while doing kexec_file reboots in a loop on a Zhihe
A210 board. Things mostly worked, but every few rounds the next kernel
would hang or purgatory would spin, depending on where the segments and
the DTB happened to land. Most of it goes back to segments now being
allocated from CMA, which exposed a few assumptions that no longer hold.
They are separate bugs, so each one gets its own patch.

Patch 1 lets the RISC-V relocation code turn the MMU off even when the
entry list has no indirection page, which is the normal case with CMA.
Patch 2 fixes the purgatory relocations, which assumed a PC-relative low
part always sits right after its high part. Patches 3 and 4 are in the
generic code: CMA quietly caps the alignment below what the RISC-V
kernel needs, and the tail of CMA segment pages was never cleared even
though the purgatory digest expects zeroes there. Patch 5 reserves the
DTB early enough that a CMA pool cannot be placed on top of it.

With all five applied, the board survives repeated kexec_file reboots,
including the layouts where every segment comes from CMA.

---
Han Gao (5):
      riscv: kexec: Disable the MMU before walking the entry list
      riscv: kexec_file: Pair PC-relative low parts with their high parts
      kexec_file: Honor the segment alignment for CMA allocations
      kexec_core: Clear the unused part of CMA segments
      riscv: mm: Reserve the DTB before scanning reserved memory

 arch/riscv/kernel/kexec_relocate.S     | 29 ++++++------
 arch/riscv/kernel/machine_kexec_file.c | 84 ++++++++++++++++++++++++++--------
 arch/riscv/mm/init.c                   | 18 ++++----
 kernel/kexec_core.c                    |  6 +--
 kernel/kexec_file.c                    |  7 +++
 5 files changed, 99 insertions(+), 45 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261023-riscv-kexec-cma-fixes-9bc69798a5cf

Best regards,
--  
Han Gao <gaohan@iscas.ac.cn>



