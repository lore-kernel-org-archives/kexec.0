Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF29ACA0EDC
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ISjEkjC8pk4JCK0OiK8KgfrhGKpNxJkH87tiU/Whh2w=; b=QePGs91JlCZ7q6
	SEq2+kJhZ/liuZMOY1lzRn8j7KUVmHjfWwR64BI6xJ8D+unmsaqaj3SV6F+DLOnbEG5AizmvAEEL3
	rh2yWXGVrOsEvd23brniYO+S+hG6b+FwY30ubQCompt4K+Pg303tY16sqyQoAqboSUaaKlUMjLEMt
	FeJhmkE0HXf/ThE5GccpNW9V4JH8D8FJ1TGgFweHb2lCFXP022kOJOXHuORPv2PT903KmKH2dZrYo
	RwaaxwZGLzJaNI7AVY/4Vrk+u3qDpK8or1t5gmx2esVqbnDqZvGtvRAK/MB4axoS6L3H2cu1D0ols
	hBlN5LywiI1HX47KEGFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk6GX-00000007Juz-3U0n;
	Fri, 30 Aug 2024 18:22:33 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk6GV-00000007JuV-1WWH
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 18:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XWs/60Qc8mo1giESc1/N4HmXbyxb+7YdXNX6HnpRBCU=; b=OtV0fUNIDfaWkHgpb3KMRcLC3v
	AzZYRTyliGxqXDzs4pqNPXKUF3ZqTR7nkzVLMdYpleK34l5IOPZkmTr2NSTWTjJQnId1xGwP8paoS
	tit50STIJCBGTEZzWwifFzoqa6C+nfoluKliWxi+BjzVH+uvjE2q+Bwv2dpqSr3EITFJFNX2cNFJc
	IGiljaaIWKOjU5TXN9tG95F+gg5JL1UO8KK/VZpY833b07KbDEEc176FkJWbRCJp8O/8GYYn7NvGx
	6mczZSc8Lu7DXNpJC/DrR6lRXl2OVYzTzf5T47TuI+jhdBbjugqc+gY7FWc9bkQUFxbqVvYkLAJSU
	wzpbnmyg==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sk6GS-007FWw-Dk; Fri, 30 Aug 2024 20:22:28 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers description
Date: Fri, 30 Aug 2024 15:21:00 -0300
Message-ID: <20240830182219.485065-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_112231_424900_86D192CB 
X-CRM114-Status: UNSURE (   9.01  )
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

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2: Some wording improvements from Stephen, thanks!
Also added his review tag.

V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/


 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc52ddc6864..351730108c58 100644
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
+			can make the crashed kernel more unstable. In the
+			configurations where kdump may not be reliable,
+			running the panic notifiers can allow collecting more
+			data on dmesg, like stack traces from other CPUS or
+			extra data dumped by panic_print. Notice that some
+			code enables this option unconditionally, like
+			Hyper-V, PowerPC (fadump) and AMD SEV.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
-- 
2.46.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
