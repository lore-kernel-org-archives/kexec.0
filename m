Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998D606D178
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sD6gHDyN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iC5qhYuC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=a8Eii8wlxK/U6i+WN38IP3N9K8zW9fYP0HNd0IGm1W0=; b=sD6gHDyNsJWQ1W
	5C3QjX/cWCpp5h5GUceaKIVQXuIOiqbcQ4yXIBMImL0QEkxYAij8VNobqBvqdry7ZsP1w/KH06n7o
	n+JFU6nJVrP8PRXheG3LNr8PlINHNuJCjBb5uEw3qe5Cw7L4QaiOJu844N1uO3FcxVTuuTYABvRLa
	Xc0DJ84pQ0Ol2RrX+En+nZUvn3tlQ74Ew+s6A6iHaz8T9QwNv78vEWHnCrvQ31Rgjr/R7zpTlyMDZ
	83a02oIPpJHEBGvqpxj2aI2bIXhbO+l0XSzJ/F2ZEXJXGaZ/b0hgB9QmjwauEa3uosrofikoHmbhP
	s72y4KRKfsHIaMo9g5ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgiT-00000006eXq-0SiQ;
	Wed, 04 Nov 2026 19:32:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgiR-00000006eXG-0yAQ;
	Wed, 04 Nov 2026 19:32:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6CBFB60D9A;
	Wed,  4 Nov 2026 19:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4421F000C1;
	Wed,  4 Nov 2026 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820730;
	bh=a8Eii8wlxK/U6i+WN38IP3N9K8zW9fYP0HNd0IGm1W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iC5qhYuCRstV+TUqjEu0rWRbTttDUR0KoUFR/Nic2bFwF64VuSt1WDgXx4WbU4Et4
	 ZNlRYe+G0MHmA1/II6uBNZBPp9Wvcvb5bBVfPJtilV3/K8lP+xGqSdbaN6ECrO9DpW
	 du+eed3fzzQNoHO1No/AbIPvxNJkxVZOJdAGHIz/EgNENL5daivIVmmxtCp9lM8GEv
	 tRA4UQbju+ehP2qFzuoGBNUaSD6Jp1yqYS1bSnF83Bb3YxwerAD9vI0v1JOGv4u38c
	 FoRp/hBAQUDPq4wTOJ5N0tlVFGudcN+g6w+AJBph58Jc+dvlqzJ6WxnPYKNN9XQMYu
	 THb00UuOGzJdA==
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
Subject: [PATCH RESEND v2 11/23] selftests/proc: check that a faulting reader doesn't hold up removal
Date: Wed,  4 Nov 2026 20:31:56 +0100
Message-ID: <20261104-work-procfs-core-v2-11-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5703; i=brauner@kernel.org; h=from:subject:message-id; bh=XyuYjQOPhfqL05zxspI3Sf2ZwFKZLHj6jlvlh6Bj2Lk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bq97GaEjt/tSvJXDmnqfdIul4otUnkuetLcImZIuI frrsJ9sRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETcJjH8D3O/N+uiwGkGvqKb uoYJuYavRK3s+jeLapeqZFQ3hKf7Mfz3X/bwb8DUWRlpKSH5XPOF/65p/KKXLLfq9KTDH5ylnqz hBgA=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read /proc/net/dev_snmp6/<dev> of a tun device into a buffer whose first
page is backed by userfaultfd and remove the device while the reader
sleeps in its copy to userspace:

- removing the entry doesn't wait for the reader

- the reader still gets what was printed before the removal

- and the next read fails with -EIO

The entry is removed under RTNL, so a regression stalls the test for
five seconds before it fails.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/proc/.gitignore            |   1 +
 tools/testing/selftests/proc/Makefile              |   1 +
 .../selftests/proc/proc-remove-slow-reader.c       | 133 +++++++++++++++++++++
 3 files changed, 135 insertions(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 3fa89f46b9c7..e2566cc0ae07 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -22,6 +22,7 @@
 /proc-uptime-002
 /proc-pidns
 /proc-remove-slow-sysctl
+/proc-remove-slow-reader
 /proc-remove-slow-readlink
 /read
 /self
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index df02699a3587..6a9bdc999f54 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -33,6 +33,7 @@ TEST_GEN_PROGS += proc-fsconfig-hidepid
 TEST_GEN_PROGS += proc-sysctl-readdir-churn
 TEST_GEN_PROGS += proc-pidns
 TEST_GEN_PROGS += proc-remove-slow-sysctl
+TEST_GEN_PROGS += proc-remove-slow-reader
 TEST_GEN_PROGS += proc-remove-slow-readlink
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/proc-remove-slow-reader.c b/tools/testing/selftests/proc/proc-remove-slow-reader.c
new file mode 100644
index 000000000000..a201645beca9
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-remove-slow-reader.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A read that faults while copying to userspace must not hold up removal of
+ * the /proc entry. /proc/net/dev_snmp6/<dev> of a tun device is removed under
+ * RTNL when the device's file is closed.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <linux/userfaultfd.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sched.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define TUN_NAME	"procslow0"
+#define SNMP6_PATH	"/proc/net/dev_snmp6/" TUN_NAME
+#define READ_PAGES	16
+#define TIMEOUT_MS	5000
+
+struct reader {
+	int fd;
+	char *buf;
+	size_t len;
+	ssize_t ret;
+};
+
+struct closer {
+	int tun;
+	int done;
+};
+
+static void *read_thread(void *arg)
+{
+	struct reader *r = arg;
+
+	r->ret = read(r->fd, r->buf, r->len);
+	return NULL;
+}
+
+static void *close_thread(void *arg)
+{
+	struct closer *c = arg;
+	ssize_t ret;
+
+	close(c->tun);
+	ret = write(c->done, "x", 1);
+	return (void *)ret;
+}
+
+TEST(remove_while_reader_faults)
+{
+	struct uffdio_api api = { .api = UFFD_API };
+	struct uffdio_register reg = {};
+	struct uffdio_zeropage zero = {};
+	long psz = sysconf(_SC_PAGESIZE);
+	struct ifreq ifr = {};
+	struct reader r = {};
+	struct closer c = {};
+	struct uffd_msg msg;
+	struct pollfd pfd;
+	pthread_t rt, ct;
+	int uffd, done[2];
+	char *buf;
+
+	if (unshare(CLONE_NEWNET))
+		SKIP(return, "unshare(CLONE_NEWNET): %s", strerror(errno));
+
+	c.tun = open("/dev/net/tun", O_RDWR | O_CLOEXEC);
+	if (c.tun < 0)
+		SKIP(return, "/dev/net/tun: %s", strerror(errno));
+	strncpy(ifr.ifr_name, TUN_NAME, IFNAMSIZ - 1);
+	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
+	ASSERT_EQ(ioctl(c.tun, TUNSETIFF, &ifr), 0);
+
+	r.fd = open(SNMP6_PATH, O_RDONLY | O_CLOEXEC);
+	if (r.fd < 0)
+		SKIP(return, SNMP6_PATH ": %s", strerror(errno));
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0)
+		SKIP(return, "userfaultfd: %s", strerror(errno));
+	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
+
+	/* Only the first page of the buffer goes through userfaultfd. */
+	buf = mmap(NULL, READ_PAGES * psz, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(buf, MAP_FAILED);
+	reg.range.start = (unsigned long)buf;
+	reg.range.len = psz;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
+
+	r.buf = buf;
+	r.len = READ_PAGES * psz;
+	ASSERT_EQ(pthread_create(&rt, NULL, read_thread, &r), 0);
+
+	/* The reader now sleeps in its copy to userspace. */
+	pfd = (struct pollfd){ .fd = uffd, .events = POLLIN };
+	ASSERT_EQ(poll(&pfd, 1, TIMEOUT_MS), 1);
+	ASSERT_EQ(read(uffd, &msg, sizeof(msg)), sizeof(msg));
+	ASSERT_EQ(msg.event, UFFD_EVENT_PAGEFAULT);
+
+	/* Closing the device removes the file that is being read. */
+	ASSERT_EQ(pipe2(done, O_CLOEXEC), 0);
+	c.done = done[1];
+	ASSERT_EQ(pthread_create(&ct, NULL, close_thread, &c), 0);
+	pfd = (struct pollfd){ .fd = done[0], .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, TIMEOUT_MS), 1) {
+		TH_LOG("removing " SNMP6_PATH " waited for the reader");
+	}
+
+	zero.range.start = (unsigned long)buf;
+	zero.range.len = psz;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_ZEROPAGE, &zero), 0);
+	ASSERT_EQ(pthread_join(rt, NULL), 0);
+	ASSERT_EQ(pthread_join(ct, NULL), 0);
+
+	/* What was printed before the removal still arrives, then nothing. */
+	EXPECT_GT(r.ret, 0);
+	EXPECT_EQ(read(r.fd, buf, psz), -1);
+	EXPECT_EQ(errno, EIO);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0


