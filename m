Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZgTqJ-0001yn-Vs
 for kexec@lists.infradead.org; Mon, 28 Sep 2015 08:31:30 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: make --work-dir easier to use
Date: Mon, 28 Sep 2015 08:28:29 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DECC4B@BPXM01GP.gisp.nec.co.jp>
References: <E1ZZ1mw-0008KT-Gf@eag09.americas.sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DE90AB@BPXM01GP.gisp.nec.co.jp>
 <20150910011740.GA25645@sgi.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DE9830@BPXM01GP.gisp.nec.co.jp>
 <20150910121229.GA7379@sgi.com>
In-Reply-To: <20150910121229.GA7379@sgi.com>
Content-Language: ja-JP
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Thu, Sep 10, 2015 at 07:44:02AM +0000, Atsushi Kumagai wrote:
>> >Hello Kumagai,
>> >
>> >On Wed, Sep 09, 2015 at 07:51:50AM +0000, Atsushi Kumagai wrote:
>> >> Hello Cliff,
>> >>
>> >> >From: Cliff Wickman <cpw@sgi.com>
>> >> >
>> >> >This patch enhances the --work-dir feature to make it easier to use.
>> >> >
>> >> >Kumagai, I plan to require the --work-dir for the -e feature, as you suggested.  I did find --work-dir
>> >> >hard to implement because of the differences between the way the various distros mount the root device
>> >> >in the crashkernel. Hence this patch.
>> >> >
>> >> >Currently the --work-dir=<PATH> must be specified in a form that is valid in the crashkernel's environment.
>> >> >In other words, the boot kernel's /var, for example, must be specified as:
>> >> >  RHEL6: /mnt/var/
>> >> >  RHEL7: /sysroot/var/
>> >> >  SLES11: /kdump/0/var/
>> >> >  SLES12: (with root=kdump) /kdump/mnt0/var/
>> >> >And the administrator must remember to create that directory.
>> >> >
>> >> >If these conditions are not met makedumpfile fails, with little explanation as to why.
>> >> >
>> >> >This patch:
>> >> >
>> >> >- Allow the path to be one that is valid in the crashkernel's environment, or allow
>> >> >  it to be valid in the boot kernel's environment.  In the second case, adjust the path to
>> >> >  how the root device is mounted in the crashkernel.
>> >> >  Limitation: The adjustment is only made if a dump file is being written, and the dump is
>> >> >  being written to /var/crash/.  Otherwise you must (as currently) use a path that is known
>> >> >  to be valid in the crashkernel's environment.
>> >> >
>> >> >- Make the directory if it does not already exist.  All components of the path are
>> >> >  made if necessary, similar to mkdir -p.
>> >>
>> >> I think such adjusting should be done in kdump feature side (e.g. kexec-tools) since
>> >> it constructs the crash kernel's environment. Each distro's kdump feature can
>> >> take care of each own environment.
>> >
>> >> Just checking by is_dir() and creating a directory are enough in makedumpfile side.
>> >>
>> >> Thanks,
>> >> Atsushi Kumagai
>> >
>> >I have been looking at how this could be done.
>> >As each distro may mount the root filesystem differently, it would seem to me that
>> >the name must be passed to makedumpfile somehow.  I don't see kexec having a role but
>> >the scripts that make the kdump initrd could.
>> >Am I missing your point in concluding that?
>>
>> Let's say about RHEL, if *path* parameter in kdump.conf is /var/crash,
>> mkdumprd can pass it to --work-dir. Since that path can store vmcore,
>> it must store also bitmaps and makedumpfilepfns.
>>
>> >One could add another option to makedumpfile (maybe --root=<path>).  And then the distro's
>> >scripts could add that option to the makedumpfile command line. But that turns out to be
>> >difficult to do in SLES, as it has its own binary named 'kdumptool' that invokes
>> >makedumpfile and it does not have a way to pass an option to makedumpfile
>> >that is derived at mkdumprd time.  It only passes along options that have been stored
>> >in /etc/sysconfig/kdump.
>> >
>> >Deriving the root path from the dump name is not very reliable if it depends on a
>> >convention that could change.
>> >What is configured in the kdump or kdump.conf file is the "/var/crash" or similar dump
>> >file directory.
>> >I propose to add a --dump-dir option to makedumpfile. The distro script can easily
>> >add --dump-dir=/var/crash to the command line, and then the path to root can be
>> >accurately derived.  If --dump-dir is not specified then --work-dir would have to
>> >be pre-adjusted, as it is currently.
>>
>> Why don't you think --work-dir=/var/crash, it's simple.
>
>In RHEL6 makedumpfile would have to adjust that to /mnt/var/crash.
>In RHEL7, /sysroot/var/crash

The important thing is that the stuff(e.g. mkdumprd) which knows the
mount point(e.g. /mnt/var/crash) also generate the argument of --work-dir
like '--work-dir=/mnt/var/crash'. It's easy way to obtain consistency.

My idea is that a user specify only -e option in a config file (e.g. kdump.conf)
and mkdumprd add --work-dir option internally when -e is specified.

>Yes, passing it as --work-dir=/var/crash is sufficient, as long as
>makedumpfile prepends everything in the dump file name before '/var/crash'
>to the work-dir.  And assuming we are always satisfied to use the dump
>file directory as the work-dir (and that works for me).
>
>So can we do that?  i.e. take --work-dir to be a complete path in the
>crashkernel environment.  And if it does not exist, adjust it using
>the path in the dump name?

The caller side like mkdumprd knows the dump file directory, 
there is no need to extract it from the dump name in makedumpfile side.
I think the fall back path you said is redundant, it's caller side's work.


Thanks,
Atsushi Kumagai

>-Cliff
>>
>>
>> Thanks,
>> Atsushi Kumagai
>>
>> >-Cliff
>> >>
>> >> >---
>> >> > makedumpfile.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >> > makedumpfile.h |    3 -
>> >> > print_info.c   |   15 ++++-
>> >> > 3 files changed, 158 insertions(+), 4 deletions(-)
>> >> >
>> >> >Index: code/makedumpfile.c
>> >> >===================================================================
>> >> >--- code.orig/makedumpfile.c
>> >> >+++ code/makedumpfile.c
>> >> >@@ -25,6 +25,7 @@
>> >> > #include <sys/time.h>
>> >> > #include <limits.h>
>> >> > #include <assert.h>
>> >> >+#include <sys/stat.h>
>> >> >
>> >> > struct symbol_table	symbol_table;
>> >> > struct size_table	size_table;
>> >> >@@ -10364,6 +10365,146 @@ int show_mem_usage(void)
>> >> > 	return TRUE;
>> >> > }
>> >> >
>> >> >+/*
>> >> >+ * return 1 if path is a directory
>> >> >+ * else return 0
>> >> >+ */
>> >> >+int
>> >> >+isdir(char *path)
>> >> >+{
>> >> >+	struct stat buf;
>> >> >+
>> >> >+	if (path) {
>> >> >+		if (stat(path, &buf) || !S_ISDIR(buf.st_mode)) {
>> >> >+			return 0;
>> >> >+		}
>> >> >+		return 1;
>> >> >+	} else {
>> >> >+		return 0;
>> >> >+	}
>> >> >+}
>> >> >+
>> >> >+/*
>> >> >+ * Set info->root_dir to the crashkernel's path to the bootkernel's root
>> >> >+ * or set it to null if that path cannot be determined.
>> >> >+ * We must assume that the dump file is in the bootkernel's /var/crash/
>> >> >+ */
>> >> >+void
>> >> >+set_rootdir()
>> >> >+{
>> >> >+	int len;
>> >> >+	char *cp1, *cp2;
>> >> >+
>> >> >+	/* allow this function to be called multiple times */
>> >> >+	if (info->root_dir)
>> >> >+		return;
>> >> >+
>> >> >+	if (!info->name_dumpfile) {
>> >> >+		info->root_dir = NULL;
>> >> >+		return;
>> >> >+	}
>> >> >+
>> >> >+	len = (int)strlen(info->name_dumpfile);
>> >> >+	if (len == 0) {
>> >> >+		info->root_dir = NULL;
>> >> >+		return;
>> >> >+	}
>> >> >+	info->root_dir = malloc(len);
>> >> >+	cp1 = info->name_dumpfile;
>> >> >+	cp2 = cp1;
>> >> >+	while (*cp2 != '\0') {
>> >> >+		if (!strncmp(cp2, "/var/crash/", 11)) {
>> >> >+			len = cp2 - cp1;
>> >> >+			strncpy(info->root_dir, cp1, len);
>> >> >+			if (!isdir(info->root_dir)) {
>> >> >+				fprintf(stderr, "Error: root directory %s does not exist\n",
>> >> >+					info->root_dir);
>> >> >+				exit(1);
>> >> >+			}
>> >> >+			return;
>> >> >+		}
>> >> >+		cp2++;
>> >> >+	}
>> >> >+	info->root_dir = NULL;
>> >> >+	return;
>> >> >+}
>> >> >+
>> >> >+/*
>> >> >+ * The --work-dir directory should be validated and created if necessary.
>> >> >+ */
>> >> >+void
>> >> >+adjust_working_dir()
>> >> >+{
>> >> >+	int ret, finished=0;
>> >> >+	char *hold, *inter_dir = NULL, *cp1, *cp2;
>> >> >+
>> >> >+	/* if a crashkernel root environment was specified, no adjust is necessary */
>> >> >+	if (isdir(info->working_dir))
>> >> >+		return;
>> >> >+
>> >> >+	set_rootdir();
>> >> >+
>> >> >+	if (!strncmp(info->working_dir, "/", 1)) {
>> >> >+		/* an absolute path should either exist in the crashkernel's
>> >> >+		   root, or should be adjusted to be relative to it */
>> >> >+		if (info->root_dir) {
>> >> >+			hold = malloc(strlen(info->working_dir)+1);
>> >> >+			strcpy(hold, info->working_dir);
>> >> >+			info->working_dir = malloc(strlen(info->root_dir) + strlen(info->working_dir));
>> >> >+			inter_dir = malloc(strlen(info->root_dir) + strlen(info->working_dir));
>> >> >+			strcpy(info->working_dir, info->root_dir);
>> >> >+			strcat(info->working_dir, hold);
>> >> >+			free (hold);
>> >> >+			fprintf(stderr, "--workdir set to %s\n", info->working_dir);
>> >> >+		} else {
>> >> >+			inter_dir = malloc(strlen(info->working_dir));
>> >> >+		}
>> >> >+	} else {
>> >> >+		/* a relative path that does not already exist should be made absolute; it is taken to
>> >> >+		   be relative to the crash kernel's root */
>> >> >+		if (info->root_dir) {
>> >> >+			hold = malloc(strlen(info->working_dir)+1);
>> >> >+			strcpy(hold, info->working_dir);
>> >> >+			info->working_dir = malloc(strlen(info->root_dir) + strlen(info->working_dir) + 1);
>> >> >+			inter_dir = malloc(strlen(info->root_dir) + strlen(info->working_dir) + 1);
>> >> >+			strcpy(info->working_dir, info->root_dir);
>> >> >+			strcat(info->working_dir, "/");
>> >> >+			strcat(info->working_dir, hold);
>> >> >+			free (hold);
>> >> >+			fprintf(stderr, "--workdir set to %s\n", info->working_dir);
>> >> >+		} else {
>> >> >+			inter_dir = malloc(strlen(info->working_dir));
>> >> >+		}
>> >> >+	}
>> >> >+
>> >> >+	/* path is complete, now make sure it exists */
>> >> >+	if (!isdir(info->working_dir)) {
>> >> >+		strcpy(inter_dir, info->working_dir);
>> >> >+		if (info->root_dir)
>> >> >+			cp1 = inter_dir + strlen(info->root_dir) + 1;
>> >> >+		else
>> >> >+			cp1 = inter_dir + 1;
>> >> >+		while (finished == 0) {
>> >> >+			strcpy(inter_dir, info->working_dir);
>> >> >+			cp2 = strchr(cp1, '/');
>> >> >+			if (cp2) {
>> >> >+				*cp2 = '\0';
>> >> >+				cp1 = cp2 + 1;
>> >> >+			} else {
>> >> >+				finished = 1;
>> >> >+			}
>> >> >+			if (!isdir(inter_dir)) {
>> >> >+				ret = mkdir(inter_dir, 0755);
>> >> >+				if (ret) {
>> >> >+					fprintf(stderr, "Error: mkdir(%s, 0755) returned %d\n",
>> >> >+						inter_dir, ret);
>> >> >+					exit(1);
>> >> >+				}
>> >> >+			}
>> >> >+		}
>> >> >+	}
>> >> >+	return;
>> >> >+}
>> >> >
>> >> > static struct option longopts[] = {
>> >> > 	{"split", no_argument, NULL, OPT_SPLIT},
>> >> >@@ -10549,6 +10690,9 @@ main(int argc, char *argv[])
>> >> > 		return COMPLETED;
>> >> > 	}
>> >> >
>> >> >+	if (info->working_dir)
>> >> >+		adjust_working_dir();
>> >> >+
>> >> > 	if (elf_version(EV_CURRENT) == EV_NONE ) {
>> >> > 		/*
>> >> > 		 * library out of date
>> >> >Index: code/makedumpfile.h
>> >> >===================================================================
>> >> >--- code.orig/makedumpfile.h
>> >> >+++ code/makedumpfile.h
>> >> >@@ -1258,7 +1258,8 @@ struct DumpInfo {
>> >> > 	/*
>> >> > 	 * for cyclic processing
>> >> > 	 */
>> >> >-	char	           *working_dir;	     /* working directory for bitmap */
>> >> >+	char	           *working_dir;	/* working directory for bitmap */
>> >> >+	char	           *root_dir;		/* crashkernel path to boot kernel's root */
>> >> > 	mdf_pfn_t          num_dumpable;
>> >> > 	unsigned long      bufsize_cyclic;
>> >> > 	unsigned long      pfn_cyclic;
>> >> >Index: code/print_info.c
>> >> >===================================================================
>> >> >--- code.orig/print_info.c
>> >> >+++ code/print_info.c
>> >> >@@ -221,11 +221,20 @@ print_usage(void)
>> >> > 	MSG("      size is at most N kilo bytes.\n");
>> >> > 	MSG("\n");
>> >> > 	MSG("  [--work-dir]:\n");
>> >> >-	MSG("      Specify the working directory for the temporary bitmap file.\n");
>> >> >-	MSG("      If this option isn't specified, the bitmap will be saved on memory.\n");
>> >> >+	MSG("      Specify the working directory for temporary files such as the bitmap.\n");
>> >> >+	MSG("      If this option isn't specified, the bitmap will be saved in memory.\n");
>> >> > 	MSG("      Filtering processing has to do 2 pass scanning to fix the memory consumption,\n");
>> >> >-	MSG("      but it can be avoided by using working directory on file system.\n");
>> >> >+	MSG("      but it can be avoided by using this working directory on the file system.\n");
>> >> > 	MSG("      So if you specify this option, the filtering speed may be bit faster.\n");
>> >> >+	MSG("      The directory path may be absolute or relative.\n");
>> >> >+	MSG("      If relative, it is taken to be based at the root filesystem.\n");
>> >> >+	MSG("      It may be an existing directory expressed with the path to the root filesystem as\n");
>> >> >+	MSG("      it is mounted in the crashkernel.\n");
>> >> >+	MSG("      Or it may expressed with '/' as the path to the root filesystem. In that case it will\n");
>> >> >+	MSG("      be automatically adjusted to be relative to the root of the crashkernel.\n");
>> >> >+	MSG("      The root of the crashkernel is determined from the dump name, if present. An assumption\n");
>> >> >+	MSG("      is made that the dump file is to be written to /var/crash/.\n");
>> >> >+	MSG("      If the directory does not exist it will be created, including multiple components.\n");
>> >> > 	MSG("\n");
>> >> > 	MSG("  [--non-mmap]:\n");
>> >> > 	MSG("      Never use mmap(2) to read VMCORE even if it supports mmap(2).\n");
>> >
>> >--
>> >Cliff Wickman
>> >SGI
>> >cpw@sgi.com
>> >(651)683-7524 vnet 207524
>> >(651)482-9347 home
>> >
>> >_______________________________________________
>> >kexec mailing list
>> >kexec@lists.infradead.org
>> >http://lists.infradead.org/mailman/listinfo/kexec
>
>--
>Cliff Wickman
>SGI
>cpw@sgi.com
>(651)683-7524 vnet 207524
>(651)482-9347 home

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
