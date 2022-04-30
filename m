From: Dave Young <dyoung@redhat.com>
Date: Sat, 30 Apr 2022 12:00:08 +0800
Subject: [PATCH 0/4] Printbufs & shrinker OOM reporting
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
Message-ID: <CALu+AoSP8QASexVOsJqbiqNH-HcdcJHjBd-=t1EJZ7sPUVTK=w@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Kent,
On Fri, 22 Apr 2022 at 07:56, Kent Overstreet <kent.overstreet@gmail.com> wrote:
>
> Debugging OOMs has been one of my sources of frustration, so this patch series
> is an attempt to do something about it.
>
> The first patch in the series is something I've been slowly evolving in bcachefs
> for years: simple heap allocated strings meant for appending to and building up
> structured log/error messages. They make it easy and straightforward to write
> pretty-printers for everything, which in turn makes good logging and error
> messages something that just happens naturally.
>
> We want it here because that means the reporting I'm adding to shrinkers can be
> used by both OOM reporting, and for the sysfs (or is it debugfs now) interface
> that Roman is adding.
>

I added the kexec list in cc.  It seems like a nice enhancement to oom
reporting.
I suspect kdump tooling need changes to retrieve the kmsg log from
vmcore, could you confirm it?  For example makedumpfile, crash, and
kexec-tools (its vmcore-dmesg tool).


> This patch series also:
>  - adds OOM reporting on shrinkers, reporting on top 10 shrinkers (in sorted
>    order!)
>  - changes slab reporting to be always-on, also reporting top 10 slabs in sorted
>    order
>  - starts centralizing OOM reporting in mm/show_mem.c
>
> The last patch in the series is only a demonstration of how to implement the
> shrinker .to_text() method, since bcachefs isn't upstream yet.
>
> Kent Overstreet (4):
>   lib/printbuf: New data structure for heap-allocated strings
>   mm: Add a .to_text() method for shrinkers
>   mm: Centralize & improve oom reporting in show_mem.c
>   bcachefs: shrinker.to_text() methods
>
>  fs/bcachefs/btree_cache.c     |  18 ++-
>  fs/bcachefs/btree_key_cache.c |  18 ++-
>  include/linux/printbuf.h      | 140 ++++++++++++++++++
>  include/linux/shrinker.h      |   5 +
>  lib/Makefile                  |   4 +-
>  lib/printbuf.c                | 271 ++++++++++++++++++++++++++++++++++
>  mm/Makefile                   |   2 +-
>  mm/oom_kill.c                 |  23 ---
>  {lib => mm}/show_mem.c        |  14 ++
>  mm/slab.h                     |   6 +-
>  mm/slab_common.c              |  53 ++++++-
>  mm/vmscan.c                   |  75 ++++++++++
>  12 files changed, 587 insertions(+), 42 deletions(-)
>  create mode 100644 include/linux/printbuf.h
>  create mode 100644 lib/printbuf.c
>  rename {lib => mm}/show_mem.c (78%)
>
> --
> 2.35.2
>

Thanks
Dave


