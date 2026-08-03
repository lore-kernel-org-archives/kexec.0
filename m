Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C55C55182
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EH7ZlxvzJ0GIxNI9j221BgzRdD8oQfBbe9Ksf/ZFGOc=; b=mIsAoLq+gJ8+Huv8rnKXBhl/Nl
	rensTf7eAVMErFTKaQEX5jojo/tgYKVNtou1uqMhULrf7a5fhXbhgq3fbxmvdWUEowXL+F6QcH13V
	4NJd6LtMBp86yYL8iaqVJAYvB/NTkl0VEA3yyIHtDP7KI0hGN8dIvyw1W7dbk0ZC3A3EWkCKY5dy8
	s6vorirkJVY7/9ummvCOoZdOyXo9r5qvN6A92hsabTydst2AlZGjb3GvJ/g+QzpRrDZYFlJCxgqp0
	2CbTPUr7bXfIbv9fXDF7UJJgsWsFwKAFbxyidNt6iWqXo6IX6CL3XLHbLDa22hTKvWcWtrl1pMNMw
	3dQpseAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqvyc-00000000AM1-2TKw;
	Mon, 03 Aug 2026 16:57:22 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqvyZ-00000000AKA-2R61
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 16:57:22 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-52b6543169fso10285231cf.2
        for <kexec@lists.infradead.org>; Mon, 03 Aug 2026 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785776237; x=1786381037; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EH7ZlxvzJ0GIxNI9j221BgzRdD8oQfBbe9Ksf/ZFGOc=;
        b=LSnSh4aKHaCzSVWdvHPuiFjhodZhgAjAV/sLVHWt7T9EOtMHH6/s2VaLOnmaGSdYVN
         UdYA6WiEBJVF2VRMHdgA8nRuf+uEC0ISF/43Gb/sCkQvat6MPlWfmJHem1H6/Scixk0N
         pkeOSWtWwu/l2MgDvzJdbSnQqMpKMMb/TOmwHvMrsA7MlmEv2IoD0lrL9vNKbybJfB+4
         L5lm62mynElCOsSzQ8nCnaUyyxH3tyJ2FsQoTxPmwpxkMBPS9v29XPJhM/wBOcyS/mfg
         z4imILWuczQgH3pt3vnzhxZNCYMya8O83Kq/1Ikx45xV5Pq0Yy69Ec8V2o+bu5821ihl
         9W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785776237; x=1786381037;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EH7ZlxvzJ0GIxNI9j221BgzRdD8oQfBbe9Ksf/ZFGOc=;
        b=lmauPxyEHaVRSKzwdfQZWevTEAGOBovHxUkkmRNXbxpCNLhEGuPDDwb7VOKLh9lI4B
         HaMs5EqNj2AffDl2tfg8yWmAHjKsdAqgkZ3avlkv6YH0NlljeI/Dn/c9Pp0j57OmspPu
         dDBfHDgOBzD9d5CoM2hc7mzhw0X+PujaNzn1bvFnngvtAzB6i4ZDJF+VKgVD8BfP3br1
         w1FPkSH585KnqmtjUYLXA1d1exUvKneVuLzzJ8BbPKdbNuXnm1D7wzJpGipGctDNYaBT
         BXXcOuMIM/Oq1Pn7IB08KnaX2UlWKRXOP/MbFWSJCKckAU8nPfhPe0/EKV0fgw+BbZqo
         lBYg==
X-Gm-Message-State: AOJu0Yxxl+weRFWPMSHvWxHiHvv6QiT27xMSrp4WCAOq1eRyXbF0XmJw
	p/lTEe2xcXqi1tTHgv223sSInEa3GBOAHTplkwLdmEWbrw++SrFSSsrr
X-Gm-Gg: AR+sD13qGn7MUMi1qcg5HaJ8zgDHVLO2IcjrGcJV9AzbWSbBa6ZePH07Kaw+pnoih/C
	g2Qo88yQJRr9OEA6qaGzoGDcxG0g0NcSLZUfqiJLYxHDhm2xRpNPBOQidIwU5tuUdVYCiSOK/cL
	3qVWKwIl/WmstRcQeX4MzafvCA/Nx3HWIRx6MbvgM0uIs8/AYOr+kt+i7kgNjJ+ieWoUHClniEo
	LRbKGSxtG3+G49T0457lTAyqXlBpdBvmQIQ/soYEHfviMARMOoktfGS0KRu2zZufE1z5scfLwz/
	ceKLAsLvhfhYC6v+JCJG4lSkvRqJGRa8LGQuIH5vDLD0BhSQ+kIHi0jk7/9qM8NuUx6dsX7zPll
	98u0fT6qVJjypHcuKAvAcAn2EL7CXBZPJjWfjjFLaI8XE23AwWEFUmI3ErsgLQnZ+jIhbry0wVW
	uOSpJOVl20ztEa8VLJKQCn7hvIrwu7Z3xQRo1/zY6+kHv4GBKIjRjTLwn80t5D/NVEfx8DMmWhm
	9GZkCFqborXwOcWzCd+URffYGBAitwzK97QFd1zKO/k
X-Received: by 2002:ac8:5c96:0:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52b5666f9abmr235460901cf.5.1785776237158;
        Mon, 03 Aug 2026 09:57:17 -0700 (PDT)
Received: from cw-fl20tjcw03-l.tailb3cd1a.ts.net ([2600:4040:9121:7700:7156:9aae:648c:5cb4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ebeb909sm64232071cf.29.2026.08.03.09.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:57:16 -0700 (PDT)
From: Serapheim Dimitropoulos <serapheimd@gmail.com>
Date: Mon, 03 Aug 2026 12:57:04 -0400
Subject: [PATCH kexec-tools v2] util_lib/elf_info: stream lockless printk
 ring records
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-vmcore-dmesg-stream-upstream-v2-1-cb7f7449bc1b@coreweave.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ7CIBCFr9LM2jGUSFtceQ/jAmHaEqU0gNik6
 d1F48KVu/fyfr4VIgVLEY7VCoGyjdZPxfBdBXpU00BoTfHAGW9YyzvMTvtAaBzFAWMKpBw+5q9
 ojWqkkJ3spYByMQfq7fK5P8ONFtKYvL9HuJSwD95hGsvwlyD/E3KNNSrGrsKIQ+Gw07v8JJVpr
 72DbXsBL596rNMAAAA=
X-Change-ID: 20260728-vmcore-dmesg-stream-upstream-7da695989f95
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>, 
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
 Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>, 
 Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785776236; l=20886;
 i=sdimitropoulos@coreweave.com; s=20260302; h=from:subject:message-id;
 bh=B9uNRtBDnmmUACtrfnDg2GHKxBLVQcmVSNXsuDo7d0I=;
 b=/YwmzL8Z9W3dy1rSVc162OtkWZ1aM3BJoQe4zEzF2da9GIHok0gSb/l0MgEqBahUPPGiG7tKV
 SF9Ghr9GG+QAMNFBMG6kO4BF0fD19mdhP7BxGOjQk/swAnoVOzp5/ln
X-Developer-Key: i=sdimitropoulos@coreweave.com; a=ed25519;
 pk=Qysvg7jaTIU0posaYFtqa5SKJlFwqzil4X0U1p1zo/g=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_095719_722637_A33065BD 
X-CRM114-Status: GOOD (  22.62  )
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

Read each active record directly from the dump instead. Keep only one
descriptor, info record, and text record in memory, and use exact reads
for each of them. Validate the ring geometry and address arithmetic, and
bound the tail-to-head traversal to the descriptor ring size.

The old and new readers produced byte-identical output for committed and
finalized records, missed and empty records, wrapped text, non-printable
bytes, and descriptor ID wraparound. Malformed fixtures covered invalid
shifts, arithmetic overflow, short reads, and invalid head/tail spans.

On a synthetic 64 MiB text ring, peak RSS dropped from 345116 KiB to
1052 KiB. A dense 100000-record fixture produced the same output in
0.23 seconds while reducing peak RSS from 345112 KiB to 1080 KiB.

Fixes: 4149df9005f2 ("printk: add support for lockless ringbuffer")
Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
---
Changes in v2:
- Drop the read-through caches and use exact per-record reads, as suggested
  by John.
- Keep the existing best-effort behavior for the undocumented /proc/kcore
  input instead of adding a separate live-input policy.
- Re-run the synthetic fixture tests, make distcheck, the 17-architecture
  build matrix, the arm64 64 MiB-ring crash test, and 200 direct and
  symlinked /proc/kcore smoke-test reads using the built arm64 package.
- Link to v1: https://lore.kernel.org/r/20260729-vmcore-dmesg-stream-upstream-v1-1-a00b5d5489f0@coreweave.com
---
 util_lib/elf_info.c | 436 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 320 insertions(+), 116 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 36eb895..19e4dfa 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -954,21 +954,133 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 		handler(out_buf, len);
 }
 
+#define PRB_MAX_STRUCT_SIZE	(64 * 1024)
+#define PRB_BAD_DATA_EXIT	66
+
+struct prb_region {
+	const char	*name;
+	uint64_t	file_offset;
+	uint64_t	size;
+};
+
 /* convenience struct for passing many values to helper functions */
 struct prb_map {
-	char		*prb;
+	uint64_t	desc_ring_count;
+	struct prb_region desc_region;
+	char		*desc;
 
-	char		*desc_ring;
-	unsigned long	desc_ring_count;
-	char		*descs;
+	struct prb_region info_region;
+	char		*info;
 
-	char		*infos;
-
-	char		*text_data_ring;
-	unsigned long	text_data_ring_size;
-	char		*text_data;
+	uint64_t	text_data_ring_size;
+	struct prb_region text_region;
+	char		*text;
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
+static void prb_region_init(struct prb_region *region, const char *name,
+			    uint64_t file_offset, uint64_t size)
+{
+	uint64_t end;
+
+	if (!size || file_offset > INT64_MAX ||
+	    add_overflow_u64(file_offset, size, &end) ||
+	    end > INT64_MAX) {
+		fprintf(stderr, "Invalid %s ring range\n", name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+
+	region->name = name;
+	region->file_offset = file_offset;
+	region->size = size;
+}
+
+static void prb_region_read(int fd, struct prb_region *region,
+			    uint64_t offset, void *buf, size_t size)
+{
+	uint64_t file_offset;
+
+	if (offset > region->size || size > region->size - offset) {
+		fprintf(stderr, "Invalid read outside %s ring\n", region->name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	if (add_overflow_u64(region->file_offset, offset, &file_offset)) {
+		fprintf(stderr, "Invalid %s read offset\n", region->name);
+		exit(PRB_BAD_DATA_EXIT);
+	}
+	read_exact(fd, buf, size, file_offset, region->name);
+}
+
 /*
  * desc_state and DESC_* definitions taken from kernel source:
  *
@@ -995,7 +1107,7 @@ enum desc_state {
 
 #define DESC32_SV_BITS		(sizeof(uint32_t) * 8)
 #define DESC32_FLAGS_SHIFT	(DESC32_SV_BITS - 2)
-#define DESC32_FLAGS_MASK	(3UL << DESC32_FLAGS_SHIFT)
+#define DESC32_FLAGS_MASK	(3U << DESC32_FLAGS_SHIFT)
 #define DESC32_STATE(sv)	(3UL & (sv >> DESC32_FLAGS_SHIFT))
 #define DESC32_ID_MASK		(~DESC32_FLAGS_MASK)
 #define DESC32_ID(sv)		((sv) & DESC32_ID_MASK)
@@ -1009,8 +1121,7 @@ enum desc_state {
  */
 
 /* Query the state of a descriptor. */
-static enum desc_state get_desc_state(unsigned long id,
-				      uint64_t state_val)
+static enum desc_state get_desc_state(uint64_t id, uint64_t state_val)
 {
 	if (id != DESC_ID(state_val))
 		return desc_miss;
@@ -1018,8 +1129,7 @@ static enum desc_state get_desc_state(unsigned long id,
 	return DESC_STATE(state_val);
 }
 
-static enum desc_state get_desc32_state(unsigned long id,
-					uint64_t state_val)
+static enum desc_state get_desc32_state(uint64_t id, uint64_t state_val)
 {
 	if (id != DESC32_ID(state_val))
 		return desc_miss;
@@ -1027,7 +1137,7 @@ static enum desc_state get_desc32_state(unsigned long id,
 	return DESC32_STATE(state_val);
 }
 
-static bool record_committed(unsigned long id, uint64_t state_var)
+static bool record_committed(uint64_t id, uint64_t state_var)
 {
 	enum desc_state state;
 
@@ -1061,7 +1171,7 @@ static uint64_t sizeof_ulong(void)
 	return (machine_pointer_bits() >> 3);
 }
 
-static void dump_record(struct prb_map *m, unsigned long id,
+static void dump_record(int fd, struct prb_map *m, uint64_t id,
 			void (*handler)(char*, unsigned int))
 {
 #define OUT_BUF_SIZE	4096
@@ -1074,57 +1184,75 @@ static void dump_record(struct prb_map *m, unsigned long id,
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
+	prb_region_read(fd, &m->desc_region, desc_offset, m->desc,
+			prb_desc_sz);
 
 	/* skip non-committed record */
-	state_var = get_ulong(desc + prb_desc_state_var_offset +
-					atomic_long_t_counter_offset);
+	state_var = get_ulong(m->desc + prb_desc_state_var_offset +
+						atomic_long_t_counter_offset);
 	if (!record_committed(id, state_var))
 		return;
 
-	begin = get_ulong(desc + prb_desc_text_blk_lpos_offset +
+	prb_region_read(fd, &m->info_region, info_offset, m->info,
+			printk_info_sz);
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
-
-	offset += sprintf(out_buf + offset, "[%5llu.%06llu] ",
-		(long long unsigned int)imaxdiv_sec.quot,
-		(long long unsigned int)imaxdiv_usec.quot);
-
 	/* skip data-less text blocks */
-	if (begin == next)
-		goto out;
+	if (begin == next) {
+		len = 0;
+	} else {
+		len = struct_val_u16(m->info, printk_info_text_len_offset);
 
-	len = struct_val_u16(info, printk_info_text_len_offset);
+		/* handle wrapping data block */
+		if (begin > next)
+			begin = 0;
 
-	/* handle wrapping data block */
-	if (begin > next)
-		begin = 0;
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
 
-	/* skip over descriptor ID */
-	begin += sizeof_ulong();
+		/* handle truncated messages */
+		if (next - begin < len)
+			len = next - begin;
 
-	/* handle truncated messages */
-	if (next - begin < len)
-		len = next - begin;
+		prb_region_read(fd, &m->text_region, begin, m->text, len);
+	}
 
-	text = m->text_data + begin;
+	ts_nsec = struct_val_u64(m->info, printk_info_ts_nsec_offset);
+	imaxdiv_sec = imaxdiv(ts_nsec, 1000000000);
+	imaxdiv_usec = imaxdiv(imaxdiv_sec.rem, 1000);
+
+	offset += sprintf(out_buf + offset, "[%5llu.%06llu] ",
+		(unsigned long long)imaxdiv_sec.quot,
+		(unsigned long long)imaxdiv_usec.quot);
 
 	/* escape non-printable characters */
 	for (i = 0; i < len; i++) {
-		unsigned char c = text[i];
+		unsigned char c = m->text[i];
 
 		if (!isprint(c) && !isspace(c))
 			offset += sprintf(out_buf + offset, "\\x%02x", c);
@@ -1137,7 +1265,6 @@ static void dump_record(struct prb_map *m, unsigned long id,
 			offset = 0;
 		}
 	}
-out:
 	out_buf[offset++] = '\n';
 
 	if (offset && handler)
@@ -1150,102 +1277,179 @@ out:
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
 	kaddr = read_file_pointer(fd, vaddr_to_offset(prb_vaddr));
-	m.prb = calloc(1, printk_ringbuffer_sz);
-	if (!m.prb) {
+	if (!kaddr || !printk_ringbuffer_sz ||
+	    printk_ringbuffer_sz > PRB_MAX_STRUCT_SIZE ||
+	    !prb_desc_sz || prb_desc_sz > PRB_MAX_STRUCT_SIZE ||
+	    !printk_info_sz || printk_info_sz > PRB_MAX_STRUCT_SIZE) {
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
+	}
+	kaddr = get_ulong(desc_ring + prb_desc_ring_descs_offset);
+	if (!kaddr) {
+		fprintf(stderr, "Invalid printk descriptor ring address\n");
+		exit(PRB_BAD_DATA_EXIT);
 	}
+	prb_region_init(&m.desc_region, "printk descriptors",
+			vaddr_to_offset(kaddr), desc_region_size);
 
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
+	prb_region_init(&m.info_region, "printk infos",
+			vaddr_to_offset(kaddr), info_region_size);
 
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
+	prb_region_init(&m.text_region, "printk text data",
+			vaddr_to_offset(kaddr), m.text_data_ring_size);
+
+	m.desc = malloc(prb_desc_sz);
+	m.info = malloc(printk_info_sz);
+	m.text = malloc(UINT16_MAX);
+	if (!m.desc || !m.info || !m.text) {
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
+	free(m.text);
+	free(m.info);
+	free(m.desc);
 }
 
 void dump_dmesg(int fd, void (*handler)(char*, unsigned int))

---
base-commit: 29898e149feb5c615b3ab6313260d58315bf1d8d
change-id: 20260728-vmcore-dmesg-stream-upstream-7da695989f95

Best regards,
-- 
Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>


