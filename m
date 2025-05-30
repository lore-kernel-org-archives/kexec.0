Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443E0C5AD49
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V683jXcvBO/wNHAZuQXuIAcraBnYtRvfHmOlvfeKHUA=; b=AgAh6w1t3pmbonMQaYOtoKbzG6
	B6JpkDnEvaxtYx+nixgPEX7dxL3bAi2hN+AhdQELdZpTua0TJ6vnzHeC0xCzu9il4z56k5j9t7n7g
	BNHmSu0x4QzEiEGB7+owpBShTeE6yQfJP1oQdqjITDgnkGNYToHd2738+8mMTnsRHqzVfYpuIIMmQ
	LWex3za7oOFM1T3DHd+ZCakLAJf16uL9CeSJV4ZGaD5agvo55eHEEiARjdHCJLuhkHLcUDVVgfQ44
	K5XQdzCXyClhPChcYqIfW3Zm1Q5pGiaVTrqCS9tGtOojZZobPq4zCVKEjLrth6oGERJGNCoNwT8QH
	hJdlmQQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL6LK-00000001ncK-3TvE;
	Fri, 30 May 2025 20:28:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL6LJ-00000001nbu-0lsq
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 20:28:42 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id AAFF61F45A;
	Fri, 30 May 2025 20:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748636919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V683jXcvBO/wNHAZuQXuIAcraBnYtRvfHmOlvfeKHUA=;
	b=vRUObJAvyUV8tetCrYJ9QxCbGrleRnbzLbScu36vYFTLrxCgEgObgvGeBl4a8F0Yu52rB9
	tBDXeLbvy/S7VYp489G4kHklWdiAr3gBuc/XfrBknpmmCuJnJhbYJPlWTUEiyRKNoKhA5h
	1dyScj+vRyp2Hgr+TZ3uYWAlQmsD42E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748636919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V683jXcvBO/wNHAZuQXuIAcraBnYtRvfHmOlvfeKHUA=;
	b=AUc3mLC5ImAbsKHOPaSiivAFkw0ONXDoPjlYRoLEfdtOxryA8PHrHKlN6MMP/qm9PgNBgi
	cxWqV+YWIPqHf3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748636919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V683jXcvBO/wNHAZuQXuIAcraBnYtRvfHmOlvfeKHUA=;
	b=vRUObJAvyUV8tetCrYJ9QxCbGrleRnbzLbScu36vYFTLrxCgEgObgvGeBl4a8F0Yu52rB9
	tBDXeLbvy/S7VYp489G4kHklWdiAr3gBuc/XfrBknpmmCuJnJhbYJPlWTUEiyRKNoKhA5h
	1dyScj+vRyp2Hgr+TZ3uYWAlQmsD42E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748636919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V683jXcvBO/wNHAZuQXuIAcraBnYtRvfHmOlvfeKHUA=;
	b=AUc3mLC5ImAbsKHOPaSiivAFkw0ONXDoPjlYRoLEfdtOxryA8PHrHKlN6MMP/qm9PgNBgi
	cxWqV+YWIPqHf3Aw==
Date: Fri, 30 May 2025 22:28:39 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v4 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <aDoU9_xxl7SP7S_o@dwarf.suse.cz>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_132841_377716_83821183 
X-CRM114-Status: GOOD (  13.77  )
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
 Documentation/admin-guide/kdump/kdump.rst     | 21 ++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         | 22 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 1f7f14c6e184..089665731509 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -311,6 +311,27 @@ crashkernel syntax
 
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
index ea81784be981..ee6be52dd8a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -983,6 +983,28 @@
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


