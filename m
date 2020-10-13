Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSQEv-0008EK-Ip
 for kexec@lists.infradead.org; Tue, 13 Oct 2020 19:45:42 +0000
Received: by mail-ot1-f71.google.com with SMTP id n21so271382ota.18
 for <kexec@lists.infradead.org>; Tue, 13 Oct 2020 12:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201012070905.5837-1-jthierry@redhat.com>
 <CACi5LpNSnr+9v_sMPZnCQu14pML6PR1bBLKqj4tVaxk2O9k0wA@mail.gmail.com>
 <f12bb1e2-c984-68d0-f952-d6b7243c8a7e@redhat.com>
In-Reply-To: <f12bb1e2-c984-68d0-f952-d6b7243c8a7e@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 14 Oct 2020 01:15:26 +0530
Message-ID: <CACi5LpM-hCjnFg6Knb57Fr7+zVnTDewYRLAFABeNrd_gy+GhGw@mail.gmail.com>
Subject: Re: [MAKDUMPFILE PATCH] Add option to estimate the size of vmcore
 dump files
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
To: Julien Thierry <jthierry@redhat.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Kazuhito Hagio <k-hagio-ab@nec.com>

Hello Julien,

On Tue, Oct 13, 2020 at 3:23 PM Julien Thierry <jthierry@redhat.com> wrote:
>
> Hi Bhupesh,
>
> On 10/13/20 10:27 AM, Bhupesh Sharma wrote:
> > Hello Julien,
> >
> > Thanks for the patch. Some nitpicks inline:
> >
> > On Mon, Oct 12, 2020 at 12:39 PM Julien Thierry <jthierry@redhat.com> wrote:
> >>
> >> A user might want to know how much space a vmcore file will take on
> >> the system and how much space on their disk should be available to
> >> save it during a crash.
> >>
> >> The option --vmcore-size does not create the vmcore file but provides
> >> an estimation of the size of the final vmcore file created with the
> >> same make dumpfile options.
> >>
> >> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> >> Cc: Kazuhito Hagio <k-hagio-ab@nec.com>
> >> ---
> >>   makedumpfile.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >>   makedumpfile.h | 12 +++++++
> >>   print_info.c   |  4 +++
> >>   3 files changed, 111 insertions(+), 3 deletions(-)
> >
> > Please update 'makedumpfile.8' as well in v2, so that the man page can
> > document the newly added option and how to use it to determine the
> > vmcore-size.
> >
>
> Ah yes, I'll do that.
>
> >> diff --git a/makedumpfile.c b/makedumpfile.c
> >> index 4c4251e..0a2bfba 100644
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -26,6 +26,7 @@
> >>   #include <limits.h>
> >>   #include <assert.h>
> >>   #include <zlib.h>
> >> +#include <libgen.h>
> >
> > I know we don't follow alphabetical order for include files in
> > makedumpfile code, but it would be good to place the new - ones
> > accordingly. So <libgen.h> can go with <limits.h> here.
> >
>
> Noted.
>
> >>   struct symbol_table    symbol_table;
> >>   struct size_table      size_table;
> >> @@ -1366,7 +1367,25 @@ open_dump_file(void)
> >>          if (!info->flag_force)
> >>                  open_flags |= O_EXCL;
> >>
> >> -       if (info->flag_flatten) {
> >> +       if (info->flag_vmcore_size) {
> >> +               char *namecpy;
> >> +               struct stat statbuf;
> >> +               int res;
> >> +
> >> +               namecpy = strdup(info->name_dumpfile ?
> >> +                                info->name_dumpfile : ".");
> >> +
> >> +               res = stat(dirname(namecpy), &statbuf);
> >> +               free(namecpy);
> >> +               if (res != 0)
> >> +                       return FALSE;
> >> +
> >> +               fd = -1;
> >> +               info->dumpsize_info.blksize = statbuf.st_blksize;
> >> +               info->dumpsize_info.block_buff_size = BASE_NUM_BLOCKS;
> >> +               info->dumpsize_info.block_info = calloc(BASE_NUM_BLOCKS, 1);
> >> +               info->dumpsize_info.non_hole_blocks = 0;
> >> +       } else if (info->flag_flatten) {
> >>                  fd = STDOUT_FILENO;
> >>                  info->name_dumpfile = filename_stdout;
> >>          } else if ((fd = open(info->name_dumpfile, open_flags,
> >> @@ -1384,6 +1403,9 @@ check_dump_file(const char *path)
> >>   {
> >>          char *err_str;
> >>
> >> +       if (info->flag_vmcore_size)
> >> +               return TRUE;
> >> +
> >>          if (access(path, F_OK) != 0)
> >>                  return TRUE; /* File does not exist */
> >>          if (info->flag_force) {
> >> @@ -4622,6 +4644,47 @@ write_and_check_space(int fd, void *buf, size_t buf_size, char *file_name)
> >>          return TRUE;
> >>   }
> >>
> >> +static int
> >> +write_buffer_update_size_info(off_t offset, void *buf, size_t buf_size)
> >> +{
> >> +       struct dumpsize_info *dumpsize_info = &info->dumpsize_info;
> >> +       int blk_end_idx = (offset + buf_size - 1) / dumpsize_info->blksize;
> >> +       int i;
> >> +
> >> +       /* Need to grow the dumpsize block buffer? */
> >> +       if (blk_end_idx >= dumpsize_info->block_buff_size) {
> >> +               int alloc_size = MAX(blk_end_idx - dumpsize_info->block_buff_size, BASE_NUM_BLOCKS);
> >> +
> >> +               dumpsize_info->block_info = realloc(dumpsize_info->block_info,
> >> +                                                   dumpsize_info->block_buff_size + alloc_size);
> >> +               if (!dumpsize_info->block_info) {
> >> +                       ERRMSG("Not enough memory\n");
> >> +                       return FALSE;
> >> +               }
> >> +
> >> +               memset(dumpsize_info->block_info + dumpsize_info->block_buff_size,
> >> +                      0, alloc_size);
> >> +               dumpsize_info->block_buff_size += alloc_size;
> >> +       }
> >> +
> >> +       for (i = 0; i < buf_size; ++i) {
> >> +               int blk_idx = (offset + i) / dumpsize_info->blksize;
> >> +
> >> +               if (dumpsize_info->block_info[blk_idx]) {
> >> +                       i += dumpsize_info->blksize;
> >> +                       i = i - (i % dumpsize_info->blksize) - 1;
> >> +                       continue;
> >> +               }
> >> +
> >> +               if (((char *) buf)[i] != 0) {
> >> +                       dumpsize_info->non_hole_blocks++;
> >> +                       dumpsize_info->block_info[blk_idx] = 1;
> >> +               }
> >> +       }
> >> +
> >> +       return TRUE;
> >> +}
> >> +
> >>   int
> >>   write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
> >>   {
> >> @@ -4643,6 +4706,8 @@ write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
> >>                  }
> >>                  if (!write_and_check_space(fd, &fdh, sizeof(fdh), file_name))
> >>                          return FALSE;
> >> +       } else if (info->flag_vmcore_size && fd == info->fd_dumpfile) {
> >> +               return write_buffer_update_size_info(offset, buf, buf_size);
> >>          } else {
> >>                  if (lseek(fd, offset, SEEK_SET) == failed) {
> >>                          ERRMSG("Can't seek the dump file(%s). %s\n",
> >> @@ -9018,6 +9083,12 @@ close_dump_file(void)
> >>          if (info->flag_flatten)
> >>                  return;
> >>
> >> +       if (info->flag_vmcore_size && info->fd_dumpfile == -1) {
> >> +               free(info->dumpsize_info.block_info);
> >> +               info->dumpsize_info.block_info = NULL;
> >> +               return;
> >> +       }
> >> +
> >>          if (close(info->fd_dumpfile) < 0)
> >>                  ERRMSG("Can't close the dump file(%s). %s\n",
> >>                      info->name_dumpfile, strerror(errno));
> >> @@ -10963,6 +11034,12 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
> >>          if (info->flag_flatten && info->flag_split)
> >>                  return FALSE;
> >>
> >> +       if (info->flag_flatten && info->flag_vmcore_size)
> >> +               return FALSE;
> >> +
> >> +       if (info->flag_mem_usage && info->flag_vmcore_size)
> >> +               return FALSE;
> >> +
> >>          if (info->name_filterconfig && !info->name_vmlinux)
> >>                  return FALSE;
> >>
> >> @@ -11043,7 +11120,8 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
> >>                   */
> >>                  info->name_memory   = argv[optind];
> >>
> >> -       } else if ((argc == optind + 1) && info->flag_mem_usage) {
> >> +       } else if ((argc == optind + 1) && (info->flag_mem_usage ||
> >> +                                           info->flag_vmcore_size)) {
> >>                  /*
> >>                  * Parameter for showing the page number of memory
> >>                  * in different use from.
> >> @@ -11423,6 +11501,7 @@ static struct option longopts[] = {
> >>          {"work-dir", required_argument, NULL, OPT_WORKING_DIR},
> >>          {"num-threads", required_argument, NULL, OPT_NUM_THREADS},
> >>          {"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
> >> +       {"vmcore-size", no_argument, NULL, OPT_VMCORE_SIZE},
> >>          {0, 0, 0, 0}
> >>   };
> >>
> >> @@ -11589,6 +11668,9 @@ main(int argc, char *argv[])
> >>                          info->flag_check_params = TRUE;
> >>                          message_level = DEFAULT_MSG_LEVEL;
> >>                          break;
> >> +               case OPT_VMCORE_SIZE:
> >> +                       info->flag_vmcore_size = TRUE;
> >> +                       break;
> >>                  case '?':
> >>                          MSG("Commandline parameter is invalid.\n");
> >>                          MSG("Try `makedumpfile --help' for more information.\n");
> >> @@ -11598,6 +11680,10 @@ main(int argc, char *argv[])
> >>          if (flag_debug)
> >>                  message_level |= ML_PRINT_DEBUG_MSG;
> >>
> >> +       if (info->flag_vmcore_size)
> >> +               /* Suppress progress indicator as dumpfile won't get written */
> >> +               message_level &= ~ML_PRINT_PROGRESS;
> >> +
> >>          if (info->flag_check_params)
> >>                  /* suppress debugging messages */
> >>                  message_level = DEFAULT_MSG_LEVEL;
> >> @@ -11751,7 +11837,11 @@ main(int argc, char *argv[])
> >>                          goto out;
> >>
> >>                  MSG("\n");
> >> -               if (info->flag_split) {
> >> +
> >> +               if (info->flag_vmcore_size) {
> >> +                       MSG("Estimated size to save vmcore is: %lld Bytes\n",
> >> +                           (long long)info->dumpsize_info.non_hole_blocks * info->dumpsize_info.blksize);
> >> +               } else if (info->flag_split) {
> >>                          MSG("The dumpfiles are saved to ");
> >>                          for (i = 0; i < info->num_dumpfile; i++) {
> >>                                  if (i != (info->num_dumpfile - 1))
> >> @@ -11808,6 +11898,8 @@ out:
> >>                          free(info->page_buf);
> >>                  if (info->parallel_info != NULL)
> >>                          free(info->parallel_info);
> >> +               if (info->dumpsize_info.block_info != NULL)
> >> +                       free(info->dumpsize_info.block_info);
> >>                  free(info);
> >>
> >>                  if (splitblock) {
> >> diff --git a/makedumpfile.h b/makedumpfile.h
> >> index 03fb4ce..fd78d5f 100644
> >> --- a/makedumpfile.h
> >> +++ b/makedumpfile.h
> >> @@ -1277,6 +1277,15 @@ struct parallel_info {
> >>   #endif
> >>   };
> >>
> >> +#define BASE_NUM_BLOCKS        50
> >> +
> >> +struct dumpsize_info {
> >> +       int blksize;
> >> +       int block_buff_size;
> >> +       unsigned char *block_info;
> >> +       int non_hole_blocks;
> >> +};
> >> +
> >>   struct ppc64_vmemmap {
> >>          unsigned long           phys;
> >>          unsigned long           virt;
> >> @@ -1321,6 +1330,7 @@ struct DumpInfo {
> >>          int             flag_vmemmap;        /* kernel supports vmemmap address space */
> >>          int             flag_excludevm;      /* -e - excluding unused vmemmap pages */
> >>          int             flag_use_count;      /* _refcount is named _count in struct page */
> >> +       int             flag_vmcore_size;    /* estimate the size of the vmcore file instead of creating it */
> >>          unsigned long   vaddr_for_vtop;      /* virtual address for debugging */
> >>          long            page_size;           /* size of page */
> >>          long            page_shift;
> >> @@ -1425,6 +1435,7 @@ struct DumpInfo {
> >>          int                     num_dumpfile;
> >>          struct splitting_info   *splitting_info;
> >>          struct parallel_info    *parallel_info;
> >> +       struct dumpsize_info    dumpsize_info;
> >>
> >>          /*
> >>           * bitmap info:
> >> @@ -2364,6 +2375,7 @@ struct elf_prstatus {
> >>   #define OPT_NUM_THREADS         OPT_START+16
> >>   #define OPT_PARTIAL_DMESG       OPT_START+17
> >>   #define OPT_CHECK_PARAMS        OPT_START+18
> >> +#define OPT_VMCORE_SIZE         OPT_START+19
> >>
> >>   /*
> >>    * Function Prototype.
> >> diff --git a/print_info.c b/print_info.c
> >> index e0c38b4..6f5a165 100644
> >> --- a/print_info.c
> >> +++ b/print_info.c
> >> @@ -308,6 +308,10 @@ print_usage(void)
> >>          MSG("      the crashkernel range, then calculates the page number of different kind per\n");
> >>          MSG("      vmcoreinfo. So currently /proc/kcore need be specified explicitly.\n");
> >>          MSG("\n");
> >> +       MSG("  [--vmcore-size]:\n");
> >> +       MSG("      This option provides an estimation of the size needed to save VMCORE on disk.\n");
> >> +       MSG("      This option option cannot be used in combination with -F.\n");
> >
> > Also not in combination with --mem-usage (as per the code changes above)?
> > And may be the options '--mem-usage / -F' also need an update to
> > mention they can't be used with --vmcore-size option.
> >
>
> Good point, I'll update those.
>
> >> +       MSG("\n");
> >>          MSG("  [-D]:\n");
> >>          MSG("      Print debugging message.\n");
> >>          MSG("\n");
> >> --
> >
> > I like the idea, but sometimes we use makedumpfile to generate a
> > dumpfile in the primary kernel as well. For example:
> >
> > $ makedumpfile -d 31 -x vmlinux /proc/kcore dumpfile
> >
> > In such use-cases it is useful to use --vmcore-size and still generate
> > the dumpfile (right now the default behaviour is not to generate a
> > dumpfile when --vmcore-size is specified). Maybe we need to think more
> > on supporting this use-case as well.
> >
>
> The thing is, if you are generating the dumpfile, you can just check the
> size of the file created with "du -b" or some other command.

I agree, but I just was looking to replace the two  'makedumpfile +
du' steps with a single 'makedumpfile --vmcore-size' step.

> Overall I don't mind supporting your case as well. Maybe that can depend
> on whether a vmcore/dumpfile filename is provided:
>
> $ makedumpfile -d 31 -x vmlinux /proc/kcore    # only estimates the size
>
> $ makedumpfile -d 31 -x vmlinux /proc/kcore dumpfile  # writes the
> dumpfile and gives the final size
>
> Any thought, opinions, suggestions?

Let's wait for Kazu's opinion on the same, but I am ok with using a
two-step 'makedumpfile + du' approach for now (and later expand
--vmcore-size as we encounter more use-cases).

@Kazuhito Hagio : What's your opinion on the above?

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
