Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B760C95AB
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BA5vBbhp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OegWozdU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oLmDMwPd5/E7rKj+sTJUI9YQ2nm5m+orCk4a0Hb3xdc=; b=BA5vBbhpoCehzC
	Ebj9QSxoWwHSTHE9B0lrY2XWEzR7c0l805PxAZsgixG7g69S+WYXwVJuwOKu5JSzc8zlokcUwlflM
	lvjV/TZJKcqieaYGrXHvgek8/iZPgdtAAMcxTb/GcmnXrPfT4oM3CpXbieItIhPSvOQpKIcifryRC
	37rMX7KcnnmSdYfj1YgwnktgSik9Oc03zcczaX/15g6SBFn/mbwznQxdHBRknL04AoRzLQDUDKTBU
	WwINcoJ3SNYnjU1YIM7aHRi+eKw37W6j7eMqqrHfIaW+GeH5ZzyDnwgxOTOY53rqOiWjY4pxeAyZu
	zFPnePEnNDAzmWwa1TAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNttk-0000000H50F-07Ah;
	Mon, 02 Nov 2026 15:24:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNttj-0000000H4ze-0deg;
	Mon, 02 Nov 2026 15:24:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 91F2860054;
	Mon,  2 Nov 2026 15:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012281F00A16;
	Mon,  2 Nov 2026 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633074;
	bh=oLmDMwPd5/E7rKj+sTJUI9YQ2nm5m+orCk4a0Hb3xdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OegWozdUNrHGegNfTW2sm1HszSzrGzjh4ebMkWsD9u5gapIhy/O07QlRH3LV8M60J
	 //9uoOmD2XV9WnY62s/9qC5sYKTMOlS7YYqmfCV9USWy3TF92pR30R3sIC3bOI2cDl
	 eEYn+NqyCZgWe3RZrUPYTjFNI78jnhghKTiQ17RDj3pUBjadrdwq1A/MV0eG6aKps7
	 XvYJ1cpQlb/G4uhuL9+gJpBzSStLEg/xW7EREUkdqnqORUj3TCI9W+nv9Qji9Ee+7B
	 DnyLhoImoHxzQ28fH5V+87G43o48UQI/63qjJ9PF6kXAg+QKgEiJv0WhYMM43w1hXk
	 YkGa+9+0aqacQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:24 +0100
Subject: [PATCH RFC 14/27] profiling: let procfs copy in writes to
 /proc/profile
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-fs-v1-14-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
In-Reply-To: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZtnZ7+j/OHZGj1nwL6jF9VPBdIcnJPmE5lAHJaT+bVk=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGropzKjAwsxvRFdHBmiuO5usrlNmAf7XGR/a5n/gvJ3Bj8se
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmropzIACgkQkcYbwGV43KLjJQEA0hf3
 srBDq6EKvc+VG3c3zONfGz6/IVil9hzyZy3OB28A/RQHopfLUnFRNQfqy4yzV+dF++aZlDkaR57
 e/BjxgpoM
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and take the multiplier from that copy. Writes
larger than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/profile.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index e7defa90a34c..6e4b34f35e3b 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -189,16 +189,14 @@ int __weak setup_profiling_timer(unsigned mult)
  * Writing a 'profiling multiplier' value into it also re-sets the profiling
  * interrupt frequency, on architectures that support this.
  */
-static ssize_t write_profile(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t write_profile(struct file *file, char *buf, size_t count,
+			     loff_t *ppos)
 {
 #ifdef CONFIG_SMP
 	if (count == sizeof(int)) {
 		unsigned int multiplier;
 
-		if (copy_from_user(&multiplier, buf, sizeof(int)))
-			return -EFAULT;
-
+		memcpy(&multiplier, buf, sizeof(int));
 		if (setup_profiling_timer(multiplier))
 			return -EINVAL;
 	}
@@ -209,7 +207,7 @@ static ssize_t write_profile(struct file *file, const char __user *buf,
 
 static const struct proc_ops profile_proc_ops = {
 	.proc_read	= read_profile,
-	.proc_write	= write_profile,
+	.proc_write_buf	= write_profile,
 	.proc_lseek	= default_llseek,
 };
 

-- 
2.53.0


