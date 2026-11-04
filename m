Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85EC606A85F
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KDVW9UM9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtF7Ltpa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=axjAzDMxe/T5Kt/VR9558Sdu9PB/HLdF+q053OKTtnM=; b=KDVW9UM9rDw2Ng
	e11FS/9h2q6DhOAHvtUCByFyFvqoQ3CkcOfK4r62A2tnqlhkL775QslKfS8uM06IqLO4sq9XfJNAu
	oJ1R+Uhi8nZvYnlACxlQUG3GoEFMA9uPGLOs4y+6JXcjpKYMPtbOEusRAmf9w4B+DOnsSThcvhRrp
	GcGzwfOwWOdT7MLmQddeDiVQzm8pYxXhFbZvM12ZPJNaRHxf3/jHk+Lt0NJcBNU8mdjRrTxf3JRVp
	mmZ3tsfk0gywNNqUY/ZlYm+Zib0yK92zdMlxQ9Zy3ILAxl2Rm0VBHcPyS5Ee1ze/JJuYl6RyoAl9V
	XSZJxDB1lgrg27lLAAIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgVA-00000006YQn-1wKD;
	Wed, 04 Nov 2026 19:18:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgV9-00000006YQT-0zdA;
	Wed, 04 Nov 2026 19:18:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A84D260A7C;
	Wed,  4 Nov 2026 19:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB61F00919;
	Wed,  4 Nov 2026 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819906;
	bh=axjAzDMxe/T5Kt/VR9558Sdu9PB/HLdF+q053OKTtnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtF7LtpaCnKrvS5VracHtmez/lTDVmZLEAJMPsf5RyRtHK8331ZbVhu/+wfqQSNNp
	 k5kqnIbPjR6sVpgI8dl+aRQlbCOs2pnczhaDMKEZx/ZWxJhKcA7brLV8fiEaMbiuh9
	 MFwalEMmSkSmMudfVxnNahrVfbIp17CK1joRPuayEeMp2faKCSbZvgOaORRjZAcf99
	 D+S/7ltnAyBBNuf+VXhjPvzz/9hi+4KRi6bMiJuG/7hKYOJ5c3GtlY1t4+Db/rkvuL
	 jH/DdCnBKpMBBqg0/ET26Tl25sQsMCrXwsOIkyA5elhHUZdHUYVdfAatvui3m3bHkd
	 QSod2kP355CYg==
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
Subject: [PATCH RESEND v2 09/51] profiling: report it when /proc/profile can't be created
Date: Wed,  4 Nov 2026 20:18:12 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-9-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=brauner@kernel.org; h=from:subject:message-id; bh=tYIXM5EjsYRFpz3d9CdZ23LhMvzI2JA5U8qSrxldqzY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9brwqovU2YO3sJayOU6SjJt6WZHyobvyDXUfg5ueIY sXw4vmmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh/8rIcHlz85mzfw/yeois tZ+X+nK/Y0nbTtuVF6duv2wgyFZ5PYmR4ROf8bk1y/9m+Rgw5Xqu+ydQsSxzObvU5rn/LzCHben y4gIA
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

create_proc_profile() returns 0 whether proc_create() worked or not, so
a write to /sys/kernel/profiling that turned profiling on but didn't
get the file reports success and there is no file to read the profile
from. Return -ENOMEM like the other failures of that write do.

Fixes: 22b8ce94708f ("profiling: dynamically enable readprofile at runtime")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/profile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index e7defa90a34c..820d5ec909d4 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -216,15 +216,15 @@ static const struct proc_ops profile_proc_ops = {
 int __ref create_proc_profile(void)
 {
 	struct proc_dir_entry *entry;
-	int err = 0;
 
 	if (!prof_on)
 		return 0;
 	entry = proc_create("profile", S_IWUSR | S_IRUGO,
 			    NULL, &profile_proc_ops);
-	if (entry)
-		proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
-	return err;
+	if (!entry)
+		return -ENOMEM;
+	proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
+	return 0;
 }
 subsys_initcall(create_proc_profile);
 #endif /* CONFIG_PROC_FS */

-- 
2.53.0


