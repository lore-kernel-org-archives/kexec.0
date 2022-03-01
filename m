From: Leonidas Spyropoulos <artafinde@archlinux.org>
Date: Tue,  1 Mar 2022 19:20:35 +0000
Subject: [PATCH 1/1] Simplify the generation of man pages
Message-ID: <20220301192035.473055-1-artafinde@archlinux.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Use `sed` to simplify the man pages generation. Keep the .in files
intact during make and generate the actual man pages with sed.
Additionally package tools already gz the man pages during install so it
doesn't really need to do that during make and it breaks reproducibility
of the package due to timestamps on files.

Motivation: https://reproducible-builds.org

Signed-off-by: Leonidas Spyropoulos <artafinde@archlinux.org>
---
 Makefile               |  20 +-
 makedumpfile.8.in      | 692 +++++++++++++++++++++++++++++++++++++++++
 makedumpfile.conf.5.in | 419 +++++++++++++++++++++++++
 3 files changed, 1120 insertions(+), 11 deletions(-)
 create mode 100644 makedumpfile.8.in
 create mode 100644 makedumpfile.conf.5.in

diff --git a/Makefile b/Makefile
index 9f9fd22..f118b31 100644
--- a/Makefile
+++ b/Makefile
@@ -112,26 +112,24 @@ $(OBJ_ARCH): $(SRC_ARCH)
 
 makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
 	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
-	echo .TH MAKEDUMPFILE 8 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.8
-	grep -v "^.TH MAKEDUMPFILE 8" $(VPATH)makedumpfile.8 >> temp.8
-	mv temp.8 makedumpfile.8
-	gzip -c ./makedumpfile.8 > ./makedumpfile.8.gz
-	echo .TH MAKEDUMPFILE.CONF 5 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.5
-	grep -v "^.TH MAKEDUMPFILE.CONF 5" $(VPATH)makedumpfile.conf.5 >> temp.5
-	mv temp.5 makedumpfile.conf.5
-	gzip -c ./makedumpfile.conf.5 > ./makedumpfile.conf.5.gz
+	@sed -e "s/@DATE@/$(DATE)/" \
+	     -e "s/@VERSION@/$(VERSION)/" \
+	     $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
+	@sed -e "s/@DATE@/$(DATE)/" \
+	     -e "s/@VERSION@/$(VERSION)/" \
+	     $(VPATH)makedumpfile.conf.5.in > $(VPATH)makedumpfile.conf.5
 
 eppic_makedumpfile.so: extension_eppic.c
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -rdynamic -o $@ extension_eppic.c -fPIC -leppic -ltinfo
 
 clean:
-	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8.gz makedumpfile.conf.5.gz
+	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
 
 install:
 	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8 ${DESTDIR}/etc
 	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
-	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8.gz
-	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5.gz
+	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
+	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
 	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
 	mkdir -p ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts
 	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/ $(VPATH)eppic_scripts/*
diff --git a/makedumpfile.8.in b/makedumpfile.8.in
new file mode 100644
index 0000000..d22588e
--- /dev/null
+++ b/makedumpfile.8.in
@@ -0,0 +1,692 @@
+.TH MAKEDUMPFILE 8 "@DATE@" "makedumpfile v at VERSION@" "Linux System Administrator's Manual"
+.SH NAME
+makedumpfile \- make a small dumpfile of kdump
+.SH SYNOPSIS
+\fBmakedumpfile\fR    [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
+.br
+\fBmakedumpfile\fR \-F [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR
+.br
+\fBmakedumpfile\fR   [\fIOPTION\fR] \-x \fIVMLINUX\fR [\-\-config \fIFILTERCONFIGFILE\fR] [\-\-eppic \fIEPPICMACRO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
+.br
+\fBmakedumpfile\fR \-R \fIDUMPFILE\fR
+.br
+\fBmakedumpfile\fR \-\-split [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE1\fR \fIDUMPFILE2\fR [\fIDUMPFILE3\fR ..]
+.br
+\fBmakedumpfile\fR [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \-\-num\-threads \fITHREADNUM\fR \fIVMCORE\fR \fIDUMPFILE\fR
+.br
+\fBmakedumpfile\fR \-\-reassemble \fIDUMPFILE1\fR \fIDUMPFILE2\fR [\fIDUMPFILE3\fR ..] \fIDUMPFILE\fR
+.br
+\fBmakedumpfile\fR \-g \fIVMCOREINFO\fR \-x \fIVMLINUX\fR
+.br
+\fBmakedumpfile\fR    [\fIOPTION\fR] [\-\-xen-syms \fIXEN-SYMS\fR|\-\-xen-vmcoreinfo \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
+.br
+\fBmakedumpfile\fR \-\-dump-dmesg [\-\-partial-dmesg] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fILOGFILE\fR
+.br
+\fBmakedumpfile\fR    [\fIOPTION\fR] \-x \fIVMLINUX\fR \-\-diskset=\fIVMCORE1\fR \-\-diskset=\fIVMCORE2\fR [\-\-diskset=\fIVMCORE3\fR ..] \fIDUMPFILE\fR
+.br
+.B makedumpfile
+\-h
+.br
+.B makedumpfile
+\-v
+.br
+.SH DESCRIPTION
+.PP
+With kdump, the memory image of the first kernel (called "panicked kernel") can
+be taken as /proc/vmcore while the second kernel (called "kdump kernel" or
+"capture kernel") is running. This document represents /proc/vmcore as
+\fIVMCORE\fR. makedumpfile makes a small \fIDUMPFILE\fR by compressing dump
+data or by excluding unnecessary pages for analysis, or both. makedumpfile
+needs the first kernel's debug information, so that it can distinguish
+unnecessary pages by analyzing how the first kernel uses the memory.
+The information can be taken from \fIVMLINUX\fR or \fIVMCOREINFO\fR.
+.PP
+makedumpfile can exclude the following types of pages while copying
+\fIVMCORE\fR to \fIDUMPFILE\fR, and a user can choose which type of pages will
+be excluded.
+.br
+.B \- Pages filled with zero
+.br
+.B \- Cache pages without private flag (non-private cache)
+.br
+.B \- Cache pages with private flag (private cache)
+.br
+.B \- User process data pages
+.br
+.B \- Free pages
+.PP
+makedumpfile provides two \fIDUMPFILE\fR formats (the ELF format and the
+kdump\-compressed format). By default, makedumpfile makes a \fIDUMPFILE\fR in
+the kdump\-compressed format. The kdump\-compressed format is readable only with
+the crash utility, and it can be smaller than the ELF format because of the
+compression support. The ELF format is readable with GDB and the crash utility.
+If a user wants to use GDB, \fIDUMPFILE\fR format has to be explicitly
+specified to be the ELF format.
+.PP
+Apart from the exclusion of unnecessary pages mentioned above, makedumpfile
+allows user to filter out targeted kernel data. The filter config file can
+be used to specify kernel/module symbols and its members that need to be
+filtered out through the erase command syntax. makedumpfile reads the filter
+config and builds the list of memory addresses and its sizes after processing
+filter commands. The memory locations that require to be filtered out are
+then poisoned with character 'X' (58 in Hex). Refer to
+\fBmakedumpfile.conf(5)\fR for file format.
+.PP
+Eppic macros can also be used to specify kernel symbols and its members that
+need to be filtered. Eppic provides C semantics including language constructs
+such as conditional statements, logical and arithmetic operators, functions,
+nested loops to traverse and erase kernel data. --eppic requires
+\fBeppic_makedumpfile.so\fR and eppic library. \fBeppic_makedumpfile.so\fR
+can be built from makedumpfile source. Refer to
+\fBhttp://code.google.com/p/eppic/\fR to build eppic library \fBlibeppic.a\fR
+and for more information on writing eppic macros.
+.PP
+To analyze the first kernel's memory usage, makedumpfile can refer to
+\fIVMCOREINFO\fR instead of \fIVMLINUX\fR. \fIVMCOREINFO\fR contains the first
+kernel's information (structure size, field offset, etc.), and \fIVMCOREINFO\fR
+is small enough to be included into the second kernel's initrd.
+.br
+If the second kernel is running on its initrd without mounting a root file
+system, makedumpfile cannot refer to \fIVMLINUX\fR because the second kernel's
+initrd cannot include a large file like \fIVMLINUX\fR. To solve the problem,
+makedumpfile makes \fIVMCOREINFO\fR beforehand, and it refers to
+\fIVMCOREINFO\fR instead of \fIVMLINUX\fR while the second kernel is running.
+.br
+\fIVMCORE\fR has contained \fIVMCOREINFO\fR since linux-2.6.24, and a user does
+not need to specify neither -x nor -i option.
+.PP
+If the second kernel is running on its initrd without mounting any file system,
+a user needs to transport the dump data to a remote host. To transport the dump
+data by SSH, makedumpfile outputs the dump data in the intermediate format (the
+flattened format) to the standard output. By piping the output data to SSH,
+a user can transport the dump data to a remote host. Note that analysis tools
+(crash utility before version 5.1.2 or GDB) cannot read the flattened format 
+directly, so on a remote host the received data in the flattened format needs
+to be rearranged to a readable \fIDUMPFILE\fR format by makedumpfile (or makedumpfile\-R.pl).
+.PP
+makedumpfile can read a \fIDUMPFILE\fR in the kdump-compressed format instead
+of \fIVMCORE\fR and re-filter it. This feature is useful in situation that
+users need to reduce the file size of \fIDUMPFILE\fR for sending it somewhere
+by ftp/scp/etc. (If all of the page types, which are specified by a new dump_level,
+are excluded from an original \fIDUMPFILE\fR already, a new \fIDUMPFILE\fR is the
+same as an original \fIDUMPFILE\fR.)
+.br
+For example, makedumpfile can create a \fIDUMPFILE\fR of dump_level 31 from the
+one of dump_level 3 like the following:
+.br
+.B Example:
+.br
+# makedumpfile \-c \-d 3 /proc/vmcore dumpfile.1
+.br
+# makedumpfile \-c \-d 31 dumpfile.1 dumpfile.2
+.PP
+makedumpfile can read \fIVMCORE\fR(s) in three kinds of sadump
+formats: single partition format, diskset format and media backup
+format, and can convert each of them into kdump-compressed format with
+filtering and compression processing. Note that for \fIVMCORE\fR(s)
+created by sadump, you always need to pass \fIVMLINUX\fR with -x
+option. Also, to pass multiple \fIVMCORE\fRs created on diskset
+configuration, you need to use --diskset option.
+
+.PP
+.SH OPTIONS
+
+.TP
+\fB\-c,\-l,\-p,\-z\fR
+Compress dump data by the page using the following compression library respectively:
+.br
+	\fB-c\fR : zlib
+.br
+	\fB-l\fR : lzo
+.br
+	\fB-p\fR : snappy
+.br
+	\fB-z\fR : zstd
+.br
+(-l, -p and -z option need USELZO=on, USESNAPPY=on and USEZSTD=on respectively
+when building makedumpfile)
+.br
+A user cannot specify this option with \-E option, because the ELF format does
+not support compressed data.
+.br
+.B Example:
+.br
+# makedumpfile \-c \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
+.BI \-d \ dump_level
+Specify the type of unnecessary page for analysis.
+.br
+Pages of the specified type are not copied to \fIDUMPFILE\fR. The page type
+marked in the following table is excluded. A user can specify multiple page
+types by setting the sum of each page type for dump_level. The maximum of
+dump_level is 31. Note that a dump_level for Xen dump filtering is 0 or 1 on
+a machine other than x86_64. On a x86_64 machine, even 2 or bigger dump level
+will be effective if you specify domain-0's \fIvmlinux\fR with \-x option.
+Then the pages are excluded only from domain-0.
+.br
+If specifying multiple dump_levels with the delimiter ',', makedumpfile retries
+to create \fIDUMPFILE\fR using the next dump_level when the size of a dumpfile
+exceeds the limit specified with '-L' or when a "No space on device" error
+happens. For example, if dump_level is "11,31" and makedumpfile fails with
+dump_level 11, makedumpfile retries with dump_level 31.
+.br
+.B Example:
+.br
+# makedumpfile \-d 11 \-x vmlinux /proc/vmcore dumpfile
+.br
+# makedumpfile \-d 11,31 \-x vmlinux /proc/vmcore dumpfile
+.br
+.B Base level:
+.br
+dump_level consists of five bits, so there are five base levels to specify the type of unnecessary page.
+.br
+	\fB 1\fR :	Exclude the pages filled with zero.
+.br
+	\fB 2\fR :	Exclude the non-private cache pages.
+.br
+	\fB 4\fR :	Exclude all cache pages.
+.br
+	\fB 8\fR :	Exclude the user process data pages.
+.br
+	\fB16\fR :	Exclude the free pages.
+
+Here is the all combinations of the bits.
+
+       |      |non-   |       |      |
+  dump | zero |private|private| user | free
+ level | page |cache  |cache  | data | page
+.br
+\-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-\-+\-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-
+     0 |      |       |       |      |
+     1 |  X   |       |       |      |
+     2 |      |   X   |       |      |
+     3 |  X   |   X   |       |      |
+     4 |      |   X   |   X   |      |
+     5 |  X   |   X   |   X   |      |
+     6 |      |   X   |   X   |      |
+     7 |  X   |   X   |   X   |      |
+     8 |      |       |       |  X   |
+     9 |  X   |       |       |  X   |
+    10 |      |   X   |       |  X   |
+    11 |  X   |   X   |       |  X   |
+    12 |      |   X   |   X   |  X   |
+    13 |  X   |   X   |   X   |  X   |
+    14 |      |   X   |   X   |  X   |
+    15 |  X   |   X   |   X   |  X   |
+    16 |      |       |       |      |  X
+    17 |  X   |       |       |      |  X
+    18 |      |   X   |       |      |  X
+    19 |  X   |   X   |       |      |  X
+    20 |      |   X   |   X   |      |  X
+    21 |  X   |   X   |   X   |      |  X
+    22 |      |   X   |   X   |      |  X
+    23 |  X   |   X   |   X   |      |  X
+    24 |      |       |       |  X   |  X
+    25 |  X   |       |       |  X   |  X
+    26 |      |   X   |       |  X   |  X
+    27 |  X   |   X   |       |  X   |  X
+    28 |      |   X   |   X   |  X   |  X
+    29 |  X   |   X   |   X   |  X   |  X
+    30 |      |   X   |   X   |  X   |  X
+    31 |  X   |   X   |   X   |  X   |  X
+
+.TP
+\fB\-L\fR \fISIZE\fR
+Limit the size of the output file to \fISIZE\fR bytes. An incomplete
+\fIDUMPFILE\fR or \fILOGFILE\fR is written if the size would otherwise exceed
+\fISIZE\fR.
+
+.TP
+\fB\-E\fR
+Create \fIDUMPFILE\fR in the ELF format.
+.br
+This option cannot be specified with the -c, -l or -p options, because
+the ELF format does not support compressed data.
+.br
+.B Example:
+.br
+# makedumpfile \-E \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
+\fB\-f\fR
+Force existing DUMPFILE to be overwritten and mem-usage to work with older
+kernel as well.
+.br
+.B Example:
+.br
+# makedumpfile \-f \-d 31 \-x vmlinux /proc/vmcore dumpfile
+.br
+This command overwrites \fIDUMPFILE\fR even if it already exists.
+.br
+# makedumpfile \-f \-\-mem\-usage /proc/kcore
+.br
+Kernel version lesser than v4.11 will not work with \-\-mem\-usage
+functionality until it has been patched with upstream commit 464920104bf7.
+Therefore if you have patched your older kernel then use \-f.
+
+.TP
+\fB\-x\fR \fIVMLINUX\fR
+Specify the first kernel's \fIVMLINUX\fR with debug information to analyze the
+first kernel's memory usage.
+.br
+This option is necessary if \fIVMCORE\fR does not contain \fIVMCOREINFO\fR,
+[\-i \fIVMCOREINFO\fR] is not specified, and dump_level is 2 or more.
+.br
+The page size of the first kernel and the second kernel should match.
+.br
+.B Example:
+.br
+# makedumpfile \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
+\fB\-i\fR \fIVMCOREINFO\fR
+Specify \fIVMCOREINFO\fR instead of \fIVMLINUX\fR for analyzing the first kernel's memory usage.
+.br
+\fIVMCOREINFO\fR should be made beforehand by makedumpfile with \-g option, and
+it contains the first kernel's information.
+.br
+This option is necessary if \fIVMCORE\fR does not contain \fIVMCOREINFO\fR,
+[\-x \fIVMLINUX\fR] is not specified, and dump_level is 2 or more.
+.br
+.B Example:
+.br
+# makedumpfile \-d 31 \-i vmcoreinfo /proc/vmcore dumpfile
+
+.TP
+\fB\-g\fR \fIVMCOREINFO\fR
+Generate \fIVMCOREINFO\fR from the first kernel's \fIVMLINUX\fR with debug
+information.
+.br
+\fIVMCOREINFO\fR must be generated on the system that is running the first
+kernel. With \-i option, a user can specify \fIVMCOREINFO\fR generated on the
+other system that is running the same first kernel. [\-x \fIVMLINUX\fR] must be
+specified.
+.br
+.B Example:
+.br
+# makedumpfile \-g vmcoreinfo \-x vmlinux
+
+.TP
+\fB\-\-config\fR \fIFILTERCONFIGFILE\fR
+Used in conjunction with \-x \fIVMLINUX\fR option, to specify the filter
+config file \fIFILTERCONFIGFILE\fR that contains erase commands to filter out
+desired kernel data from vmcore while creating \fIDUMPFILE\fR. For filter
+command syntax please refer to \fBmakedumpfile.conf(5)\fR.
+
+.TP
+\fB\-\-eppic\fR \fIEPPICMACRO\fR
+Used in conjunction with \-x \fIVMLINUX\fR option, to specify the eppic macro
+file that contains filter rules or directory that contains eppic macro
+files to filter out desired kernel data from vmcore while creating \fIDUMPFILE\fR.
+When directory is specified, all the eppic macros in the directory are processed.
+
+.TP
+\fB\-F\fR
+Output the dump data in the flattened format to the standard output for
+transporting the dump data by SSH.
+.br
+Analysis tools (crash utility before version 5.1.2 or GDB) cannot read the 
+flattened format directly. For analysis, the dump data in the flattened format
+should be rearranged to a normal \fIDUMPFILE\fR (readable with analysis tools)
+by \-R option. By which option is specified with \-F option, the format of the
+rearranged \fIDUMPFILE\fR is fixed.
+In other words, it is impossible to specify the \fIDUMPFILE\fR format when the
+dump data is rearranged with \-R option. If specifying \-E option with \-F option,
+the format of the rearranged \fIDUMPFILE\fR is the ELF format. Otherwise, it
+is the kdump\-compressed format. All the messages are output to standard error
+output by \-F option because standard output is used for the dump data.
+.br
+.B Example:
+.br
+# makedumpfile \-F \-c \-d 31 \-x vmlinux /proc/vmcore \e
+.br
+| ssh user at host "cat > dumpfile.tmp"
+.br
+# makedumpfile \-F \-c \-d 31 \-x vmlinux /proc/vmcore \e
+.br
+| ssh user at host "makedumpfile \-R dumpfile"
+.br
+# makedumpfile \-F \-E \-d 31 \-i vmcoreinfo  /proc/vmcore \e
+.br
+| ssh user at host "makedumpfile \-R dumpfile"
+.br
+# makedumpfile \-F \-E \-\-xen-vmcoreinfo \fIVMCOREINFO\fR /proc/vmcore \e
+.br
+| ssh user at host "makedumpfile \-R dumpfile"
+
+.TP
+\fB\-R\fR
+Rearrange the dump data in the flattened format from the standard input to a
+normal \fIDUMPFILE\fR (readable with analysis tools).
+.br
+.B Example:
+.br
+# makedumpfile \-R dumpfile < dumpfile.tmp
+.br
+# makedumpfile \-F \-d 31 \-x vmlinux /proc/vmcore \e
+.br
+| ssh user at host "makedumpfile \-R dumpfile"
+
+Instead of using \-R option, a perl script "makedumpfile\-R.pl" rearranges the
+dump data in the flattened format to a normal \fIDUMPFILE\fR, too. The perl
+script does not depend on architecture, and most systems have perl command.
+Even if a remote host does not have makedumpfile, it is possible to rearrange
+the dump data in the flattened format to a readable \fIDUMPFILE\fR on a remote
+host by running this script.
+.br
+.B Example:
+.br
+# makedumpfile \-F \-d 31 \-x vmlinux /proc/vmcore \e
+.br
+| ssh user@host "makedumpfile\-R.pl dumpfile"
+
+.TP
+\fB\-\-split\fR
+Split the dump data to multiple \fIDUMPFILE\fRs in parallel. If specifying
+\fIDUMPFILE\fRs on different storage devices, a device can share I/O load
+with other devices and it reduces time for saving the dump data. The file
+size of each \fIDUMPFILE\fR is smaller than the system memory size which
+is divided by the number of \fIDUMPFILE\fRs. This feature supports only
+the kdump\-compressed format.
+.br
+.B Example:
+.br
+# makedumpfile \-\-split \-d 31 \-x vmlinux /proc/vmcore dumpfile1 dumpfile2
+
+.TP
+\fB\-\-num\-threads\fR \fITHREADNUM\fR
+Using multiple threads to read and compress data of each page in parallel.
+And it will reduces time for saving \fIDUMPFILE\fR.
+Note that if the usable cpu number is less than the thread number, it may
+lead to great performance degradation.
+This feature only supports creating \fIDUMPFILE\fR in kdump\-comressed
+format from \fIVMCORE\fR in kdump\-compressed format or elf format.
+.br
+.B Example:
+.br
+# makedumpfile \-d 31 \-\-num\-threads 4 /proc/vmcore dumpfile
+
+.TP
+\fB\-\-reassemble\fR
+Reassemble multiple \fIDUMPFILE\fRs, which are created by \-\-split option,
+into one \fIDUMPFILE\fR. dumpfile1 and dumpfile2 are reassembled into dumpfile
+on the following example.
+.br
+.B Example:
+.br
+# makedumpfile \-\-reassemble dumpfile1 dumpfile2 dumpfile
+
+.TP
+\fB\-b\fR \fI<order>\fR
+Cache 2^order pages in ram when generating \fIDUMPFILE\fR before writing to output.
+The default value is 4.
+
+.TP
+\fB\-\-cyclic\-buffer\fR \fIbuffer_size\fR
+Specify the buffer size in kilo bytes for bitmap data.
+Filtering processing will be divided into multi cycles to fix the memory consumption,
+the number of cycles is represented as:
+
+    num_of_cycles = system_memory / (\fIbuffer_size\fR * 1024 * bit_per_bytes * page_size )
+
+The lesser number of cycles, the faster working speed is expected.
+By default, \fIbuffer_size\fR will be calculated automatically depending on system memory
+size, so ordinary users don't need to specify this option.
+
+.br
+.B Example:
+.br
+# makedumpfile \-\-cyclic\-buffer 1024 \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
+\fB\-\-splitblock\-size\fR \fIsplitblock_size\fR
+Specify the splitblock size in kilo bytes for analysis with --split.
+If --splitblock N is specified, difference of each splitted dumpfile size is at most N
+kilo bytes.
+.br
+.B Example:
+.br
+# makedumpfile \-\-splitblock\-size 1024 \-d 31 \-x vmlinux \-\-split /proc/vmcore dumpfile1 dumpfile2
+
+.TP
+
+\fB\-\-work\-dir\fR
+Specify the working directory for the temporary bitmap file.
+If this option isn't specified, the bitmap will be saved on memory.
+Filtering processing has to do 2 pass scanning to fix the memory consumption,
+but it can be avoided by using working directory on file system.
+So if you specify this option, the filtering speed may be bit faster.
+
+.br
+.B Example:
+.br
+# makedumpfile \-\-work\-dir /tmp \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
+\fB\-\-non\-mmap\fR
+Never use \fBmmap(2)\fR to read \fIVMCORE\fR even if it supports \fBmmap(2)\fR.
+Generally, reading \fIVMCORE\fR with \fBmmap(2)\fR is faster than without it,
+so ordinary users don't need to specify this option.
+This option is mainly for debugging.
+.br
+.B Example:
+.br
+# makedumpfile \-\-non\-mmap \-d 31 \-x vmlinux /proc/vmcore dumpfile
+
+.TP
+\fB\-\-xen-syms\fR \fIXEN-SYMS\fR
+Specify the \fIXEN-SYMS\fR with debug information to analyze the xen's memory usage.
+This option extracts the part of xen and domain-0.
+.br
+.B Example:
+.br
+# makedumpfile \-E \-\-xen-syms xen-syms /proc/vmcore dumpfile
+
+.TP
+\fB\-\-xen-vmcoreinfo\fR \fIVMCOREINFO\fR
+Specify \fIVMCOREINFO\fR instead of \fIXEN-SYMS\fR for analyzing the xen's memory usage.
+.br
+\fIVMCOREINFO\fR should be made beforehand by makedumpfile with \-g option, and
+it contains the xen's information.
+.br
+.B Example:
+.br
+# makedumpfile \-E \-\-xen-vmcoreinfo \fIVMCOREINFO\fR /proc/vmcore dumpfile
+
+.TP
+\fB\-X\fR
+Exclude all the user domain pages from Xen kdump's \fIVMCORE\fR, and extracts the
+part of xen and domain-0. If \fIVMCORE\fR contains \fIVMCOREINFO\fR for Xen, it is
+not necessary to specify \fI\-\-xen-syms\fR and \fI\-\-xen-vmcoreinfo\fR.
+.br
+.B Example:
+.br
+# makedumpfile \-E \-X /proc/vmcore dumpfile
+
+.TP
+\fB\-\-xen_phys_start\fR \fIxen_phys_start_address\fR
+This option is only for x86_64.
+Specify the \fIxen_phys_start_address\fR, if the xen code/data is relocatable
+and \fIVMCORE\fR does not contain \fIxen_phys_start_address\fR in the CRASHINFO.
+\fIxen_phys_start_address\fR can be taken from the line of "Hypervisor code
+and data" in /proc/iomem. For example, specify 0xcee00000 as \fIxen_phys_start_address\fR
+if /proc/iomem is the following:
+  -------------------------------------------------------
+  # cat /proc/iomem
+  ...
+    cee00000-cfd99999 : Hypervisor code and data
+  ...
+  -------------------------------------------------------
+
+.br
+.B Example:
+.br
+# makedumpfile \-E \-X \-\-xen_phys_start 0xcee00000 /proc/vmcore dumpfile
+
+.TP
+\fB\-\-message-level\fR \fImessage_level\fR
+Specify the message types.
+.br
+Users can restrict outputs printed by specifying \fImessage_level\fR
+with this option. The message type marked with an X in the following
+table is printed. For example, according to the table, specifying 7 as
+\fImessage_level\fR means progress indicator, common message, and error
+message are printed, and this is a default value. Note that the maximum
+value of \fImessage_level\fR is 31.
+.br
+
+ message | progress | common  | error   | debug   | report
+ level   | indicator| message | message | message | message
+.br
+\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-
+       0 |          |         |         |         |
+       1 |    X     |         |         |         |
+       2 |          |    X    |         |         |
+       3 |    X     |    X    |         |         |
+       4 |          |         |    X    |         |
+       5 |    X     |         |    X    |         |
+       6 |          |    X    |    X    |         |
+     * 7 |    X     |    X    |    X    |         |
+       8 |          |         |         |    X    |
+       9 |    X     |         |         |    X    |
+      10 |          |    X    |         |    X    |
+      11 |    X     |    X    |         |    X    |
+      12 |          |         |    X    |    X    |
+      13 |    X     |         |    X    |    X    |
+      14 |          |    X    |    X    |    X    |
+      15 |    X     |    X    |    X    |    X    |
+      16 |          |         |         |         |    X
+      17 |    X     |         |         |         |    X
+      18 |          |    X    |         |         |    X
+      19 |    X     |    X    |         |         |    X
+      20 |          |         |    X    |         |    X
+      21 |    X     |         |    X    |         |    X
+      22 |          |    X    |    X    |         |    X
+      23 |    X     |    X    |    X    |         |    X
+      24 |          |         |         |    X    |    X
+      25 |    X     |         |         |    X    |    X
+      26 |          |    X    |         |    X    |    X
+      27 |    X     |    X    |         |    X    |    X
+      28 |          |         |    X    |    X    |    X
+      29 |    X     |         |    X    |    X    |    X
+      30 |          |    X    |    X    |    X    |    X
+      31 |    X     |    X    |    X    |    X    |    X
+
+.TP
+\fB\-\-vtop\fR \fIvirtual_address\fR
+This option is useful, when user debugs the translation problem
+of virtual address. If specifing \fIvirtual_address\fR, its physical
+address is printed. It makes debugging easy by comparing the
+output of this option with the one of "vtop" subcommand of the
+crash utility.
+"--vtop" option only prints the translation output, and it does
+not affect the dumpfile creation.
+
+.TP
+\fB\-\-dump-dmesg\fR
+This option overrides the normal behavior of makedumpfile.  Instead of
+compressing and filtering a \fIVMCORE\fR to make it smaller, it simply
+extracts the dmesg log from a \fIVMCORE\fR and writes it to the specified
+\fILOGFILE\fR. If a \fIVMCORE\fR does not contain \fIVMCOREINFO\fR for dmesg,
+it is necessary to specfiy [\-x \fIVMLINUX\fR] or [\-i \fIVMCOREINFO\fR].
+
+.br
+.B Example:
+.br
+# makedumpfile \-\-dump-dmesg /proc/vmcore dmesgfile
+.br
+# makedumpfile \-\-dump-dmesg -x vmlinux /proc/vmcore dmesgfile
+.br
+
+
+.TP
+\fB\-\-partial-dmesg\fR
+This option will make --dump-dmesg extract only dmesg logs since that buffer was
+last cleared on the crashed kernel, through "dmesg --clear" for example.
+
+
+.TP
+\fB\-\-mem-usage\fR
+This option is currently supported on x86_64, arm64, ppc64 and s390x.
+This option is used to show the page numbers of current system in different
+use. It should be executed in 1st kernel. By the help of this, user can know
+how many pages is dumpable when different dump_level is specified. It analyzes
+the 'System Ram' and 'kernel text' program segment of /proc/kcore excluding
+the crashkernel range, then calculates the page number of different kind per
+vmcoreinfo. So currently /proc/kcore need be specified explicitly.
+
+.br
+.B Example:
+.br
+# makedumpfile \-\-mem-usage /proc/kcore
+.br
+
+
+.TP
+\fB\-\-diskset=VMCORE\fR
+Specify multiple \fIVMCORE\fRs created on sadump diskset configuration
+the same number of times as the number of \fIVMCORE\fRs in increasing
+order from left to right.  \fIVMCORE\fRs are assembled into a single
+\fIDUMPFILE.
+
+.br
+.B Example:
+.br
+# makedumpfile \-x vmlinux \-\-diskset=vmcore1 \-\-diskset=vmcore2 dumpfile
+
+.TP
+\fB\-D\fR
+Print debugging message.
+
+.TP
+\fB\-h (\-\-help)\fR
+Show help message and LZO/snappy support status (enabled/disabled).
+
+.TP
+\fB\-v\fR
+Show the version of makedumpfile.
+
+.TP
+\fB\-\-check-params\fR
+Only check whether the command-line parameters are valid or not, and exit.
+Preferable to be given as the first parameter.
+
+.TP
+\fB\-\-dry-run\fR
+Do not write the output dump file while still performing operations specified
+by other options.
+This option cannot be used with the --dump-dmesg, --reassemble and -g options.
+
+.TP
+\fB\-\-show-stats\fR
+Display report messages. This is an alternative to enabling bit 4 in the level
+provided to --message-level.
+
+.SH ENVIRONMENT VARIABLES
+
+.TP 8
+.B TMPDIR
+This environment variable is used in 1st kernel environment for a temporary memory bitmap file.
+If your machine has a lots of memory and you use small tmpfs on /tmp, makedumpfile
+can fail for a little memory because makedumpfile makes a very large temporary
+memory bitmap file in this case. To avoid this failure, you should specify
+--work-dir option to use file system on storage for the bitmap file.
+
+.SH DIAGNOSTICS
+makedumpfile exits with the following value.
+.TP
+\fB0\fR : makedumpfile succeeded.
+.TP
+\fB1\fR : makedumpfile failed without the following reasons.
+.TP
+\fB2\fR : makedumpfile failed due to the different version between  \fIVMLINUX\fR and \fIVMCORE\fR.
+
+.SH AUTHORS
+.PP
+Written by Masaki Tachibana, and Ken'ichi Ohmichi.
+
+.SH SEE ALSO
+.PP
+crash(8), gdb(1), kexec(8), makedumpfile.conf(5)
+
diff --git a/makedumpfile.conf.5.in b/makedumpfile.conf.5.in
new file mode 100644
index 0000000..54e1be8
--- /dev/null
+++ b/makedumpfile.conf.5.in
@@ -0,0 +1,419 @@
+.TH MAKEDUMPFILE.CONF 5 "@DATE@" "makedumpfile v at VERSION@" "Linux System Administrator's Manual"
+.SH NAME
+makedumpfile.conf \- The filter configuration file for makedumpfile(8).
+.SH DESCRIPTION
+.PP
+The makedumpfile.conf is a configuration file for makedumpfile tool.
+makedumpfile.conf file contains the erase commands to filter out desired kernel
+data from the vmcore while creating \fIDUMPFILE\fR using makedumpfile tool.
+makedumpfile reads the filter config and builds the list of memory addresses
+and its sizes after processing filter commands. The memory locations that
+require to be filtered out are then poisoned with character \fIX\fR (58 in Hex).
+.SH FILE FORMAT
+.PP
+The file consists of module sections that contains filter commands. A section
+begins with the name of the section in square brackets and continues until the
+next section begins.
+
+.br
+"["<\fIModuleName\fR>"]"
+.br
+<\fIFilterCommands\fR>
+.br
+
+where
+.br
+"[" is the character \fB[\fR
+.br
+"]" is the character \fB]\fR
+.TP
+<\fIModuleName\fR>
+is either 'vmlinux' or name of a Linux kernel module.
+.TP
+<\fIFilterCommands\fR>
+is a list of one or more filter commands as described in the section
+\fBFILTER COMMANDS\fR of this manual page.
+.PP
+The section name indicates a kernel module name (including \fBvmlinux\fR) where
+the symbols specified in subsequent erase commands belong to. The unnamed
+section defaults to \fB[vmlinux]\fR section. However, a user can also explicitly
+define \fB[vmlinux]\fR section. The sections help makedumpfile tool to select
+appropriate kernel or module debuginfo file before processing the subsequent
+erase commands. Before selecting appropriate debuginfo file, the module name
+is validated against the loaded modules from the vmcore. If no match is found,
+then the section is ignored and makedumpfile skips to the next module section.
+If match is found, then makedumpfile will try to load the corresponding
+module debuginfo file. If module debuginfo is not available then, makedumpfile
+will skip the section with a warning message.
+.SH FILTER COMMANDS
+.SS filter command
+.PP
+A filter command is either an erase command or a loop construct. Each erase
+command and loop construct must start with a new line. Each filter command
+describes data in the dump to be erased. Syntax:
+
+.br
+<\fIEraseCommands\fR>|<\fILoopConstruct\fR>
+.br
+
+where
+.TP
+<\fIEraseCommands\fR>
+Described in the subsection \fBerase command\fR of this manual page.
+.TP
+<\fILoopConstruct\fR>
+Described in the subsection \fBLoop construct\fR of this manual page.
+.SS erase command
+.PP
+Erase specified size of a kernel data referred by specified kernel/module
+symbol or its member component. The erase command syntax is:
+
+.br
+\fBerase\fR <\fISymbol\fR>[.\fImember\fR[...]] [\fBsize\fR
+<\fISizeValue\fR>[K|M]]
+.br
+\fBerase\fR <\fISymbol\fR>[.\fImember\fR[...]] [\fBsize\fR <\fISizeSymbol\fR>]
+.br
+\fBerase\fR <\fISymbol\fR>[.\fImember\fR[...]] [\fBnullify\fR]
+.br
+
+where
+.br
+.TP
+<\fISymbol\fR>
+A kernel or module symbol (variable) name that is part of global symbols
+\fB/proc/kallsyms\fR.
+.TP
+<\fISizeValue\fR>
+A positive integer value as a size of the data in bytes to be erased. The
+suffixes 'K' and 'M' can be used to specify kilobytes and Megabytes
+respectively where, K means 1024 bytes and M means 1024 ^ 2 = 1048576 bytes.
+The suffixes are not case sensitive.
+.TP
+<\fISizeSymbol\fR>
+A simple expression of the form <\fISymbol\fR>[.\fImember\fR[...]] that denotes
+a symbol which contains a positive integer value as a size of the data in bytes
+to be erased.
+.TP
+<\fISymbol\fR>[.\fImember\fR[...]]
+A simple expression that results into either a global kernel symbol name or
+its member components. The expression always uses '.' operator to specify
+the \fImember\fR component of kernel symbol or its member irrespective of
+whether it is of pointer type or not.
+.TP
+\fImember\fR[...]
+Member or component of member in <\fISymbol\fR>.
+.PP
+The \fBerase\fR command takes two arguments 1. kernel symbol name or its
+member components and 2. size of the data referred by argument (1) OR
+\fBnullify\fR keyword. The second argument \fBsize\fR OR \fBnullify\fR is
+optional. The unit for size value is in \fBbytes\fR. If \fBsize\fR option is
+not specified then the size of the first argument is determined according to
+its data type using dwarf info from debuginfo file. In case of '\fBchar *\fR'
+data type, the length of string pointed by '\fBchar *\fR' pointer is determined
+with an upper limit of 1024. The \fBsize\fR can be specified in two forms 1.
+a integer value as explained above (<\fISizeValue\fR>) and 2. a simple
+expression in the form of <\fISymbol\fR>[.\fImember\fR[...]]] that results into
+base type (integer) variable.
+.PP
+If the specified <\fISymbol\fR> is of type '\fBvoid *\fR', then user needs to
+provide either \fBsize\fR or \fBnullify\fR option, otherwise the erase command
+will not have any effect.
+.PP
+The \fBnullify\fR option only works if specified <\fISymbol\fR> is a pointer.
+Instead of erasing data pointed by the specified pointer \fBnullify\fR erases
+the pointer value and set it to '0' (NULL). Please note that by nullifying
+the pointer values may affect the debug ability of created \fIDUMPFILE\fR.
+Use the \fBnullify\fR option only when the size of data to be erased is not
+known.  \fBe.g.\fR data pointed by '\fBvoid *\fR'.
+.PP
+Let us look at the makedumpfile.conf file from the example below which was
+configured to erase desired kernel data from the kernel module with name
+\fBmymodule\fR. At line 1 and 3, the user has not specified size option while
+erasing 'array_var' and 'mystruct1.name' symbols. Instead the user depends on
+makedumpfile to automatically determine the sizes to be erased \fBi.e\fR
+100 bytes for 'array_var' and 11 bytes for 'mystruct1.name'.  At line 2,
+while erasing the 'mystruct1.buffer' member the user has specified the size
+value 25 against the actual size of 50. In this case the user specified
+\fBsize\fR takes the precedence and makedumpfile erases only 25 bytes from
+\'mystruct1.buffer'. At line 4, the size of the data pointed by \fBvoid *\fR
+pointer 'mystruct1.addr' is unknown. Hence the \fBnullify\fR option has been
+specified to reset the pointer value to NULL. At line 5, the
+\'mystruct2.addr_size' is specified as \fBsize\fR argument to determine the
+size of the data pointed by \fBvoid *\fR pointer 'mystruct2.addr'.
+.br
+
+.B Example:
+.PP
+Assuming the following piece of code is from kernel module 'mymodule':
+.br
+
+struct s1 {
+.br
+	char *name;
+.br
+	void *addr1;
+.br
+	void *addr2;
+.br
+	char buffer[50];
+.br
+};
+.br
+struct s2 {
+.br
+	void *addr;
+.br
+	long addr_size;
+.br
+};
+.br
+
+/* Global symbols */
+.br
+char array_var[100];
+.br
+struct s1 mystruct1;
+.br
+struct s2 *mystruct2;
+.br
+
+int foo()
+.br
+{
+.br
+	...
+.br
+	s1.name = "Hello World";
+.br
+	...
+.br
+}
+.br
+
+\fBmakedumpfile.conf:\fR
+.br
+[mymodule]
+.br
+erase array_var
+.br
+erase mystruct1.buffer size 25
+.br
+erase mystruct1.name
+.br
+erase mystruct1.addr1 nullify
+.br
+# Assuming addr2 points to 1024 bytes
+.br
+erase mystruct1.addr2 size 1K
+.br
+erase mystruct2.addr size mystruct2.addr_size
+.br
+.B EOF
+
+.SS Loop construct
+.PP
+A Loop construct allows the user to traverse the linked list or array elements
+and erase the data contents referred by each element.
+
+.br
+\fBfor\fR <\fIid\fR> \fBin\fR {<\fIArrayVar\fR> |
+.br
+		   <\fIStructVar\fR> \fBvia\fR <\fINextMember\fR> |
+.br
+		   <\fIListHeadVar\fR> \fBwithin\fR
+<\fIStructName\fR>\fB:\fR<\fIListHeadMember\fR>}
+.br
+	\fBerase\fR <\fIid\fR>[.\fIMemberExpression\fR]
+[\fBsize\fR <\fISizeExpression\fR>|\fBnullify\fR]
+.br
+	[\fBerase\fR <\fIid\fR>...]
+.br
+	[...]
+.br
+\fBendfor\fR
+.PP
+where
+.PP
+.TP
+<\fIid\fR>
+Arbitrary name used to temporarily point to elements of the list. This is
+also called iteration variable.
+.TP
+<\fIArrayVar\fR>
+A simple expression in the form of <\fISymbol\fR>[.\fImember\fR[...]] that
+results into an array variable.
+.TP
+<\fIStructVar\fR>
+A simple expression in the form of <\fISymbol\fR>[.\fImember\fR[...]] that
+results into a variable that points to a structure.
+.TP
+<\fINextMember\fR>
+Member within <\fIStructVar\fR> that points to an object of same type that of
+<\fIStructVar\fR>.
+.TP
+<\fIListHeadVar\fR>
+A simple expression in the form of <\fISymbol\fR>[.\fImember\fR[...]] that
+results into a variable of type struct list_head.
+.TP
+<\fIStructName\fR>
+Name of the structure type that can be traversed using HEAD variable
+<\fIListHeadVar\fR> and contains a member named <\fIListHeadMember\fR>.
+.TP
+<\fIListHeadMember\fR>
+Name of a member in <\fIStructName\fR>, of type struct list_head.
+.TP
+<\fIMemberExpression\fR>
+A simple expression in the form of [.\fImember\fR[...]] to specify a member
+or component of an element in <\fIArrayVar\fR>, <\fIStructVar\fR>
+or <\fIStructName\fR>.
+.TP
+<\fISizeExpression\fR>
+Size value in the form of <\fISizeValue\fR>, <\fIid\fR>[.\fIMemberExpression\fR]
+or <\fISymbol\fR>[.\fImember\fR[...]].
+.PP
+The \fBfor\fR loop construct allows to iterate on list of elements in an array
+or linked lists. Each element in the list is assigned to iteration variable
+<\fIid\fR>. The type of the iteration variable is determined by that of the
+list elements. The entry specified after '\fBin\fR' terminal is called LIST
+entry. The LIST entry can be an array variable, structure variable/pointer or a
+struct list_head type variable. The set of \fBerase\fR commands specified
+between \fBfor\fR and \fBendfor\fR, will be executed for each element in the
+LIST entry.
+.PP
+If the LIST entry specified is an array variable, then the loop will be
+executed for each array element. The size of the array will be determined by
+using dwarf information.
+.PP
+If the LIST entry specified is a structure variable/pointer, then a traversal
+member (<\fINextMember\fR>) must be specified using '\fBvia\fR' terminal. The
+\fBfor\fR loop will continue until the value of traversal member is NULL or
+matches with address of the first node <\fIStructVar\fR> if it is a circular
+linked list.
+.PP
+If the LIST entry is specified using a struct list_head type variable, then
+\fBwithin\fR terminal must be used to specify the structure name
+<\fIStructName\fR> that is surrounding to it along with the struct list_head
+type member after '\fB:\fR' which is part of the linked list. In the erase
+statement <\fIid\fR> then denotes the structure that the list_head is
+contained in (ELEMENT_OF).
+.PP
+The below example illustrates how to use loop construct for traversing
+Array, linked list via next member and list_head.
+
+.B Example:
+.PP
+Assuming following piece of code is from kernel module 'mymodule':
+.br
+
+struct s1 {
+.br
+	struct *next;
+.br
+	struct list_head list;
+.br
+	char private[100];
+.br
+	void *key;
+.br
+	long key_size;
+.br
+};
+.br
+
+/* Global symbols */
+.br
+struct s1 mystruct1;
+.br
+static LIST_HEAD(s1_list_head);
+.br
+struct s1 myarray[100];
+.br
+
+void foo()
+.br
+{
+.br
+	struct s1 *s1_ptr;
+.br
+	...
+.br
+	...
+.br
+	s1_ptr = malloc(...);
+.br
+	...
+.br
+	...
+.br
+	list_add(&s1_ptr->list, &s1_list_head);
+.br
+	...
+.br
+}
+.br
+
+\fBmakedumpfile.conf:\fR
+.br
+[mymodule]
+.br
+# erase private fields from list starting with mystruct1 connected via
+.br
+# 'next' member:
+.br
+for mys1 in mystruct1 via next
+.br
+	erase mys1.private
+.br
+	erase mys1.key size mys1.key_size
+.br
+endfor
+.br
+
+# erase private fields from list starting with list_head variable
+.br
+# s1_list_head.
+.br
+for mys1 in s1_list_head.next within s1:list
+.br
+	erase mys1.private
+.br
+	erase mys1.key size mys1.key_size
+.br
+endfor
+.br
+
+# erase private fields from all elements of the array myarray:
+.br
+for mys1 in myarray
+.br
+	erase mys1.private
+.br
+	erase mys1.key size mys1.key_size
+.br
+endfor
+.br
+.B EOF
+.PP
+In the above example, the first \fBfor\fR construct traverses the linked list
+through a specified structure variable \fBmystruct1\fR of type \fBstruct s1\fR.
+The linked list can be traversed using '\fBnext\fR' member of \fBmystruct1\fR.
+Hence a \fBvia\fR terminal has been used to specify the traversal member
+name '\fBnext\fR'.
+.PP
+The second \fBfor\fR construct traverses the linked list through a specified
+struct list_head variable \fBs1_list_head.next\fR. The global symbol
+\fBs1_list_head\fR is a start address of the linked list and its \fBnext\fR
+member points to the address of struct list_head type member '\fBlist\fR' from
+\fBstruct s1\fR. Hence a \fBwithin\fR terminal is used to specify the structure
+name '\fBs1\fR' that can be traversed using \fBs1_list_head.next\fR variable
+along with the name of struct list_head type member '\fBlist\fR' which is part
+of the linked list that starts from \fBs1_list_head\fR global symbol.
+.PP
+The third \fBfor\fR construct traverses the array elements specified through
+a array variable \fBmyarray\fR.
+.br
+.SH SEE ALSO
+.PP
+makedumpfile(8)
+
-- 
2.35.1


