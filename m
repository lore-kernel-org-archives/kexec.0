Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDe48-0003ED-H5
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 15:16:26 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8CB423EE0AE
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:22 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 767AA45DEAD
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 608B345DE9E
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4D8F51DB803C
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:22 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0BECD1DB803B
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:22 +0900 (JST)
Received: from m106.css.fujitsu.com (m106 [127.0.0.1])
	by m106.s.css.fujitsu.com (Postfix) with ESMTP id CB93FA00020
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:21 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by m106.s.css.fujitsu.com (Postfix) with ESMTP id 52EEDA00014
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:16:21 +0900 (JST)
Date: Wed, 12 Oct 2011 00:16:17 +0900 (   )
Message-Id: <20111012.001617.347148567.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 04/12] Verify and read VMCORE(s) in sadump-related formats
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
References: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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

Try to read VMCORE(s) as sadump-related formats: single partition,
diskset or media backup and verify their header information. If the
VMCORE(s) doesn't belong to each of them, the check continues to
checking of ELF format.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |   17 ++-
 sadump_info.c  |  480 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sadump_info.h  |   10 ++
 3 files changed, 500 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 8a3a3d3..7057009 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -628,11 +628,16 @@ open_dump_memory(void)
 	if (status == TRUE) {
 		info->flag_refiltering = TRUE;
 		return get_kdump_compressed_header_info(info->name_memory);
-	} else if (status == FALSE) {
-		return TRUE;
-	} else {
-		return FALSE;
 	}
+
+	status = check_and_get_sadump_header_info(info->name_memory);
+	if (status == TRUE)
+		return TRUE;
+
+	if (status == ERROR)
+		return TRUE;
+
+	return FALSE;
 }
 
 int
@@ -3007,7 +3012,7 @@ dump_dmesg()
 	if (!open_files_for_creating_dumpfile())
 		return FALSE;
 
-	if (!info->flag_refiltering) {
+	if (!info->flag_refiltering && !info->flag_sadump) {
 		if (!get_elf_info(info->fd_memory, info->name_memory))
 			return FALSE;
 	}
@@ -5757,7 +5762,7 @@ create_dumpfile(void)
 	if (!open_files_for_creating_dumpfile())
 		return FALSE;
 
-	if (!info->flag_refiltering) {
+	if (!info->flag_refiltering && !info->flag_sadump) {
 		if (!get_elf_info(info->fd_memory, info->name_memory))
 			return FALSE;
 	}
diff --git a/sadump_info.c b/sadump_info.c
index c94d233..2f66148 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -20,6 +20,7 @@
 
 #include "makedumpfile.h"
 #include "print_info.h"
+#include "sadump_mod.h"
 
 struct sadump_diskset_info {
 	char *name_memory;
@@ -40,10 +41,470 @@ struct sadump_info {
 	unsigned long data_offset;
 };
 
+static char *guid_to_str(efi_guid_t *guid, char *buf, size_t buflen);
+static struct tm *efi_time_t_to_tm(const efi_time_t *e);
+static int verify_magic_number(uint32_t magicnum[DUMP_PART_HEADER_MAGICNUM_SIZE]);
+static int read_device(void *buf, size_t bytes, ulong *offset);
+static int read_device_diskset(struct sadump_diskset_info *sdi, void *buf,
+			       size_t bytes, ulong *offset);
+static int read_sadump_header(char *filename);
+static int read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sdi);
+
 static struct sadump_info sadump_info = {};
 static struct sadump_info *si = &sadump_info;
 
 int
+check_and_get_sadump_header_info(char *filename)
+{
+	int i;
+
+	if (!read_sadump_header(filename))
+		return FALSE;
+
+	if (info->flag_sadump_diskset && info->flag_sadump == SADUMP_DISKSET) {
+
+		si->diskset_info[0].fd_memory = info->fd_memory;
+		si->diskset_info[0].sph_memory = si->sph_memory;
+		si->diskset_info[0].data_offset = si->data_offset;
+
+		for (i = 1; i < si->num_disks; ++i) {
+			struct sadump_diskset_info *sdi =
+				&si->diskset_info[i];
+
+			if ((sdi->fd_memory =
+			     open(sdi->name_memory, O_RDONLY)) < 0) {
+				ERRMSG("Can't open the dump diskset "
+				       "memory(%s). %s\n", sdi->name_memory,
+				       strerror(errno));
+				return FALSE;
+			}
+
+			if (!read_sadump_header_diskset(i, sdi))
+				return FALSE;
+		}
+	}
+
+	return TRUE;
+}
+
+static char *
+guid_to_str(efi_guid_t *guid, char *buf, size_t buflen)
+{
+	snprintf(buf, buflen,
+		 "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
+		 guid->data1, guid->data2, guid->data3,
+		 guid->data4[0], guid->data4[1], guid->data4[2],
+		 guid->data4[3], guid->data4[4], guid->data4[5],
+		 guid->data4[6], guid->data4[7]);
+
+	return buf;
+}
+
+static struct tm *
+efi_time_t_to_tm(const efi_time_t *e)
+{
+	static struct tm t;
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
+		return &t;
+
+	return localtime_r(&ti, &t);
+}
+
+static int
+verify_magic_number(uint32_t magicnum[DUMP_PART_HEADER_MAGICNUM_SIZE])
+{
+	int i;
+
+	for (i = 1; i < DUMP_PART_HEADER_MAGICNUM_SIZE; ++i)
+		if (magicnum[i] != (magicnum[i - 1] + 7) * 11)
+			return FALSE;
+
+	return TRUE;
+}
+
+static int
+read_device(void *buf, size_t bytes, ulong *offset)
+{
+	if (lseek(info->fd_memory, *offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek a file(%s). %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (read(info->fd_memory, buf, bytes) != bytes) {
+		ERRMSG("Can't read a file(%s). %s\n",
+		       info->name_memory, strerror(errno));
+		return FALSE;
+	}
+	*offset += bytes;
+	return TRUE;
+}
+
+static int
+read_device_diskset(struct sadump_diskset_info *sdi, void *buf,
+		    size_t bytes, unsigned long *offset)
+{
+	if (lseek(sdi->fd_memory, *offset, SEEK_SET) < 0) {
+		ERRMSG("Can't seek a file(%s). %s\n",
+		       sdi->name_memory, strerror(errno));
+		return FALSE;
+	}
+	if (read(sdi->fd_memory, buf, bytes) != bytes) {
+		ERRMSG("Can't read a file(%s). %s\n",
+		       sdi->name_memory, strerror(errno));
+		return FALSE;
+	}
+	*offset += bytes;
+	return TRUE;
+}
+
+static int
+read_sadump_header(char *filename)
+{
+	struct sadump_part_header *sph = NULL;
+	struct sadump_header *sh = NULL;
+	struct sadump_disk_set_header *sdh = NULL;
+	struct sadump_media_header *smh = NULL;
+	unsigned long offset = 0, sub_hdr_offset;
+	unsigned long block_size = SADUMP_DEFAULT_BLOCK_SIZE;
+	unsigned long bitmap_len, dumpable_bitmap_len;
+	enum sadump_format_type flag_sadump;
+	uint32_t smram_cpu_state_size = 0;
+	char guid[33];
+
+	if ((si->sph_memory = malloc(SADUMP_DEFAULT_BLOCK_SIZE)) == NULL) {
+		ERRMSG("Can't allocate memory for partition header buffer: "
+		       "%s\n", strerror(errno));
+		return FALSE;
+	}
+
+	if ((si->sh_memory = malloc(SADUMP_DEFAULT_BLOCK_SIZE)) == NULL) {
+		ERRMSG("Can't allocate memory for dump header buffer: "
+		       "%s\n", strerror(errno));
+		return FALSE;
+	}
+
+	if ((si->sdh_memory = malloc(SADUMP_DEFAULT_BLOCK_SIZE)) == NULL) {
+		ERRMSG("Can't allocate memory for disk set header buffer: "
+		       "%s\n", strerror(errno));
+		return FALSE;
+	}
+
+	if ((si->smh_memory = malloc(SADUMP_DEFAULT_BLOCK_SIZE)) == NULL) {
+		ERRMSG("Can't allocate memory for media header buffer: "
+		       "%s\n", strerror(errno));
+		return FALSE;
+	}
+
+	sph = si->sph_memory;
+	sh = si->sh_memory;
+	sdh = si->sdh_memory;
+	smh = si->smh_memory;
+
+restart:
+	if (block_size < 0)
+		return FALSE;
+
+	if (!read_device(sph, block_size, &offset))
+		return ERROR;
+
+	if (sph->signature1 == SADUMP_SIGNATURE1 &&
+	    sph->signature2 == SADUMP_SIGNATURE2) {
+
+		if (sph->set_disk_set == 0) {
+
+			flag_sadump = SADUMP_SINGLE_PARTITION;
+
+			DEBUG_MSG("sadump: read dump device as single partition\n");
+
+		} else {
+
+			flag_sadump = SADUMP_DISKSET;
+
+			DEBUG_MSG("sadump: read dump device as diskset\n");
+
+		}
+
+	} else {
+
+		offset = 0;
+
+		if (!read_device(smh, block_size, &offset))
+			return ERROR;
+
+		if (!read_device(sph, block_size, &offset))
+			return ERROR;
+
+		if (sph->signature1 != SADUMP_SIGNATURE1 ||
+		    sph->signature2 != SADUMP_SIGNATURE2) {
+
+			DEBUG_MSG("sadump: does not have partition header\n");
+
+			flag_sadump = SADUMP_UNKNOWN;
+
+			DEBUG_MSG("sadump: read dump device as unknown format\n");
+
+			goto out;
+		}
+
+		flag_sadump = SADUMP_MEDIA_BACKUP;
+
+		DEBUG_MSG("sadump: read dump device as media backup format\n");
+
+	}
+
+	if (!verify_magic_number(sph->magicnum)) {
+		DEBUG_MSG("sadump: invalid magic number\n");
+		return FALSE;
+	}
+
+	if (flag_sadump == SADUMP_DISKSET) {
+		uint32_t header_blocks;
+		size_t header_size;
+
+		if (sph->set_disk_set != 1) {
+			DEBUG_MSG("sadump: id of this disk is %d\n",
+				  sph->set_disk_set);
+			return FALSE;
+		}
+
+		if (!read_device(&header_blocks, sizeof(uint32_t),
+					&offset))
+			return FALSE;
+
+		offset -= sizeof(uint32_t);
+		header_size = header_blocks * block_size;
+
+		if (header_size > block_size) {
+			sdh = realloc(sdh, header_size);
+			if (!sdh) {
+				ERRMSG("Can't allocate memory for disk "
+				       "set memory\n");
+				return FALSE;
+			}
+		}
+
+		if (!read_device(sdh, header_size, &offset))
+			return ERROR;
+
+		DEBUG_MSG("sadump: the diskset consists of %u disks\n",
+			  sdh->disk_num);
+
+	}
+
+	if (!read_device(sh, block_size, &offset))
+		return FALSE;
+
+	sub_hdr_offset = offset;
+
+	if (strncmp(sh->signature, SADUMP_SIGNATURE, 8) != 0) {
+		DEBUG_MSG("sadump: does not have dump header\n");
+		return FALSE;
+	}
+
+	if (flag_sadump == SADUMP_MEDIA_BACKUP) {
+
+		if (memcmp(&sph->sadump_id, &smh->sadump_id,
+			   sizeof(efi_guid_t)) != 0) {
+			DEBUG_MSG("sadump: system ID mismatch\n");
+			DEBUG_MSG("  partition header: %s\n",
+				  guid_to_str(&sph->sadump_id, guid,
+					      sizeof(guid)));
+			DEBUG_MSG("  media header: %s\n",
+				  guid_to_str(&smh->sadump_id, guid,
+					      sizeof(guid)));
+			return FALSE;
+		}
+
+		if (memcmp(&sph->disk_set_id, &smh->disk_set_id,
+			   sizeof(efi_guid_t)) != 0) {
+			DEBUG_MSG("sadump: disk set ID mismtch\n");
+			DEBUG_MSG("  partition header: %s\n",
+				  guid_to_str(&sph->disk_set_id, guid,
+					      sizeof(guid)));
+			DEBUG_MSG("  media header: %s\n",
+				  guid_to_str(&smh->disk_set_id, guid,
+					      sizeof(guid)));
+			return FALSE;
+		}
+
+		if (memcmp(&sph->time_stamp, &smh->time_stamp,
+			   sizeof(efi_time_t)) != 0) {
+			DEBUG_MSG("sadump: time stamp mismatch\n");
+			DEBUG_MSG("  partition header: %s",
+				  asctime(efi_time_t_to_tm(&sph->time_stamp)));
+			DEBUG_MSG("  media header: %s",
+				  asctime(efi_time_t_to_tm(&smh->time_stamp)));
+		}
+
+		if (smh->sequential_num != 1) {
+			DEBUG_MSG("sadump: first media file has sequential "
+				  "number %d\n", smh->sequential_num);
+			return FALSE;
+		}
+
+	}
+
+	if (sh->block_size != block_size) {
+		block_size = sh->block_size;
+		offset = 0;
+		goto restart;
+	}
+
+	if (sh->sub_hdr_size > 0) {
+		if (!read_device(&smram_cpu_state_size, sizeof(uint32_t),
+				 &offset)) {
+			DEBUG_MSG("sadump: cannot read SMRAM CPU STATE size\n");
+			return FALSE;
+		}
+		smram_cpu_state_size /= sh->nr_cpus;
+
+		offset -= sizeof(uint32_t);
+		offset += sh->sub_hdr_size * block_size;
+	}
+
+	if (!sh->bitmap_blocks) {
+		DEBUG_MSG("sadump: bitmap_blocks is zero\n");
+		return FALSE;
+	}
+
+	if (!sh->dumpable_bitmap_blocks) {
+		DEBUG_MSG("sadump: dumpable_bitmap_blocks is zero\n");
+		return FALSE;
+	}
+
+	bitmap_len = block_size * sh->bitmap_blocks;
+	dumpable_bitmap_len = block_size * sh->dumpable_bitmap_blocks;
+
+	si->sub_hdr_offset = sub_hdr_offset;
+	si->smram_cpu_state_size = smram_cpu_state_size;
+	si->data_offset = offset + bitmap_len + dumpable_bitmap_len;
+
+out:
+	switch (flag_sadump) {
+	case SADUMP_SINGLE_PARTITION:
+		DEBUG_MSG("sadump: single partition configuration\n");
+		break;
+	case SADUMP_DISKSET:
+		DEBUG_MSG("sadump: diskset configuration with %d disks\n",
+			  sdh->disk_num);
+		break;
+	case SADUMP_MEDIA_BACKUP:
+		DEBUG_MSG("sadump: media backup file\n");
+		break;
+	case SADUMP_UNKNOWN:
+		DEBUG_MSG("sadump: unknown format\n");
+		break;
+	}
+
+	info->flag_sadump = flag_sadump;
+
+	return TRUE;
+}
+
+static int
+read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sdi)
+{
+	struct sadump_part_header *sph = NULL;
+	unsigned long offset = 0;
+	char guid[33];
+
+	if ((sph = malloc(si->sh_memory->block_size)) == NULL) {
+		ERRMSG("Can't allocate memory for partition header buffer. "
+		       "%s\n", strerror(errno));
+		goto error;
+	}
+
+	if (!read_device_diskset(sdi, sph, si->sh_memory->block_size,
+				 &offset))
+		goto error;
+
+	if (sph->signature1 != SADUMP_SIGNATURE1 ||
+	    sph->signature2 != SADUMP_SIGNATURE2) {
+		DEBUG_MSG("sadump: does not have partition header\n");
+		free(sph);
+		goto error;
+	}
+
+	if (memcmp(&si->sph_memory->sadump_id, &sph->sadump_id,
+		   sizeof(efi_guid_t)) != 0) {
+		DEBUG_MSG("sadump: system ID mismatch\n");
+		DEBUG_MSG("  partition header on disk #1: %s\n",
+			  guid_to_str(&si->sph_memory->sadump_id, guid,
+				      sizeof(guid)));
+		DEBUG_MSG("  partition header on disk #%d: %s\n", diskid,
+			  guid_to_str(&sph->sadump_id, guid, sizeof(guid)));
+		goto error;
+	}
+
+	if (memcmp(&si->sph_memory->disk_set_id, &sph->disk_set_id,
+		   sizeof(efi_guid_t)) != 0) {
+		DEBUG_MSG("sadump: disk set ID mismatch\n");
+		DEBUG_MSG("  partition header on disk #1: %s\n",
+			  guid_to_str(&si->sph_memory->disk_set_id, guid,
+				      sizeof(guid)));
+		DEBUG_MSG("  partition header on disk #%d: %s\n", diskid,
+			  guid_to_str(&sph->disk_set_id, guid, sizeof(guid)));
+		goto error;
+	}
+
+	if (memcmp(&si->sdh_memory->vol_info[diskid-1].id, &sph->vol_id,
+		   sizeof(efi_guid_t)) != 0) {
+		DEBUG_MSG("sadump: volume ID mismatch\n");
+		DEBUG_MSG("  disk set header on disk #1: %s\n",
+			  guid_to_str(&si->sdh_memory->vol_info[diskid-1].id,
+				      guid, sizeof(guid)));
+		DEBUG_MSG("  partition header on disk #%d: %s\n",
+			  diskid+1,
+			  guid_to_str(&sph->vol_id, guid, sizeof(guid)));
+		goto error;
+	}
+
+	if (memcmp(&si->sph_memory->time_stamp, &sph->time_stamp,
+		   sizeof(efi_time_t)) != 0) {
+		DEBUG_MSG("sadump time stamp mismatch\n");
+		DEBUG_MSG("  partition header on disk #1: %s\n",
+			  asctime(efi_time_t_to_tm
+				  (&si->sph_memory->time_stamp)));
+		DEBUG_MSG("  partition header on disk #%d: %s\n",
+			  diskid, asctime(efi_time_t_to_tm(&sph->time_stamp)));
+	}
+
+	if (diskid+1 != sph->set_disk_set) {
+		DEBUG_MSG("sadump: wrong disk order; #%d expected but #%d given\n",
+			  diskid+1, sph->set_disk_set);
+		goto error;
+	}
+
+	sdi->sph_memory = sph;
+	sdi->data_offset = si->sh_memory->block_size;
+
+	return TRUE;
+
+error:
+	free(sph);
+
+	return FALSE;
+}
+
+int
 sadump_add_diskset_info(char *name_memory)
 {
 	si->num_disks++;
@@ -71,8 +532,25 @@ sadump_head_disk_name_memory(void)
 void
 free_sadump_info(void)
 {
-	if (si->diskset_info)
+	if (si->sph_memory)
+		free(si->sph_memory);
+	if (si->sh_memory)
+		free(si->sh_memory);
+	if (si->sdh_memory)
+		free(si->sdh_memory);
+	if (si->smh_memory)
+		free(si->smh_memory);
+	if (si->diskset_info) {
+		int i;
+
+		for (i = 1; i < si->num_disks; ++i) {
+			if (si->diskset_info[i].fd_memory)
+				close(si->diskset_info[i].fd_memory);
+			if (si->diskset_info[i].sph_memory)
+				free(si->diskset_info[i].sph_memory);
+		}
 		free(si->diskset_info);
+	}
 }
 
 #endif /* defined(__x86__) && defined(__x86_64__) */
diff --git a/sadump_info.h b/sadump_info.h
index 863956d..c54d29f 100644
--- a/sadump_info.h
+++ b/sadump_info.h
@@ -24,6 +24,7 @@
 
 #if defined(__x86__) || defined(__x86_64__)
 
+int check_and_get_sadump_header_info(char *filename);
 int sadump_add_diskset_info(char *name_memory);
 char *sadump_head_disk_name_memory(void);
 void free_sadump_info(void);
@@ -35,6 +36,15 @@ static inline int sadump_is_supported_arch(void)
 
 #else
 
+static inline int check_and_get_sadump_header_info(char *filename)
+{
+	info->flag_sadump = SADUMP_UNKNOWN;
+
+	DEBUG_MSG("sadump: unsupported architecture\n");
+
+	return TRUE;
+}
+
 static inline int sadump_add_diskset_info(char *name_memory)
 {
 	return TRUE;
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
