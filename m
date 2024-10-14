Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2BDD18129
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sostmU9U9Tj+OzNghj8Ih6uxRKkuLL55lHT4K8a/qi4=; b=AonwRq8n6qHi6R
	TdaAjWNyDiEc+iQIcfUBkvP24YtIn0KlvhGe1xlz5AaoM7i/GqqyIsqggAAimLd9gdwjUZ3hwDtYP
	Mzy+8BQ62fLfKmMLTLrqL0ieXVpuRJ//ibZGhZ1s/nxwe1NwGP7lrPHvF8gUfnlHT6kdCRtRgZ/TT
	h/0PRfmM1iniQXIZ1MmgZRl/E4vE7rqZl+fIBiCEDGZ9//cxQMXoxB/NGmhPtNFghJiv7cfl1yxgo
	CqeJafZ7oQwdyJ0rT/C0Mm2gzd1es+WAK4FulLoD4zY4WHpwc59VFQkrSbo0UdDcwtOrtSPl88u84
	4MSpLKyAcmpptXUe0WhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N99-00000005iRy-2NH2;
	Mon, 14 Oct 2024 15:38:11 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N2o-00000005f8Q-29Gz
	for kexec@lists.infradead.org;
	Mon, 14 Oct 2024 15:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728919899; x=1760455899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vXkoVNytN+Hs1P12AdrrKQuvzn46CbV56pdzNqiusdQ=;
  b=cWzl8q86oV8HI6OJ3XLL9k2wfSndnA0czDJMQW2xX8y9tj8KAELIZhnh
   OEZBrxBBG0zNIuDN6Z1Qbc0ugIyATmwoZO86CCpnBEkkwqCacV7XsqMhC
   OUeibahjeOWXWD0m5fHo9LJhGFfoaSgz0B0fDp4//hFEzcQFHpSsb0aNI
   PbJ1YjJtVaJNViNXDBHRNawI07nFQpN8T9b/+dPJsoE/c4TbPzfkuZQX8
   VpSmmZNzfk6bqca/wmo7Y9niqhlOBxHA8sU787C0pzEeoVpJqO28KHFwK
   a9w2xN27ueQaZNTktDeWf21dgYIBmxB8EkliI/4Xz/9qFnqwIHsAV2VWK
   w==;
X-CSE-ConnectionGUID: IpurJe5HSM+B+dI//qlkjA==
X-CSE-MsgGUID: Mk5HvdjpQE2v6iG+rN5tbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39399311"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39399311"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 08:31:34 -0700
X-CSE-ConnectionGUID: mZ/QdLCpRs6ACbGKyQYlLQ==
X-CSE-MsgGUID: PmdWuYaoRue3qdmOtMkG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82168515"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 14 Oct 2024 08:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 41A5E2ED; Mon, 14 Oct 2024 18:31:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] build: Update configure.ac to follow the changes
Date: Mon, 14 Oct 2024 18:31:29 +0300
Message-ID: <20241014153129.295176-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
References: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_083138_646002_7547D874 
X-CRM114-Status: UNSURE (   9.00  )
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

Running bootstrap on Debian spills a few problems in configure.ac.
Update it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 configure.ac | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8dcd4f57bdfb..a3cf34a33777 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl
 dnl 
 
 dnl ---Required
-AC_INIT(kexec-tools, 2.0.29.git)
+AC_INIT([kexec-tools],[2.0.29.git])
 AC_CONFIG_AUX_DIR(./config)
 AC_CONFIG_HEADERS([include/config.h])
 AC_LANG(C)
@@ -92,25 +92,25 @@ if test "x$TARGET_CFLAGS" = "x" ; then
 	TARGET_CFLAGS='-O2 -Wall'
 fi
 
-AC_ARG_WITH([objdir], AC_HELP_STRING([--with-objdir=<dir>],[select directory for object files]),
+AC_ARG_WITH([objdir], AS_HELP_STRING([--with-objdir=<dir>],[select directory for object files]),
 	[ OBJDIR="$withval" ], [ OBJDIR="$OBJDIR" ])
 
 AC_ARG_WITH([gamecube],
-		AC_HELP_STRING([--with-gamecube],[enable gamecube support]),
+		AS_HELP_STRING([--with-gamecube],[enable gamecube support]),
 		AC_DEFINE(WITH_GAMECUBE, 1,
 			[Define to include gamecube support]))
 
-AC_ARG_WITH([zlib], AC_HELP_STRING([--without-zlib],[disable zlib support]),
+AC_ARG_WITH([zlib], AS_HELP_STRING([--without-zlib],[disable zlib support]),
 	[ with_zlib="$withval"], [ with_zlib=yes ] )
 
-AC_ARG_WITH([lzma], AC_HELP_STRING([--without-lzma],[disable lzma support]),
+AC_ARG_WITH([lzma], AS_HELP_STRING([--without-lzma],[disable lzma support]),
 	[ with_lzma="$withval"], [ with_lzma=yes ] )
 
-AC_ARG_WITH([xen], AC_HELP_STRING([--without-xen],
+AC_ARG_WITH([xen], AS_HELP_STRING([--without-xen],
 	[disable extended xen support]), [ with_xen="$withval"], [ with_xen=yes ] )
 
 AC_ARG_WITH([booke],
-		AC_HELP_STRING([--with-booke],[build for booke]),
+		AS_HELP_STRING([--with-booke],[build for booke]),
 		AC_DEFINE(CONFIG_BOOKE,1,
 			[Define to build for BookE]))
 
@@ -245,4 +245,5 @@ AC_SUBST([OBJDIR])
 AC_SUBST([INSTALL])
 
 dnl ---Output
-AC_OUTPUT([Makefile])
+AC_CONFIG_FILES([Makefile])
+AC_OUTPUT
-- 
2.43.0.rc1.1336.g36b5255a03ac


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
