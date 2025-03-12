Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C686C28B28
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=; b=zzhlgvou5dALQiEOLXHwFQqKAv
	0EqSjlap9X7X9wQIhVv/xfxLG0NJPg0GI4frfcGABVAAUZ5aD0A9lJFvQBac4Qq8CYK3mgasjMH2N
	5M/BsvNBuw3U+1TDm+5MjRU0OrlYFEYyfNwnD28OWfTmYa5qN4/JNlFnJHxr0/iu0MWbpSq8KEn9d
	QtZNt0MUCl8e2HG4bdcqk+uP5pmp4T04zbOUZ1Axypv5Y8Wy5SlKCF7c+YWtrgHjdx45qFUymkC8S
	KxhWnAmNNH7yS8wWQN+d6FvChnclTgXaxjltm2lw5xnAXSpjz5WL5KCu4cd+DoiOHPgxuaARa9VaD
	MHjq8bBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsTLK-00000009VtQ-30TV;
	Wed, 12 Mar 2025 21:10:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsTKg-00000009Vq7-1tWP
	for kexec@lists.infradead.org;
	Wed, 12 Mar 2025 21:09:43 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id E633D21180;
	Wed, 12 Mar 2025 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=eAeVEYg1oKb/jqK3mj1MD6uelnRztRT+Vzy4iqSyyYRTRlZBOFW1mQtuPua1FSBjOaJKva
	HDGYWVfNDLK0XAL9qao+hp53cVGQZbIproq/k0A4UJ6cIf9L1ojmJsr72qH1OfAj0vrNIw
	Y6r36HEhUauJUjLQP7md4Juftp5E3m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=1frobXGW60b8vrjJwYPkDn6pGVf+XkrPnPKFop7agS5HVdl1fAaIxgbBH4Fjvm8mMSqO35
	QqFr6XizbBstmSAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=qabWvGZUC1x9OUycHRz36WT2uQtOBRORelgR6FwUS1uxVODB1QT1ss6bMSXVj94+3F2G9w
	rl6v94QXf4yf467sFcuh01Kykd/5B3lewjFpKOUUf7L4mqbBHfEcByM7eHic/EubPlkI5Z
	aA1pQONsL+pd7qgss9TQ6Ct1+GJY/gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=lH5LOpbQ5XWfsn/0nLeKkW6+/+JSqAG7hgW9fz47VXPAkcn3Qqa08Gfx4CG40fyfbfUppo
	B8Twq863Vbqz9lDA==
Date: Wed, 12 Mar 2025 22:09:39 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <Z9H4E82EslkGR7pV@dwarf.suse.cz>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:email,dwarf.suse.cz:mid,localhost:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_140942_634121_C6F4C96C 
X-CRM114-Status: GOOD (  15.26  )
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

Describe the new crashkernel ",cma" suffix in Documentation/

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 Documentation/admin-guide/kdump/kdump.rst     | 24 +++++++++++++++++--
 .../admin-guide/kernel-parameters.txt         | 22 +++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5376890adbeb..0a7ec98c74fa 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -315,6 +314,27 @@ crashkernel syntax
 
             crashkernel=0,low
 
+4) crashkernel=size,cma
+
+	Reserve additional crash kernel memory from CMA. This reservation is
+	usable by the first system's userspace memory and kernel movable
+	allocations (memory balloon, zswap). Pages allocated from this memory
+	range will not be included in the vmcore so this should not be used if
+	dumping of userspace memory is intended and it has to be expected that
+	some movable kernel pages may be missing from the dump.
+
+	A standard crashkernel reservation, as described above, is still needed
+	to hold the crash kernel and initrd.
+
+	This option increases the risk of a kdump failure: DMA transfers
+	configured by the first kernel may end up corrupting the second
+	kernel's memory.
+
+	This reservation method is intended for systems that can't afford to
+	sacrifice enough memory for standard crashkernel reservation and where
+	less reliable and possibly incomplete kdump is preferable to no kdump at
+	all.
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..895b974dc3bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -987,6 +987,28 @@
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
+	crashkernel=size[KMG],cma
+			[KNL, X86] Reserve additional crash kernel memory from
+			CMA. This reservation is usable by the first system's
+			userspace memory and kernel movable allocations (memory
+			balloon, zswap). Pages allocated from this memory range
+			will not be included in the vmcore so this should not
+			be used if dumping of userspace memory is intended and
+			it has to be expected that some movable kernel pages
+			may be missing from the dump.
+
+			A standard crashkernel reservation, as described above,
+			is still needed to hold the crash kernel and initrd.
+
+			This option increases the risk of a kdump failure: DMA
+			transfers configured by the first kernel may end up
+			corrupting the second kernel's memory.
+
+			This reservation method is intended for systems that
+			can't afford to sacrifice enough memory for standard
+			crashkernel reservation and where less reliable and
+			possibly incomplete kdump is preferable to no kdump at
+			all.
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


