Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92ABFEC118
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 21:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1oCpYm0KzSTu0Ip3vGkBopZtx8t/TNQY1UTxcF3u410=; b=RKzQL9df0x5qFbF9MOkDi1wi+z
	xlk8/aI6AnG+vtGpq9LTVtrr/zv8+E0LDesIRUG1Xgt2faxA3az59J8uSFoNy3w5vXU7iObrb1NU3
	C4sAWxb2P5lfrOXAUa1uiJVBNyZNANw87cbxCdzFg73oLKybU3bkL4F3arBYiyzUFD3skzzxJg2jD
	dDT1u2sY3aHhTJ0oKmE8Kjot++DCC3wzJG5JzrEVlxNiSf+oVki+h0k5wA+NW1W5pVs9FkC/QF7HJ
	F0VDQd5eNpat8gA8xAe3kJbnMAfclrXAviUghDHNYRZE9zQ8lY42yAtzQi8v29Q8NWTnQHE3WjkNE
	6D9jTOgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59JM-00000002Fxw-3sgw;
	Tue, 24 Mar 2026 21:29:16 +0000
Received: from hillsboro-edge.smtp.mymangomail.com ([5.78.130.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59JG-00000002FxX-2hX5
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 21:29:12 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by las-vegas.smtp.mymangomail.com (Mango Mail) with ESMTP id BE441418CA;
	Tue, 24 Mar 2026 17:28:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774387733;
	bh=U3g2cJ4i0kfU7fAPqpRnGVtuJyqHXzzYfGdEhgmkup8=;
	h=From:To:Cc:Subject:Date:From;
	b=c4hrJpkFB8lQJsNFKNROacA0nVLwxVgniVWlIQsJb8Wld5lCwcvt5xGlCqc4DKYkZ
	 NfujZ/Rz+GIGS/5fdF8afxfDWbtWAc2q1mTRl7WQnmmucn/qy+P09LaJG/AduDKiq1
	 pjKOnrI7O70gNdDXDQTZeydb9+xQQN9PvmpFnlmg=
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
Received: from authenticated-user (smtp.mymangomail.com [205.185.121.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by las-vegas.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 7FFAC41694;
	Tue, 24 Mar 2026 17:27:36 -0400 (EDT)
From: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Subject: [PATCH v4 0/5] liveupdate: tighten handover cleanup and session
 lifetime
Date: Tue, 24 Mar 2026 22:27:25 +0100
Message-ID: <20260324212730.65290-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_142911_033965_0150D5E7 
X-CRM114-Status: UNSURE (   9.21  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Pasha,

this v4 keeps the simpler direction from your mail: outgoing handover is
still driven by a boolean rebooting gate, refcount pinning of outgoing
sessions during serialization, and session->mutex as the serialization
point for in-flight mutations. There is no return to the earlier closing
counter or a larger session state machine.

The main changes in this respin are:

- reshape the series into five commits, each building and standing on its
  own
- keep incoming session origin immutable and use retrieved only as the
  checked-out bit
- make FINISH and implicit close consume incoming sessions without
  reopening races through retrieve-by-name
- route deserialize failures through explicit rollback paths for
  sessions, files, and serialized memfd state
- validate KHO-preserved extents before walking serialized metadata
- harden incoming FLB lifetime and remaining teardown paths

Patches 1-4 keep the core session, kexec, deserialize and validation work
separate. Patch 5 carries the remaining FLB and teardown fixes needed to
match the final tree.

Oskar Gerlicz Kowalczuk (5):
  liveupdate: block outgoing session updates during reboot
  kexec: abort liveupdate handover on kernel_kexec() unwind
  liveupdate: fail session restore on file deserialization errors
  liveupdate: validate handover metadata before using it
  liveupdate: harden FLB lifetime and remaining teardown paths

 include/linux/kexec_handover.h     |  13 +
 include/linux/liveupdate.h         |  17 +-
 kernel/kexec_core.c                |   4 +
 kernel/liveupdate/kexec_handover.c |  22 ++
 kernel/liveupdate/luo_core.c       |  16 +-
 kernel/liveupdate/luo_file.c       | 237 ++++++++++++--
 kernel/liveupdate/luo_flb.c        | 116 +++++--
 kernel/liveupdate/luo_internal.h   |  14 +-
 kernel/liveupdate/luo_session.c    | 500 ++++++++++++++++++++++++-----
 lib/tests/liveupdate.c             |   2 +
 mm/memfd_luo.c                     | 160 +++++++--
 11 files changed, 934 insertions(+), 167 deletions(-)

-- 
2.53.0

