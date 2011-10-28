Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJj3H-0003Ov-SH
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 09:48:41 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 56DE83EE081
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:38 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F69945DE4E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 27A7E45DE50
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C46EE08002
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:38 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BD0B21DB8037
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:37 +0900 (JST)
Received: from ml13.css.fujitsu.com (ml13 [127.0.0.1])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id 8178AFD0026
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:37 +0900 (JST)
Received: from localhost6.localdomain6 (unknown [10.124.63.45])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id 11B0AFD001F
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:37 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 06/14] Initialize internal data according to sadump-related
	formats
Date: Fri, 28 Oct 2011 18:48:36 +0900
Message-ID: <20111028094836.20940.7998.stgit@localhost6.localdomain6>
In-Reply-To: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Set page_size, nr_cpus and time stamp. Also, initialize bitmap table
in the same way as initialize_bitmap_memory() for kdump-compressed
format.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   28 +++++++++++
 sadump_info.c  |  144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sadump_info.h  |   36 ++++++++++++++
 sadump_mod.h   |    2 +
 4 files changed, 210 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 96faf60..c5ea9ce 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -119,6 +119,12 @@ get_max_mapnr(void)
 		info->max_mapnr = info->dh_memory->max_mapnr;
 		return TRUE;
 	}
+
+	if (info->flag_sadump) {
+		info->max_mapnr = sadump_get_max_mapnr();
+		return TRUE;
+	}
+
 	max_paddr = get_max_paddr();
 	info->max_mapnr = paddr_to_pfn(max_paddr);
 
@@ -2305,6 +2311,28 @@ initial(void)
 		if (!initialize_bitmap_memory())
 			return FALSE;
 
+	} else if (info->flag_sadump) {
+		int nr_cpus;
+
+		if (info->flag_elf_dumpfile) {
+			MSG("'-E' option is disable, ");
+			MSG("because %s is sadump %s format.\n",
+			    info->name_memory, sadump_format_type_name());
+			return FALSE;
+		}
+
+		set_page_size(sadump_page_size());
+
+		if (!sadump_initialize_bitmap_memory())
+			return FALSE;
+
+		if (!sadump_get_nr_cpus(&nr_cpus))
+			return FALSE;
+
+		set_nr_cpus(nr_cpus);
+
+		(void) sadump_set_timestamp(&info->timestamp);
+
 	} else if (!get_phys_base())
 		return FALSE;
 
diff --git a/sadump_info.c b/sadump_info.c
index 2f66148..2efeb63 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -39,6 +39,7 @@ struct sadump_info {
 	unsigned long sub_hdr_offset;
 	uint32_t smram_cpu_state_size;
 	unsigned long data_offset;
+	unsigned long long *block_table;
 };
 
 static char *guid_to_str(efi_guid_t *guid, char *buf, size_t buflen);
@@ -505,6 +506,125 @@ error:
 }
 
 int
+sadump_initialize_bitmap_memory(void)
+{
+	struct sadump_header *sh = si->sh_memory;
+	struct dump_bitmap *bmp;
+	unsigned long dumpable_bitmap_offset, dumpable_bitmap_len;
+	unsigned long long section, max_section, pfn;
+	unsigned long long *block_table;
+
+	dumpable_bitmap_offset =
+		si->sub_hdr_offset +
+		sh->block_size * (sh->sub_hdr_size + sh->bitmap_blocks);
+
+	dumpable_bitmap_len = sh->block_size * sh->dumpable_bitmap_blocks;
+
+	bmp = malloc(sizeof(struct dump_bitmap));
+	if (bmp == NULL) {
+		ERRMSG("Can't allocate memory for the memory-bitmap. %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
+	bmp->fd = info->fd_memory;
+	bmp->file_name = info->name_memory;
+	bmp->no_block = -1;
+	memset(bmp->buf, 0, BUFSIZE_BITMAP);
+	bmp->offset = dumpable_bitmap_offset;
+
+	max_section = divideup(sh->max_mapnr, SADUMP_PF_SECTION_NUM);
+
+	block_table = calloc(sizeof(unsigned long long), max_section);
+	if (block_table == NULL) {
+		ERRMSG("Can't allocate memory for the block_table. %s\n",
+		       strerror(errno));
+		free(bmp);
+		return FALSE;
+	}
+
+	for (section = 0; section < max_section; ++section) {
+		if (section > 0)
+			block_table[section] = block_table[section-1];
+		for (pfn = section * SADUMP_PF_SECTION_NUM;
+		     pfn < (section + 1) * SADUMP_PF_SECTION_NUM;
+		     ++pfn)
+			if (is_dumpable(bmp, pfn))
+				block_table[section]++;
+	}
+
+	info->bitmap_memory = bmp;
+	si->block_table = block_table;
+
+	return TRUE;
+}
+
+int
+sadump_get_nr_cpus(int *nr_cpus)
+{
+	unsigned long offset;
+	struct sadump_smram_cpu_state scs, zero;
+	uint32_t x_cpu;
+	int count;
+
+	memset(&zero, 0, sizeof(zero));
+
+	offset = si->sub_hdr_offset + sizeof(uint32_t) +
+		si->sh_memory->nr_cpus * sizeof(struct sadump_apic_state);
+
+	count = 0;
+	for (x_cpu = 0; x_cpu < si->sh_memory->nr_cpus; ++x_cpu) {
+		if (!read_device(&scs, sizeof(scs), &offset))
+			return FALSE;
+		if (memcmp(&scs, &zero, sizeof(scs)) != 0)
+			count++;
+	}
+
+	*nr_cpus = count;
+
+	DEBUG_MSG("sadump: nr_cpus: %d\n", *nr_cpus);
+
+	return TRUE;
+}
+
+int
+sadump_set_timestamp(struct timeval *ts)
+{
+	static struct tm t;
+	efi_time_t *e = &si->sph_memory->time_stamp;
+	time_t ti;
+
+	memset(&t, 0, sizeof(t));
+
+	t.tm_sec  = e->second;
+	t.tm_min  = e->minute;
+	t.tm_hour = e->hour;
+	t.tm_mday = e->day;
+	t.tm_mon  = e->month - 1;
+	t.tm_year = e->year - 1900;
+
+	if (e->timezone != EFI_UNSPECIFIED_TIMEZONE)
+		t.tm_hour += e->timezone;
+
+	else
+		DEBUG_MSG("sadump: timezone information is missing\n");
+
+	ti = mktime(&t);
+	if (ti == (time_t)-1)
+		return FALSE;
+
+	ts->tv_sec = ti;
+	ts->tv_usec = 0;
+
+	return TRUE;
+}
+
+unsigned long long
+sadump_get_max_mapnr(void)
+{
+	return si->sh_memory->max_mapnr;
+}
+
+int
 sadump_add_diskset_info(char *name_memory)
 {
 	si->num_disks++;
@@ -523,12 +643,34 @@ sadump_add_diskset_info(char *name_memory)
 	return TRUE;
 }
 
+long
+sadump_page_size(void)
+{
+	return si->sh_memory->block_size;
+}
+
 char *
 sadump_head_disk_name_memory(void)
 {
 	return si->diskset_info[0].name_memory;
 }
 
+char *
+sadump_format_type_name(void)
+{
+	switch (info->flag_sadump) {
+	case SADUMP_SINGLE_PARTITION:
+		return "single partition";
+	case SADUMP_DISKSET:
+		return "diskset";
+	case SADUMP_MEDIA_BACKUP:
+		return "media backup";
+	case SADUMP_UNKNOWN:
+		return "unknown";
+	}
+	return NULL;
+}
+
 void
 free_sadump_info(void)
 {
@@ -551,6 +693,8 @@ free_sadump_info(void)
 		}
 		free(si->diskset_info);
 	}
+	if (si->block_table)
+		free(si->block_table);
 }
 
 #endif /* defined(__x86__) && defined(__x86_64__) */
diff --git a/sadump_info.h b/sadump_info.h
index c54d29f..0a04141 100644
--- a/sadump_info.h
+++ b/sadump_info.h
@@ -25,8 +25,14 @@
 #if defined(__x86__) || defined(__x86_64__)
 
 int check_and_get_sadump_header_info(char *filename);
+int sadump_initialize_bitmap_memory(void);
+int sadump_get_nr_cpus(int *nr_cpus);
+int sadump_set_timestamp(struct timeval *ts);
+unsigned long long sadump_get_max_mapnr(void);
 int sadump_add_diskset_info(char *name_memory);
+long sadump_page_size(void);
 char *sadump_head_disk_name_memory(void);
+char *sadump_format_type_name(void);
 void free_sadump_info(void);
 
 static inline int sadump_is_supported_arch(void)
@@ -45,17 +51,47 @@ static inline int check_and_get_sadump_header_info(char *filename)
 	return TRUE;
 }
 
+static inline int sadump_initialize_bitmap_memory(void)
+{
+	return FALSE;
+}
+
+static inline int sadump_get_nr_cpus(int *nr_cpus)
+{
+	return 0;
+}
+
+static inline int sadump_set_timestamp(struct timeval *ts)
+{
+	return FALSE;
+}
+
+static inline unsigned long long sadump_get_max_mapnr(void)
+{
+	return 0;
+}
+
 static inline int sadump_add_diskset_info(char *name_memory)
 {
 	return TRUE;
 }
 
+static inline long sadump_page_size(void)
+{
+	return 0;
+}
+
 static inline char *
 sadump_head_disk_name_memory(void)
 {
 	return NULL;
 }
 
+static inline char *sadump_format_type_name(void)
+{
+	return NULL;
+}
+
 static inline void free_sadump_info(void)
 {
 	return;
diff --git a/sadump_mod.h b/sadump_mod.h
index 3385123..efd059f 100644
--- a/sadump_mod.h
+++ b/sadump_mod.h
@@ -169,6 +169,8 @@ struct sadump_media_header {
 	char reserve[4044];	// reserve feild
 };
 
+#define SADUMP_PF_SECTION_NUM 4096
+
 #endif /* defined(__x86__) && defined(__x86_64__) */
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
