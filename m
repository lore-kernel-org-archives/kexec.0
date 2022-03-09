From: David Wysochanski <dwysocha@redhat.com>
Date: Wed, 9 Mar 2022 03:25:56 -0500
Subject: [PATCH 2/3] makedumpfile: use pointer arithmetics for dump_dmesg
In-Reply-To: <20220307172322.7909-3-prudo@redhat.com>
References: <20220307172322.7909-1-prudo@redhat.com>
 <20220307172322.7909-3-prudo@redhat.com>
Message-ID: <CALF+zOkOyzgaf_QVGrnRCVU+pTde4CNZ_QT1iy9vHYD=hLJNgg@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Mar 7, 2022 at 12:23 PM Philipp Rudo <prudo@redhat.com> wrote:
>
> When parsing the printk buffer for the old printk mechanism (> v3.5.0+ and
> < 5.10.0) a log entry is currently specified by the offset into the
> buffer where the entry starts. Change this to use a pointers instead.
> This is done in preparation for using the new cycle detection mechanism.
>
> Signed-off-by: Philipp Rudo <prudo@redhat.com>
> ---
>  makedumpfile.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 7ed9756..edf128b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5482,13 +5482,10 @@ dump_log_entry(char *logptr, int fp, const char *file_name)
>   * get log record by index; idx must point to valid message.
>   */
>  static char *
> -log_from_idx(unsigned int idx, char *logbuf)
> +log_from_idx(char *logptr, char *logbuf)

How about "log_from_ptr" since 'idx' has special name and you're
changing this to a ptr now?

>  {
> -       char *logptr;
>         unsigned int msglen;
>
> -       logptr = logbuf + idx;
> -
>         /*
>          * A length == 0 record is the end of buffer marker.
>          * Wrap around and return the message at the start of
> @@ -5502,14 +5499,13 @@ log_from_idx(unsigned int idx, char *logbuf)
>         return logptr;
>  }
>
> -static long
> -log_next(unsigned int idx, char *logbuf)
> +static void *
> +log_next(void *_logptr, void *_logbuf)
>  {
> -       char *logptr;
> +       char *logptr = _logptr;
> +       char *logbuf = _logbuf;
>         unsigned int msglen;
>
> -       logptr = logbuf + idx;
> -
>         /*
>          * A length == 0 record is the end of buffer marker. Wrap around and
>          * read the message at the start of the buffer as *this* one, and
> @@ -5519,10 +5515,10 @@ log_next(unsigned int idx, char *logbuf)
>         msglen = USHORT(logptr + OFFSET(printk_log.len));
>         if (!msglen) {
>                 msglen = USHORT(logbuf + OFFSET(printk_log.len));
> -               return msglen;
> +               return logbuf + msglen;
>         }
>
> -       return idx + msglen;
> +       return logptr + msglen;
>  }
>
>  int
> @@ -5530,11 +5526,12 @@ dump_dmesg()
>  {
>         int log_buf_len, length_log, length_oldlog, ret = FALSE;
>         unsigned long index, log_buf, log_end;
> -       unsigned int idx, log_first_idx, log_next_idx;
> +       unsigned int log_first_idx, log_next_idx;
>         unsigned long long first_idx_sym;
>         unsigned long log_end_2_6_24;
>         unsigned      log_end_2_6_25;
>         char *log_buffer = NULL, *log_ptr = NULL;
> +       char *idx;
>
>         /*
>          * log_end has been changed to "unsigned" since linux-2.6.25.
> @@ -5681,8 +5678,8 @@ dump_dmesg()
>                         ERRMSG("Can't open output file.\n");
>                         goto out;
>                 }
> -               idx = log_first_idx;
> -               while (idx != log_next_idx) {
> +               idx = log_buffer + log_first_idx;
> +               while (idx != log_buffer + log_next_idx) {

I would find another name other than "idx" here, maybe just "ptr"?


>                         log_ptr = log_from_idx(idx, log_buffer);
>                         if (!dump_log_entry(log_ptr, info->fd_dumpfile,
>                                             info->name_dumpfile))
> --
> 2.35.1
>


