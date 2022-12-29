Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147FDC4332F
	for <kexec@archiver.kernel.org>; Thu, 29 Dec 2022 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HStYHE2OXQfiPhiCayhFTlJKShvCjzpD4sXjlM4UxXk=; b=ZCIIJIrSSHS2IF
	sLL2aEzuaGKxcOhRZzurwiO5O6RdyvdWQ5K4gaRa0zbijXS7kFxL961RmB3OeIFm+HbtvlMT85X8M
	LhF7ZoaRwuqny8cFUu5ns5hWeyqg5PcItFj37Ott2W3LoxMBYlcIpNeiPzrPDZ9H9xmM+IvxCRjMp
	GyXQzr/0Fnag/ygQPMXhuU0Rlbd4X8lgYBs7S/Cxu/7mU+VQDwbR3XE8llfEqUQ/LeLWaxm7FqS3Q
	c6EOEBBbp1IRLOAGEovk8dpOjoiVGxitnlxOIx5wfMiIP96fcxVlBZgQsKRxjiG57DVfSsPI6VM3P
	6naxAHwxXl7I+CnnV4rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAtD4-00GF5H-PN; Thu, 29 Dec 2022 13:44:38 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAtCx-00GEyQ-NR
	for kexec@lists.infradead.org; Thu, 29 Dec 2022 13:44:34 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1672321453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ONVoAOSV4R74Fcc+S7klnQwitE7KOgWX9DTWXdoRQo0=;
	b=TXVDMhPJGL1QCQYUmQxrJxkU/cypzAG1uj6UUvbwCzsXTADl0sr21wzpVAog+QM9x2iJo4
	P+4oDQub8fT4ZCwg74hqVrTA1HXclyuPqL+Qhrz9vXHJ1N0m+Zz31b9t8e382J+34Oy7Ct
	saOOgoK8aqg4YdOYU7lbfG4MUTmC+tJZ/khpoRJuvQwsU4GPbu8J8vn8eZfzuJJ5x7oGMl
	02RHJ23JJ6x/sfVcX2dlYTiWVFTp6J71bOtOoVKgkGMYQbtzEJMJkP6gQUoh0lDy6rVm8l
	2vShLjYpSiVzioTj9ycGy7eoFmN8DGyF7OEb+GcuJ2cDfO+jc0lNE8qbm3GQ7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1672321453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ONVoAOSV4R74Fcc+S7klnQwitE7KOgWX9DTWXdoRQo0=;
	b=DB3b0cWA02D46fic+goYCvu+45MlQLaUlbBt0nfXLXaSAlWlRPKVkCxgo3+sXPj+TLlwCI
	gAz9sAAlYmgnGsAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] docs: gdbmacros: print newest record
Date: Thu, 29 Dec 2022 14:49:39 +0106
Message-Id: <20221229134339.197627-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_054431_954389_A3B808A4 
X-CRM114-Status: UNSURE (   8.71  )
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

@head_id points to the newest record, but the printing loop
exits when it increments to this value (before printing).

Exit the printing loop after the newest record has been printed.

The python-based function in scripts/gdb/linux/dmesg.py already
does this correctly.

Fixes: e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")
Cc: stable@vger.kernel.org
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Documentation/admin-guide/kdump/gdbmacros.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kdump/gdbmacros.txt b/Documentation/admin-guide/kdump/gdbmacros.txt
index 82aecdcae8a6..030de95e3e6b 100644
--- a/Documentation/admin-guide/kdump/gdbmacros.txt
+++ b/Documentation/admin-guide/kdump/gdbmacros.txt
@@ -312,10 +312,10 @@ define dmesg
 			set var $prev_flags = $info->flags
 		end
 
-		set var $id = ($id + 1) & $id_mask
 		if ($id == $end_id)
 			loop_break
 		end
+		set var $id = ($id + 1) & $id_mask
 	end
 end
 document dmesg

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
