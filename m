Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PBjnC-0008Lm-AN
	for kexec@lists.infradead.org; Fri, 29 Oct 2010 07:54:31 +0000
Date: Fri, 29 Oct 2010 09:54:25 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] - make /proc/vmcore accesable on x86_64
Message-ID: <20101029075425.GA1978@jolsa.brq.redhat.com>
References: <20101019150630.GA1870@jolsa.brq.redhat.com>
	<20101022085412.GA8267@verge.net.au>
	<20101028121627.GE16206@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101028121627.GE16206@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Thu, Oct 28, 2010 at 09:16:27PM +0900, Simon Horman wrote:
> On Fri, Oct 22, 2010 at 10:54:12AM +0200, Simon Horman wrote:
> > On Tue, Oct 19, 2010 at 05:06:30PM +0200, Jiri Olsa wrote:

SNIP

> > > My goal is to share data within the host and kexec-ed kernel,
> > > so I'd like to use the /proc/vmcore for that.. any other
> > > ideas are welcome :)
> > 
> > This approach seems reasonable to me.
> > I'll push it if a I don't hear any objections
> > in the near future.
> 
> Hi Jiru,
> 
> could you please submit this as a formal patch with a signed-off-by line?
sure, it's attached

thanks,
jirka
---

hi,

I was playing around with preserve context feature on x86_64
and was not able to get the /proc/vmcore in the kexec-ed
kernel until I aplied attached patch.

If the x86_64 arch returns 0 (KEXEC_ARCH_DEFAULT) then following
condition in load_crashdump_segments function will fill 386 as the
machine for the vmcore elf header..

...

        if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64)
        {
                elf_info.machine = EM_X86_64;
        } else {
                elf_info.machine       = EM_386;
                elf_info.lowmem_limit  = X86_MAXMEM;
                elf_info.get_note_info = get_crash_notes;
        }
...

ending with kexec-ed kernel failing check for the machine,
and disabling vmcore interface.

wbr,
jirka


Signed-off-by: Jiri Olsa <jolsa@redhat.com>
---
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 06e5ae9..40f989a 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -691,6 +691,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 
+	memset(&elf_info, 0x0, sizeof(elf_info));
+
 	/* Constant parts of the elf_info */
 	elf_info.data             = ELFDATA2LSB;
 	elf_info.backup_src_start = BACKUP_SRC_START;
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 3092643..c34fd92 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -134,10 +134,7 @@ int arch_process_options(int argc, char **argv)
 }
 
 const struct arch_map_entry arches[] = {
-	/* For compatibility with older patches
-	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_X86_64 here.
-	 */
-	{ "x86_64", KEXEC_ARCH_DEFAULT },
+	{ "x86_64", KEXEC_ARCH_X86_64 },
 	{ NULL, 0 },
 };
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
