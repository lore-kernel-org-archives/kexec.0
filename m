Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493B606EE85
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2CIzu0BX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ME/FJRfX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RCWYzTdROaZ//Ublq96X/PsjFPNs26aKqDomYMjplOg=; b=2CIzu0BXxvWehu
	BZufivIBizJAMLSLlkCTWFPLEbPOMHEP3NKEvTKIG4KKoXjS1Dp1NhFwqThP2NNlIgdosREXVwxJ4
	s0TaGJrh8vkzs+DjVVGLws4RFk/eEEeZhd+dBy5pQKcoQr5UcQV0WwK3/7TFxAq3FLy1Nn0F3kDgf
	79Eq7NL4dRzPCsx5vIBlW+oneM3XlkXswjsJdJuMOmhSAKDfxXnDAf2YUkwBTaoGy2HIZUS9JQixh
	LHvROAVskMyaA/ProFQvbkVU2+cmMO1Eil8bQC3+e5K/1rmEWfHfFd2oC7Eo4xzLeCiqwV1z5bd3C
	WOwHAlD3bXX3ilVa5GKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgmG-00000006g37-0hJw;
	Wed, 04 Nov 2026 19:36:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgmF-00000006g2t-0DFN;
	Wed, 04 Nov 2026 19:36:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B748743B3B;
	Wed,  4 Nov 2026 19:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AA31F000C1;
	Wed,  4 Nov 2026 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820966;
	bh=RCWYzTdROaZ//Ublq96X/PsjFPNs26aKqDomYMjplOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ME/FJRfXHJFiJdRPuFY8HbJeu+GJeM1uYMSHhRXC3OyCBFoBbHe/D+KeCbkSHUcc+
	 kLRnw4KPAQXBd/Lm2rxl+osnRqATeVzThclIJcTYxyw83fwPKWjsdttrzz2MJEJ/6F
	 npCV8gjOwaHDC61e0ru1NTfEA8b0b9x7dSf/HzSrhuivx0LurSS5jZoyjtt0F/X5HF
	 VXCm5Gcq8bWGfXJvVTfcnPDEXQVmN0yImiDrAgCIzYQ7ciRBherm+QOR9W6FvpFf9V
	 +E2b6pif2bObHvbMb8emuD8Je5Z+LHQE+m9YVr5ffRfEUXrIRpnoiS5t/MTpZE9nue
	 yYDTpnmmsO8rw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: [PATCH RESEND v2 01/23] alpha: srm_env: let procfs copy in writes
Date: Wed,  4 Nov 2026 20:35:52 +0100
Message-ID: <20261104-work-procfs-arch-v2-1-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=brauner@kernel.org; h=from:subject:message-id; bh=ud6jo66qun6GxlQdhdvRvLMRIAP9XF8+raIGbqJmJWQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97ngrnBxmYyak9tmw1FJNeJLkRYtVzupn21htlqi1O tScYHfuKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjpJkaGRUtzVix3XJqTVWf1 dU6h87OwGM+PZ2ve597KXb144TfGWIZ/ZoovQk90zVv4S5HDJPnSp5RpZyfb5iyb8PbjaTdr44T nLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement ->proc_write_buf() so procfs copies in what is written to
/proc/srm_environment/* before it pins the entry, and hand that copy to
the console callback through the page it used before.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/alpha/kernel/srm_env.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/srm_env.c b/arch/alpha/kernel/srm_env.c
index faafc2df7886..6a1742b09a82 100644
--- a/arch/alpha/kernel/srm_env.c
+++ b/arch/alpha/kernel/srm_env.c
@@ -81,7 +81,7 @@ static int srm_env_proc_show(struct seq_file *m, void *v)
 	return ret;
 }
 
-static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
+static ssize_t srm_env_proc_write(struct file *file, char *buffer,
 				  size_t count, loff_t *pos)
 {
 	int res;
@@ -92,13 +92,8 @@ static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
 	if (!buf)
 		return -ENOMEM;
 
-	res = -EINVAL;
-	if (count >= PAGE_SIZE)
-		goto out;
-
 	res = -EFAULT;
-	if (copy_from_user(buf, buffer, count))
-		goto out;
+	memcpy(buf, buffer, count);
 	buf[count] = '\0';
 
 	ret1 = callback_setenv(id, buf, count);
@@ -109,14 +104,13 @@ static ssize_t srm_env_proc_write(struct file *file, const char __user *buffer,
 		res = (int) ret1;
 	}
 
- out:
 	free_page((unsigned long)buf);
 	return res;
 }
 
 static const struct proc_ops srm_env_proc_ops = {
 	.proc_show	= srm_env_proc_show,
-	.proc_write	= srm_env_proc_write,
+	.proc_write_buf	= srm_env_proc_write,
 };
 
 static int __init

-- 
2.53.0


