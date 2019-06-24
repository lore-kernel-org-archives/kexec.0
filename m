Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfUC9-0004yG-M1
 for kexec@lists.infradead.org; Mon, 24 Jun 2019 19:00:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS
 id 8F771A2825
 for <kexec@lists.infradead.org>; Mon, 24 Jun 2019 18:59:53 +0000 (UTC)
From: Varad Gautam <vrd@amazon.de>
Subject: [PATCH v2] x86: Support multiboot2 images
Date: Mon, 24 Jun 2019 20:59:24 +0200
Message-ID: <1561402764-3534-1-git-send-email-vrd@amazon.de>
In-Reply-To: <1558423948-24583-3-git-send-email-vrd@amazon.de>
References: <1558423948-24583-3-git-send-email-vrd@amazon.de>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Varad Gautam <vrd@amazon.de>, Amit Shah <aams@amazon.de>, David Woodhouse <dwmw@amazon.co.uk>

Add a new type `multiboot2-x86` that allows loading multiboot2 [1] images
within the relocation range specified in the image header. The image is
always placed at the lowest available address, regardless of the
preference information.

Also make multiboot2 take priority over multiboot if the -t flag isn't
specified.

[1] https://www.gnu.org/software/grub/manual/multiboot2/multiboot.html

Signed-off-by: Varad Gautam <vrd@amazon.de>
---
 include/x86/multiboot2.h         | 416 ++++++++++++++++++++++++++++++
 kexec/arch/i386/kexec-mb2-x86.c  | 543 +++++++++++++++++++++++++++++++++++++++
 kexec/arch/i386/kexec-x86.c      |   2 +
 kexec/arch/x86_64/Makefile       |   1 +
 kexec/arch/x86_64/kexec-x86_64.c |   2 +
 kexec/arch/x86_64/kexec-x86_64.h |   5 +
 kexec/kexec.8                    |  24 ++
 7 files changed, 993 insertions(+)
 create mode 100644 include/x86/multiboot2.h
 create mode 100644 kexec/arch/i386/kexec-mb2-x86.c

diff --git a/include/x86/multiboot2.h b/include/x86/multiboot2.h
new file mode 100644
index 0000000..5693923
--- /dev/null
+++ b/include/x86/multiboot2.h
@@ -0,0 +1,416 @@
+/*  multiboot2.h - Multiboot 2 header file.  */
+/*  Copyright (C) 1999,2003,2007,2008,2009,2010  Free Software Foundation, Inc.
+ *
+ *  Permission is hereby granted, free of charge, to any person obtaining a copy
+ *  of this software and associated documentation files (the "Software"), to
+ *  deal in the Software without restriction, including without limitation the
+ *  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ *  sell copies of the Software, and to permit persons to whom the Software is
+ *  furnished to do so, subject to the following conditions:
+ *
+ *  The above copyright notice and this permission notice shall be included in
+ *  all copies or substantial portions of the Software.
+ *
+ *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL ANY
+ *  DEVELOPER OR DISTRIBUTOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
+ *  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef MULTIBOOT_HEADER
+#define MULTIBOOT_HEADER 1
+
+/* How many bytes from the start of the file we search for the header.  */
+#define MULTIBOOT_SEARCH			32768
+#define MULTIBOOT_HEADER_ALIGN			8
+
+/* The magic field should contain this.  */
+#define MULTIBOOT2_HEADER_MAGIC			0xe85250d6
+
+/* This should be in %eax.  */
+#define MULTIBOOT2_BOOTLOADER_MAGIC		0x36d76289
+
+/* Alignment of multiboot modules.  */
+#define MULTIBOOT_MOD_ALIGN			0x00001000
+
+/* Alignment of the multiboot info structure.  */
+#define MULTIBOOT_INFO_ALIGN			0x00000008
+
+/* Flags set in the 'flags' member of the multiboot header.  */
+
+#define MULTIBOOT_TAG_ALIGN                  8
+#define MULTIBOOT_TAG_TYPE_END               0
+#define MULTIBOOT_TAG_TYPE_CMDLINE           1
+#define MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME  2
+#define MULTIBOOT_TAG_TYPE_MODULE            3
+#define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO     4
+#define MULTIBOOT_TAG_TYPE_BOOTDEV           5
+#define MULTIBOOT_TAG_TYPE_MMAP              6
+#define MULTIBOOT_TAG_TYPE_VBE               7
+#define MULTIBOOT_TAG_TYPE_FRAMEBUFFER       8
+#define MULTIBOOT_TAG_TYPE_ELF_SECTIONS      9
+#define MULTIBOOT_TAG_TYPE_APM               10
+#define MULTIBOOT_TAG_TYPE_EFI32             11
+#define MULTIBOOT_TAG_TYPE_EFI64             12
+#define MULTIBOOT_TAG_TYPE_SMBIOS            13
+#define MULTIBOOT_TAG_TYPE_ACPI_OLD          14
+#define MULTIBOOT_TAG_TYPE_ACPI_NEW          15
+#define MULTIBOOT_TAG_TYPE_NETWORK           16
+#define MULTIBOOT_TAG_TYPE_EFI_MMAP          17
+#define MULTIBOOT_TAG_TYPE_EFI_BS            18
+#define MULTIBOOT_TAG_TYPE_EFI32_IH          19
+#define MULTIBOOT_TAG_TYPE_EFI64_IH          20
+#define MULTIBOOT_TAG_TYPE_LOAD_BASE_ADDR    21
+
+#define MULTIBOOT_HEADER_TAG_END  0
+#define MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST  1
+#define MULTIBOOT_HEADER_TAG_ADDRESS  2
+#define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS  3
+#define MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS  4
+#define MULTIBOOT_HEADER_TAG_FRAMEBUFFER  5
+#define MULTIBOOT_HEADER_TAG_MODULE_ALIGN  6
+#define MULTIBOOT_HEADER_TAG_EFI_BS  7
+#define MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS_EFI64  9
+#define MULTIBOOT_HEADER_TAG_RELOCATABLE  10
+
+#define MULTIBOOT2_ARCHITECTURE_I386  0
+#define MULTIBOOT2_ARCHITECTURE_MIPS32  4
+#define MULTIBOOT_HEADER_TAG_OPTIONAL 1
+
+#define MULTIBOOT_LOAD_PREFERENCE_NONE 0
+#define MULTIBOOT_LOAD_PREFERENCE_LOW 1
+#define MULTIBOOT_LOAD_PREFERENCE_HIGH 2
+
+#define MULTIBOOT_CONSOLE_FLAGS_CONSOLE_REQUIRED 1
+#define MULTIBOOT_CONSOLE_FLAGS_EGA_TEXT_SUPPORTED 2
+
+#ifndef ASM_FILE
+
+typedef unsigned char		multiboot_uint8_t;
+typedef unsigned short		multiboot_uint16_t;
+typedef unsigned int		multiboot_uint32_t;
+typedef unsigned long long	multiboot_uint64_t;
+
+struct multiboot_header
+{
+  /* Must be MULTIBOOT_MAGIC - see above.  */
+  multiboot_uint32_t magic;
+
+  /* ISA */
+  multiboot_uint32_t architecture;
+
+  /* Total header length.  */
+  multiboot_uint32_t header_length;
+
+  /* The above fields plus this one must equal 0 mod 2^32. */
+  multiboot_uint32_t checksum;
+};
+
+struct multiboot_header_tag
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+};
+
+struct multiboot_header_tag_information_request
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t requests[0];
+};
+
+struct multiboot_header_tag_address
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t header_addr;
+  multiboot_uint32_t load_addr;
+  multiboot_uint32_t load_end_addr;
+  multiboot_uint32_t bss_end_addr;
+};
+
+struct multiboot_header_tag_entry_address
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t entry_addr;
+};
+
+struct multiboot_header_tag_console_flags
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t console_flags;
+};
+
+struct multiboot_header_tag_framebuffer
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t width;
+  multiboot_uint32_t height;
+  multiboot_uint32_t depth;
+};
+
+struct multiboot_header_tag_module_align
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+};
+
+struct multiboot_header_tag_relocatable
+{
+  multiboot_uint16_t type;
+  multiboot_uint16_t flags;
+  multiboot_uint32_t size;
+  multiboot_uint32_t min_addr;
+  multiboot_uint32_t max_addr;
+  multiboot_uint32_t align;
+  multiboot_uint32_t preference;
+};
+
+struct multiboot_color
+{
+  multiboot_uint8_t red;
+  multiboot_uint8_t green;
+  multiboot_uint8_t blue;
+};
+
+struct multiboot_mmap_entry
+{
+  multiboot_uint64_t addr;
+  multiboot_uint64_t len;
+#define MULTIBOOT_MEMORY_AVAILABLE		1
+#define MULTIBOOT_MEMORY_RESERVED		2
+#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE       3
+#define MULTIBOOT_MEMORY_NVS                    4
+#define MULTIBOOT_MEMORY_BADRAM                 5
+  multiboot_uint32_t type;
+  multiboot_uint32_t zero;
+};
+typedef struct multiboot_mmap_entry multiboot_memory_map_t;
+
+struct multiboot_tag
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+};
+
+struct multiboot_tag_string
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  char string[0];
+};
+
+struct multiboot_tag_module
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t mod_start;
+  multiboot_uint32_t mod_end;
+  char cmdline[0];
+};
+
+struct multiboot_tag_basic_meminfo
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t mem_lower;
+  multiboot_uint32_t mem_upper;
+};
+
+struct multiboot_tag_bootdev
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t biosdev;
+  multiboot_uint32_t slice;
+  multiboot_uint32_t part;
+};
+
+struct multiboot_tag_mmap
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t entry_size;
+  multiboot_uint32_t entry_version;
+  struct multiboot_mmap_entry entries[0];  
+};
+
+struct multiboot_vbe_info_block
+{
+  multiboot_uint8_t external_specification[512];
+};
+
+struct multiboot_vbe_mode_info_block
+{
+  multiboot_uint8_t external_specification[256];
+};
+
+struct multiboot_tag_vbe
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+
+  multiboot_uint16_t vbe_mode;
+  multiboot_uint16_t vbe_interface_seg;
+  multiboot_uint16_t vbe_interface_off;
+  multiboot_uint16_t vbe_interface_len;
+
+  struct multiboot_vbe_info_block vbe_control_info;
+  struct multiboot_vbe_mode_info_block vbe_mode_info;
+};
+
+struct multiboot_tag_framebuffer_common
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+
+  multiboot_uint64_t framebuffer_addr;
+  multiboot_uint32_t framebuffer_pitch;
+  multiboot_uint32_t framebuffer_width;
+  multiboot_uint32_t framebuffer_height;
+  multiboot_uint8_t framebuffer_bpp;
+#define MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED 0
+#define MULTIBOOT_FRAMEBUFFER_TYPE_RGB     1
+#define MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT	2
+  multiboot_uint8_t framebuffer_type;
+  multiboot_uint16_t reserved;
+};
+
+struct multiboot_tag_framebuffer
+{
+  struct multiboot_tag_framebuffer_common common;
+
+  union
+  {
+    struct
+    {
+      multiboot_uint16_t framebuffer_palette_num_colors;
+      struct multiboot_color framebuffer_palette[0];
+    };
+    struct
+    {
+      multiboot_uint8_t framebuffer_red_field_position;
+      multiboot_uint8_t framebuffer_red_mask_size;
+      multiboot_uint8_t framebuffer_green_field_position;
+      multiboot_uint8_t framebuffer_green_mask_size;
+      multiboot_uint8_t framebuffer_blue_field_position;
+      multiboot_uint8_t framebuffer_blue_mask_size;
+    };
+  };
+};
+
+struct multiboot_tag_elf_sections
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t num;
+  multiboot_uint32_t entsize;
+  multiboot_uint32_t shndx;
+  char sections[0];
+};
+
+struct multiboot_tag_apm
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint16_t version;
+  multiboot_uint16_t cseg;
+  multiboot_uint32_t offset;
+  multiboot_uint16_t cseg_16;
+  multiboot_uint16_t dseg;
+  multiboot_uint16_t flags;
+  multiboot_uint16_t cseg_len;
+  multiboot_uint16_t cseg_16_len;
+  multiboot_uint16_t dseg_len;
+};
+
+struct multiboot_tag_efi32
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t pointer;
+};
+
+struct multiboot_tag_efi64
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint64_t pointer;
+};
+
+struct multiboot_tag_smbios
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t major;
+  multiboot_uint8_t minor;
+  multiboot_uint8_t reserved[6];
+  multiboot_uint8_t tables[0];
+};
+
+struct multiboot_tag_old_acpi
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t rsdp[0];
+};
+
+struct multiboot_tag_new_acpi
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t rsdp[0];
+};
+
+struct multiboot_tag_network
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint8_t dhcpack[0];
+};
+
+struct multiboot_tag_efi_mmap
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t descr_size;
+  multiboot_uint32_t descr_vers;
+  multiboot_uint8_t efi_mmap[0];
+}; 
+
+struct multiboot_tag_efi32_ih
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t pointer;
+};
+
+struct multiboot_tag_efi64_ih
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint64_t pointer;
+};
+
+struct multiboot_tag_load_base_addr
+{
+  multiboot_uint32_t type;
+  multiboot_uint32_t size;
+  multiboot_uint32_t load_base_addr;
+};
+
+#endif /* ! ASM_FILE */
+
+#endif /* ! MULTIBOOT_HEADER */
diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
new file mode 100644
index 0000000..7eaab0c
--- /dev/null
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -0,0 +1,543 @@
+/*
+ *  kexec-mb2-x86.c
+ *
+ *  multiboot2 support for kexec to boot xen.
+ *
+ *  Copyright (C) 2019 Varad Gautam (vrd at amazon.de), Amazon.com, Inc. or its affiliates.
+ *
+ *  Parts based on GNU GRUB, Copyright (C) 2000  Free Software Foundation, Inc
+ *  Parts taken from kexec-multiboot-x86.c, Eric Biederman (ebiederm@xmission.com)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ *  02111-1307, USA.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <elf.h>
+#include <boot/elf_boot.h>
+#include <ip_checksum.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "kexec-x86.h"
+#include <arch/options.h>
+
+/* From GNU GRUB */
+#include <x86/multiboot2.h>
+#include <x86/mb_info.h>
+
+/* Framebuffer */
+#include <sys/ioctl.h>
+#include <linux/fb.h>
+
+extern struct arch_options_t arch_options;
+
+/* Static storage */
+static char headerbuf[MULTIBOOT_SEARCH];
+static struct multiboot_header *mbh = NULL;
+struct multiboot2_header_info {
+	struct multiboot_header_tag_information_request *request_tag;
+	struct multiboot_header_tag_address *addr_tag;
+	struct multiboot_header_tag_entry_address *entry_addr_tag;
+	struct multiboot_header_tag_console_flags *console_tag;
+	struct multiboot_header_tag_framebuffer *fb_tag;
+	struct multiboot_header_tag_module_align *mod_align_tag;
+	struct multiboot_header_tag_relocatable *rel_tag;
+} mhi;
+
+#define ALIGN_UP(addr, align) \
+	((addr + (typeof (addr)) align - 1) & ~((typeof (addr)) align - 1))
+
+int multiboot2_x86_probe(const char *buf, off_t buf_len)
+/* Is it a good idea to try booting this file? */
+{
+	int i, len;
+	/* First of all, check that this is an ELF file */
+	if ((i=elf_x86_probe(buf, buf_len)) < 0)
+		return i;
+
+	/* Now look for a multiboot header. */
+	len = MULTIBOOT_SEARCH;
+	if (len > buf_len)
+		len = buf_len;
+
+	memcpy(headerbuf, buf, len);
+	if (len < sizeof(struct multiboot_header)) {
+		/* Short file */
+		return -1;
+	}
+	for (mbh = (struct multiboot_header *) headerbuf;
+	     ((char *) mbh <= (char *) headerbuf + len - sizeof(struct multiboot_header));
+	     mbh = (struct multiboot_header *) ((char *) mbh + MULTIBOOT_HEADER_ALIGN)) {
+		if (mbh->magic == MULTIBOOT2_HEADER_MAGIC
+		    && !((mbh->magic+mbh->architecture+mbh->header_length+mbh->checksum) & 0xffffffff)) {
+			/* Found multiboot header. */
+			return 0;
+		}
+	}
+	/* Not multiboot */
+	return -1;
+}
+
+void multiboot2_x86_usage(void)
+/* Multiboot-specific options */
+{
+	printf("    --command-line=STRING        Set the kernel command line to STRING.\n");
+	printf("    --reuse-cmdline       	 Use kernel command line from running system.\n");
+	printf("    --module=\"MOD arg1 arg2...\"  Load module MOD with command-line \"arg1...\"\n");
+	printf("                                 (can be used multiple times).\n");
+}
+
+static size_t
+multiboot2_get_mbi_size(int ranges, int cmdline_size, int modcount, int modcmd_size)
+{
+	return (2 * sizeof (uint32_t) + sizeof (struct multiboot_tag)
+		+ sizeof (struct multiboot_tag)
+		+ ALIGN_UP (sizeof (struct multiboot_tag_basic_meminfo), MULTIBOOT_TAG_ALIGN)
+		+ ALIGN_UP ((sizeof (struct multiboot_tag_mmap)
+			+ ranges * sizeof (struct multiboot_mmap_entry)), MULTIBOOT_TAG_ALIGN)
+		+ ALIGN_UP (sizeof (struct multiboot_tag_load_base_addr), MULTIBOOT_TAG_ALIGN)
+		+ (sizeof (struct multiboot_tag_string)
+			+ ALIGN_UP (cmdline_size, MULTIBOOT_TAG_ALIGN))
+		+ (sizeof (struct multiboot_tag_string)
+			+ ALIGN_UP (strlen(BOOTLOADER " " BOOTLOADER_VERSION) + 1, MULTIBOOT_TAG_ALIGN))
+		+ (modcount * sizeof (struct multiboot_tag_module) + modcmd_size));
+}
+
+static void multiboot2_read_header_tags(void)
+{
+	struct multiboot_header_tag *tag;
+
+	for (tag = (struct multiboot_header_tag *) (mbh + 1);
+	     tag->type != MULTIBOOT_TAG_TYPE_END;
+	     tag = (struct multiboot_header_tag *) ((char *) tag + ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN)))
+	{
+		switch (tag->type)
+		{
+		case MULTIBOOT_HEADER_TAG_INFORMATION_REQUEST:
+		{
+			mhi.request_tag = (struct multiboot_header_tag_information_request *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_RELOCATABLE:
+		{
+			mhi.rel_tag = (struct multiboot_header_tag_relocatable *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_ADDRESS:
+		{
+			mhi.addr_tag = (struct multiboot_header_tag_address *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS:
+		{
+			mhi.entry_addr_tag = (struct multiboot_header_tag_entry_address *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_CONSOLE_FLAGS:
+		{
+			mhi.console_tag = (struct multiboot_header_tag_console_flags *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_FRAMEBUFFER:
+		{
+			mhi.fb_tag = (struct multiboot_header_tag_framebuffer *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_MODULE_ALIGN:
+		{
+			mhi.mod_align_tag = (struct multiboot_header_tag_module_align *) tag;
+			break;
+		}
+		case MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS_EFI64:
+		case MULTIBOOT_HEADER_TAG_EFI_BS:
+			/* Ignoring EFI. */
+			break;
+		default:
+		{
+			if (!(tag->flags & MULTIBOOT_HEADER_TAG_OPTIONAL))
+				fprintf(stderr, "unsupported tag: 0x%x", tag->type);
+			break;
+		}
+		}
+	}
+}
+
+struct multiboot_mmap_entry *multiboot_construct_memory_map(struct memory_range *range,
+							    int ranges,
+							    unsigned long long *mem_lower,
+							    unsigned long long *mem_upper)
+{
+	struct multiboot_mmap_entry *entries;
+	int i;
+
+	*mem_lower = *mem_upper = 0;
+	entries = xmalloc(ranges * sizeof(*entries));
+	for (i = 0; i < ranges; i++) {
+		entries[i].addr = range[i].start;
+		entries[i].len = range[i].end - range[i].start + 1;
+
+		if (range[i].type == RANGE_RAM) {
+			entries[i].type = MULTIBOOT_MEMORY_AVAILABLE;
+			/*
+			 * Is this the "low" memory?  Can't just test
+			 * against zero, because Linux protects (and
+			 * hides) the first few pages of physical
+			 * memory.
+			 */
+
+			if ((range[i].start <= 64*1024)
+				&& (range[i].end > *mem_lower)) {
+				range[i].start = 0;
+				*mem_lower = range[i].end;
+			}
+			/* Is this the "high" memory? */
+			if ((range[i].start <= 0x100000)
+				&& (range[i].end > *mem_upper + 0x100000))
+			*mem_upper = range[i].end - 0x100000;
+		} else if (range[i].type == RANGE_ACPI)
+			entries[i].type = MULTIBOOT_MEMORY_ACPI_RECLAIMABLE;
+		else if (range[i].type == RANGE_ACPI_NVS)
+			entries[i].type = MULTIBOOT_MEMORY_NVS;
+		else if (range[i].type == RANGE_RESERVED)
+			entries[i].type = MULTIBOOT_MEMORY_RESERVED;
+	}
+	return entries;
+}
+
+static uint64_t multiboot2_make_mbi(struct kexec_info *info, char *cmdline, int cmdline_len,
+			     unsigned long load_base_addr, void *mbi_buf, size_t mbi_bytes)
+{
+	uint64_t *ptrorig = mbi_buf;
+	struct multiboot_mmap_entry *mmap_entries;
+	unsigned long long mem_lower = 0, mem_upper = 0;
+
+	*ptrorig = mbi_bytes; /* u32 total_size, u32 reserved */
+	ptrorig++;
+
+	mmap_entries = multiboot_construct_memory_map(info->memory_range, info->memory_ranges, &mem_lower, &mem_upper);
+	{
+		struct multiboot_tag_basic_meminfo *tag = (struct multiboot_tag_basic_meminfo *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_BASIC_MEMINFO;
+		tag->size = sizeof (struct multiboot_tag_basic_meminfo);
+		tag->mem_lower = mem_lower;
+		tag->mem_upper = mem_upper;
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	{
+		struct multiboot_tag_mmap *tag = (struct multiboot_tag_mmap *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_MMAP;
+		tag->size = sizeof(struct multiboot_tag_mmap) + sizeof(struct multiboot_mmap_entry) * info->memory_ranges;
+		tag->entry_size = sizeof(struct multiboot_mmap_entry);
+		tag->entry_version = 0;
+		memcpy(tag->entries, mmap_entries, tag->entry_size * info->memory_ranges);
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	if (mhi.rel_tag) {
+		struct multiboot_tag_load_base_addr *tag = (struct multiboot_tag_load_base_addr *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_LOAD_BASE_ADDR;
+		tag->size = sizeof (struct multiboot_tag_load_base_addr);
+		tag->load_base_addr = load_base_addr;
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	{
+		struct multiboot_tag_string *tag = (struct multiboot_tag_string *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_CMDLINE;
+		tag->size = sizeof (struct multiboot_tag_string) + cmdline_len;
+		memcpy(tag->string, cmdline, cmdline_len);
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	{
+		struct multiboot_tag_string *tag = (struct multiboot_tag_string *) ptrorig;
+
+		tag->type = MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME;
+		tag->size = sizeof(struct multiboot_tag_string) + strlen(BOOTLOADER " " BOOTLOADER_VERSION) + 1;
+		sprintf(tag->string, "%s", BOOTLOADER " " BOOTLOADER_VERSION);
+		ptrorig += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+	if (mhi.fb_tag) {
+		struct multiboot_tag_framebuffer *tag = (struct multiboot_tag_framebuffer *) ptrorig;
+		struct fb_fix_screeninfo info;
+		struct fb_var_screeninfo mode;
+		int fd;
+
+		tag->common.type = MULTIBOOT_TAG_TYPE_FRAMEBUFFER;
+		tag->common.size = sizeof(struct multiboot_tag_framebuffer);
+		/* check if purgatory will reset to standard ega text mode */
+		if (arch_options.reset_vga || arch_options.console_vga) {
+			tag->common.framebuffer_type = MB_FRAMEBUFFER_TYPE_EGA_TEXT;
+			tag->common.framebuffer_addr = 0xb8000;
+			tag->common.framebuffer_pitch = 80*2;
+			tag->common.framebuffer_width = 80;
+			tag->common.framebuffer_height = 25;
+			tag->common.framebuffer_bpp = 16;
+
+			ptrorig += ALIGN_UP (tag->common.size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+			goto out;
+		}
+
+		/* use current graphics framebuffer settings */
+		fd = open("/dev/fb0", O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "can't open /dev/fb0: %s\n", strerror(errno));
+			goto out;
+		}
+		if (ioctl(fd, FBIOGET_FSCREENINFO, &info) < 0){
+			fprintf(stderr, "can't get screeninfo: %s\n", strerror(errno));
+			close(fd);
+			goto out;
+		}
+		if (ioctl(fd, FBIOGET_VSCREENINFO, &mode) < 0){
+			fprintf(stderr, "can't get modeinfo: %s\n", strerror(errno));
+			close(fd);
+			goto out;
+		}
+		close(fd);
+
+		if (info.smem_start == 0 || info.smem_len == 0) {
+			fprintf(stderr, "can't get linerar framebuffer address\n");
+			goto out;
+		}
+
+		if (info.type != FB_TYPE_PACKED_PIXELS) {
+			fprintf(stderr, "unsupported framebuffer type\n");
+			goto out;
+		}
+
+		if (info.visual != FB_VISUAL_TRUECOLOR) {
+			fprintf(stderr, "unsupported framebuffer visual\n");
+			goto out;
+		}
+
+		tag->common.framebuffer_type = MB_FRAMEBUFFER_TYPE_RGB;
+		tag->common.framebuffer_addr = info.smem_start;
+		tag->common.framebuffer_pitch = info.line_length;
+		tag->common.framebuffer_width = mode.xres;
+		tag->common.framebuffer_height = mode.yres;
+		tag->common.framebuffer_bpp = mode.bits_per_pixel;
+
+		tag->framebuffer_red_field_position = mode.red.offset;
+		tag->framebuffer_red_mask_size = mode.red.length;
+		tag->framebuffer_green_field_position = mode.green.offset;
+		tag->framebuffer_green_mask_size = mode.green.length;
+		tag->framebuffer_blue_field_position = mode.blue.offset;
+		tag->framebuffer_blue_mask_size = mode.blue.length;
+
+		ptrorig += ALIGN_UP (tag->common.size, MULTIBOOT_TAG_ALIGN) / sizeof (*ptrorig);
+	}
+
+out:
+	return (uint64_t) ptrorig;
+}
+
+static uint64_t multiboot2_mbi_add_module(void *mbi_buf, uint64_t mbi_ptr, uint32_t mod_start,
+					  uint32_t mod_end, char *mod_clp)
+{
+	struct multiboot_tag_module *tag = (struct multiboot_tag_module *) mbi_ptr;
+
+	tag->type = MULTIBOOT_TAG_TYPE_MODULE;
+	tag->size = sizeof(struct multiboot_tag_module) + strlen((char *)(long) mod_clp) + 1;
+	tag->mod_start = mod_start;
+	tag->mod_end = mod_end;
+
+	memcpy(tag->cmdline, (char *)(long) mod_clp, strlen((char *)(long) mod_clp) + 1);
+	mbi_ptr += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN);
+
+	return mbi_ptr;
+}
+
+static uint64_t multiboot2_mbi_end(void *mbi_buf, uint64_t mbi_ptr)
+{
+	struct multiboot_tag *tag = (struct multiboot_tag *) mbi_ptr;
+
+	tag->type = MULTIBOOT_TAG_TYPE_END;
+	tag->size = sizeof (struct multiboot_tag);
+	mbi_ptr += ALIGN_UP (tag->size, MULTIBOOT_TAG_ALIGN);
+
+	return mbi_ptr;
+}
+
+int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info)
+{
+	struct mem_ehdr ehdr;
+	void *mbi_buf;
+	size_t mbi_bytes;
+	unsigned long addr;
+	struct entry32_regs regs;
+	char *command_line = NULL, *tmp_cmdline = NULL;
+	int command_line_len;
+	char *imagename, *cp, *append = NULL;;
+	int result;
+	int opt;
+	int modules, mod_command_line_space;
+	uint64_t mbi_ptr;
+	char *mod_clp_base;
+	/* See options.h -- add any more there, too. */
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ "command-line",		1, 0, OPT_CL },
+		{ "append",			1, 0, OPT_CL },
+		{ "reuse-cmdline",		0, 0, OPT_REUSE_CMDLINE },
+		{ "module",			1, 0, OPT_MOD },
+		{ 0, 				0, 0, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
+
+	/* Probe for the MB header if it's not already found */
+	if (mbh == NULL && multiboot_x86_probe(buf, len) != 1)
+	{
+		fprintf(stderr, "Cannot find a loadable multiboot2 header.\n");
+		return -1;
+	}
+
+	/* Parse the header tags. */
+	multiboot2_read_header_tags();
+
+	/* Parse the command line */
+	command_line_len = 0;
+	modules = 0;
+	mod_command_line_space = 0;
+	result = 0;
+	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1)
+	{
+		switch(opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX) {
+				break;
+			}
+		case OPT_CL:
+			append = optarg;
+			break;
+		case OPT_REUSE_CMDLINE:
+			tmp_cmdline = get_command_line();
+			break;
+		case OPT_MOD:
+			modules++;
+			mod_command_line_space += strlen(optarg) + 1;
+			break;
+		}
+	}
+	imagename = argv[optind];
+
+	/* Final command line = imagename + <OPT_REUSE_CMDLINE> + <OPT_CL> */
+	tmp_cmdline = concat_cmdline(command_line, append);
+	if (command_line) {
+		free(command_line);
+	}
+	command_line = concat_cmdline(imagename, tmp_cmdline);
+	if (tmp_cmdline) {
+		free(tmp_cmdline);
+	}
+	command_line_len = strlen(command_line) + 1;
+
+	/* Load the ELF executable */
+	if (mhi.rel_tag)
+		elf_exec_build_load_relocatable(info, &ehdr, buf, len, 0,
+						mhi.rel_tag->min_addr, mhi.rel_tag->max_addr,
+						mhi.rel_tag->align);
+	else
+		elf_exec_build_load(info, &ehdr, buf, len, 0);
+
+	/* Load the setup code */
+	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
+			   0, ULONG_MAX, 1, 0);
+
+	/* Construct information tags. */
+	mbi_bytes = multiboot2_get_mbi_size(info->memory_ranges, command_line_len, modules, mod_command_line_space);
+	mbi_buf = xmalloc(mbi_bytes);
+
+	mbi_ptr = multiboot2_make_mbi(info, command_line, command_line_len, info->rhdr.rel_addr, mbi_buf, mbi_bytes);
+	free(command_line);
+
+	/* Load modules */
+	if (modules) {
+		char *mod_filename, *mod_command_line, *mod_clp, *buf;
+		off_t mod_size;
+		int i = 0;
+
+		mod_clp_base = xmalloc(mod_command_line_space);
+
+		/* Go back and parse the module command lines */
+		mod_clp = mod_clp_base;
+		optind = opterr = 1;
+		while((opt = getopt_long(argc, argv,
+					 short_options, options, 0)) != -1) {
+			if (opt != OPT_MOD) continue;
+
+			/* Split module filename from command line */
+			mod_command_line = mod_filename = optarg;
+			if ((cp = strchr(mod_filename, ' ')) != NULL) {
+				/* See as I discard the 'const' modifier */
+				*cp = '\0';
+			}
+
+			/* Load the module */
+			buf = slurp_decompress_file(mod_filename, &mod_size);
+
+			if (cp != NULL) *cp = ' ';
+
+			/* Pick the next aligned spot to load it in. Always page align. */
+			addr = add_buffer(info, buf, mod_size, mod_size, getpagesize(),
+					  mhi.rel_tag->min_addr, mhi.rel_tag->max_addr, 1);
+
+			/* Add the module command line */
+			sprintf(mod_clp, "%s", mod_command_line);
+
+			mbi_ptr = multiboot2_mbi_add_module(mbi_buf, mbi_ptr, addr, addr + mod_size, mod_clp);
+
+			mod_clp += strlen(mod_clp) + 1;
+			i++;
+		}
+
+		free(mod_clp_base);
+	}
+
+	mbi_ptr = multiboot2_mbi_end(mbi_buf, mbi_ptr);
+
+	if (sort_segments(info) < 0)
+		return -1;
+
+	addr = add_buffer(info, mbi_buf, mbi_bytes, mbi_bytes, 4,
+			  mhi.rel_tag->min_addr, mhi.rel_tag->max_addr, 1);
+
+	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
+	regs.eax = MULTIBOOT2_BOOTLOADER_MAGIC;
+	regs.ebx = addr;
+	regs.eip = ehdr.e_entry;
+	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
+
+	return 0;
+}
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index fb0e6f9..ec7b7ad 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -34,6 +34,8 @@
 #include <arch/options.h>
 
 struct file_type file_type[] = {
+	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
+	  multiboot2_x86_usage },
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
index 1cf10f9..275add5 100644
--- a/kexec/arch/x86_64/Makefile
+++ b/kexec/arch/x86_64/Makefile
@@ -4,6 +4,7 @@
 x86_64_KEXEC_SRCS =  kexec/arch/i386/kexec-elf-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-bzImage.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
+x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-mb2-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
 x86_64_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index ccdc980..3c593ac 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -34,6 +34,8 @@
 
 struct file_type file_type[] = {
 	{ "elf-x86_64", elf_x86_64_probe, elf_x86_64_load, elf_x86_64_usage },
+	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
+	  multiboot2_x86_usage },
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
diff --git a/kexec/arch/x86_64/kexec-x86_64.h b/kexec/arch/x86_64/kexec-x86_64.h
index 4cdeffb..21c3a73 100644
--- a/kexec/arch/x86_64/kexec-x86_64.h
+++ b/kexec/arch/x86_64/kexec-x86_64.h
@@ -33,4 +33,9 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info);
 void bzImage64_usage(void);
 
+int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info);
+void multiboot2_x86_usage(void);
+int multiboot2_x86_probe(const char *buf, off_t buf_len);
+
 #endif /* KEXEC_X86_64_H */
diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 2fafaaa..2580725 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -311,6 +311,30 @@ with command-line arguments
 .I "arg1 arg2 ..."
 This parameter can be specified multiple times.
 .RE
+.PP
+.B multiboot2-x86
+.RS
+.TP
+.BI \-\-command\-line= string
+Set the kernel command line to
+.IR string .
+.TP
+.BI \-\-reuse-cmdline
+Use the command line from the running system. When a panic kernel is loaded, it
+strips the
+.I
+crashkernel
+parameter automatically. The
+.I BOOT_IMAGE
+parameter is also stripped.
+.TP
+.BI \-\-module= "mod arg1 arg2 ..."
+Load module
+.I mod
+with command-line arguments
+.I "arg1 arg2 ..."
+This parameter can be specified multiple times.
+.RE
 
 .SH ARCHITECTURE OPTIONS
 .TP
-- 
2.7.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
