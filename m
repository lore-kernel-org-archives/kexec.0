Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8891ACDB466
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UOez79RuCkdTb6GX+r2GeYiormCvBqIuFWI1yj7+7gc=; b=iMatSIa9zEUR8zaj+MT7Ucz3nI
	xiE+Gny0SWSNW1JBuppy6DuIcKYmy/Rgib/nvi8jvVqMI/5JnzgxU/e8udPkkK0FZ+Djtdx6soG4K
	BVshTvp6A6H5np3VD3ZphjQcH8PzCTwNU3HZpjN/A+3oexX3fSSXiyxBvoM19CXRxZvD27rizlFMz
	djTwuYAFJyoD+sKrhpeLmrSg9C3adppCxs2jrHls0Wfv5yW1TeWl9Vs2iZO11vULRDzipMTb/Xnz0
	b6Au3M702FIapBJGXeGItwY3G5dMpozO9I1Eml2Ws6OefMIgc/wcS9TNjQnt2P5tRMYKQJSF+pZ9j
	F/f76b3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgt-00000005NwH-33wT;
	Mon, 22 Jun 2026 20:56:23 +0000
Received: from esa2.hc555-34.eu.iphmx.com ([23.90.104.147])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgp-00000005NqA-1bQq
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161779; x=1813697779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oe5TUasz9guqQd5HibSbK5i7pU/fmg3upfM3+F4TvHI=;
  b=BaNULeABycfQ4QVijcnjsV0tdzxI9mHpEwM6CGu5t2MmsqIf02TD/hcl
   3M/Bi2etGhtk+9K1vjbzkZMF24DbwiASiVYrjY0Bx+V6olHIYVG3mbmM2
   uI/YMI84mb7CDxMgDPf66kpMM6hXZDwFSgrKa1O9ceQLfrUoODXNvuGCM
   OCj45yHa0zWoZ7aI4EPeKVJMCWYUPmPnIljFZ3ApaIowXRPqcFUzYtNd4
   g1868fcn9c92upRpg5WpW/7FK+kQznvWKSrDCJpUO0w9pLAhbUfNMF1V3
   99GmkcMMKhEtXer/lc3o518hYnVzxPLZyPHEQIaR6dnROezctLGydrsEr
   A==;
X-CSE-ConnectionGUID: n5ezhUWRRBeXN+Tkz8pd3g==
X-CSE-MsgGUID: maaCstyxSpmu/SpVYgk4xw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:16 +0300
X-CSE-ConnectionGUID: R5Q9cCRCR2Kh9FaKw3XdWg==
X-CSE-MsgGUID: fVsxtkO9Q22fsKbwSBhqDw==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 23 Jun 2026 00:01:25 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:14 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 09/10] vmcore_tasks: Add main entry point and backtrace parser
Date: Mon, 22 Jun 2026 23:54:47 +0300
Message-ID: <20260622205550.1087163-10-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135619_902753_7B535D29 
X-CRM114-Status: GOOD (  25.22  )
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

- vmcore_tasks.c: Main entry point that orchestrates vmcore
  analysis. Opens vmcore ELF, parses headers and vmcoreinfo
  note, initializes architecture and memory subsystems, collects
  all tasks with per-thread register state and backtraces,
  extracts kernel dmesg, and writes combined output to
  tasks_buffer.txt. Supports debug verbosity levels via -d flag.

- vmcore_tasks_backtrace_parser.py: Post-processing Python tool
  that parses tasks_buffer.txt and resolves raw addresses to
  function names and source locations using addr2line and readelf.
  Handles shared library load address calculation, ELF link base
  detection for non-PIE binaries, C++ symbol demangling, and
  classifies tasks into user/kernel/running/crashed categories.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 vmcore_tasks/vmcore_tasks.c                   | 182 ++++++++
 vmcore_tasks/vmcore_tasks_backtrace_parser.py | 393 ++++++++++++++++++
 2 files changed, 575 insertions(+)
 create mode 100644 vmcore_tasks/vmcore_tasks.c
 create mode 100644 vmcore_tasks/vmcore_tasks_backtrace_parser.py

diff --git a/vmcore_tasks/vmcore_tasks.c b/vmcore_tasks/vmcore_tasks.c
new file mode 100644
index 00000000..68785b4e
--- /dev/null
+++ b/vmcore_tasks/vmcore_tasks.c
@@ -0,0 +1,182 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include "elf_info.h"
+#include "vmcore_info.h"
+#include "memory.h"
+#include "maple_tree.h"
+
+#include "vmcore_tasks_defs.h"
+#include "tasks.h"
+
+extern const char *fname;
+struct arch_deps arch;
+int debug_level = 0;
+
+#define OUT_BUF_SIZE	(64 * 1024)  // Larger buffer for full dmesg
+
+static char dmesg_buf[OUT_BUF_SIZE];
+static size_t dmesg_len = 0;
+static bool dmesg_truncated = false;
+
+void dmesg_handler(char *buf, unsigned int len)
+{
+	if (dmesg_len + len < OUT_BUF_SIZE) {
+		memcpy(dmesg_buf + dmesg_len, buf, len);
+		dmesg_len += len;
+		dmesg_buf[dmesg_len] = '\0';
+	} else if (!dmesg_truncated) {
+		fprintf(stderr, "Warning: dmesg buffer full, output truncated\n");
+		dmesg_truncated = true;
+	}
+}
+
+/* Write dmesg to file */
+void save_dmesg_formatted(FILE *fp, const char *dmesg)
+{
+	if (dmesg && dmesg[0]) {
+		fprintf(fp, "\ndmesg: (size: %zu)\n%s\n", dmesg_len, dmesg);
+	}
+}
+
+void cleanup_minicore(struct system_minicore *sys_mc)
+{
+	if (!sys_mc || !sys_mc->tasks)
+		return;
+
+	for (int i = 0; i < sys_mc->task_count; i++) {
+		struct task_data *task = &sys_mc->tasks[i];
+
+		/* Free VMA metadata */
+		if (task->vmas.vma_meta) {
+			free(task->vmas.vma_meta);
+			task->vmas.vma_meta = NULL;
+		}
+
+		/* Free threads array */
+		if (task->threads) {
+			free(task->threads);
+			task->threads = NULL;
+		}
+	}
+
+	free(sys_mc->tasks);
+	sys_mc->tasks = NULL;
+	sys_mc->task_count = 0;
+}
+
+int main(int argc, char **argv)
+{
+	int fd = -1, ret = 0;
+	struct system_minicore sys_mc;
+	// Initialize vmcoreinfo tables from raw data
+	const char *vmci_data;
+	size_t vmci_size;
+	const char *corefile = NULL;
+	FILE *out_fp = NULL;
+
+	memset(&sys_mc, 0, sizeof(sys_mc));
+	
+	/* Parse command line arguments */
+	for (int i = 1; i < argc; i++) {
+		if (strncmp(argv[i], "-d", 2) == 0) {
+			if (argv[i][2] != '\0') {
+				/* -d<level> form, e.g. -d1, -d3 */
+				debug_level = atoi(&argv[i][2]);
+			} else if (i + 1 < argc && argv[i + 1][0] != '-') {
+				/* -d <level> form with space */
+				debug_level = atoi(argv[++i]);
+			} else {
+				/* -d alone — default to TRACE */
+				debug_level = DBG_TRACE;
+			}
+			if (debug_level < DBG_NONE || debug_level > DBG_MEM) {
+				fprintf(stderr, "Invalid debug level %d (valid: %d-%d)\n",
+					debug_level, DBG_NONE, DBG_MEM);
+				ret = -1;
+				goto out_close;
+			}
+		} else if (argv[i][0] != '-') {
+			corefile = argv[i];
+		} else {
+			fprintf(stderr, "Unknown option: %s\n", argv[i]);
+			fprintf(stderr, "usage: %s [-d[0-4]] <kernel core file>\n", argv[0]);
+			ret = -1;
+			goto out_close;
+		}
+	}
+	if (!corefile) {
+		fprintf(stderr, "usage: %s [-d[0-4]] <kernel core file>\n", argv[0]);
+		ret = -1;
+		goto out_close;
+	}
+
+	fname = corefile;
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			fname, strerror(errno));
+		ret = -1;
+		goto out_close;
+	}
+
+	pr_info("Reading vmcore ELF and initializing vmcoreinfo\n");
+	ret = read_elf(fd);
+	if (ret != 0) {
+		fprintf(stderr, "Unable to read ELF information"
+			" from vmcore\n");
+		ret = -1;
+		goto out_close;
+	}
+	
+	if (elf_get_raw_vmcoreinfo(&vmci_data, &vmci_size) == 0) {
+		vmcoreinfo_init(vmci_data, vmci_size);
+		vmcore_set_fd(fd);
+	} else {
+		fprintf(stderr, "Warning: no VMCOREINFO note found\n");
+	}
+
+	/* Dump vmcoreinfo for debugging */
+	if (is_trace()) vmcoreinfo_dump();
+
+	pr_info("Initializing architecture specific dependencies\n");
+	arch_init();
+	mem_vtop = arch.vtop;
+	memory_config_init();
+
+	/* Open output file for writing */
+	out_fp = fopen("tasks_buffer.txt", "w");
+	if (!out_fp) {
+		fprintf(stderr, "Failed to open output file: %s\n", strerror(errno));
+		ret = -1;
+		goto out_close;
+	}
+	pr_info("os release: %s\n", vmcoreinfo_osrelease());
+
+	pr_info("Collecting tasks data\n");
+	ret = collect_tasks(&sys_mc);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to collect tasks\n");
+		ret = -1;
+		goto out_close;
+	}
+	save_minicore_formatted(out_fp, &sys_mc);
+
+	pr_info("Dumping dmesg log\n");
+	dump_dmesg(fd, dmesg_handler);
+	save_dmesg_formatted(out_fp, dmesg_buf);
+
+	printf("Tasks data saved to tasks_buffer.txt\n");
+
+out_close:
+	if (out_fp)
+		fclose(out_fp);
+	cleanup_minicore(&sys_mc);
+	if (fd >= 0)	
+		close(fd);
+	vmcoreinfo_cleanup();
+	return ret;
+}
\ No newline at end of file
diff --git a/vmcore_tasks/vmcore_tasks_backtrace_parser.py b/vmcore_tasks/vmcore_tasks_backtrace_parser.py
new file mode 100644
index 00000000..5abea4ef
--- /dev/null
+++ b/vmcore_tasks/vmcore_tasks_backtrace_parser.py
@@ -0,0 +1,393 @@
+#!/usr/bin/env python
+
+import argparse
+import subprocess
+import os
+import sys
+import logging
+import re
+
+g_output_file = 'tasks_output.txt'
+g_readelf_file_dict = {'name':'readelf','path':'./'}
+g_addr2line_file_dict = {'name':'addr2line','path':'./'}
+g_syms_default = ""
+g_task_list = []
+g_user_task_list = []
+g_kernel_task_list = []
+g_running_task_list = []
+g_crash_task_list = []
+g_libs_address_so_dict = {}
+g_libs_load_address_dict = {}
+
+
+class MyFormatter(logging.Formatter):
+	err_fmt  = "ERR: %(msg)s"
+	dbg_fmt  = "DBG: %(module)s: %(lineno)d: %(msg)s"
+	info_fmt = "%(msg)s"
+
+	def __init__(self, fmt="%(levelno)s: %(msg)s"):
+		logging.Formatter.__init__(self, fmt)
+
+	def format(self, record):
+		format_orig = self._fmt
+
+		if record.levelno == logging.DEBUG:
+			self._fmt = MyFormatter.dbg_fmt
+
+		elif record.levelno == logging.INFO:
+			self._fmt = MyFormatter.info_fmt
+
+		elif record.levelno == logging.ERROR:
+			self._fmt = MyFormatter.err_fmt
+
+		result = logging.Formatter.format(self, record)
+
+		self._fmt = format_orig
+
+		return result
+
+# create logger
+fmt = MyFormatter()
+logger = logging.getLogger('mcd_bt_parser_logger')
+logger.setLevel(logging.INFO)
+
+# create console handler
+console_handler = logging.StreamHandler()
+console_handler.setFormatter(fmt)
+logger.addHandler(console_handler)
+
+class ArgumentParser:
+	def __init__(self):
+		self.mandatory_arg = ['buffer']
+		self.mandatory_toolchain_tools = [g_readelf_file_dict, g_addr2line_file_dict]
+		self.parser = argparse.ArgumentParser(description='Mini codedump backtrace parser')
+
+		self.parser.add_argument('--buffer', '-b', metavar='<path to tasks buffer>', required=True, help='tasks buffer')
+		self.parser.add_argument('--syms', '-s', '--path', '-p', metavar='<path to libs/apps syms>', required=True, help='libs/apps path. can be separated by :')
+		self.parser.add_argument('--toolchain', '-t', metavar='<path to toolchain>', help='toolchain bin directory, or full path including prefix (e.g. /path/bin/riscv64-mti-linux-gnu-)')
+		self.parser.add_argument('--toolchain-prefix', metavar='<toolchain prefix>', help='toolchain tool prefix (e.g. mips64el-linux-musl-)')
+
+		self.activate()
+
+		# Update tool names if --toolchain-prefix is given
+		if self.args.toolchain_prefix:
+			g_readelf_file_dict['name'] = self.args.toolchain_prefix + 'readelf'
+			g_addr2line_file_dict['name'] = self.args.toolchain_prefix + 'addr2line'
+		elif self.args.toolchain and not os.path.isdir(self.args.toolchain):
+			# Support combined path+prefix, e.g. /path/bin/riscv64-mti-linux-gnu-
+			toolchain_dir = os.path.dirname(self.args.toolchain)
+			toolchain_prefix = os.path.basename(self.args.toolchain)
+			if toolchain_dir and os.path.isdir(toolchain_dir):
+				self.args.toolchain = toolchain_dir
+				g_readelf_file_dict['name'] = toolchain_prefix + 'readelf'
+				g_addr2line_file_dict['name'] = toolchain_prefix + 'addr2line'
+				logger.info("auto-detected toolchain dir: {} prefix: {}".format(toolchain_dir, toolchain_prefix))
+
+		if g_syms_default:
+			self.args.syms="{}:{}".format(self.args.syms,g_syms_default)
+		else:
+			self.args.syms=self.args.syms
+
+		# Normalize syms paths: if a path is a file, use its parent directory
+		normalized_paths = []
+		for spath in self.args.syms.split(':'):
+			if os.path.isfile(spath):
+				parent = os.path.dirname(spath) or '.'
+				logger.info("syms path '{}' is a file, using parent directory '{}'".format(spath, parent))
+				normalized_paths.append(parent)
+			else:
+				normalized_paths.append(spath)
+		self.args.syms = ':'.join(normalized_paths)
+		self.check_mandatory_args()
+		self.check_dependency_tools()
+
+	def activate(self):
+		self.args = self.parser.parse_args()
+
+	def args(self):
+		return self.args
+
+	def check_mandatory_args(self):
+		logger.info("checking mandatory input args")
+		for arg in vars(self.args):
+			logger.debug("parsing arguments: arg={} value={}".format(arg, getattr(self.args, arg)))
+
+			if arg in self.mandatory_arg and not os.path.isfile(getattr(self.args, arg)):
+				logger.error("missing mandatory input arg: --{}. {} is invalid file path".format(arg, getattr(self.args, arg)))
+				sys.exit()
+
+		logger.info("Done!")
+
+	def check_dependency_tools(self):
+		# got toolchain input flag
+		if (self.args.toolchain) != None and os.path.isdir(self.args.toolchain):
+			logger.debug("got toolchain flag: {}".format(self.args.toolchain))
+			# go over the toolchain dir and verify the mandatory tools are there
+			for file_dict in self.mandatory_toolchain_tools:
+				path = "{}/{}".format(self.args.toolchain, file_dict['name'])
+				if (not os.path.isfile(path)):
+					logger.error("toolchain path is missing tool: {}".format(path))
+					sys.exit()
+				else:
+					# update the toolchain tool path
+					path = "{}/{}".format(self.args.toolchain, file_dict['name'])
+					file_dict['path'] = self.args.toolchain
+					logger.debug("updating toolchain tools path to: {}".format(file_dict['path']))
+
+		# didn't get toolchain flag - tools must be in current working directory of parser
+		else:
+			for file_dict in self.mandatory_toolchain_tools:
+				if (not os.path.isfile("{}/{}".format(file_dict['path'], file_dict['name']))):
+					logger.error("toolchain path is missing tool: {}".format(file_dict))
+					sys.exit()
+
+class BacktraceParser:
+	def __init__(self, user_params):
+		self.addr2line = "{}/{}".format(g_addr2line_file_dict['path'], g_addr2line_file_dict['name'])
+		self.readelf_path = "{}/{}".format(g_readelf_file_dict['path'], g_readelf_file_dict['name'])
+		self.syms = user_params.args.syms
+		self.buffer = user_params.args.buffer
+		self.PF_DUMPCORE = 0x00000200  # Dumped core
+		self.PF_SIGNALED = 0x00000400  # Killed by a signal
+
+		self.parse_buffer_txt()
+
+		self.print_tasks_summary()
+
+	def write_to_file(self, content, write_handle):
+		write_handle.write(content)
+
+	def get_task_flags(self, line):
+		return int(line.split("flags: ")[1].rstrip(), 16)
+
+	def is_crashed_task(self, flag):
+		return flag & self.PF_SIGNALED != 0
+
+	def get_text_address_from_so(self, readelf_path, so_file):
+		logger.debug("input params: readelf_path={} so_file={}".format(readelf_path, so_file))
+
+		if not so_file in g_libs_address_so_dict:
+			logger.debug("{} not found in libs offset dictionary, trying to get .text section from {}".format(so_file, so_file))
+			cmd = '{} -S {} | grep -F .text'.format(readelf_path, so_file)
+			value = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).stdout.read().split()[3]
+			logger.debug("value={}".format(value))
+			logger.debug("text address in {} is: {}".format(so_file, str(value)))
+			g_libs_address_so_dict[so_file] = value
+
+		return g_libs_address_so_dict.get(so_file)
+
+	def check_func_name(self, func_name):
+		out_func_name = func_name
+
+		if func_name.startswith('_Z'):
+			cmd = '{} {}'.format('c++filt -n -p', func_name)
+			out_func_name = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).stdout.read().rstrip().decode("utf-8")
+			logger.debug("func name {} mangled to {}".format(func_name, out_func_name))
+
+		return out_func_name
+
+	def print_tasks_summary(self):
+		logger.info("writing tasks summary into {}".format(g_output_file))
+
+		with open(g_output_file, 'a') as writer:
+			# summary of all tasks
+			writer.write("\n{}\nuser tasks:\n{}\n".format(11 * "=", 11 * "="))
+			for task in g_user_task_list:
+				writer.write(task)
+
+			writer.write("\n{}\nkernel tasks:\n{}\n".format(13 * "=", 13 * "="))
+			for task in g_kernel_task_list:
+				writer.write(task)
+
+			writer.write("\n{}\nrunning tasks:\n{}\n".format(14 * "=", 14 * "="))
+			for task in g_running_task_list:
+				writer.write(task)
+
+			writer.write("\n{}\ncrash tasks:\n{}\n".format(12 * "=", 12 * "="))
+			for task in g_crash_task_list:
+				writer.write(task)
+		logger.info("Done!")
+
+	def handle_so_file(self, line, filename, bt_index, addr):
+		func_name = "<unknown function>"
+		file_line = "<.so binary not found>"
+		for path in self.syms.split(':'):
+			full_path = path + "/" + os.path.basename(filename)
+			if os.path.isfile(full_path):
+				logger.debug("found .so file at: {}".format(full_path))
+
+				so_address_offset = int(self.get_text_address_from_so(self.readelf_path, full_path), 16)
+				so_virtual_base = int(g_libs_load_address_dict [filename], 16)
+				text_virtual_addr = so_virtual_base + so_address_offset
+				bt_offset = addr - text_virtual_addr
+
+				cmd = '{} -e {} -f -s -p -i -j .text {}'.format(self.addr2line, full_path, hex(bt_offset))
+				logger.debug("addr: " + str(hex(addr)) + " text_virtual_addr: " + str(hex(text_virtual_addr)) + " so_virtual_base: " + str(hex(so_virtual_base)) + " so_address_offset: " + str(hex(so_address_offset)) + " cmd: " + cmd)
+				bt = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()[0].decode("utf-8")
+
+				# in case of inline function
+				if "(inlined by)" in bt:
+					cmd = '{} -e {} -f -s -p -i -j .text {}'.format(self.addr2line, full_path, hex(bt_offset + 4))
+					bt = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()[0].decode("utf-8").splitlines()[-1].replace(" (inlined by) ", "")
+
+				logger.debug("backtrace cmd: {}\noutput:{}".format(cmd, bt))
+
+				try:
+					func_name = self.check_func_name(bt.split()[0])
+					file_line = bt.split('at ')[1].rstrip()
+				except:
+					logger.error("in getting function name/line number")
+					logger.error("backtrace cmd: {}\n".format(cmd))
+					func_name = "<error in getting function>"
+					file_line = "<error in getting file line>"
+
+				break
+
+		return "{}  {} in {} at {} [{}]\n".format(bt_index, str(hex(addr)),
+											func_name, file_line,filename)
+
+	def find_binary(self, filename):
+		"""Find binary in syms paths, preferring _unstripped variant."""
+		basename = os.path.basename(filename)
+		for path in self.syms.split(':'):
+			# Prefer _unstripped variant
+			unstripped = path + "/" + basename + "_unstripped"
+			if os.path.isfile(unstripped):
+				return unstripped
+			regular = path + "/" + basename
+			if os.path.isfile(regular):
+				return regular
+		return None
+
+	def get_elf_load_base(self, readelf_path, elf_file):
+		"""Get the ELF link base address (first LOAD segment p_vaddr).
+		For non-PIE executables this is the fixed link address (e.g. 0x120000000).
+		For PIE executables / shared libraries this is typically 0.
+		"""
+		cmd = '{} -l {} 2>/dev/null | grep LOAD | head -1'.format(readelf_path, elf_file)
+		try:
+			out = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).stdout.read().decode("utf-8").strip()
+			if out:
+				# LOAD segment line: "  LOAD  0x000000 0x1000000000 0x1000000000 ..."
+				# p_vaddr is the 3rd field (index 2)
+				parts = out.split()
+				return int(parts[2], 16)
+		except Exception as e:
+			logger.warning("Failed to get ELF load base for {}: {}".format(elf_file, e))
+		return 0
+
+	def handle_bin_file(self, line, filename, bt_index, addr, vm_start=0):
+		func_name = "<unknown function>"
+		file_line = "<binary file not found>"
+		full_path = self.find_binary(filename)
+		if full_path:
+			logger.debug("found binary app at: {}".format(full_path))
+			elf_link_base = self.get_elf_load_base(self.readelf_path, full_path)
+			bt_offset = (addr - vm_start) + elf_link_base
+			cmd = '{} -e {} -f -s -p {}'.format(self.addr2line, full_path, str(hex(bt_offset)))
+			bt = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()[0].decode("utf-8").rstrip()
+			logger.debug("backtrace cmd: {}\noutput:{}".format(cmd, bt))
+
+			try:
+				func_name = self.check_func_name(bt.split()[0])
+				file_line = bt.split('at ')[1].rstrip()
+			except:
+				logger.error("in getting function name/line number")
+				logger.error("backtrace cmd: {}\n".format(cmd))
+				func_name = "<error in getting function>"
+				file_line = "<error in getting file line>"
+
+		return "{}  {} in {} at {} [{}]\n".format(bt_index, str(hex(addr)),
+												 func_name, file_line, filename)
+
+	def parse_buffer_txt(self):
+		# open buffer txt for read, open output file for write
+		with open(self.buffer, 'r', errors='replace') as buffer_txt:
+			with open(g_output_file, 'w') as writer:
+				logger.info("reading from {} into {}".format(self.buffer, g_output_file))
+
+				# go over each line
+				line = buffer_txt.readline()
+				while line:
+					line_len = len(line)
+					logger.debug("current line is: {}".format(line))
+
+					# start of task
+					if line.startswith('name:'):
+						task_name = line.split('name:')[1].split(',')[0]
+						logger.debug("current task name is: {}".format(task_name))
+
+						# if the header task is user
+						if "is_user_task: Y" in line:
+							logger.debug("task {} is user task".format(task_name))
+							g_user_task_list.append("{}".format(line))
+
+						# if the header task is kernel
+						elif "is_user_task: N" in line:
+							logger.debug("task {} is kernel task".format(task_name))
+							g_kernel_task_list.append("{}".format(line))
+
+						if "state: 0" in line:
+							logger.debug("task {} is in running mode".format(task_name))
+							g_running_task_list.append("{}".format(line))
+
+						if self.is_crashed_task(self.get_task_flags(line)):
+							logger.debug("task {} is crashed".format(task_name))
+							g_crash_task_list.append("{}".format(line))
+
+						# write the header task to file
+						self.write_to_file("\n{}\n{}{}\n".format('=' * line_len, line, '=' * line_len), writer)
+
+					#/proc/map libs load address parsing
+					elif line.startswith("vm_nr"):
+						g_libs_load_address_dict.clear()
+						self.write_to_file(line, writer)
+
+					elif line.strip() and line.split()[0].isdigit():
+						if len(line.split()) > 4:
+							buffer_libname = os.path.basename(line.split()[2].rstrip())
+							if not buffer_libname in g_libs_load_address_dict:
+								value = line.split()[1].split('-')[0][1:]
+								g_libs_load_address_dict[buffer_libname] = value
+						self.write_to_file(line, writer)
+
+					# backtrace parsing
+					elif re.match(r'#.*?addr=',line):
+						bt_index = line.split(' ')[0]
+						addr = int(line.split(', ')[0].split('=')[1].rstrip(), 16)
+						vm_start = int(line.split(', ')[1].split('=')[1].rstrip(), 16)
+						lib_name = os.path.basename(line.split(', ')[3].split('=')[1].rstrip())
+
+						if addr == 0:
+							self.write_to_file(("{}: {}\n".format(line.split(':')[0], str(hex(addr)))), writer)
+
+						else:
+							# in case of SHARED library
+							if '.so' in lib_name:
+								output = self.handle_so_file(line, lib_name, bt_index, addr)
+							else:
+								output = self.handle_bin_file(line, lib_name, bt_index, addr, vm_start)
+
+							self.write_to_file(output, writer)
+
+					# print the dmesg header
+					elif line.startswith("dmesg:"):
+						self.write_to_file("\n{}\n{}{}\n".format('=' * line_len, line, '=' * line_len), writer)
+
+					# line is not backtrace and not header - just print the line
+					else:
+						self.write_to_file(line, writer)
+
+					# read the next line
+					line = buffer_txt.readline()
+
+				# end of tasks buffer
+				self.write_to_file("\n{} END OF TASKS BUFFER {}\n".format(30 * "@", 30 * "@"), writer)
+
+def main():
+	user_params = ArgumentParser()
+	BacktraceParser(user_params)
+
+if __name__ == '__main__':
+	main()
+
-- 
2.43.0


