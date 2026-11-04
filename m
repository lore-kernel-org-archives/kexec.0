Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852B6074A45
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KX0+K4Ir;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2MBURx3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QKQgab6F/A3kQED3xQkQ3++bbO+NbqHo8+XrgOES7ts=; b=KX0+K4Iro4pRfl
	TlUzhTdVL+wou7gpX0d23WbOKfmU1BHclLRI8r9fmBo6XAhOhvvz6ctFAmZNBxnOoq2gZFS0/UsAJ
	D4gvaK0Yi1gtF5Q3B0F35YPyyt10q0DWi+aDJxt8oBWrBriD05rN3BH2IFrv2l1bfjL4QX5Xc+LCF
	y7vjxRX/wMu8LVkYrNlbddqHfNZgkQBeHPSJJRV/UZOVhx5EbnE2+iSxqNajthGyF3g/z9AE2r2Jq
	VDszLJjnaQijFyq/7YmvF7FtrpGy3haCM934gV3Ju9NXk2ABnaXdEmq4q1PuJpj3sqXkB6jo3Wubc
	hGLdKmuKjeKcftSczdKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfB2-00000006JQg-1gBl;
	Wed, 04 Nov 2026 17:53:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfB1-00000006JQQ-0dNv;
	Wed, 04 Nov 2026 17:53:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D5ED2401D7;
	Wed,  4 Nov 2026 17:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A771F000C1;
	Wed,  4 Nov 2026 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814814;
	bh=QKQgab6F/A3kQED3xQkQ3++bbO+NbqHo8+XrgOES7ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2MBURx36IjZzkcLb2KZAEwlpj6Z6rTqm97dO+7doIkZr1Kqzh3uc53FtsyC6p1Qp
	 E8Af1CfcCZKJoPDeo0p3M/GnYCJ80+n57IzNLCGvu4Bk9CouKYGn+orF70IL7nf4yK
	 nSpBJriEksHHTVFnNpFK4ihBuIC0cyx3Y7QU8Dbel9oqxkaIvG8hLqBlKw9PD83NvO
	 Bpz6mm+6hDo0ijhkfwkqF65V7CvpgQI6W9+n1sejUJ9eDCv5Ck/cp7SLlpsYIc7IQv
	 Zd1bVKw2snQGORVqHtYYXf4KLvRRmu/GjBV2fT+bsIs5Xg1tLwdr852VnqimxYBAh0
	 3a+pujJgabI2w==
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
	Chuck Lever <cel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 30/51] net: pktgen: reject device names with a '/'
Date: Wed,  4 Nov 2026 18:47:16 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-30-bbf7d5546809@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=brauner@kernel.org; h=from:subject:message-id; bh=F9CLtO30/n/hY0YqeSuPpMfy319PBmjhBXOfLkB61UI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9znvCdcJ1NYf0fOujSQtemwvu3bBBpcRumo2Bz5Xi5 X/ThD8YdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkbhIjw/Ob9c5r2Pj/Kk6s buYtSBDaVZfYmFppvu/Y99lhKbqyPIwMMz2n+1lZtz+NPHGpn+1Yf0m55kdBz6TyQ6z6D9ifhZc wAQA=
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

"add_device" takes a name like eth0@1. Only the part in front of the
'@' has to name a network device. The rest is free text and all of it
becomes the name of a file in /proc/net/pktgen, where procfs takes a
'/' as a directory separator. So "add_device lo@a/b" makes procfs look
for a directory "lo@a" that doesn't exist and warn about it. Any user
can do that in a network namespace of its own:

  name 'lo@a/b'
  WARNING: fs/proc/generic.c:174 at __xlate_proc_name+0xb1/0xf0, CPU#3: bash/241
  Call Trace:
   __proc_create+0xd0/0x9b0
   proc_create_reg+0x45/0xf0
   proc_create_data+0x77/0xf0
   pktgen_thread_write+0xd8d/0x1750

With panic_on_warn that takes the machine down. And if "lo@a" exists
because somebody added a device of that name, procfs used to register
the new entry below that regular file, and removing "lo@a" freed both.

Reject names with a '/'.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: e6fce5b916cd ("pktgen: multiqueue etc.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/core/pktgen.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index d63eeadddfcc..02af70d360bc 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3831,6 +3831,10 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	int err;
 	int node = cpu_to_node(t->cpu);
 
+	/* The name becomes the name of a file in /proc/net/pktgen. */
+	if (strchr(ifname, '/'))
+		return -EINVAL;
+
 	/* We don't allow a device to be on several threads */
 
 	if (__pktgen_NN_threads(t->net, ifname, FIND)) {

-- 
2.53.0


