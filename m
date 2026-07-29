Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B2CC53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dyqrLuOyw9Vj8iSsV2gE8/OUT7C0YTHbpVdgIrqzPEg=; b=Ye5fkrcuk13GAftjn0QxlX8T0G
	kiVeNyp5ssBSP9ZEVdlY5JqBJw7M/ZAoHIyRNTJUdMgU8nD2YKmmCwPDiXzMpfYR+NlqkL0jSlt5x
	9BtWT9s25el+/ysRvSitJGdvFyQoPiXJ2a/EejX/5HtcX+PoLRis3S58Q6kh7GyMFwgBo7miG8R29
	SHTc/diyfiS0TojDfiSJxoO4mEARVmks2X8Eu+crIcm+XvJPGMFWWB+vvD8v01vmuITcXynqhYom2
	pLjFkYAN+Pb815tDbIYRdHioNUd4M4aHORjBtD/kiCasgxjKGAV05KYJXq6FR8O7JGin6M6dj5wpC
	eYROUMig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5py-00000008L5k-05ya;
	Wed, 29 Jul 2026 15:04:50 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5pu-00000008L5Q-26Ay
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 15:04:48 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8efec2c28f8so6981436d6.2
        for <kexec@lists.infradead.org>; Wed, 29 Jul 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785337485; x=1785942285; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dyqrLuOyw9Vj8iSsV2gE8/OUT7C0YTHbpVdgIrqzPEg=;
        b=CeKjZ1RFbNN6v2bjcEToRuWi7dSdeRzMJ2LYeVcibGsjV7Shak8MLsXhTOqN1Vt0vR
         TK8e+VwPF3krJpyZ7EpDqAuw/Is5D48yIemfql37RyzXxPJACpweaDDr6kTg1nVEqHgI
         DI/RA0x8EeGdhYm0bJPblOdZEt0AYpV5lS0JGPTJ9grzbejYIDOIRtWbtYobw1cU27jy
         ryP6JVx25wFwqPQIttI2m8LLsJjoaqDXiGW9r6p3yw4iHJOAB1jjaJKSDBMewqhhKZGC
         RpjioqW0/TduxvMJa/5XT3Ovr28iWaSr+LtCiJhLd90LHw5Bs27N+gXpRa+BIoslWuYP
         1ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337485; x=1785942285;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dyqrLuOyw9Vj8iSsV2gE8/OUT7C0YTHbpVdgIrqzPEg=;
        b=g+DfVeQtNAP3iEeKx8vO54Ft7eW12ba4Q87WfOQraX1CZ1zasfR+6fROugPaGJwYZF
         VjzsU7He28Xn5bgU7V8dBmtBb7FFijt074jOk2je3FPGbl/xD3sW/p1iv9EMgGeup/lm
         RYaOCb9pmfeQ19oL2Pj7r/7NdGk+39lnVmpLxegDO03bIkGBYPe3pGNb+7ure7G7hx+p
         eKXGt84dXFL1ps2GLe5cltRnyDkBCwe3pzQLOZ9WNjI82E4yl4YRVljS3T4aKBW6yxst
         2xkBv+bFJprJsF+VIM0gQ5t0kWvtDxFN8YcoYeGzWxYF4tcGr4pKpeFpOYPiFmAV7MMq
         1hig==
X-Gm-Message-State: AOJu0Yz2p6Y0N4/YhQqO3ggxWT0JPhvIsNs1/qNuBTf7kT2W+WMSccjz
	YNbuNXfE45H7ELjE2QKLUn4PevxY/O7fitJ8GzmZst7OHxJV/ixbpfzh
X-Gm-Gg: AR+sD12UarcBKtuvckTo8GsIAbB2azdOJcnnLZJsVo8udnAulaOBOaVqRubIpFZzruE
	9uobm3LtL5HwbPC4A2W/D6wphNbIy3EQ5gtuf9Rt3crD6is3a+bNf/lr/paQIYW+YDilkhuWyyO
	zMYEJhUFUlZIbnKdQYG5MM9fdbyzxvU+zqbdEMle/YWxMbH21OLQ+xDuh8nqBblSxMBli41dDc+
	D5MZF7Q2ZBIQddVlUYZuBLhcN0LtUGhyLteUck/3CJ1ZWW8OZ6ZIikCdKe6rTSL5FsCJjcyJD+8
	J5zAAFP2qbs5vmY9GhG6YQS4pX8hwDXqafuKc9zWQ1P0FTDZjwdg/wJPL/5rhEwXBERCuszGEgI
	KVt4zizq9wPDeFdoPEX64N0S6pChZ7JWs+zgGKiTmHPhyc6onlbs5PNdE1DJv+Whh3O5rvPOPUI
	skZTxVVb08UiyHlS80Drhq2kb06eFWgp2z9eUgbPJUOImX6iouwl7eTE3EplXXLrh9tbr+9FvYW
	eXG/B8zxLMKbjSX1dAzDUa7KbnC7Kj3f2vLTxe1Ihg3
X-Received: by 2002:a05:6214:4304:b0:8ee:b05c:596d with SMTP id 6a1803df08f44-90816f97678mr83784786d6.22.1785337484247;
        Wed, 29 Jul 2026 08:04:44 -0700 (PDT)
Received: from cw-fl20tjcw03-l.tailb3cd1a.ts.net ([2600:4040:9121:7700:2888:2cc1:5c33:a237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd8c0adsm26207876d6.45.2026.07.29.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:04:43 -0700 (PDT)
From: Serapheim Dimitropoulos <serapheimd@gmail.com>
Date: Wed, 29 Jul 2026 11:04:31 -0400
Subject: [PATCH kexec-tools] util_lib/elf_info: stream lockless printk ring
 records
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-vmcore-dmesg-stream-upstream-v1-1-a00b5d5489f0@coreweave.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MywqDMBBG4VeRWXfABrykr1K6CMmvBhsjM1YE8
 d0bSnfn25yTFBKh9KhOEuxRY14K7reK/OSWERxDMZnatHVnet6TzwIOCTqybgKX+LP+owuutY3
 t7WAbKotVMMTjt3/SjAOet5zfSq/r+gLmcWQhewAAAA==
X-Change-ID: 20260728-vmcore-dmesg-stream-upstream-7da695989f95
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>, 
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
 Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>, 
 Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337483; l=25050;
 i=sdimitropoulos@coreweave.com; s=20260302; h=from:subject:message-id;
 bh=0hoE1f3OD8DY5HxJnruQ50lEd4gJF9qnR8AK+48fWyo=;
 b=lQIcEq7E54WeMvxUut3B8WLkHU8BJA15rxCUI+eKYw95CrWrYtur51Smz7hGS2ojDJbindzmM
 O/q+sy6zJ0ECvMtUzkNsDB5bDxPC5ABvWD8oMDW9ByZEYbL6WAUkcI4
X-Developer-Key: i=sdimitropoulos@coreweave.com; a=ed25519;
 pk=Qysvg7jaTIU0posaYFtqa5SKJlFwqzil4X0U1p1zo/g=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_080446_676276_09699E19 
X-CRM114-Status: GOOD (  24.44  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>

We came across this while testing kdump on an arm64 system with a 64 MiB
printk text ring and an 850 MiB capture kernel. vmcore-dmesg was run from
the capture kernel before makedumpfile, but it was killed with SIGKILL
before it could produce any output.

The lockless ringbuffer reader copies the complete descriptor, info, and
text rings before it starts processing records. For the above setup
these copies raised peak RSS to about 345 MiB. This is a significant
part of the memory available to the capture kernel, and most of the
copied data is only visited once.

Stream the active records directly from the dump instead. We initially
considered using exact reads for every field. That keeps memory use
bounded, but turns every record into several small reads. Since a vmcore
does not change, use three 64 KiB read-through caches for its descriptor,
info, and text data. This keeps the number of reads down without making
memory use depend on the configured ring size.

The same caching is not safe for live /proc/kcore. A cache fill can read
ahead into a record while it is still being written and later return
stale text after the descriptor becomes committed. Identify an open
/proc/kcore file by device and inode, use exact uncached reads, accept
only finalized records, and re-read the descriptor after copying each
record. Retain a character-device fallback for older kernels.

Validate the ring geometry and all address arithmetic before walking
the ring. Also bound the tail-to-head walk by the descriptor count so a
corrupt dump cannot make the reader wrap offsets or loop indefinitely.

The old and new readers produced byte-identical output for committed
and finalized records, missed and empty records, wrapped text,
non-printable bytes, and descriptor ID wraparound. Malformed fixtures
covered invalid shifts, arithmetic overflow, short reads, and invalid
head/tail spans.

On a synthetic 64 MiB text ring, peak RSS dropped from 345176 KiB to
1572 KiB. A dense 100000-record fixture produced the same output while
reducing peak RSS from 345172 KiB to 1584 KiB. On a live arm64 system,
both /proc/kcore and a symlink to it exercised the uncached path and
produced byte-identical output: 20764 records and 4469182 bytes in about
1.2 seconds. The 17-architecture build matrix and make distcheck also
passed.

Fixes: 4149df9005f2 ("printk: add support for lockless ringbuffer")
Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
---
 util_lib/elf_info.c | 553 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 435 insertions(+), 118 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 36eb895..b4f4a44 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -954,21 +954,194 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 		handler(out_buf, len);
 }
 
+#define PRB_CACHE_SIZE		(64 * 1024)
+#define PRB_BAD_DATA_EXIT	66
+
+struct prb_cache {
+	char		*buf;
+	const char	*name;
+	uint64_t	file_offset;
+	uint64_t	region_size;
+	uint64_t	cache_offset;
+	size_t		cache_len;
+};
+
 /* convenience struct for passing many values to helper functions */
 struct prb_map {
-	char		*prb;
+	uint64_t	desc_ring_count;
+	struct prb_cache desc_cache;
+	char		*desc;
+	char		*desc_verify;
 
-	char		*desc_ring;
-	unsigned long	desc_ring_count;
-	char		*descs;
+	struct prb_cache info_cache;
+	char		*info;
 
-	char		*infos;
+	uint64_t	text_data_ring_size;
+	struct prb_cache text_cache;
+	char		*text;
 
-	char		*text_data_ring;
-	unsigned long	text_data_ring_size;
-	char		*text_data;
+	bool		live;
 };
 
+static bool add_overflow_u64(uint64_t a, uint64_t b, uint64_t *sum)
+{
+	if (a > UINT64_MAX - b)
+		return true;
+	*sum = a + b;
+	return false;
+}
+
+static bool mul_overflow_u64(uint64_t a, uint64_t b, uint64_t *product)
+{
+	if (a && b > UINT64_MAX / a)
+		return true;
+	*product = a * b;
+	return false;
+}
+
+static void validate_prb_field(const char *name, uint64_t struct_size,
+			       uint64_t offset, uint64_t field_size)
+{
+	if (offset > struct_size || field_size > struct_size - offset) {
+		fprintf(stderr,
+			"Invalid %s offset or size in VMCOREINFO\n", name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+}
+
+static void validate_prb_nested_field(const char *name, uint64_t struct_size,
+				      uint64_t outer_offset,
+				      uint64_t inner_offset,
+				      uint64_t field_size)
+{
+	uint64_t offset;
+
+	if (add_overflow_u64(outer_offset, inner_offset, &offset)) {
+		fprintf(stderr,
+			"Invalid %s offset or size in VMCOREINFO\n", name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	validate_prb_field(name, struct_size, offset, field_size);
+}
+
+static void read_exact(int fd, void *buf, size_t size, uint64_t offset,
+		       const char *name)
+{
+	size_t done = 0;
+
+	if (offset > INT64_MAX || size > INT64_MAX - offset) {
+		fprintf(stderr, "Invalid file range for %s\n", name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+
+	while (done < size) {
+		ssize_t ret;
+
+		ret = pread(fd, (char *)buf + done, size - done,
+			    (off_t)(offset + done));
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret < 0) {
+			fprintf(stderr, "Failed to read %s: %s\n",
+				name, strerror(errno));
+			exit(65);
+		}
+		if (!ret) {
+			fprintf(stderr, "Short read while reading %s\n", name);
+			exit(65);
+		}
+		done += ret;
+	}
+}
+
+static void prb_cache_init(struct prb_cache *cache, const char *name,
+			   uint64_t file_offset, uint64_t region_size,
+			   bool enable_cache)
+{
+	uint64_t end;
+
+	if (!region_size || file_offset > INT64_MAX ||
+	    add_overflow_u64(file_offset, region_size, &end) ||
+	    end > INT64_MAX) {
+		fprintf(stderr, "Invalid %s ring range\n", name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+
+	cache->buf = NULL;
+	cache->name = name;
+	cache->file_offset = file_offset;
+	cache->region_size = region_size;
+	cache->cache_offset = UINT64_MAX;
+	cache->cache_len = 0;
+	if (!enable_cache)
+		return;
+
+	cache->buf = malloc(PRB_CACHE_SIZE);
+	if (!cache->buf) {
+		fprintf(stderr, "Failed to malloc %u bytes for %s cache: %s\n",
+			PRB_CACHE_SIZE, name, strerror(errno));
+		exit(64);
+	}
+}
+
+static void prb_cache_read(int fd, struct prb_cache *cache, uint64_t offset,
+			   void *buf, size_t size)
+{
+	char *dest = buf;
+	uint64_t file_offset;
+
+	if (offset > cache->region_size || size > cache->region_size - offset) {
+		fprintf(stderr, "Invalid read outside %s ring\n", cache->name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	if (!cache->buf) {
+		if (add_overflow_u64(cache->file_offset, offset, &file_offset)) {
+			fprintf(stderr, "Invalid %s read offset\n", cache->name);
+			exit(PRB_BAD_DATA_EXIT);
+		}
+		read_exact(fd, buf, size, file_offset, cache->name);
+		return;
+	}
+
+	while (size) {
+		uint64_t cache_end;
+		size_t available;
+		size_t copy;
+
+		if (cache->cache_offset == UINT64_MAX ||
+		    add_overflow_u64(cache->cache_offset, cache->cache_len,
+				     &cache_end) ||
+		    offset < cache->cache_offset || offset >= cache_end) {
+			uint64_t remaining = cache->region_size - offset;
+
+			cache->cache_offset = offset;
+			cache->cache_len = remaining < PRB_CACHE_SIZE ?
+				remaining : PRB_CACHE_SIZE;
+			if (add_overflow_u64(cache->file_offset, offset,
+					     &file_offset)) {
+				fprintf(stderr, "Invalid %s cache offset\n",
+					cache->name);
+				exit(PRB_BAD_DATA_EXIT);
+			}
+			read_exact(fd, cache->buf, cache->cache_len, file_offset,
+				   cache->name);
+			cache_end = cache->cache_offset + cache->cache_len;
+		}
+
+		available = cache_end - offset;
+		copy = size < available ? size : available;
+		memcpy(dest, cache->buf + (offset - cache->cache_offset), copy);
+		dest += copy;
+		offset += copy;
+		size -= copy;
+	}
+}
+
+static void prb_cache_destroy(struct prb_cache *cache)
+{
+	free(cache->buf);
+}
+
 /*
  * desc_state and DESC_* definitions taken from kernel source:
  *
@@ -995,7 +1168,7 @@ enum desc_state {
 
 #define DESC32_SV_BITS		(sizeof(uint32_t) * 8)
 #define DESC32_FLAGS_SHIFT	(DESC32_SV_BITS - 2)
-#define DESC32_FLAGS_MASK	(3UL << DESC32_FLAGS_SHIFT)
+#define DESC32_FLAGS_MASK	(3U << DESC32_FLAGS_SHIFT)
 #define DESC32_STATE(sv)	(3UL & (sv >> DESC32_FLAGS_SHIFT))
 #define DESC32_ID_MASK		(~DESC32_FLAGS_MASK)
 #define DESC32_ID(sv)		((sv) & DESC32_ID_MASK)
@@ -1009,8 +1182,7 @@ enum desc_state {
  */
 
 /* Query the state of a descriptor. */
-static enum desc_state get_desc_state(unsigned long id,
-				      uint64_t state_val)
+static enum desc_state get_desc_state(uint64_t id, uint64_t state_val)
 {
 	if (id != DESC_ID(state_val))
 		return desc_miss;
@@ -1018,8 +1190,7 @@ static enum desc_state get_desc_state(unsigned long id,
 	return DESC_STATE(state_val);
 }
 
-static enum desc_state get_desc32_state(unsigned long id,
-					uint64_t state_val)
+static enum desc_state get_desc32_state(uint64_t id, uint64_t state_val)
 {
 	if (id != DESC32_ID(state_val))
 		return desc_miss;
@@ -1027,7 +1198,7 @@ static enum desc_state get_desc32_state(unsigned long id,
 	return DESC32_STATE(state_val);
 }
 
-static bool record_committed(unsigned long id, uint64_t state_var)
+static bool record_readable(uint64_t id, uint64_t state_var, bool live)
 {
 	enum desc_state state;
 
@@ -1036,7 +1207,15 @@ static bool record_committed(unsigned long id, uint64_t state_var)
 	else
 		state = get_desc_state(id, state_var);
 
-	return (state == desc_committed || state == desc_finalized);
+	if (state == desc_finalized)
+		return true;
+
+	/*
+	 * A crash can leave the newest record committed but not finalized.
+	 * Live records must be finalized because committed records may still
+	 * be reopened and modified by a writer.
+	 */
+	return (!live && state == desc_committed);
 }
 
 static uint64_t id_inc(uint64_t id)
@@ -1061,7 +1240,7 @@ static uint64_t sizeof_ulong(void)
 	return (machine_pointer_bits() >> 3);
 }
 
-static void dump_record(struct prb_map *m, unsigned long id,
+static void dump_record(int fd, struct prb_map *m, uint64_t id,
 			void (*handler)(char*, unsigned int))
 {
 #define OUT_BUF_SIZE	4096
@@ -1074,57 +1253,82 @@ static void dump_record(struct prb_map *m, unsigned long id,
 	uint64_t ts_nsec;
 	uint64_t begin;
 	uint64_t next;
-	char *info;
-	char *text;
-	char *desc;
-	int i;
-
-	desc = m->descs + ((id % m->desc_ring_count) * prb_desc_sz);
-	info = m->infos + ((id % m->desc_ring_count) * printk_info_sz);
-
-	/* skip non-committed record */
-	state_var = get_ulong(desc + prb_desc_state_var_offset +
-					atomic_long_t_counter_offset);
-	if (!record_committed(id, state_var))
+	uint64_t desc_offset;
+	uint64_t info_offset;
+	uint64_t slot;
+	size_t i;
+
+	slot = id % m->desc_ring_count;
+	if (mul_overflow_u64(slot, prb_desc_sz, &desc_offset) ||
+	    mul_overflow_u64(slot, printk_info_sz, &info_offset)) {
+		fprintf(stderr, "Invalid printk ring record offset\n");
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	prb_cache_read(fd, &m->desc_cache, desc_offset, m->desc, prb_desc_sz);
+
+	/* skip records that are not safe to read */
+	state_var = get_ulong(m->desc + prb_desc_state_var_offset +
+						atomic_long_t_counter_offset);
+	if (!record_readable(id, state_var, m->live))
 		return;
 
-	begin = get_ulong(desc + prb_desc_text_blk_lpos_offset +
+	prb_cache_read(fd, &m->info_cache, info_offset, m->info,
+		       printk_info_sz);
+
+	begin = get_ulong(m->desc + prb_desc_text_blk_lpos_offset +
 			  prb_data_blk_lpos_begin_offset) %
 		m->text_data_ring_size;
-	next = get_ulong(desc + prb_desc_text_blk_lpos_offset +
+	next = get_ulong(m->desc + prb_desc_text_blk_lpos_offset +
 			 prb_data_blk_lpos_next_offset) %
 	       m->text_data_ring_size;
 
-	ts_nsec = struct_val_u64(info, printk_info_ts_nsec_offset);
-	imaxdiv_sec = imaxdiv(ts_nsec, 1000000000);
-	imaxdiv_usec = imaxdiv(imaxdiv_sec.rem, 1000);
+	/* skip data-less text blocks */
+	if (begin == next) {
+		len = 0;
+	} else {
+		len = struct_val_u16(m->info, printk_info_text_len_offset);
 
-	offset += sprintf(out_buf + offset, "[%5llu.%06llu] ",
-		(long long unsigned int)imaxdiv_sec.quot,
-		(long long unsigned int)imaxdiv_usec.quot);
+		/* handle wrapping data block */
+		if (begin > next)
+			begin = 0;
 
-	/* skip data-less text blocks */
-	if (begin == next)
-		goto out;
+		/* skip over descriptor ID */
+		if (begin > UINT64_MAX - sizeof_ulong()) {
+			fprintf(stderr, "Invalid printk text block position\n");
+			exit(PRB_BAD_DATA_EXIT);
+		}
+		begin += sizeof_ulong();
+		if (begin > next) {
+			fprintf(stderr, "Invalid printk text block range\n");
+			exit(PRB_BAD_DATA_EXIT);
+		}
 
-	len = struct_val_u16(info, printk_info_text_len_offset);
+		/* handle truncated messages */
+		if (next - begin < len)
+			len = next - begin;
 
-	/* handle wrapping data block */
-	if (begin > next)
-		begin = 0;
+		prb_cache_read(fd, &m->text_cache, begin, m->text, len);
+	}
 
-	/* skip over descriptor ID */
-	begin += sizeof_ulong();
+	/* Live /proc/kcore data may change while a record is being read. */
+	if (m->live) {
+		prb_cache_read(fd, &m->desc_cache, desc_offset,
+			       m->desc_verify, prb_desc_sz);
+		if (memcmp(m->desc, m->desc_verify, prb_desc_sz))
+			return;
+	}
 
-	/* handle truncated messages */
-	if (next - begin < len)
-		len = next - begin;
+	ts_nsec = struct_val_u64(m->info, printk_info_ts_nsec_offset);
+	imaxdiv_sec = imaxdiv(ts_nsec, 1000000000);
+	imaxdiv_usec = imaxdiv(imaxdiv_sec.rem, 1000);
 
-	text = m->text_data + begin;
+	offset += sprintf(out_buf + offset, "[%5llu.%06llu] ",
+		(unsigned long long)imaxdiv_sec.quot,
+		(unsigned long long)imaxdiv_usec.quot);
 
 	/* escape non-printable characters */
 	for (i = 0; i < len; i++) {
-		unsigned char c = text[i];
+		unsigned char c = m->text[i];
 
 		if (!isprint(c) && !isspace(c))
 			offset += sprintf(out_buf + offset, "\\x%02x", c);
@@ -1137,115 +1341,228 @@ static void dump_record(struct prb_map *m, unsigned long id,
 			offset = 0;
 		}
 	}
-out:
 	out_buf[offset++] = '\n';
 
 	if (offset && handler)
 		handler(out_buf, offset);
 }
 
+static bool input_is_live(int fd)
+{
+	struct stat st;
+	struct stat kcore_st;
+
+	if (fstat(fd, &st)) {
+		fprintf(stderr, "Failed to stat %s: %s\n",
+			fname, strerror(errno));
+		exit(65);
+	}
+
+	/*
+	 * Match the opened file's identity rather than the supplied pathname so
+	 * aliases such as symlinks cannot accidentally enable read-ahead caching.
+	 * Some kernels expose /proc/kcore as a regular procfs file.
+	 */
+	if (!stat("/proc/kcore", &kcore_st) &&
+	    st.st_dev == kcore_st.st_dev &&
+	    st.st_ino == kcore_st.st_ino)
+		return true;
+
+	return S_ISCHR(st.st_mode);
+}
+
 /*
  *  Handle the lockless printk_ringbuffer.
  */
 static void dump_dmesg_lockless(int fd, void (*handler)(char*, unsigned int))
 {
 	struct prb_map m;
+	char *prb;
+	char *desc_ring;
+	char *text_data_ring;
+	uint64_t desc_region_size;
+	uint64_t info_region_size;
+	uint64_t id_mask;
+	uint64_t record_count;
 	uint64_t head_id;
 	uint64_t tail_id;
 	uint64_t kaddr;
 	uint64_t id;
-	int ret;
+	uint64_t count_bits;
+	uint64_t size_bits;
+	uint64_t word_size;
 
 	/* setup printk_ringbuffer */
+	memset(&m, 0, sizeof(m));
+	/*
+	 * Cached data must not predate the first descriptor read when the
+	 * underlying ring is live. Disable read-ahead for /proc/kcore.
+	 */
+	m.live = input_is_live(fd);
 	kaddr = read_file_pointer(fd, vaddr_to_offset(prb_vaddr));
-	m.prb = calloc(1, printk_ringbuffer_sz);
-	if (!m.prb) {
+	if (!kaddr || !printk_ringbuffer_sz ||
+	    printk_ringbuffer_sz > PRB_CACHE_SIZE ||
+	    !prb_desc_sz || prb_desc_sz > PRB_CACHE_SIZE ||
+	    !printk_info_sz || printk_info_sz > PRB_CACHE_SIZE) {
+		fprintf(stderr, "Invalid printk ring metadata\n");
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	prb = calloc(1, printk_ringbuffer_sz);
+	if (!prb) {
 		fprintf(stderr, "Failed to malloc %zu bytes for prb: %s\n",
 			printk_ringbuffer_sz, strerror(errno));
 		exit(64);
 	}
-	ret = pread(fd, m.prb, printk_ringbuffer_sz, vaddr_to_offset(kaddr));
-	if (ret != printk_ringbuffer_sz) {
-		fprintf(stderr, "Failed to read prb of size %zu bytes: %s\n",
-			printk_ringbuffer_sz, strerror(errno));
-		exit(65);
-	}
+	read_exact(fd, prb, printk_ringbuffer_sz, vaddr_to_offset(kaddr),
+		   "printk ringbuffer");
+
+	word_size = sizeof_ulong();
+	validate_prb_field("printk_ringbuffer.desc_ring",
+			   printk_ringbuffer_sz,
+			   printk_ringbuffer_desc_ring_offset, 1);
+	validate_prb_field("prb_desc_ring.count_bits",
+			   printk_ringbuffer_sz -
+			   printk_ringbuffer_desc_ring_offset,
+			   prb_desc_ring_count_bits_offset, sizeof(uint32_t));
+	validate_prb_field("prb_desc_ring.descs",
+			   printk_ringbuffer_sz -
+			   printk_ringbuffer_desc_ring_offset,
+			   prb_desc_ring_descs_offset, word_size);
+	validate_prb_field("prb_desc_ring.infos",
+			   printk_ringbuffer_sz -
+			   printk_ringbuffer_desc_ring_offset,
+			   prb_desc_ring_infos_offset, word_size);
+	validate_prb_nested_field("prb_desc_ring.head_id",
+				  printk_ringbuffer_sz -
+				  printk_ringbuffer_desc_ring_offset,
+				  prb_desc_ring_head_id_offset,
+				  atomic_long_t_counter_offset, word_size);
+	validate_prb_nested_field("prb_desc_ring.tail_id",
+				  printk_ringbuffer_sz -
+				  printk_ringbuffer_desc_ring_offset,
+				  prb_desc_ring_tail_id_offset,
+				  atomic_long_t_counter_offset, word_size);
+	validate_prb_field("printk_ringbuffer.text_data_ring",
+			   printk_ringbuffer_sz,
+			   printk_ringbuffer_text_data_ring_offset, 1);
+	validate_prb_field("prb_data_ring.size_bits",
+			   printk_ringbuffer_sz -
+			   printk_ringbuffer_text_data_ring_offset,
+			   prb_data_ring_size_bits_offset, sizeof(uint32_t));
+	validate_prb_field("prb_data_ring.data",
+			   printk_ringbuffer_sz -
+			   printk_ringbuffer_text_data_ring_offset,
+			   prb_data_ring_data_offset, word_size);
+	validate_prb_nested_field("prb_desc.state_var", prb_desc_sz,
+				  prb_desc_state_var_offset,
+				  atomic_long_t_counter_offset, word_size);
+	validate_prb_nested_field("prb_desc.text_blk_lpos.begin", prb_desc_sz,
+				  prb_desc_text_blk_lpos_offset,
+				  prb_data_blk_lpos_begin_offset, word_size);
+	validate_prb_nested_field("prb_desc.text_blk_lpos.next", prb_desc_sz,
+				  prb_desc_text_blk_lpos_offset,
+				  prb_data_blk_lpos_next_offset, word_size);
+	validate_prb_field("printk_info.ts_nsec", printk_info_sz,
+			   printk_info_ts_nsec_offset, sizeof(uint64_t));
+	validate_prb_field("printk_info.text_len", printk_info_sz,
+			   printk_info_text_len_offset, sizeof(uint16_t));
 
 	/* setup descriptor ring */
-	m.desc_ring = m.prb + printk_ringbuffer_desc_ring_offset;
-	m.desc_ring_count = 1 << struct_val_u32(m.desc_ring,
-					prb_desc_ring_count_bits_offset);
-	kaddr = get_ulong(m.desc_ring + prb_desc_ring_descs_offset);
-	m.descs = calloc(1, prb_desc_sz * m.desc_ring_count);
-	if (!m.descs) {
-		fprintf(stderr, "Failed to malloc %lu bytes for descs: %s\n",
-			prb_desc_sz * m.desc_ring_count, strerror(errno));
-		exit(64);
+	desc_ring = prb + printk_ringbuffer_desc_ring_offset;
+	count_bits = struct_val_u32(desc_ring,
+				    prb_desc_ring_count_bits_offset);
+	if (count_bits >= machine_pointer_bits() - 2) {
+		fprintf(stderr, "Invalid printk descriptor count bits: %llu\n",
+			(unsigned long long)count_bits);
+		exit(PRB_BAD_DATA_EXIT);
 	}
-	ret = pread(fd, m.descs, prb_desc_sz * m.desc_ring_count,
-		    vaddr_to_offset(kaddr));
-	if (ret != prb_desc_sz * m.desc_ring_count) {
-		fprintf(stderr,
-			"Failed to read descs of size %lu bytes: %s\n",
-			prb_desc_sz * m.desc_ring_count, strerror(errno));
-		exit(65);
+	m.desc_ring_count = 1ULL << count_bits;
+	if (mul_overflow_u64(prb_desc_sz, m.desc_ring_count,
+			     &desc_region_size) ||
+	    mul_overflow_u64(printk_info_sz, m.desc_ring_count,
+			     &info_region_size)) {
+		fprintf(stderr, "Invalid printk descriptor ring size\n");
+		exit(PRB_BAD_DATA_EXIT);
 	}
+	kaddr = get_ulong(desc_ring + prb_desc_ring_descs_offset);
+	if (!kaddr) {
+		fprintf(stderr, "Invalid printk descriptor ring address\n");
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	prb_cache_init(&m.desc_cache, "printk descriptors",
+		       vaddr_to_offset(kaddr), desc_region_size,
+		       !m.live);
 
 	/* setup info ring */
-	kaddr = get_ulong(m.prb + prb_desc_ring_infos_offset);
-	m.infos = calloc(1, printk_info_sz * m.desc_ring_count);
-	if (!m.infos) {
-		fprintf(stderr, "Failed to malloc %lu bytes for infos: %s\n",
-			printk_info_sz * m.desc_ring_count, strerror(errno));
-		exit(64);
-	}
-	ret = pread(fd, m.infos, printk_info_sz * m.desc_ring_count,
-		    vaddr_to_offset(kaddr));
-	if (ret != printk_info_sz * m.desc_ring_count) {
-		fprintf(stderr,
-			"Failed to read infos of size %lu bytes: %s\n",
-			printk_info_sz * m.desc_ring_count, strerror(errno));
-		exit(65);
+	kaddr = get_ulong(desc_ring + prb_desc_ring_infos_offset);
+	if (!kaddr) {
+		fprintf(stderr, "Invalid printk info ring address\n");
+		exit(PRB_BAD_DATA_EXIT);
 	}
+	prb_cache_init(&m.info_cache, "printk infos", vaddr_to_offset(kaddr),
+		       info_region_size, !m.live);
 
 	/* setup text data ring */
-	m.text_data_ring = m.prb + printk_ringbuffer_text_data_ring_offset;
-	m.text_data_ring_size = 1 << struct_val_u32(m.text_data_ring,
-					prb_data_ring_size_bits_offset);
-	kaddr = get_ulong(m.text_data_ring + prb_data_ring_data_offset);
-	m.text_data = calloc(1, m.text_data_ring_size);
-	if (!m.text_data) {
-		fprintf(stderr,
-			"Failed to malloc %lu bytes for text_data: %s\n",
-			m.text_data_ring_size, strerror(errno));
-		exit(64);
+	text_data_ring = prb + printk_ringbuffer_text_data_ring_offset;
+	size_bits = struct_val_u32(text_data_ring,
+				   prb_data_ring_size_bits_offset);
+	if (size_bits >= machine_pointer_bits()) {
+		fprintf(stderr, "Invalid printk text data size bits: %llu\n",
+			(unsigned long long)size_bits);
+		exit(PRB_BAD_DATA_EXIT);
 	}
-	ret = pread(fd, m.text_data, m.text_data_ring_size,
-		    vaddr_to_offset(kaddr));
-	if (ret != m.text_data_ring_size) {
-		fprintf(stderr,
-			"Failed to read text_data of size %lu bytes: %s\n",
-			m.text_data_ring_size, strerror(errno));
-		exit(65);
+	m.text_data_ring_size = 1ULL << size_bits;
+	kaddr = get_ulong(text_data_ring + prb_data_ring_data_offset);
+	if (!kaddr) {
+		fprintf(stderr, "Invalid printk text data ring address\n");
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	prb_cache_init(&m.text_cache, "printk text data",
+		       vaddr_to_offset(kaddr), m.text_data_ring_size,
+		       !m.live);
+
+	m.desc = malloc(prb_desc_sz);
+	m.info = malloc(printk_info_sz);
+	m.text = malloc(UINT16_MAX);
+	m.desc_verify = m.live ? malloc(prb_desc_sz) : NULL;
+	if (!m.desc || !m.info || !m.text ||
+	    (m.live && !m.desc_verify)) {
+		fprintf(stderr, "Failed to allocate printk record buffers: %s\n",
+			strerror(errno));
+		exit(64);
 	}
 
 	/* ready to go */
 
-	tail_id = get_ulong(m.desc_ring + prb_desc_ring_tail_id_offset +
+	tail_id = get_ulong(desc_ring + prb_desc_ring_tail_id_offset +
 						atomic_long_t_counter_offset);
-	head_id = get_ulong(m.desc_ring + prb_desc_ring_head_id_offset +
+	head_id = get_ulong(desc_ring + prb_desc_ring_head_id_offset +
 						atomic_long_t_counter_offset);
+	free(prb);
+	id_mask = machine_pointer_bits() == 32 ? DESC32_ID_MASK : DESC_ID_MASK;
+	if ((tail_id & ~id_mask) || (head_id & ~id_mask)) {
+		fprintf(stderr, "Invalid printk descriptor head or tail ID\n");
+		exit(PRB_BAD_DATA_EXIT);
+	}
 
-	for (id = tail_id; id != head_id; id = id_inc(id))
-		dump_record(&m, id, handler);
-
-	/* dump head record */
-	dump_record(&m, id, handler);
+	for (id = tail_id, record_count = 0; ; id = id_inc(id)) {
+		if (record_count++ >= m.desc_ring_count) {
+			fprintf(stderr,
+				"Printk descriptor head/tail span exceeds ring size\n");
+			exit(PRB_BAD_DATA_EXIT);
+		}
+		dump_record(fd, &m, id, handler);
+		if (id == head_id)
+			break;
+	}
 
-	free(m.text_data);
-	free(m.infos);
-	free(m.descs);
-	free(m.prb);
+	free(m.desc_verify);
+	free(m.text);
+	free(m.info);
+	free(m.desc);
+	prb_cache_destroy(&m.text_cache);
+	prb_cache_destroy(&m.info_cache);
+	prb_cache_destroy(&m.desc_cache);
 }
 
 void dump_dmesg(int fd, void (*handler)(char*, unsigned int))

---
base-commit: 29898e149feb5c615b3ab6313260d58315bf1d8d
change-id: 20260728-vmcore-dmesg-stream-upstream-7da695989f95

Best regards,
-- 
Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>


