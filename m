Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UECxZ-0007uj-W0
 for kexec@lists.infradead.org; Sat, 09 Mar 2013 06:08:48 +0000
Date: Sat, 09 Mar 2013 15:08:05 +0900 (JST)
Message-Id: <20130309.150805.363182260.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC] makedumpfile: Improve reading speed with mmap()
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130308113332.12c1d2e83e973e652757eaf0@mxc.nes.nec.co.jp>
References: <20130306.181349.528423566.d.hatayama@jp.fujitsu.com>
 <20130308.104518.339920543.d.hatayama@jp.fujitsu.com>
 <20130308113332.12c1d2e83e973e652757eaf0@mxc.nes.nec.co.jp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, cpw@sgi.com, lisa.mitchell@hp.com, vgoyal@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC] makedumpfile: Improve reading speed with mmap()
Date: Fri, 8 Mar 2013 11:33:32 +0900

> Hello HATAYAMA-san,
> 
> On Fri, 08 Mar 2013 10:45:18 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> Subject: Re: [RFC] makedumpfile: Improve reading speed with mmap()
>> Date: Wed, 6 Mar 2013 18:13:50 +0900
>> 
>> > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> > Subject: [RFC] makedumpfile: Improve reading speed with mmap()
>> > Date: Wed, 6 Mar 2013 15:48:04 +0900
>> > 
>> >> Hello,
>> >> 
>> >> I made the prototype patch to use mmap() on /proc/vmcore for
>> >> benchmarking.
>> >> 
>> >> This patch simply replaces read(2) with mmap(2), I think we can see
>> >> the pure performance improvement by reducing the number of map/unmap.
>> >> 
>> >>   - When /proc/vmcore supports mmap(), readmem() calls read_with_mmap() 
>> >>     to read /proc/vmcore with mmap() instead of read().
>> >> 
>> >>   - Introduce --map-size <Kbyte> option to specify the map size.
>> >>     This option is necessary to use mmap() in this patch, but just for
>> >>     benchmarking. I'll remove this option in release version and change
>> >>     the map size into suitable constant size to get enough performance
>> >>     improvement.
>> >> 
>> >>   - This patch is based on devel branch:
>> >>     http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/devel
>> >> 
>> >> Unfortunately, I haven't done test and benchmarking in 2nd kernel yet
>> >> because I can't start up newer kernel as 2nd kernel on my machine.
>> >> (It seems just my environment issue.) 
>> >> 
>> >> At least, this patch works for vmcores saved on local disk,
>> >> so it will work in 2nd kernel too.
>> >> 
>> >> If anyone helps to do benchmarking, it's very helpful for me.
>> >> And any comments for this patch are welcome.
>> > 
>> > Kumagai-san,
>> > 
>> > I think it necessary to compare this generic one with the idea
>> > considering virtual memory mapping, which should affect filtering
>> > performance to some degree.
>> > 
>> > http://lists.infradead.org/pipermail/kexec/2013-February/007982.html
>> > 
>> > I guess implementation can relatively be moduler. I'll post a
>> > prorotype patch for benchmark later.
>> 
>> Sorry, I investigated this around again and now I think this generic
>> one is enough if size of mmap() range is large enough more than 2MB
>> that is page size used for mapping virtual memory mapping.
>> 
>> So, let's benchmark this version.
>> 
>> BTW, I think it useful to prepare a temporary branch for this
>> benchmark for people who help benchmark. It's awkward to manage
>> patches manually.
> 
> Yes, I thought that I should prepare such a branch when the patch for
> benchmark is fixed, and now is the time.
> 
>> 
>> Also, I posted the following patch yesterday. The v2 patch for mmap()
>> on /proc/vmcore needs this since new note type is added in
>> "VMCOREINFO" name.
>> 
>> [PATCH 0/3] makedumpfile, elf: distinguish ELF note types by ELF note names
>> http://lists.infradead.org/pipermail/kexec/2013-March/008136.html
> 
> Now, I can't get the chance to review the patch set above.
> But, anyway, I created the branch "mmap":
> 
> http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/mmap
> 
> Please use it for benchmark.

Thanks! It's very helpful.

Also, I tested a little the mmap branch code and found a small bug
that max file offset used in calculating mmap()'s position is
wrong. Please see the next patch.

# But sorry, I made this quickly so I didn't consider design enough.

From 77ef0e836bba4713bfb578949d2785962179d630 Mon Sep 17 00:00:00 2001
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Sat, 9 Mar 2013 13:49:43 +0900
Subject: [PATCH] makedumpfile: fix max offset relative to file

To see file offset of each memory chunk, it's correct to read p_offset
in the corresponing PT_LOAD entrie.

On /proc/vmcore PT_LOAD entries are sorted on p_load values in
increasing order. So, it's sufficient to refer to the last PT_LOAD
entry only. But the code here doesn't assuming that, calculating
maximum one from all the PT_LOAD entries.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 elf_info.c     | 12 ++++++++++++
 elf_info.h     |  2 ++
 makedumpfile.c |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/elf_info.c b/elf_info.c
index 9bd8cd0..aa8cacb 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -45,6 +45,7 @@ struct pt_load_segment {
 };
 
 static int			nr_cpus;             /* number of cpu */
+static off_t			max_file_offset;
 
 /*
  * File information about /proc/vmcore:
@@ -637,6 +638,12 @@ get_elf_info(int fd, char *filename)
 			return FALSE;
 		j++;
 	}
+	max_file_offset = 0;
+	for (i = 0; i < num_pt_loads; ++i) {
+		struct pt_load_segment *p = &pt_loads[i];
+		max_file_offset=MAX(max_file_offset,
+				    p->file_offset+p->phys_end-p->phys_start);
+	}
 	if (!has_pt_note()) {
 		ERRMSG("Can't find PT_NOTE Phdr.\n");
 		return FALSE;
@@ -869,3 +876,8 @@ set_eraseinfo(off_t offset, unsigned long size)
 	size_eraseinfo   = size;
 }
 
+off_t
+get_max_file_offset(void)
+{
+	return max_file_offset;
+}
diff --git a/elf_info.h b/elf_info.h
index eb58023..61ab3c9 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -71,6 +71,8 @@ int has_eraseinfo(void);
 void get_eraseinfo(off_t *offset, unsigned long *size);
 void set_eraseinfo(off_t offset, unsigned long size);
 
+off_t get_max_file_offset(void);
+
 #endif  /* ELF_INFO_H */
 
 
diff --git a/makedumpfile.c b/makedumpfile.c
index 3351158..7acbf72 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -235,7 +235,7 @@ static int
 update_mmap_range(off_t offset) {
 	off_t start_offset;
 	off_t map_size;
-	off_t max_offset = info->max_mapnr * info->page_size;
+	off_t max_offset = get_max_file_offset();
 
 	munmap(info->mmap_buf,
 	       info->mmap_end_offset - info->mmap_start_offset);
-- 
1.8.1.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
