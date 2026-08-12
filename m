Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94621C5CFEB
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XKdbUWVjqXoP5QkUXtvUTfFmZJO1U64wmy2Dn8sFEgY=; b=Rm3cU4U9CxBzsB
	gl/4QyMc2CzVlJXqKn89P8lBM3S1JV+hHOoIfho8gVfqP2QHB2AV/855zztFgeLwsB8zKPo3S4UIQ
	6De2MX+Aaa6gl9xZjDZ4zCuF5JVLJ3eW1iqj7x57r5CWNOzNjnnsGyNlF8+WrSBHROqMwR7VzsjwR
	rX1av99u9nP0cip0lAw0em5pDFF3OQxLd/Ooo3QgGfKy+9vo+28rIizn7fR8yVF82xHjtNXegUBxv
	6eWVcVBVrkxjLwp8DNkN8rnO77kMM04eWI36BqsWparNMqq/L2ADKgMNp4F/nnfLRDtpLWAQd7MD4
	hCeNUEI5wj5K9N58Xe0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7C7-0000000G5kA-1rIT;
	Wed, 12 Aug 2026 11:32:27 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7C3-0000000G5gl-03sq
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 11:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XKdbUWVjqXoP5QkUXtvUTfFmZJO1U64wmy2Dn8sFEgY=; b=nBqpzEymNpnG2HId4WtGj1MEdu
	S6GCQwciU8L1OUqLGN8J587I0XRVbYRruA9hE6AOieKa0nfA9YNRMeThxYiybpb4ebbZ0T95a309C
	RrMi5JRsPnai1lAY9uxzVZcZSO0aJsQvPFyA80Wl/WE6C2k2qo0pXVOp0M31VgbaSVfblaJ12jrSv
	hGQWdCfIaoDJJbDZRf+trKB6vAZsVH0AEKVXLupg9QzzE0ske1hrfv08+TS27YAculnFGC5TgBo5U
	VroTc5gKS436rfbSGtv2ApEnejh6J6o5w3/U6z24wZLjVFsPz4ZXseru4TriWBqQqixRm6vX0ZjYV
	475p7TMw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu7Bi-004JJE-0s;
	Wed, 12 Aug 2026 11:32:03 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v6 0/2] kexec: keep the next kernel off hardware-poisoned
 pages
Date: Wed, 12 Aug 2026 04:31:50 -0700
Message-Id: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdZfGoC/2XQ22rDMAyA4Vcxuo6G5VPcXPU9xhhOLLdmkBRnm
 I6Sdx8pjGXzrdD3I/SAlUvmFQbxgMI1r3mZYRCuEzBdw3xhzBEGAUoqJ3vV4wffeXq/LfsiR+z
 VOMpgyOggoRNwK5zy/Rl8fesEXPP6uZSvZ7/SPv1J+f+pSkhITk6eInmZ+Bx5zGF+WcoF9lZVB
 69l4xUSppOK5K2l5Ezj9a/3UjdeI6HXITiOLLWlxpujb15RDRL2Mto+kXHKxsbbg6f2fouEJ8s
 0WlbsrPvjt237BuvIbZutAQAA
X-Change-ID: 20260727-kexec_posioned-72bb0a4143a0
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, 
 riel@surriel.com, kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>, 
 Bradley Morgan <include@grrlz.net>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4000; i=leitao@debian.org;
 h=from:subject:message-id; bh=MEuO2alc61B25/RbuNvMKIHActXYMHq90TiaCXPG2gM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqfFmsIQEnDIumBT1dUzqWEh0n4xoEnjZzL5AyX
 uRmodHGmXuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanxZrAAKCRA1o5Of/Hh3
 bZUWD/91dXzRWqOndMqQZW8KYQaSDpHWB5EzGhwM5+rZECR2+0h8C/+bLmI3gUsHIdixbYE/yh2
 LWHOiSJhopjAbzpKo2M5MlnhlFD/fEhmMUq/PvSbsO2NnKhYAFG6DDuApmgUHGOaHeBNQBF0dXU
 yC1fcWse9Xep2n3nwmmRekxkUziMX2FYj78rjQdkTnfWzlIZQjx5cKigcZZc9NxBYkwTVMY61B2
 D3HF2sEwu9+nkBMN/MfgbKhoVKRfZEfEl2kwAw86Gbih7GWBr6VXMJ4lhtzBETVfOWq+tJJdhMO
 KKbVpG4xVhBvGc0HkEW1UnSG3tEb0ZqzmFs5gxLTpFIsCk+rt6LEm8qzda/wVRwwFgXb804Ix5c
 xd9weCQyDdQw6sTbZfJU2JEuvtxds/Zv4L2FoBOcIf+ZHxOuQffSV9uYSJNUOpSHe+exqt2iJie
 vAkudANJRCTmaDM+54PO2nasXoB9PhtQGHJV+48InkGTgxZTGZs5/4legBfKMT7YsiyI9LaS/vZ
 MZ02c1ljfhOsBVceQs0P+WsfJ6jShGinCzLfw+j3CFNXCFkHEsmikbReimi01nCx+Nn3NL028Wo
 cctiIX+G67d/etdCT0a65SAMdIWjNWqM+CQ9aKkBvpFKvK4tvAjtSsGqzKHXUxnpgy4uY4vGomS
 DxRKjKNPpzKSHUA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_043223_074674_E9AFE113 
X-CRM114-Status: GOOD (  14.61  )
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

Memory failures are common enough on large fleets that kexec regularly
lands the next kernel on a frame the memory failure subsystem has already
marked bad. Patch 2 teaches the segment placement to avoid those frames.

Patch 1 is a prerequisite. locate_mem_hole_top_down() walks candidates
downwards without ever checking that the subtraction stays above zero, so
the walk can wrap and report success with a destination outside of RAM.
Patch 2 adds one more downward step to that loop, so the bug is fixed
first and both patches rely on the same bail-out.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v6:
- Split the pre-existing top-down underflow out into its own patch, and
  drop the "if (poison < kbuf->memsz)" guard from the hwpoison hunk now
  that the loop bail-out covers it. (Mike Rapoport, Sashiko)
- Reword the changelog: the MCE comes from reading the poison back, not
  from the relocation copy writing it, and the placement paragraphs read
  better split up. (Mike Rapoport)
- Move cond_resched() after the struct page dereference, so the scan does
  not yield between pfn_to_online_page() and is_page_hwpoison().
  (Pratyush Yadav, Sashiko)
- Keep cond_resched() per pfn rather than batching it. (Kiryl Shutsemau,
  Rik van Riel)
- Link to v5: https://patch.msgid.link/20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org

Changes in v5:
- Return -EHWPOISON instead of -EADDRNOTAVAIL
- Leverage is_page_hwpoison() instead of per-page check
- Link to v4: https://patch.msgid.link/20260807-kexec_posioned-v4-1-70d57f14625d@debian.org

Changes in v4:
- Anchor the top-down hole finder on the first poisoned page in the
  window and the bottom-up one on the last, so each jumps clear of the
  poison in one step. New range_first_hwpoison(). (Kiryl Shutsemau)
- Count a poisoned hugetlb folio in full: the flag lives on the folio,
  not on the subpages, so the per-pfn scan missed poisoned tail pages.
  (Kiryl Shutsemau)
- Link to v3: https://patch.msgid.link/20260803-kexec_posioned-v3-1-83aa6ede0351@debian.org

Changes in v3:
- Return the address of the last poisoned page in the range, or
  PHYS_ADDR_MAX when it is clean, instead of a bool plus an output
  parameter. Renamed to range_last_hwpoison(). (Pratyush Yadav)
- Add cond_resched() to the scan loop, as a segment can span half of
  memory. (Sashiko)
- Link to v2: https://patch.msgid.link/20260730-kexec_posioned-v2-1-f92d18551f64@debian.org

Changes in v2:
- Change from pfn_to_page() to pfn_to_online_page(). (Miaohe Lin)
- Return the poisoned address once we find a hit, to avoid the O(n^2)
  rescan. (Sashiko)
- Link to v1: https://patch.msgid.link/20260728-kexec_posioned-v1-1-160c81d180fe@debian.org

To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Baoquan He <baoquan.he@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
To: Miaohe Lin <linmiaohe@huawei.com>
To: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: rmikey@meta.com
Cc: riel@surriel.com

---
Breno Leitao (2):
      kexec_file: stop the top-down search before it underflows
      kexec: keep the next kernel off hardware-poisoned pages

 include/linux/mm.h  | 14 ++++++++++++++
 kernel/kexec_core.c | 10 ++++++++++
 kernel/kexec_file.c | 20 +++++++++++++++++++-
 mm/memory-failure.c | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletion(-)
---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-kexec_posioned-72bb0a4143a0

Best regards,
--  
Breno Leitao <leitao@debian.org>


