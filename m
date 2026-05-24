Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3DFCD6E57
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/Gbe7Qml17jIe3XN86Y6LdJlXDlmgpTm43teh2Wv6VU=; b=xUWuSz7WGcLhcQe7xTcO3I/ljA
	ClDB9Qte/s865bH+EFg0LiPg8bqgJ+vfdFQKEIDwIkXTRwqiI8JD0iK2z7WwWbH4ZaIKBxOh2JETW
	Uy5HtmYPRfULei01o1E+luTDm0qaLHSY3p66g+/Lt1SY/W6ZQXI/6o3iksoCohppKL+hL4cvB0kpS
	xRH+u4ibXRX0vUEd38480HUP/VIeRsMlgXafisFT+JEqYNc2BQUpcIL0YjboVfcL18sMkmtJ/v1CC
	HPaZxVDR4GJw/KvlTN263p6uEM4tJoueMS59JyiM04NvgeHImR6PuKC+UGd0HtL3JbWmliT6/AVIT
	xZQ4rC7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQrh-0000000DIDF-1ZgX;
	Tue, 02 Jun 2026 15:17:13 +0000
Received: from [111.201.25.229] (helo=gmail.com)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRClY-0000000FMOE-2uN8
	for kexec@lists.infradead.org;
	Sun, 24 May 2026 17:37:33 +0000
From: Yifei Chu <yifeichu24@gmail.com>
To: kexec@lists.infradead.org
Subject: [BUG] liveupdate: incoming/outgoing session ioctls accepted in wrong phase can panic
Date: Mon, 25 May 2026 01:31:39 +0800
Message-ID: <177964389908.73725.3374791433218646192@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_103732_909115_78FCD0DB 
X-CRM114-Status: UNSURE (   6.74  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:17:10 -0700
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

Hello,

Resending this to kexec@lists.infradead.org in plain text only. The
previous copy to this list was rejected because it was sent as HTML mail.
The original report was also sent to the liveupdate maintainers,
linux-kernel, linux-mm, and the related reviewers.

Short version: I found that liveupdate session ioctls can be accepted on
the wrong kind of session. In my tests, that lets userspace drive memfd LUO
into KHO restore paths for current-kernel preserved memory, which hits
kho_restore_page() warnings and panics with panic_on_warn=1.

There are two closely related cases.

First, a newly created outgoing session accepts incoming-only operations:

  LIVEUPDATE_SESSION_FINISH
  LIVEUPDATE_SESSION_RETRIEVE_FD

After preserving a memfd, either ioctl dispatches into the incoming restore
path and reaches kho_restore_page().

Second, a retrieved incoming session accepts the outgoing-only operation:

  LIVEUPDATE_SESSION_PRESERVE_FD

After a real KHO/kexec handoff, the PoC retrieves the incoming session,
preserves a new current-kernel memfd on it, and then calls FINISH. That
again treats current-kernel state as incoming KHO state.

Tested environment:

  Linux version 7.0.9, x86_64 QEMU
  gcc 12.3.0, GNU ld 2.38
  CONFIG_LIVEUPDATE=y
  CONFIG_LIVEUPDATE_MEMFD=y
  CONFIG_KEXEC_HANDOVER=y
  Boot args included: kho=on liveupdate=on panic_on_warn=1

Outgoing-session FINISH result:

  session fd=4
  preserved memfd token=0x6f757466696e6973
  calling FINISH on outgoing session; this should be rejected
  WARNING: kernel/liveupdate/kexec_handover.c:256 at kho_restore_page+0x1e9/0x4a0
  memfd_luo_finish+0x12c/0x370
  luo_session_finish+0x35/0x130
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Outgoing-session RETRIEVE_FD result:

  calling RETRIEVE_FD on outgoing session; this should be rejected
  WARNING: kernel/liveupdate/kexec_handover.c:256 at kho_restore_page+0x1e9/0x4a0
  memfd_luo_retrieve+0x224/0x9f0
  luo_session_retrieve_fd+0x124/0x320
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Incoming-session PRESERVE_FD result:

  [stage2] retrieved incoming session fd=4
  [stage2] preserving new fd on incoming session; this should be rejected
  [stage2] late preserve succeeded token=0x696e636f6d653032
  [stage2] finishing session should hit KHO restore WARN
  WARNING: kernel/liveupdate/kexec_handover.c:256 at kho_restore_page+0x11e/0x280
  memfd_luo_finish+0x6d/0x190
  luo_session_finish+0x31/0xa0
  Kernel panic - not syncing: kernel: panic_on_warn set ...

My read is that the ioctl paths need to enforce session phase/origin
consistently. A minimal direction would be:

  PRESERVE_FD: require !session->retrieved
  RETRIEVE_FD: require session->retrieved
  FINISH: require session->retrieved

An explicit immutable incoming/outgoing origin bit might be clearer if the
state machine is expected to grow.

The full report artifacts are available and were included with the original
mail sent to the other recipients:

  liveupdate_phase_origin_warn_panic.tar.gz

It contains two PoC directories, full QEMU serial logs, kernel configs, and
README files. I can resend the artifacts in plain-text-friendly form if that
is preferred.

I reproduced the panics on the 7.0.9 QEMU build above. I also checked the
current liveupdate userspace API documentation and current mainline source for
related semantics/source shape, but I have not yet runtime-tested current
mainline.

Thanks,
Chuyifei

