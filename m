Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA75FD149C5
	for <kexec@archiver.kernel.org>; Fri, 25 Oct 2024 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VAs9fggr4BGdNJ68lpNK7nB+tuU5j36kCouUs8GVD4c=; b=j7EVzFm+3pxatH
	CEfzgB1R8T7IOuaN/jOZ9JI83nqhNpm5CfotWddIfsWX1emxEpsZSjtw0XpGnBMZYIcqWlGkJDEG1
	SBenGxghVItNYG2K2eppnHV2y3YOnbopuaG3kVLlh06rUv1VY8TT7jAw8p9ZOudaatqm7S/lX2upH
	GET3FwphwQa2bFEJFXuEItHvZQH6wGR0gqHCDGmw9HoMYU0RvAF78PYBBOxXpSvaHZW7m6EllCeul
	O7P++ElxTu2MN6Nh5vBXVqg7EzN8n3OLeufAX6bhinMbXlfyo4cMKV/nTGJscP8FdEWhQiG8+991G
	kp6Mso7UIA7eEQ5kPRpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4N7o-00000004QuG-3Kdk;
	Fri, 25 Oct 2024 16:25:20 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4N3f-00000004PCV-1K5d
	for kexec@lists.infradead.org;
	Fri, 25 Oct 2024 16:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EHLpWcwrtqUoy9yZdOs2vFLOu6EebO+piZZlDeFdZ2U=; b=YbG4Yt1fz5SrBiorVVGTzoxFeJ
	BhofV7UIxCiw/O7cutk+kz6WvBmC3k7ykYF4pUi6Z41Y6UYNkseVt0/GgfigbyWDEAiyY4Seab18d
	qoAmreG73WYGcrQoiJnm5C1E5e0fnuHLmy8r/TujFw69CXkl9j8jpFNsDKCRo5EjjK/B9F3WeMKof
	feMj6hD08D7rHFaMNeGwde8yIbz3T+m0QRWT8e5R/yy3vJTbOjp/mDajPO7WEJJMKc9TPUtvtOBTp
	6Ni5Z62vjOyA5HYEFgC4gDu79/x6kDOtLC2DwdWldwyENU8OkTUe+Td1/VEXNbvhdFgi1bqn+J4FG
	K11pt7BQ==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t4N3P-00F5mK-VM; Fri, 25 Oct 2024 18:20:48 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH V3] Documentation: Improve crash_kexec_post_notifiers description
Date: Fri, 25 Oct 2024 13:18:20 -0300
Message-ID: <20241025162042.905104-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_092105_136518_14EFE421 
X-CRM114-Status: UNSURE (   9.92  )
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
Cc: kernel-dev@igalia.com, bhe@redhat.com, corbet@lwn.net, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, stephen.s.brennan@oracle.com, horms@kernel.org, dyoung@redhat.com, vgoyal@redhat.com, linux-debuggers@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The crash_kexec_post_notifiers description could be improved a bit,
by clarifying its upsides (yes, there are some!) and be more descriptive
about the downsides, specially mentioning code that enables the option
unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more
recently, AMD SEV[2].

[0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before running crash kernel").
[1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic").
[2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump").

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V3: Improved wording and commit description, detailing more about the addition
of code that enables crash_kexec_post_notifiers unconditionally.

Thanks Baoquan and Simon for the suggestions!


 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3978fb704c53..2a7a523bb90b 100644
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
+			like Hyper-V, PowerPC (fadump) and AMD SEV.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
