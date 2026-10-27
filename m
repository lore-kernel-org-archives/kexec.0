Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B05606A329
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mS7RUcAC;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=YMEQLLkP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=; b=mS7RUcACWSpEiW
	H7iQTUuFDN7rENFRFh1+F9ZyXuZql1XQ0x22Z0jjYvZxcoRwHu1fabeRR6hLpMzDRuAxh7p9tyfDo
	Byi7tLPJuwgEXZFUjXKCV60CC5KTbDzKuNSz7JH5NoUGJF+ncwkavMWIA83ltntbofxafibXuWEVS
	mNf5CV9k6ibBJxFM0Sd8KblFD+6fxdseGZfr/ZRD327u93IL/ALFgfWjrivy7iAOBijjmJ15LClH3
	CKDnwGeo9pCcBiunNynIcLXmxJpXYvoE5xchdwQQIykBH9PA5HnblaLKU/c38rtN4kVsb5K4UL/VP
	KxpdERXGdzGUIPEVu8EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLXxM-00000003hMA-3phO;
	Tue, 27 Oct 2026 03:34:36 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLXxJ-00000003hLh-2Lpv
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 03:34:35 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c46bd7a7345so94695066b.0
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072071; x=1793676871; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
        b=YMEQLLkPGEIKV/cL5W6wnHBUpuj2xbdjVvGFo7e6ZUINiFXCfUswogaUfSPe+IFojR
         F+zbiwzNYNlIW6b5pUoBwDLRl53EwNikh6y2KMKhqGHAMy3784sOdMnL0yXkePWIBAKN
         r3SBaRbFpQM8Xw9siLcZCXrZsd/3frKyysd5nGF1c597GmB8YkbGa2AwoBd2DSkS+FO6
         +/i124aEJ9aYgmBaGxWOZAdF8Zps+13GReewdk9gC96Jk7N3E+POMDubqz5Ns5c9nnX7
         S6yfbN7Ea10JJK1LhPglMxbMQcGGBvqHF3KfP/5nzM+jmbwRbsoAAxhScqLsbLj6hheo
         jkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072071; x=1793676871;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
        b=fNoLD/82nFiBOAqO/QuH6mLNL9AuXRUO3on9CrmdIvs/CbSOWT2xCj4QyaNzhb79QZ
         f53aev2UIYBm/xYDZc830sUadkcJTvrIlUX77Q9k3r/phzkRZxDoyQqnzJgVbGTGuBk9
         U/uZT/xMZaqgZrIxIvBnzn3BDu2IPEicITR4dMzGxXhbyiB6QsE/2bXsWLTo39+zBN3t
         qmObeQFgeesArqQTL2GrksLSZpYL2+3GjBDpTGYkxnrEOL/4IQ/G5uaSAJdjb82azoBP
         83dACS6XR6qJUdoOAPuriNmWcMQCPJWGcRXKczdKy0l0BJHGs3z1dgxI6wDtoV8JJD6Y
         xOJA==
X-Forwarded-Encrypted: i=1; AKwUvBwFMrB9j6si83Q54BsxFyQs3V8isQgGycl2n7qkFQf7vu186sPZ1/gpw8fPWImXNV1Sf1/Olw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJssp/tDrX26MilnlZuoMPOn+h6GbkEkAgmg7hjZXBQfWKFpWEs
	j2VIY0GcWPfWhJZKZphFuqAHeIIl8nM2yDy4zztNjPwclCZQ+qAI6VQ2Nffdfvx/XJU=
X-Gm-Gg: AYBFou2WHqigGARB3glgrWlZ9c18OeQ2V7XGXmXTd7TU77npNKzzesZaR8dZxRmYfvA
	bW6tOqoVNzE7LhSb/L90XEtUNMtfsiuV91X4U9WtwBD5rEh/MgT7w0CBPwOI0J20fReVoowxopS
	2tNGd5wu+YB4GcI5gyhwIFjlqGJ2L95fN6NF0OThaQ1p3VOv2J7SARsiaiju+QQ98M3+mS1mUb2
	U68tbq+SOmcJi4pghzK1Vx8T6936trGdtNNDuplEHIZVvidUaSaOxxCdLAGj/pQnvjUttyKHFKj
	DRX8girIhChVcnfvJgnl9cV0o1iqC83+VdGtdkF1mmZ8wd2OJxGErJ1q/msPW6FVH5ne9cJXxEv
	wXzXWvtDFKmi5RHbzAox5ZZj9DQXchFs/ZF4+NGpW5zvLLtgBtgjRXNo/8XX/d18e+vP6F10O6p
	/GJ0GRM88/lYWegc0I21mYVXPYC9VHOaonJfwPRYw26Pw0khR6TXsuC6MR8U6yq6KcYpZI3cVxx
	pEKtkRV7FXq/iqN3mnlTGeEezTF2pmxvy8BfYAFP2uQCg==
X-Received: by 2002:a17:907:9303:b0:c46:7de7:e41d with SMTP id a640c23a62f3a-c49a7417cabmr116191366b.18.1793072071043;
        Mon, 26 Oct 2026 20:34:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd52435asm380825966b.36.2026.10.26.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:34:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:34:28 -0700
Message-Id: <179307206859.1171062.6841971971647864368.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_203433_662969_B56E28EA 
X-CRM114-Status: GOOD (  28.54  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
... snip ...
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

This one arguably should have at least a trivial selftest.

Test attatched
-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] selftests/memfd: test shared file position atomicity

Without FMODE_ATOMIC_POS, concurrent reads or writes on a shared memfd
can use the same file position. Two writers can overwrite each other's
records:

    CPU 1                         CPU 2
    pos = file->f_pos
                                  pos = file->f_pos
    write a record at pos
                                  write a record at pos
    file->f_pos = pos + size
                                  file->f_pos = pos + size

Add separate shared-read and shared-write tests using the kselftest
harness. Check the final offset, file size and exactly-once record delivery
rather than requiring a particular interleaving.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/selftests/memfd/.gitignore  |   1 +
 tools/testing/selftests/memfd/Makefile    |   3 +-
 tools/testing/selftests/memfd/memfd_pos.c | 136 ++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/memfd/memfd_pos.c

diff --git a/tools/testing/selftests/memfd/.gitignore b/tools/testing/selftests/memfd/.gitignore
index dd9a051f608e2..574ab97ebd982 100644
--- a/tools/testing/selftests/memfd/.gitignore
+++ b/tools/testing/selftests/memfd/.gitignore
@@ -2,4 +2,5 @@
 fuse_mnt
 fuse_test
 memfd_test
+memfd_pos
 memfd-test-file
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 163b6f68631c4..67a95c34541cd 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -2,7 +2,7 @@
 CFLAGS += -D_FILE_OFFSET_BITS=64
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := memfd_test
+TEST_GEN_PROGS := memfd_test memfd_pos
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
 TEST_GEN_FILES := fuse_test fuse_mnt
 
@@ -22,6 +22,7 @@ include ../lib.mk
 
 $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 
+$(OUTPUT)/memfd_pos: LDLIBS += -pthread
 $(OUTPUT)/memfd_test: memfd_test.c common.c
 $(OUTPUT)/fuse_test: fuse_test.c common.c
 
diff --git a/tools/testing/selftests/memfd/memfd_pos.c b/tools/testing/selftests/memfd/memfd_pos.c
new file mode 100644
index 0000000000000..5f3749d13f561
--- /dev/null
+++ b/tools/testing/selftests/memfd/memfd_pos.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define THREADS 4
+#define RECORDS 16384
+#define TOTAL (THREADS * RECORDS)
+
+struct worker {
+	int fd;
+	unsigned int id;
+	bool reading;
+	pthread_barrier_t *barrier;
+	atomic_uint *seen;
+	int error;
+};
+
+static void *transfer(void *arg)
+{
+	struct worker *w = arg;
+	unsigned int i;
+
+	pthread_barrier_wait(w->barrier);
+	for (i = 0; i < RECORDS; i++) {
+		uint32_t value = w->id * RECORDS + i;
+		ssize_t n;
+
+		do {
+			n = w->reading ? read(w->fd, &value, sizeof(value)) :
+				write(w->fd, &value, sizeof(value));
+		} while (n < 0 && errno == EINTR);
+		if (n != sizeof(value) || value >= TOTAL) {
+			w->error = 1;
+			break;
+		}
+		if (w->reading)
+			atomic_fetch_add(&w->seen[value], 1);
+	}
+	return NULL;
+}
+
+FIXTURE(memfd_pos) {
+	int fd;
+	atomic_uint *seen;
+};
+
+FIXTURE_SETUP(memfd_pos)
+{
+	self->fd = memfd_create("position", MFD_CLOEXEC);
+	if (self->fd < 0 && errno == ENOSYS)
+		SKIP(return, "memfd_create unavailable");
+	ASSERT_GE(self->fd, 0);
+	self->seen = calloc(TOTAL, sizeof(*self->seen));
+	ASSERT_NE(self->seen, NULL);
+	for (unsigned int i = 0; i < TOTAL; i++)
+		atomic_init(&self->seen[i], 0);
+}
+
+FIXTURE_TEARDOWN(memfd_pos)
+{
+	close(self->fd);
+	free(self->seen);
+}
+
+static int run_workers(int fd, bool reading, atomic_uint *seen)
+{
+	pthread_barrier_t barrier;
+	pthread_t threads[THREADS];
+	struct worker workers[THREADS];
+	int ret = 0;
+	unsigned int i;
+
+	if (pthread_barrier_init(&barrier, NULL, THREADS))
+		return 1;
+	for (i = 0; i < THREADS; i++) {
+		workers[i] = (struct worker) {
+			.fd = fd, .id = i, .reading = reading,
+			.barrier = &barrier, .seen = seen,
+		};
+		/* The harness isolates this test in a child; abort on setup failure. */
+		if (pthread_create(&threads[i], NULL, transfer, &workers[i]))
+			abort();
+	}
+	for (i = 0; i < THREADS; i++) {
+		if (pthread_join(threads[i], NULL) || workers[i].error)
+			ret = 1;
+	}
+	pthread_barrier_destroy(&barrier);
+	return ret;
+}
+
+/* Concurrent writes sharing an open file description must not overlap. */
+TEST_F(memfd_pos, shared_write)
+{
+	struct stat st;
+	uint32_t value;
+	unsigned int i;
+
+	ASSERT_EQ(run_workers(self->fd, false, self->seen), 0);
+	ASSERT_EQ(fstat(self->fd, &st), 0);
+	ASSERT_EQ(st.st_size, (off_t)(TOTAL * sizeof(value)));
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_CUR), st.st_size);
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_SET), 0);
+	for (i = 0; i < TOTAL; i++) {
+		ASSERT_EQ(read(self->fd, &value, sizeof(value)), sizeof(value));
+		ASSERT_LT(value, TOTAL);
+		atomic_fetch_add(&self->seen[value], 1);
+	}
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(atomic_load(&self->seen[i]), 1);
+}
+
+/* Concurrent reads must consume every record exactly once. */
+TEST_F(memfd_pos, shared_read)
+{
+	uint32_t i;
+
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(write(self->fd, &i, sizeof(i)), sizeof(i));
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_SET), 0);
+	ASSERT_EQ(run_workers(self->fd, true, self->seen), 0);
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_CUR), (off_t)(TOTAL * sizeof(i)));
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(atomic_load(&self->seen[i]), 1);
+}
+
+TEST_HARNESS_MAIN

-- 
Gregory Price <gourry@gourry.net>

