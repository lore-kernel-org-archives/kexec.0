From: David Wysochanski <dwysocha@redhat.com>
Date: Wed, 16 Mar 2022 09:17:35 -0400
Subject: [PATCH v2 0/4] makedumpfile: harden parsing of old prink buffer
In-Reply-To: <20220314160432.9414-1-prudo@redhat.com>
References: <20220314160432.9414-1-prudo@redhat.com>
Message-ID: <CALF+zOmis2fGgQXh_bW=ZH7C5omNNYuor4B9-AO7SqDSVZ52RQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Mar 14, 2022 at 12:04 PM Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi,
>
> dumping the dmesg can cause an endless loop for the old prink mechanism (>
> v3.5.0 and < v5.10.0) when the log_buf got corrupted. This series fixes those
> cases by adding a cycle detection. The cycle detection is implemented in a
> generic way so that it can be reused in other parts of makedumpfile.
>
> Thanks
> Philipp
>
> v2:
>         * Rename 'idx' to 'ptr'
>         * Also print the non-loop part when a cycle was detected. Such a
>           situation can happen when log_buf wrapped around in the kernel
>           (log_first_idx != 0) and the corruption occurred on an
>           idx < log_first_idx.
>         * Add patch 4 fixing a bug independent from the memory corruption but
>           found while investigating it.
>
> Philipp Rudo (4):
>   makedumpfile: add generic cycle detection
>   makedumpfile: use pointer arithmetics for dump_dmesg
>   makedumpfile: use cycle detection when parsing the prink log_buf
>   makedumpfile: print error when reading with unsupported compression
>
>  Makefile       |   2 +-
>  detect_cycle.c |  99 +++++++++++++++++++++++++++++++++++++
>  detect_cycle.h |  40 +++++++++++++++
>  makedumpfile.c | 131 ++++++++++++++++++++++++++++++++++++++++---------
>  4 files changed, 247 insertions(+), 25 deletions(-)
>  create mode 100644 detect_cycle.c
>  create mode 100644 detect_cycle.h
>
> --
> 2.35.1
>

Thanks for doing v2.  Reviewing / testing this now...


