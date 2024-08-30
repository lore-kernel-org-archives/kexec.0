Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27953CA0FF7
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QB7l1mPyQDPekjveN0axiucuWKtnZp2Hr4BdRnQveC0=; b=Is6WANb+OXdVim
	ozqylP3EBE8NDIiy69zw1sokprPl/Vb2yESAotVG9tLTJNVl9wj9fuTUeS9SziX1uFZBLFcFS4TFe
	xWqfKex8ErCOG/7CU+XLbr9My39hdg1hNzmdSbc0CMWfD7efsemDa4VOx4OVrbzaNtdIUi3qTsB8H
	gi9mueUoQ0/OXF+Cq08ruka7L2Y5UM6g2vAlLTnrjey/m0V3adkPL6VfDnPktSXvSo3uvwYgRevSu
	4J6+ygMUTL+2Dyr3B+NUc37iCUD6bBlvxHUS/atzk9HaZrdNtQ1uNdw4dFW/XHorMyghyjoxp4zto
	hfAfrfSOKZ7a/mjVF2nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2GF-00000006X5X-0vhd;
	Fri, 30 Aug 2024 14:05:59 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2Ep-00000006WgP-3vry
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 14:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=g7u3JY1dUMc3W4JVQxtJZrZEzcHPVuAghUUeOne4iAY=; b=oV0O0fTBZZfPvlMEar3HxRPa0R
	60yLSGtHnZeL//MGhGu2vHwUSUo5HxT8qquoOyBGnBJNR7LJE1NUbQ05R0hqFX+0Fi/e1l1wa/ctr
	G8fnCLEOVdVU2mg3Dnc3k7sAP1m2w0+tnKWn+lFobslVpqkPbK2uPvDm3wmQgxMBnbntetzGHLqiD
	+oiuRhbx7V/x2BisNbLierYpDp154lb/OHLrlQgI46cSo8M9hj/zPAiXTCmZz4bZVOhI8CeNi7b3l
	XcKv2NoG3gg0a2k/b1ezD4vA3ZLg6YmD7aRuiBwc4eZ5ixf21Q4aNuCakkxZDC6BvpILj+qISMj/v
	gK6Dsy4Q==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sk2Ea-007AjX-Ae; Fri, 30 Aug 2024 16:04:16 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: Improve crash_kexec_post_notifiers description
Date: Fri, 30 Aug 2024 11:03:22 -0300
Message-ID: <20240830140401.458542-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_070432_304133_72E61738 
X-CRM114-Status: UNSURE (   9.16  )
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
Cc: bhe@redhat.com, corbet@lwn.net, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, stephen.s.brennan@oracle.com, kernel-dev@igalia.com, dyoung@redhat.com, vgoyal@redhat.com, linux-debuggers@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Be more clear about the downsides, the upsides (yes, there are some!)
and about code that unconditionally sets that.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc52ddc6864..cb25dc5cbe9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -913,12 +913,16 @@
 			the parameter has no effect.
 
 	crash_kexec_post_notifiers
-			Run kdump after running panic-notifiers and dumping
-			kmsg. This only for the users who doubt kdump always
-			succeeds in any situation.
-			Note that this also increases risks of kdump failure,
-			because some panic notifiers can make the crashed
-			kernel more unstable.
+			Only jump to kdump kernel after running the panic
+			notifiers and dumping kmsg. This option increases the
+			risks of a kdump failure, since some panic notifiers
+			can make the crashed kernel more unstable. As a bright
+			side, it might allow to collect more data on dmesg like
+			stack traces from other CPUs or extra data dumped by
+			panic_print. This is usually only for users who doubt
+			kdump will succeed every time. Notice that some code
+			enables this option unconditionally, like Hyper-V,
+			PowerPC (fadump) and AMD SEV.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
