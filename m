Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDXMZ-0000Y8-ED
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 18:20:04 +0000
Received: by mail-ot1-f70.google.com with SMTP id r18so158261otq.6
 for <kexec@lists.infradead.org>; Wed, 02 Sep 2020 11:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200902073404.1067640-1-rburanyi@google.com>
In-Reply-To: <20200902073404.1067640-1-rburanyi@google.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 2 Sep 2020 23:47:51 +0530
Message-ID: <CACi5LpMPJ_WH9q4fXrUky-bUqbk_AW0djEm71z5m5bins5bTjA@mail.gmail.com>
Subject: Re: [PATCH] kexec: remove the 2GB size limit on initrd file
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
To: Robi Buranyi <rburanyi@google.com>
Cc: Greg Thelen <gthelen@google.com>, kexec mailing list <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

Hi Robi,

On Wed, Sep 2, 2020 at 1:05 PM Robi Buranyi <rburanyi@google.com> wrote:
>
> Enable loading initrd files exceeding the INT_MAX size. Remove the
> INT_MAX limit completely, and let any initrd load if it fits in the
> memory.
>
> Signed-off-by: Robi Buranyi <rburanyi@google.com>
> ---
>  kernel/kexec_file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index ca40bef75a61..659a9d165198 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -222,7 +222,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>         loff_t size;
>
>         ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
> -                                      &size, INT_MAX, READING_KEXEC_IMAGE);
> +                                      &size, 0, READING_KEXEC_IMAGE);
>         if (ret)
>                 return ret;
>         image->kernel_buf_len = size;
> @@ -242,7 +242,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>         /* It is possible that there no initramfs is being loaded */
>         if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>                 ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
> -                                              &size, INT_MAX,
> +                                              &size, 0,
>                                                READING_KEXEC_INITRAMFS);
>                 if (ret)
>                         goto out;
> --
> 2.28.0.402.g5ffc5be6b7-goog

Can you share some background about this fix? For example why is it
needed or what is failing at your end?
I think a 2GB initramfs is a good enough size to accommodate while
loading it via kexec_file_load(). Eventually the initramfs to be
loaded is passed via user-space as a command line argument to the
kexec_file_load() syscall, so we should be careful about the file
sizes we might be loading here.

I am just trying to understand what initramfs size limits you are
working with from a kexec_file_load() p-o-v.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
