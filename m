Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288386073D0C
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ECD5I7NR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZMD0huu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=r5+oZHp7BRrXwItSZJfGO9IDNpMhGDSeaixBJWzgZo8=; b=ECD5I7NRNYCgsZ
	YxVXe/Cf3tx33DLG8hUf1Npx9i+cpqlQbpb/cQ35rC8dc/CqsJ5j/euCo7aqUw13WzA5xNlN11JfK
	+4ojbn3nEieiX7ORjDrrfUnQJqSblFcv94JW2OP8GmeelOFCo6GHwc/WZyljOFLq69rTmTpQxQbl8
	Ai37qVeEUJGb00lB1bQwUJOcXzRbUHhY3YxSk+KwwVO6I1ccp7OLEV1t+bDm7nmOC10G2W43pU6zH
	0EsKD3xnaBMJfgm9SV5FUV6Ro+6GfN64cnm9S7phii9D4u3CvFe61Q1PIP8RWuPnqAIobbB1zbouT
	BJNrV+iCHkEb+eBZsuxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgdg-00000006cUz-3jia;
	Wed, 04 Nov 2026 19:27:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgdf-00000006cUS-2EwZ;
	Wed, 04 Nov 2026 19:27:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F1EE160D97;
	Wed,  4 Nov 2026 19:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AAB1F00A02;
	Wed,  4 Nov 2026 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820434;
	bh=r5+oZHp7BRrXwItSZJfGO9IDNpMhGDSeaixBJWzgZo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZMD0huuUQp5LSr9n7+L0WCkQqKPzyWmpwqfqg+XzsqNRlIuKtlf3Iar8GeYyXaoh
	 Duy1KTIkLZPd4wpyWSeEROyKAch5aD1WchnGy/bdzHJBKTDW5fUbZVdDqnccb3ML1S
	 ynk82YbCOwpdp9OfHLn4Hk4TAslcNPy+3iNGpY8Onlv8nBJw5pFj50Y4poa5zyKxIw
	 OVO6zjJj0L1s71YhuEz2nNM9sGb2RL+EkTlUz3tA5wau2YU3GduBQbxH1kPyHOemIX
	 jzrV1tyP5WTyanlHmpiwciBJbTfxSsr8dPDlHohaL0lhPAdIlgdQvP+X/AxRNITsuF
	 bSYKsfrnb9SrA==
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
Subject: [PATCH RESEND v2 45/51] selftests/proc: check a sysctl listing while entries come and go
Date: Wed,  4 Nov 2026 20:27:00 +0100
Message-ID: <20261104-work-procfs-bugfixes-v2-45-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5901; i=brauner@kernel.org; h=from:subject:message-id; bh=PpkRsqulHaX8LI6MUrkW65va02k7nMeISt9l3ZnWEgo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bmK23C5Vd0CJeVXYmud2s9Pn+J3m37HmVpnFi7ow2 bTfWdpXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyeRLDfw/N+y99eaf/2OCk /PjiV39BNqFbYdWnZD3mCaZ8OpuwbArDb9buj/tfO6Qb3GbVUb7QsZ5hkv1nv0KD0viMIPmMExu SGQE=
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

List /proc/sys/net/ipv4/conf of a new network namespace in two pieces:

- with a buffer that holds the dots and "all", register a tun device
  whose name sorts first, finish the listing: "all" is listed once

- with that device registered and a buffer that holds the dots and it,
  unregister it, finish the listing: "all" is still listed

Both fail without the fix, the first lists "all" twice, the second not
at all.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/proc/.gitignore            |   1 +
 tools/testing/selftests/proc/Makefile              |   1 +
 .../selftests/proc/proc-sysctl-readdir-churn.c     | 152 +++++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 8520c7878ea2..5b5e24e39cbd 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -25,4 +25,5 @@
 /self
 /setns-dcache
 /setns-sysvipc
+/proc-sysctl-readdir-churn
 /thread-self
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index e0c0d313f4d0..dae09f333455 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -30,6 +30,7 @@ TEST_GEN_PROGS += setns-sysvipc
 TEST_GEN_PROGS += thread-self
 TEST_GEN_PROGS += proc-multiple-procfs
 TEST_GEN_PROGS += proc-fsconfig-hidepid
+TEST_GEN_PROGS += proc-sysctl-readdir-churn
 TEST_GEN_PROGS += proc-pidns
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/proc-sysctl-readdir-churn.c b/tools/testing/selftests/proc/proc-sysctl-readdir-churn.c
new file mode 100644
index 000000000000..b2ad097b464a
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-sysctl-readdir-churn.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A listing of a /proc/sys directory that takes more than one getdents64()
+ * must not show an entry twice or skip one when an entry is registered or
+ * unregistered in between. /proc/sys/net/ipv4/conf/<dev> of a tun device
+ * comes and goes with the device.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <sched.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define CONF_DIR	"/proc/sys/net/ipv4/conf"
+#define TUN_NAME	"a0"		/* sorts before "all" */
+#define TUN_PATH	CONF_DIR "/" TUN_NAME
+#define SMALL_BUF	80		/* ".", ".." and one short name */
+#define NAMES		64
+
+static int tun_open(const char *name)
+{
+	struct ifreq ifr = {};
+	int fd;
+
+	fd = open("/dev/net/tun", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
+	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
+	if (ioctl(fd, TUNSETIFF, &ifr)) {
+		close(fd);
+		return -1;
+	}
+	return fd;
+}
+
+/* one getdents64() into @buf, the names appended to @names */
+static int list(int fd, char *buf, size_t size, char names[][NAME_MAX + 1],
+		int *n)
+{
+	long ret, off;
+	int got = 0;
+
+	ret = syscall(__NR_getdents64, fd, buf, size);
+	if (ret < 0)
+		return -errno;
+	for (off = 0; off < ret;) {
+		struct dirent64 *d = (void *)(buf + off);
+
+		if (*n < NAMES)
+			strcpy(names[(*n)++], d->d_name);
+		got++;
+		off += d->d_reclen;
+	}
+	return got;
+}
+
+static int count(char names[][NAME_MAX + 1], int n, const char *name)
+{
+	int i, c = 0;
+
+	for (i = 0; i < n; i++)
+		if (!strcmp(names[i], name))
+			c++;
+	return c;
+}
+
+FIXTURE(sysctl_readdir) {
+	int dir;
+	int n;
+	char names[NAMES][NAME_MAX + 1];
+	char buf[65536];
+};
+
+FIXTURE_SETUP(sysctl_readdir)
+{
+	int tun;
+
+	if (unshare(CLONE_NEWNET))
+		SKIP(return, "unshare(CLONE_NEWNET): %s", strerror(errno));
+	tun = open("/dev/net/tun", O_RDWR | O_CLOEXEC);
+	if (tun < 0)
+		SKIP(return, "/dev/net/tun: %s", strerror(errno));
+	close(tun);
+	self->dir = open(CONF_DIR, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	if (self->dir < 0)
+		SKIP(return, CONF_DIR ": %s", strerror(errno));
+	self->n = 0;
+}
+
+FIXTURE_TEARDOWN(sysctl_readdir)
+{
+	close(self->dir);
+}
+
+/* a device registered in front of the position doesn't repeat an entry */
+TEST_F(sysctl_readdir, register_in_front)
+{
+	int tun;
+
+	/* ".", ".." and "all", "default" doesn't fit */
+	ASSERT_EQ(list(self->dir, self->buf, SMALL_BUF, self->names, &self->n), 3);
+	ASSERT_EQ(count(self->names, self->n, "all"), 1);
+
+	tun = tun_open(TUN_NAME);
+	ASSERT_GE(tun, 0);
+	ASSERT_EQ(access(TUN_PATH, F_OK), 0);
+
+	while (list(self->dir, self->buf, sizeof(self->buf), self->names,
+		    &self->n) > 0)
+		;
+	EXPECT_EQ(count(self->names, self->n, "all"), 1);
+	EXPECT_EQ(count(self->names, self->n, "default"), 1);
+	EXPECT_EQ(count(self->names, self->n, "lo"), 1);
+	close(tun);
+}
+
+/* a device unregistered in front of the position doesn't skip an entry */
+TEST_F(sysctl_readdir, unregister_in_front)
+{
+	int tun;
+
+	tun = tun_open(TUN_NAME);
+	ASSERT_GE(tun, 0);
+	ASSERT_EQ(access(TUN_PATH, F_OK), 0);
+
+	/* ".", ".." and the device, "all" doesn't fit */
+	ASSERT_EQ(list(self->dir, self->buf, SMALL_BUF, self->names, &self->n), 3);
+	ASSERT_EQ(count(self->names, self->n, TUN_NAME), 1);
+
+	/* closing the device unregisters its sysctls under RTNL */
+	close(tun);
+	ASSERT_EQ(access(TUN_PATH, F_OK), -1);
+
+	while (list(self->dir, self->buf, sizeof(self->buf), self->names,
+		    &self->n) > 0)
+		;
+	EXPECT_EQ(count(self->names, self->n, "all"), 1);
+	EXPECT_EQ(count(self->names, self->n, "default"), 1);
+	EXPECT_EQ(count(self->names, self->n, "lo"), 1);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0


