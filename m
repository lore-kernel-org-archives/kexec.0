Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XXQcn-0004aH-Rd
 for kexec@lists.infradead.org; Fri, 26 Sep 2014 08:11:34 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 26 Sep 2014 09:11:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4A1E82190046
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 09:10:38 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8Q8AxFL24510704
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 08:10:59 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8Q8AxuW012753
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 02:10:59 -0600
Date: Fri, 26 Sep 2014 10:10:57 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: Add "--mem-usage" support for s390x
Message-ID: <20140926101057.14549a12@holzheu>
In-Reply-To: <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On Thu, 25 Sep 2014 17:44:12 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 09/24/14 at 05:19pm, Michael Holzheu wrote:
> > On Tue, 23 Sep 2014 10:40:58 +0800
> > Baoquan He <bhe@redhat.com> wrote:

[snip]

> > > 
> > > Hi Michael, 
> > > 
> > > Please alse provide a get_versiondep_info_s390x since page_offset is
> > > needed in set_kcore_vmcoreinfo() and other information need it too, such
> > > as VMALLOC_START/VMEMMAP_START/MODULES_VADDR, if you want to provide a
> > > is_vmalloc_addr_s390x before initial() is called.
> > 
> > Hello Baoquan,
> > 
> > Thanks for the hint! I looked into the x86_64 implementation of 
> > get_versiondep_info() where version dependent constants are used
> > for vmalloc_start and others.
> > 
> > For s390x this is not so easy because vmalloc_start is dependent
> > on the memory size of the system (see setup_memory_end()
> > in arch/s390/kernel/setup.c). Unfortunately "info->max_mapnr"
> > is not set at that time.
> 
> I am not aware of s390 arch and memory layout. But I can explain what
> those versiondep_info are used for, hope they can help. In fact in
> x86_64, page_offset is got for set_kcore_vmcoreinfo(), there the
> vmcoreinfo_addr need be converted to kvaddr. Since vmcoreinfo_addr is a
> physical addr, we can't use it directly. And
> VMALLOC_START/VMEMMAP_START/MODULES_VADDR are all used to filter this
> virtual addr space region since our vmcore only care about the physical
> ram addr region.
> 
> If you need get these before they are used for s390 arch. If necessary
> you can build a different code flow if you can achive the goal. All
> these are all used to get dumpable load segments from kcore.

Isn't this a chicken-and-egg problem? In order to determine vmalloc start
I have to be able to read memory. But in order to read memory I have
to call get_kcore_dump_loads() first.

What about using /proc/iomem to find out if an address is a real address?

The following patch seems to work for me:
---
 elf_info.c     |    4 ++--
 makedumpfile.c |   26 ++++++++++++++++++++++++++
 makedumpfile.h |    1 +
 3 files changed, 29 insertions(+), 2 deletions(-)

--- a/elf_info.c
+++ b/elf_info.c
@@ -854,7 +854,7 @@ int get_kcore_dump_loads(void)
 
 	for (i = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
-		if (is_vmalloc_addr(p->virt_start))
+		if (!is_real_addr(p->virt_start))
 			continue;
 		loads++;
 	}
@@ -874,7 +874,7 @@ int get_kcore_dump_loads(void)
 
 	for (i = 0, j = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
-		if (is_vmalloc_addr(p->virt_start))
+		if (!is_real_addr(p->virt_start))
 			continue;
 		if (j >= loads)
 			return FALSE;
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -9227,6 +9227,32 @@ int is_crashkernel_mem_reserved(void)
 	return !!crash_reserved_mem_nr;
 }
 
+struct addr_check {
+	unsigned long addr;
+	int found;
+};
+
+static int real_addr_callback(void *data, int nr, char *str,
+			      unsigned long base, unsigned long length)
+{
+	struct addr_check *addr_check = data;
+	unsigned long addr = addr_check->addr;
+
+	if (addr >= base && addr < base + length) {
+		addr_check->found = 1;
+		return -1;
+	}
+	return 0;
+}
+
+int is_real_addr(unsigned long addr)
+{
+	struct addr_check addr_check = {addr, 0};
+
+	iomem_for_each_line("System RAM\n", real_addr_callback, &addr_check);
+	return addr_check.found;
+}
+
 static int get_page_offset(void)
 {
 	struct utsname utsname;
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1567,6 +1567,7 @@ int read_disk_dump_header(struct disk_du
 int read_kdump_sub_header(struct kdump_sub_header *kh, char *filename);
 void close_vmcoreinfo(void);
 int close_files_for_creating_dumpfile(void);
+int is_real_addr(unsigned long addr);
 
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
