Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45676D13585
	for <kexec@archiver.kernel.org>; Sun, 27 Oct 2024 20:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=v3QOf+ZHpKl77WcmXrUUeGXBuk2PXxdX9T+Il+iSJdc=; b=DdnhSSUwp1DMt8
	H+UDlCWgLsi63L0YA5wDo3RkpEHKC8/+jxpOUZ263+15wmPPGPVuB6fys6a2gn1O42MeBknZpWev9
	EXJ5qS4dFjkw2aPkemmPfmdTiy00w/CSq+EJ1x3cJf6QgchZDIZHUQ/N/O55IoEgQ0SjMD/T1y6y8
	xALJKxyMN8owoJk74N6sNaOQXP/jfz0o2gMxs5ipl29pSNXMnakS++EEb1z45alFTHGbaVylJfIET
	104jFWJ+KsU2Qw2dBLIOrcCJcyKW1ObOcEw27KlEscmtNanZ+OSLMulXs3+FbiaiMD4E+wIkdF9g5
	75Gw/dNsLoksJYCnvECw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5A7U-00000008s8u-219G;
	Sun, 27 Oct 2024 20:44:16 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5A5a-00000008rYJ-1erU
	for kexec@lists.infradead.org;
	Sun, 27 Oct 2024 20:42:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FxIReQk1S15DxmmdigQ/aBi+z2bQeCrpB1btCYSB/wQ=; b=D7TzJVsxo2l8g8syJxk4o1O1sG
	I8FSJam1xhJuzwqGa5XuazVMdRCj87qWp2kLoUoEpeh/N3r2G/PA0gwf0t91EHRNkUnzFsrmq/Y2+
	5wNQJWWCfInlUzQQot0JDeCyLHXvll3RA3WB+C93fykW3BDsaFgkdK0H8Tcv1FLONeob0z3QzJaJQ
	owuTzuHsMXzVHiv1cs3KMOjGNskSLKU+BR9dw8e8+9XoUDVmgA7nKQYQm+xk1qhQA7xTgAnZt595x
	RxMUsTqdLGDj1WMesZ8Zgab3RejU3yqL2H5EYUOdCyW12On5w6u/bUXKsP/6OO37GQeDweIvTtwke
	MCHXDkZg==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t5A5N-00Fpx6-MO; Sun, 27 Oct 2024 21:42:06 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH V4] Documentation: Improve crash_kexec_post_notifiers description
Date: Sun, 27 Oct 2024 17:36:58 -0300
Message-ID: <20241027204159.985163-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_134218_455624_714BA206 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: kernel-dev@igalia.com, bhe@redhat.com, corbet@lwn.net, mhklinux@outlook.com, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, stephen.s.brennan@oracle.com, horms@kernel.org, dyoung@redhat.com, vgoyal@redhat.com, linux-debuggers@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The crash_kexec_post_notifiers description could be improved a bit,
by clarifying its upsides (yes, there are some!) and be more descriptive
about the downsides, specially mentioning code that enables the option
unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more recently,
AMD SEV-SNP[2].

[0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before running crash kernel").
[1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic").
[2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump").

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V4:
* s/AMD SEV/AMD SEV-SNP/ for better clarity, since there are more variants
of AMD SEV - thanks a lot Michael Kelley for the good explanation.

V3 link, including interesting clarifications about AMD SEV variants, by
Michael: https://lore.kernel.org/r/20241025162042.905104-1-gpiccoli@igalia.com/


 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3978fb704c53..1dbd0b0df6fe 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -918,12 +918,16 @@
 			the parameter has no effect.
 
 	crash_kexec_post_notifiers
-			Run kdump after running panic-notifiers and dumping
-			kmsg. This only for the users who doubt kdump always
-			succeeds in any situation.
-			Note that this also increases risks of kdump failure,
-			because some panic notifiers can make the crashed
-			kernel more unstable.
+			Only jump to kdump kernel after running the panic
+			notifiers and dumping kmsg. This option increases
+			the risks of a kdump failure, since some panic
+			notifiers can make the crashed kernel more unstable.
+			In configurations where kdump may not be reliable,
+			running the panic notifiers could allow collecting
+			more data on dmesg, like stack traces from other CPUS
+			or extra data dumped by panic_print. Note that some
+			configurations enable this option unconditionally,
+			like Hyper-V, PowerPC (fadump) and AMD SEV-SNP.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
