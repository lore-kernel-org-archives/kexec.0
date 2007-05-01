Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HisZo-0005I5-3g
	for kexec@lists.infradead.org; Tue, 01 May 2007 09:39:35 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0304B215DF
	for <kexec@lists.infradead.org>; Tue,  1 May 2007 15:39:13 +0200 (CEST)
Date: Tue, 1 May 2007 15:39:12 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
Message-ID: <20070501133912.GA8247@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch implements support for following the debug information link in the
.gnu_debuginfo section if the specified binary contains one. That makes it
possible to call makedumpfile with -x /boot/vmlinux-<version> on distributions
that ship extra -debuginfo packages for the kernel.

See GDB documentation, section 15.2 "Debugging Information in Separate Files"
for information about then contents of the .gnu_debuginfo section, the
algorithm used to find the debuginfo file and the CRC checksum implementation.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |  296 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |    8 +
 2 files changed, 302 insertions(+), 2 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -339,17 +339,313 @@ open_config_file(struct DumpInfo *info, 
 	return TRUE;
 }
 
+unsigned long
+gnu_debuglink_crc32 (unsigned long crc, unsigned char *buf, size_t len)
+{
+	static const unsigned long crc32_table[256] = {
+		0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419,
+		0x706af48f, 0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4,
+		0xe0d5e91e, 0x97d2d988, 0x09b64c2b, 0x7eb17cbd, 0xe7b82d07,
+		0x90bf1d91, 0x1db71064, 0x6ab020f2, 0xf3b97148, 0x84be41de,
+		0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7, 0x136c9856,
+		0x646ba8c0, 0xfd62f97a, 0x8a65c9ec, 0x14015c4f, 0x63066cd9,
+		0xfa0f3d63, 0x8d080df5, 0x3b6e20c8, 0x4c69105e, 0xd56041e4,
+		0xa2677172, 0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b,
+		0x35b5a8fa, 0x42b2986c, 0xdbbbc9d6, 0xacbcf940, 0x32d86ce3,
+		0x45df5c75, 0xdcd60dcf, 0xabd13d59, 0x26d930ac, 0x51de003a,
+		0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423, 0xcfba9599,
+		0xb8bda50f, 0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
+		0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d, 0x76dc4190,
+		0x01db7106, 0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f,
+		0x9fbfe4a5, 0xe8b8d433, 0x7807c9a2, 0x0f00f934, 0x9609a88e,
+		0xe10e9818, 0x7f6a0dbb, 0x086d3d2d, 0x91646c97, 0xe6635c01,
+		0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e, 0x6c0695ed,
+		0x1b01a57b, 0x8208f4c1, 0xf50fc457, 0x65b0d9c6, 0x12b7e950,
+		0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3,
+		0xfbd44c65, 0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2,
+		0x4adfa541, 0x3dd895d7, 0xa4d1c46d, 0xd3d6f4fb, 0x4369e96a,
+		0x346ed9fc, 0xad678846, 0xda60b8d0, 0x44042d73, 0x33031de5,
+		0xaa0a4c5f, 0xdd0d7cc9, 0x5005713c, 0x270241aa, 0xbe0b1010,
+		0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
+		0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17,
+		0x2eb40d81, 0xb7bd5c3b, 0xc0ba6cad, 0xedb88320, 0x9abfb3b6,
+		0x03b6e20c, 0x74b1d29a, 0xead54739, 0x9dd277af, 0x04db2615,
+		0x73dc1683, 0xe3630b12, 0x94643b84, 0x0d6d6a3e, 0x7a6a5aa8,
+		0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1, 0xf00f9344,
+		0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb,
+		0x196c3671, 0x6e6b06e7, 0xfed41b76, 0x89d32be0, 0x10da7a5a,
+		0x67dd4acc, 0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5,
+		0xd6d6a3e8, 0xa1d1937e, 0x38d8c2c4, 0x4fdff252, 0xd1bb67f1,
+		0xa6bc5767, 0x3fb506dd, 0x48b2364b, 0xd80d2bda, 0xaf0a1b4c,
+		0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55, 0x316e8eef,
+		0x4669be79, 0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
+		0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f, 0xc5ba3bbe,
+		0xb2bd0b28, 0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31,
+		0x2cd99e8b, 0x5bdeae1d, 0x9b64c2b0, 0xec63f226, 0x756aa39c,
+		0x026d930a, 0x9c0906a9, 0xeb0e363f, 0x72076785, 0x05005713,
+		0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38, 0x92d28e9b,
+		0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21, 0x86d3d2d4, 0xf1d4e242,
+		0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1,
+		0x18b74777, 0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c,
+		0x8f659eff, 0xf862ae69, 0x616bffd3, 0x166ccf45, 0xa00ae278,
+		0xd70dd2ee, 0x4e048354, 0x3903b3c2, 0xa7672661, 0xd06016f7,
+		0x4969474d, 0x3e6e77db, 0xaed16a4a, 0xd9d65adc, 0x40df0b66,
+		0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
+		0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605,
+		0xcdd70693, 0x54de5729, 0x23d967bf, 0xb3667a2e, 0xc4614ab8,
+		0x5d681b02, 0x2a6f2b94, 0xb40bbe37, 0xc30c8ea1, 0x5a05df1b,
+		0x2d02ef8d
+	};
+	unsigned char *end;
+
+	crc = ~crc & 0xffffffff;
+	for (end = buf + len; buf < end; ++buf)
+		crc = crc32_table[(crc ^ *buf) & 0xff] ^ (crc >> 8);
+	return ~crc & 0xffffffff;
+}
+
+int
+get_debuginfo_link(char *debuginfo_name, size_t len, uint32_t *crc)
+{
+	Elf 		*elfd = NULL;
+	Elf_Scn 	*scn = NULL;
+	Elf_Data 	*data;
+	GElf_Shdr 	shdr;
+	size_t 		shstrndx;
+	int 		n;
+	int 		found = FALSE;
+	char 		*debuglink_data = NULL;
+	int 		debuglink_data_size = 0;
+	int 		offset;
+
+	if (lseek(dwarf_info.vmlinux_fd, 0, SEEK_SET) == SEEK_FAILED) {
+		ERRMSG("Can't seek the kernel file(%s). %s\n",
+				dwarf_info.vmlinux_name, strerror(errno));
+		return -1;
+	}
+
+	elfd = elf_begin(dwarf_info.vmlinux_fd, ELF_C_READ, NULL);
+	if (!elfd) {
+		ERRMSG("Can't get first elf header of %s.\n",
+		    dwarf_info.vmlinux_name);
+	}
+
+	if (elf_getshstrndx(elfd, &shstrndx) < 0) {
+		ERRMSG("Can't get the section index of the string table.\n");
+		goto out;
+	}
+
+	/* search a .gnu_debuglink section in all sections */
+	while ((scn = elf_nextscn(elfd, scn)) != NULL) {
+		char *name;
+
+		if (gelf_getshdr(scn, &shdr) == NULL) {
+			ERRMSG("Can't get section header.\n");
+			goto out;
+		}
+		name = elf_strptr(elfd, shstrndx, shdr.sh_name);
+
+		if (strcmp(name, ".gnu_debuglink") == 0) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found)
+		goto out;
+
+	/* we got it :-) */
+
+	/* merge the data to one big buffer (if ever necessary ...) */
+	data = NULL; n = 0;
+	while (n < shdr.sh_size && (data = elf_getdata(scn, data)) != NULL) {
+
+		/* merge */
+		debuglink_data = (char *)realloc(debuglink_data,
+				debuglink_data_size + data->d_size);
+		if (!debuglink_data) {
+			ERRMSG("Unable to (re-)allocate memory in get_debuginfo_link()\n");
+			goto out;
+		}
+		memmove(debuglink_data + debuglink_data_size, data->d_buf, data->d_size);
+		debuglink_data_size += data->d_size;
+	}
+
+	/* now get the elements */
+	strncpy(debuginfo_name, debuglink_data, len);
+	debuginfo_name[len-1] = 0;
+
+	/* move to the CRC: "a four-byte CRC checksum, stored in the same
+	 * endianness used for the executable file itself.  The checksum is
+	 * computed on the debugging information file's full contents by the
+	 * function given below, passing zero as the CRC argument." */
+	offset = strlen(debuglink_data) + 1;
+	offset += 3;
+	offset &= ~3;
+
+	memcpy(crc, debuglink_data + offset, 4);
+
+out:
+	free(debuglink_data);
+	if (elfd)
+		elf_end(elfd);
+	return found ? 0 : -1;
+}
+
+
+void
+get_full_path(const char *executable, char *path, size_t len)
+{
+	if (executable[0] == '/') {
+		/* already a full path ... */
+		strncpy(path, executable, len);
+		path[len-1] = 0;
+	} else {
+		size_t tmp;
+
+		getcwd(path, len);
+		path[len-1] = 0;
+
+		tmp = strlen(path);
+		strncat(path + tmp, executable, len - tmp);
+		path[len-1] = 0;
+	}
+}
+
+int
+dirname(const char *filename, char *dirname, size_t len)
+{
+	char *c;
+	int  n;
+
+	/* find the last '/' */
+	c = strrchr(filename, '/');
+	if (!c)
+		return -1;
+
+	/* preserve the trailing slash */
+	n = c - filename + 1;
+
+	/* check for enough size */
+	if (len <= n)
+		return -1;
+
+	strncpy(dirname, filename, n);
+	dirname[n] = 0;
+
+	return 0;
+}
+
+
+static int
+do_open_and_check_crc(const char *binary, uint32_t crc)
+{
+	int 		fd;
+	unsigned char 	buffer[BUFFER_SIZE];
+	int 		ret;
+	unsigned long	calc_crc = 0;
+
+	fd = open(binary, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	while ((ret = read(fd, buffer, BUFFER_SIZE)) > 0) {
+		calc_crc = gnu_debuglink_crc32(calc_crc, buffer, ret);
+	}
+
+	if (calc_crc != crc) {
+		close(fd);
+		return -1;
+	}
+
+	/* back to the beginning */
+	lseek(fd, SEEK_SET, 0);
+
+	return fd;
+}
+
+int
+open_debuginfo_binary(const char 	*kernel_full_path,
+		      const char 	*debuginfo_name,
+		      uint32_t 		crc)
+{
+	int 	fd, ret;
+	char 	dir[PATH_MAX], tmp[PATH_MAX];
+
+	/* 1st: EXECDIR/DEBUGFILE */
+	ret = dirname(kernel_full_path, dir, PATH_MAX);
+	if (ret < 0) {
+		ERRMSG("Couldn't retrieve directory name for '%s'\n",
+				kernel_full_path);
+		return -1;
+	}
+	strcpy(tmp, dir);
+	strncat(tmp, debuginfo_name, PATH_MAX);
+	tmp[PATH_MAX-1] = 0;
+
+	fd = do_open_and_check_crc(tmp, crc);
+	if (fd >= 0)
+		return fd;
+
+	/* 2nd: EXECDIR/.debug/DEBUGFILE */
+	strcpy(tmp, dir);
+	strncat(tmp, ".debug/", PATH_MAX);
+	strncat(tmp, debuginfo_name, PATH_MAX);
+	tmp[PATH_MAX-1] = 0;
+
+	fd = do_open_and_check_crc(tmp, crc);
+	if (fd >= 0)
+		return fd;
+
+	/* 3rd: GLOBALDEBUGDIR/EXECDIR/DEBUGFILE */
+	strcpy(tmp, GLOBALDEBUGDIR);
+	strncat(tmp, dir, PATH_MAX);
+	strncat(tmp, debuginfo_name, PATH_MAX);
+	tmp[PATH_MAX-1] = 0;
+
+	fd = do_open_and_check_crc(tmp, crc);
+	if (fd >= 0)
+		return fd;
+
+	ERRMSG("Cound't find %s\n", debuginfo_name);
+
+	return -1;
+}
+
 int
 open_kernel_file()
 {
 	int fd;
+	static char debuginfo_name[PATH_MAX];
+	uint32_t crc;
+	int ret;
 
 	if ((fd = open(dwarf_info.vmlinux_name, O_RDONLY)) < 0) {
 		ERRMSG("Can't open the kernel file(%s). %s\n",
 		    dwarf_info.vmlinux_name, strerror(errno));
 		return FALSE;
 	}
+
+	/* (temporarily) set the fd */
 	dwarf_info.vmlinux_fd = fd;
+
+	/* check whether it contains a debuginfo link */
+	ret = get_debuginfo_link(debuginfo_name, PATH_MAX, &crc);
+	if (ret == 0) {
+		char kernel_full_path[PATH_MAX];
+		int debuginfo_fd;
+
+		/* make a full path because the debuginfo mechanism needs this */
+		get_full_path(dwarf_info.vmlinux_name, kernel_full_path, PATH_MAX);
+
+		debuginfo_fd = open_debuginfo_binary(kernel_full_path, debuginfo_name, crc);
+		if (debuginfo_fd < 0)
+			return FALSE;
+
+		dwarf_info.vmlinux_fd = debuginfo_fd;
+		dwarf_info.vmlinux_name = debuginfo_name;
+	}
+
 	return TRUE;
 }
 
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -29,6 +29,7 @@
 #include <libelf.h>
 #include <dwarf.h>
 #include <byteswap.h>
+#include <limits.h>
 #include "diskdump_mod.h"
 
 /*
@@ -297,8 +298,6 @@ do { \
 #define FALSE		(0)
 #define MAX(a,b)	((a) > (b) ? (a) : (b))
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
-#define LONG_MAX	((long)(~0UL>>1))
-#define ULONG_MAX	(~0UL)
 #define ULONGLONG_MAX	(~0ULL)
 #define DEFAULT_ORDER	(4)
 #define TIMEOUT_STDIN	(600)
@@ -658,3 +657,8 @@ struct dwarf_info {
 
 extern struct dwarf_info	dwarf_info;
 
+/* other constants */
+#define SEEK_FAILED	((off_t)-1)
+#define GLOBALDEBUGDIR  "/usr/lib/debug"
+#define BUFFER_SIZE	20505
+

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
