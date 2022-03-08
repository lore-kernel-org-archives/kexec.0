From: David Wysochanski <dwysocha@redhat.com>
Date: Tue, 8 Mar 2022 12:16:18 -0500
Subject: [PATCH 0/3] makedumpfile: harden parsing of old prink buffer
In-Reply-To: <20220307172322.7909-1-prudo@redhat.com>
References: <20220307172322.7909-1-prudo@redhat.com>
Message-ID: <CALF+zOmA3N9cZa6R=RFZ-K6F2T=xYrevRNxHYtxhu4vcm3fPog@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Mar 7, 2022 at 12:23 PM Philipp Rudo <prudo@redhat.com> wrote:
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
> Philipp Rudo (3):
>   makedumpfile: add generic cycle detection
>   makedumpfile: use pointer arithmetics for dump_dmesg
>   makedumpfile: use cycle detection when parsing the prink log_buf
>
>  Makefile       |  2 +-
>  detect_cycle.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  detect_cycle.h | 40 ++++++++++++++++++++
>  makedumpfile.c | 65 +++++++++++++++++++++++++--------
>  4 files changed, 190 insertions(+), 16 deletions(-)
>  create mode 100644 detect_cycle.c
>  create mode 100644 detect_cycle.h
>
> --
> 2.35.1
>

You can add
Tested-by: Dave Wysochanski <dwysocha@redhat.com>

As I mentioned in the Red Hat bug, for my testing, I ran over 1,000
vmcores as a test set comparing "makedumpfile --dump-dmesg" output and
saw no difference.  Then I ran the one vmcore we found the loop on,
and with these patches the loop was correctly detected and
makedumpfile terminated rather than running forever.

I'm still reviewing code a bit and may have a few minor bits of
feedback in a few days.  However, I don't offhand see anything that
sticks out as wrong so far the code looks good.

Thanks for doing this patchset.


