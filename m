Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9CCC021B1
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=; b=FNyzqctHuNyHAkSe0+foUsBOsy
	e7L2bNSNdNN6pWYT3GJIVlyK8eYk3XIJdxfq78vcjtHI7/rHJqUrlssDZblQnoi0zTeK7VwGaKSkb
	R5ZtVuKHIoY0ntbegDj5NpqA8k6GJwtn3swNujKUa1QhcqEdsLtjW3vUfpDpI66qk5aUMebcPrIc0
	HwwhnqUXLWQ52/XUcIt980nTAhzqvnrCkUBUpM4clYjN3adbu+pqb2J7gLsc3A1SE9JZFw0FE82Cm
	uByc1k1tx6FqCqSwzzbI1Ea0RQKpRHWwUuygsKSw0+8u4ey7IW0Ypk71YQUKd0R1jngbbmAKYeqLE
	YkbbdxFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9qj-00000001zm5-1ImF;
	Thu, 20 Feb 2025 16:56:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9of-00000001zAP-40LS
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 16:54:27 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7976721186;
	Thu, 20 Feb 2025 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=XTMerqX0GICjNsYCmpT3d86Y5d/iCOx3eeIgF+zW9pC0xqJUBLi1xpGj28SIdC6SbeWbMa
	7NpY3W4Q9XcH8kNohCHJQ5QQWWzOPd1txXDLDLIIh5qQmdD73YynIG3U3SSssZMdl78yqh
	Uc7N/GG8qI0ZFM7ZFs7VsucAXvt/wCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=eaoodYHMSTrDFPSZZoxEeoyhBJcAyVrRgb032l5UFSC5tZ7yzLRtWRtBEwYIhzM6LA/9La
	Q5TByx/Su9H0/ZDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=XTMerqX0GICjNsYCmpT3d86Y5d/iCOx3eeIgF+zW9pC0xqJUBLi1xpGj28SIdC6SbeWbMa
	7NpY3W4Q9XcH8kNohCHJQ5QQWWzOPd1txXDLDLIIh5qQmdD73YynIG3U3SSssZMdl78yqh
	Uc7N/GG8qI0ZFM7ZFs7VsucAXvt/wCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wakkuwf1ugz5t/UIuNizagYe9kFHhtgEfpZOsreDN3A=;
	b=eaoodYHMSTrDFPSZZoxEeoyhBJcAyVrRgb032l5UFSC5tZ7yzLRtWRtBEwYIhzM6LA/9La
	Q5TByx/Su9H0/ZDw==
Date: Thu, 20 Feb 2025 17:54:24 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v2 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <Z7deQKy1F8BW1ibi@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.785];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,localhost:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_085426_136704_F9B8FB1C 
X-CRM114-Status: GOOD (  16.35  )
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
---
 Documentation/admin-guide/kdump/kdump.rst     | 19 +++++++++++++++++--
 .../admin-guide/kernel-parameters.txt         | 14 ++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5376890adbeb..3f7ff301c604 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -213,8 +213,7 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
    kernel.
 
    Otherwise it should be the start of memory region reserved for
-   second kernel using boot parameter "crashkernel=Y@X". Here X is
-   start of memory region reserved for dump-capture kernel.
+   second kernel using boot parameter "crashkernel=Y@X". Here X is start of memory region reserved for dump-capture kernel.
    Generally X is 16MB (0x1000000). So you can set
    CONFIG_PHYSICAL_START=0x1000000
 
@@ -315,6 +314,22 @@ crashkernel syntax
 
             crashkernel=0,low
 
+4) crashkernel=size,cma
+
+   Reserves additional memory from CMA. A standard crashkernel reservation, as
+   described above, is still needed, but can be just big enough to hold the
+   kernel and initrd. All the memory the crash kernel needs for its runtime and
+   for running the kdump userspace processes can be provided by this CMA
+   reservation, re-using memory available to the production system's userspace.
+   Because of this, the CMA reservation should not be used if kdump is configured
+   to dump userspace memory - the re-used memory ranges won't be in the vmcore.
+
+   This option increases the risk of a kdump failure: DMA transfers configured
+   by the first kernel may end up corrupting the second kernel's memory. This
+   reservation method is intended for systems that can't afford to sacrifice
+   enough memory for standard crashkernel reservation and where less reliable
+   kdump is preferrable to no kdump at all.
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..ea4d53435515 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -987,6 +987,20 @@
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
+	crashkernel=size[KMG],cma
+			[KNL, X86] Reserve additional crash kernel memory from CMA.
+			This reservation is usable by the first system's userspace,
+			so this should not be used if dumping of userspace
+			memory is intended. A standard crashkernel reservation,
+			as described above, is still needed to hold the crash
+			kernel and initrd.
+			This option increases the risk of a kdump failure: DMA
+			transfers configured by the first kernel may end up
+			corrupting the second kernel's memory. This reservation
+			method is intended for systems that can't afford to
+			sacrifice enough memory for standard crashkernel
+			reservation and where less reliable kdump is preferrable 
+			to no kdump at all.
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


