Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E777C5DF7D
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eWnjlV7uPwe+4gWKLK9EeUBWXA1Tt40aub4O3Hlvu3M=; b=gsdOjdi3VjWYzyA6E74+ImjntX
	Mq6CX7ZV5ZV84s9B14dBaYlF8NSNmP1o+q3jSnWGWDA4K4KWq56Qsad0vd5rkj8mlUIzqLyXFPIfa
	1VBEyFGefAk8ua8NaxUhDbvEFTyej9f6hACndbFATjFkuABoFcU9SDFHZ+jgIdkUonXWKoe79jWi7
	Qg9Am8IypFiXcGj1RStrwt+SjQK+BF736M62fF/3Gg9q5xw2PeJRPdr+sNPJ8zmCQ9USb5rE/e2zY
	1BFNs2VCryUmq+ra5H4ZmNfEEuEAkIdMvzSUiDuspwI1vmaOjW0vhszDNDLGgj0xZsLtFpW4rv8SJ
	q9xew1dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwKpA-00000008Anr-03cy;
	Tue, 18 Aug 2026 14:29:56 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwKp6-00000008Ame-1svq
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 14:29:54 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-52cd38ddcdfso22490541cf.3
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063390; x=1787668190; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eWnjlV7uPwe+4gWKLK9EeUBWXA1Tt40aub4O3Hlvu3M=;
        b=Z2wfxjZyF2cmkWwuz9qAmc/ZZhE92/ewJirpx2xprghRxdTwnx8Og+9H4ZOnUms9gt
         i5159v29lccArBeD7ywCfeYGWqWfmG4S2RWuu56UCeeyue4xbeL0vsuuQJ/h1PHsmzAT
         aabfwzyQhuSNWvh0kYKRz8HfysW99aQ+FfOwR8i/tJEfoD0MHNT/CH4LAXNOImc88+sf
         Cd2lwAJeG7YUEC6V16jA7tarZm2Vklpf48aN/QuI0L73uiSPfH3E1y9ZsgS16Nf4TdTe
         O19cTV2zJ2mL7N602wFjGC7f44498f1y6Co/M5raspL+/tBPJckYIi/MPZVwg6ZW6lta
         Ss7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063390; x=1787668190;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eWnjlV7uPwe+4gWKLK9EeUBWXA1Tt40aub4O3Hlvu3M=;
        b=LsmI2IRAiFX5zxbiS64gr0KBB+/DYjPwKoOmQvNZJ8uz65RHxmvTfqG9Q85B2Pkt53
         jdo39rjhS98Pt6nxFn6ZHVs3u1JF/chEL0K7Z2EHQkd1bF1Z1lPI7cgOoSmKH5uw0lGm
         MqWJWqBZRRYNN6TUc4LCCXeysTVdvE2v8TfgMXZGZU9Jh032rFhQw97IpQ5bA4bKCh7p
         Vt7et2w9aCsNbSLmm5abdHSIJ32VNwJ+tDnXAveLbHfd06bBFydlSO9JILmO2lMw/zQI
         qWv4MUV+MAbicQ9G7uuysaEG5MrGyjqMZZdBaT5iHbzoqEDMW65NIk8lL6M6jbGVgMjR
         M0sA==
X-Gm-Message-State: AOJu0Yx5HfY5mqnifqTbXxRxABXs2NZdZuFhjwlnTq8CL2isYcv0rOqG
	zQARk7NyUMkyHYdORTO1uoQFeS3qqV9ADgm65LJuOFloFfj2pFaj5UeZ
X-Gm-Gg: AR+sD12RTky8/Dep0KEkSKfN/c+ei+WpzlObSxZly9cEkLVqk1bFAQRCEaWWDnB6uDt
	fRhPZl/fdJBu5zX2OIso1kv5xgjJojzFNAvzAE49FuVDyp5URym/gM+TYRPitaZjJ3nIRBZ7DHl
	n3UrZ6zJZUrfPGm1eoCurut3lMU0NJcBIM8umEuTj0KmtHY5eOXZw+3+9Q4Kp9r/urAreaI2xh1
	7TgkoIBVmHKbMqaD9atqRdzJhxM2PMcH35J07Ne2JSLW2vK9YJen1Tiy2OAHOqU/2k6C6COpfEd
	j9FxeaEdfcm+pUAAbzp+MHD78BaLI2mjtyX+/DxBtBcamYuH3HHHrfpWOXNwGB8x9mOq7nOEQ7d
	ibQUHN7RDyiAw3pLMJ6GXTxhcMBxVnf537dx1LcM3a1iqag5/FYHgpIF+lZ/hkQNRXvZS7qIXU0
	r8Xe9vyW2D712540CDMefBL6sDOOTqfz/i4BPxGrODHucgBHVQX8lMSm3FvjvskCy6NOWwbdBXn
	c+gAnz+Dp7zH/cypkJENZw722/eYbCk12KKxI3khOm8pbP/gI2W2N4=
X-Received: by 2002:ac8:588c:0:b0:51c:22c5:daee with SMTP id d75a77b69052e-52dbd6f3d55mr85177801cf.29.1787063390074;
        Tue, 18 Aug 2026 07:29:50 -0700 (PDT)
Received: from cw-fl20tjcw03-l.tailb3cd1a.ts.net ([2600:4040:9121:7700:1cd5:215e:ad6c:6a3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db610b491sm40138761cf.8.2026.08.18.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:29:49 -0700 (PDT)
From: Serapheim Dimitropoulos <serapheimd@gmail.com>
Date: Tue, 18 Aug 2026 10:29:39 -0400
Subject: [PATCH kexec-tools v3] util_lib/elf_info: stream lockless printk
 ring records
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-vmcore-dmesg-stream-upstream-v3-1-d721a5482f24@coreweave.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBCFr0Jm7ZhSLVBW3sO4qO0AjZaSFisJ4
 e5W48KVu/fyfr4VIgVLEdpihUDJRuvHbA67AvSgxp7QmuyBM16xmjeYnPaB0DiKPcY5kHL4mL6
 iNqqSQjaykwLyxRSos8vn/gw3Wkjj7P09wiWHXfAO5yEPfwnyPyGVWKJi7CqMOGYOO73LT1KJ9
 to72LYXl7fVe9MAAAA=
X-Change-ID: 20260728-vmcore-dmesg-stream-upstream-7da695989f95
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>, 
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
 Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>, 
 Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787063389; l=8027;
 i=sdimitropoulos@coreweave.com; s=20260302; h=from:subject:message-id;
 bh=hijgKW6X2v2d3SNPlNjO1MGGReiFBIVbFQJgWYObBd0=;
 b=Mft83oKPZeAc2h/ARUnObhOurxUqmDAEa22F7tAmudmlDR7DiWGWYXrOhGH+tm8sKDQFyXz9/
 Cqt7TH4u/ERD1+t//9FAZNEAmLYBsKhKUyLnzAfin/bF7R+VIb5zsiz
X-Developer-Key: i=sdimitropoulos@coreweave.com; a=ed25519;
 pk=Qysvg7jaTIU0posaYFtqa5SKJlFwqzil4X0U1p1zo/g=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_072952_524059_134F9AF3 
X-CRM114-Status: GOOD (  16.79  )
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
text rings before it starts processing records. For the above setup these
copies raised peak RSS to about 345 MiB. This is a significant part of the
memory available to the capture kernel, and most of the copied data is only
visited once.

Keep the ring file offsets and read each active record directly instead.
Allocate space for one descriptor, one info record, and one text record.
Leave the existing ring geometry parsing, types, traversal, and
record-state handling unchanged.

The old and new readers produced byte-identical output for committed and
finalized records, missed and empty records, wrapped text, non-printable
bytes, descriptor ID wraparound, and a dense 100000-record fixture.

For the dense fixture with a 64 MiB text ring, peak RSS dropped from
345276 KiB to 1276 KiB. Runtime increased from 1.98 to 2.09 seconds due to
the per-record reads.

Fixes: 4149df9005f2 ("printk: add support for lockless ringbuffer")
Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
---
Changes in v3:
- Keep the patch focused on changing where ring data is read.
- Remove the new validation and overflow-checking framework, and retain the
  existing types, ring geometry parsing, arithmetic, traversal, and
  record-state handling.
- Use direct pread() calls and the same error handling style as the existing
  reader.
- Re-run make distcheck, byte-for-byte small and dense fixture comparisons,
  peak RSS measurements, and ASan/UBSan tests of the printk-ring path.
- Link to v2: https://lore.kernel.org/r/20260803-vmcore-dmesg-stream-upstream-v2-1-cb7f7449bc1b@coreweave.com
---
 util_lib/elf_info.c | 94 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 36eb895..d6e5ffc 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -960,12 +960,15 @@ struct prb_map {
 
 	char		*desc_ring;
 	unsigned long	desc_ring_count;
-	char		*descs;
+	uint64_t	desc_offset;
+	char		*desc;
 
-	char		*infos;
+	uint64_t	info_offset;
+	char		*info;
 
 	char		*text_data_ring;
 	unsigned long	text_data_ring_size;
+	uint64_t	text_data_offset;
 	char		*text_data;
 };
 
@@ -1061,7 +1064,7 @@ static uint64_t sizeof_ulong(void)
 	return (machine_pointer_bits() >> 3);
 }
 
-static void dump_record(struct prb_map *m, unsigned long id,
+static void dump_record(int fd, struct prb_map *m, unsigned long id,
 			void (*handler)(char*, unsigned int))
 {
 #define OUT_BUF_SIZE	4096
@@ -1078,9 +1081,16 @@ static void dump_record(struct prb_map *m, unsigned long id,
 	char *text;
 	char *desc;
 	int i;
+	int ret;
 
-	desc = m->descs + ((id % m->desc_ring_count) * prb_desc_sz);
-	info = m->infos + ((id % m->desc_ring_count) * printk_info_sz);
+	ret = pread(fd, m->desc, prb_desc_sz, m->desc_offset +
+		    ((id % m->desc_ring_count) * prb_desc_sz));
+	if (ret != prb_desc_sz) {
+		fprintf(stderr, "Failed to read desc of size %zu bytes: %s\n",
+			prb_desc_sz, strerror(errno));
+		exit(65);
+	}
+	desc = m->desc;
 
 	/* skip non-committed record */
 	state_var = get_ulong(desc + prb_desc_state_var_offset +
@@ -1088,6 +1098,15 @@ static void dump_record(struct prb_map *m, unsigned long id,
 	if (!record_committed(id, state_var))
 		return;
 
+	ret = pread(fd, m->info, printk_info_sz, m->info_offset +
+		    ((id % m->desc_ring_count) * printk_info_sz));
+	if (ret != printk_info_sz) {
+		fprintf(stderr, "Failed to read info of size %zu bytes: %s\n",
+			printk_info_sz, strerror(errno));
+		exit(65);
+	}
+	info = m->info;
+
 	begin = get_ulong(desc + prb_desc_text_blk_lpos_offset +
 			  prb_data_blk_lpos_begin_offset) %
 		m->text_data_ring_size;
@@ -1120,7 +1139,13 @@ static void dump_record(struct prb_map *m, unsigned long id,
 	if (next - begin < len)
 		len = next - begin;
 
-	text = m->text_data + begin;
+	ret = pread(fd, m->text_data, len, m->text_data_offset + begin);
+	if (ret != len) {
+		fprintf(stderr, "Failed to read text of size %hu bytes: %s\n",
+			len, strerror(errno));
+		exit(65);
+	}
+	text = m->text_data;
 
 	/* escape non-printable characters */
 	for (i = 0; i < len; i++) {
@@ -1176,58 +1201,37 @@ static void dump_dmesg_lockless(int fd, void (*handler)(char*, unsigned int))
 	m.desc_ring_count = 1 << struct_val_u32(m.desc_ring,
 					prb_desc_ring_count_bits_offset);
 	kaddr = get_ulong(m.desc_ring + prb_desc_ring_descs_offset);
-	m.descs = calloc(1, prb_desc_sz * m.desc_ring_count);
-	if (!m.descs) {
-		fprintf(stderr, "Failed to malloc %lu bytes for descs: %s\n",
-			prb_desc_sz * m.desc_ring_count, strerror(errno));
+	m.desc_offset = vaddr_to_offset(kaddr);
+	m.desc = calloc(1, prb_desc_sz);
+	if (!m.desc) {
+		fprintf(stderr, "Failed to malloc %zu bytes for desc: %s\n",
+			prb_desc_sz, strerror(errno));
 		exit(64);
 	}
-	ret = pread(fd, m.descs, prb_desc_sz * m.desc_ring_count,
-		    vaddr_to_offset(kaddr));
-	if (ret != prb_desc_sz * m.desc_ring_count) {
-		fprintf(stderr,
-			"Failed to read descs of size %lu bytes: %s\n",
-			prb_desc_sz * m.desc_ring_count, strerror(errno));
-		exit(65);
-	}
 
 	/* setup info ring */
 	kaddr = get_ulong(m.prb + prb_desc_ring_infos_offset);
-	m.infos = calloc(1, printk_info_sz * m.desc_ring_count);
-	if (!m.infos) {
-		fprintf(stderr, "Failed to malloc %lu bytes for infos: %s\n",
-			printk_info_sz * m.desc_ring_count, strerror(errno));
+	m.info_offset = vaddr_to_offset(kaddr);
+	m.info = calloc(1, printk_info_sz);
+	if (!m.info) {
+		fprintf(stderr, "Failed to malloc %zu bytes for info: %s\n",
+			printk_info_sz, strerror(errno));
 		exit(64);
 	}
-	ret = pread(fd, m.infos, printk_info_sz * m.desc_ring_count,
-		    vaddr_to_offset(kaddr));
-	if (ret != printk_info_sz * m.desc_ring_count) {
-		fprintf(stderr,
-			"Failed to read infos of size %lu bytes: %s\n",
-			printk_info_sz * m.desc_ring_count, strerror(errno));
-		exit(65);
-	}
 
 	/* setup text data ring */
 	m.text_data_ring = m.prb + printk_ringbuffer_text_data_ring_offset;
 	m.text_data_ring_size = 1 << struct_val_u32(m.text_data_ring,
 					prb_data_ring_size_bits_offset);
 	kaddr = get_ulong(m.text_data_ring + prb_data_ring_data_offset);
-	m.text_data = calloc(1, m.text_data_ring_size);
+	m.text_data_offset = vaddr_to_offset(kaddr);
+	m.text_data = calloc(1, UINT16_MAX);
 	if (!m.text_data) {
 		fprintf(stderr,
-			"Failed to malloc %lu bytes for text_data: %s\n",
-			m.text_data_ring_size, strerror(errno));
+			"Failed to malloc %u bytes for text_data: %s\n",
+			UINT16_MAX, strerror(errno));
 		exit(64);
 	}
-	ret = pread(fd, m.text_data, m.text_data_ring_size,
-		    vaddr_to_offset(kaddr));
-	if (ret != m.text_data_ring_size) {
-		fprintf(stderr,
-			"Failed to read text_data of size %lu bytes: %s\n",
-			m.text_data_ring_size, strerror(errno));
-		exit(65);
-	}
 
 	/* ready to go */
 
@@ -1237,14 +1241,14 @@ static void dump_dmesg_lockless(int fd, void (*handler)(char*, unsigned int))
 						atomic_long_t_counter_offset);
 
 	for (id = tail_id; id != head_id; id = id_inc(id))
-		dump_record(&m, id, handler);
+		dump_record(fd, &m, id, handler);
 
 	/* dump head record */
-	dump_record(&m, id, handler);
+	dump_record(fd, &m, id, handler);
 
 	free(m.text_data);
-	free(m.infos);
-	free(m.descs);
+	free(m.info);
+	free(m.desc);
 	free(m.prb);
 }
 

---
base-commit: 29898e149feb5c615b3ab6313260d58315bf1d8d
change-id: 20260728-vmcore-dmesg-stream-upstream-7da695989f95

Best regards,
-- 
Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>


