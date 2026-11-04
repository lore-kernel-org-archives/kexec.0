Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C67606D618
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VALbWOze;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpyBwaL0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=axjAzDMxe/T5Kt/VR9558Sdu9PB/HLdF+q053OKTtnM=; b=VALbWOzeezcs/K
	fNg6YVHRfrKpSLX72B3tpg5TcKGe6tACvONLHcDQ8+jQ0u/HK/vyjuoXchomsqYSyWgFn0oeTrcod
	8VhZBvads2zOl7V0r0tQ3Z6dq0dWsVmxTnh5beEts23UJ9cNjPskg4NlXVsPS94F8wSFtbT/16NMI
	4PMbM0E8huIOWrB+y/Pq5cKWfXllGXbLJYgFIVTKnszvVghGqm53kugHvWW83zbFxxUkvjpycx/6g
	19j3iT3sFQBmBCnHMg+k00nKqOVVYFqmXjuFzrbqeP/HTrPHG+QOL6qXOIUOYYWyvhsVOnzNQCCJE
	YbaCIcb0TCiknfWgV4dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeov-00000006Dor-2hN6;
	Wed, 04 Nov 2026 17:30:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeot-00000006DoK-1yFu;
	Wed, 04 Nov 2026 17:30:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BA3040BCA;
	Wed,  4 Nov 2026 17:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318C11F0093A;
	Wed,  4 Nov 2026 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813443;
	bh=axjAzDMxe/T5Kt/VR9558Sdu9PB/HLdF+q053OKTtnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BpyBwaL0/aYVXoHwq05IXwkJfbiN+sH/NMlrIciQjG65t4BqcyIJFg2nSk8XDCCkV
	 c7rAC5Gwt0eJ+/2lGcpbp0ALBTDjeOzJXNQqmnuVDle4iduB5dvN2rzhDckY+qtIzb
	 gs1CNuM6mGLr4omD5X5lb2yIJHjoEFVFY17i90YDIqHEiBZHsPoN/pZZJkVTJ0KPFp
	 EUeGwANAMrg4AicMXKhoLnEodEFkU0cutq7m4urrRAjYhUQUJ5q8o2+x5TkfWHjCPD
	 i91uDDI+3s3/ZTdD9a7P2TXIzuGYqpzF7L202zVk0SuzYL1uXQEo7tJ52MN1ssXopq
	 kuzwiBlPYX93w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Nov 2026 18:27:26 +0100
Subject: [PATCH v2 09/51] profiling: report it when /proc/profile can't be
 created
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-work-procfs-bugfixes-v2-9-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tYIXM5EjsYRFpz3d9CdZ23LhMvzI2JA5U8qSrxldqzY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9zmb5c+HYnPYns6fufFrw5b7Y3/kPP5ytKnep0a7Jn
 RU85ZS3VkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEDoUzMjw1q1TdWGx2OGny
 nwfxD9yf9a1xbZhUXGz4leXXTAWLvycZ/tmE5T+0eFcqb8S9dXuWRJTqOn+e0/UWz2+d/yn/trX
 0PxsA
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


