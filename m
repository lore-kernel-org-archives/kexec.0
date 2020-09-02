Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDXok-0003h9-Vk
 for kexec@lists.infradead.org; Wed, 02 Sep 2020 18:49:12 +0000
Received: by mail-oi1-x244.google.com with SMTP id i17so339831oig.10
 for <kexec@lists.infradead.org>; Wed, 02 Sep 2020 11:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200902073404.1067640-1-rburanyi@google.com>
 <CACi5LpMPJ_WH9q4fXrUky-bUqbk_AW0djEm71z5m5bins5bTjA@mail.gmail.com>
 <CANF=oU6+c6eT9sNcxV7cKDuf2bmHRC=x=Vh8y-1q=xm_VWDj9Q@mail.gmail.com>
In-Reply-To: <CANF=oU6+c6eT9sNcxV7cKDuf2bmHRC=x=Vh8y-1q=xm_VWDj9Q@mail.gmail.com>
From: Robi Buranyi <rburanyi@google.com>
Date: Wed, 2 Sep 2020 11:48:57 -0700
Message-ID: <CANF=oU4xWqrE89JzPAMWrockTCR+hHz_fm1Yx5aF9z_git-Bmg@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Greg Thelen <gthelen@google.com>, kexec mailing list <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

On Wed, Sep 2, 2020 at 11:41 AM Robi Buranyi <rburanyi@google.com> wrote:
>
>
>
> On Wed, Sep 2, 2020 at 11:18 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>>
>> Hi Robi,
>>
>> On Wed, Sep 2, 2020 at 1:05 PM Robi Buranyi <rburanyi@google.com> wrote:
>> >
>> > Enable loading initrd files exceeding the INT_MAX size. Remove the
>> > INT_MAX limit completely, and let any initrd load if it fits in the
>> > memory.
>> >
>> > Signed-off-by: Robi Buranyi <rburanyi@google.com>
>> > ---
>> >  kernel/kexec_file.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> > index ca40bef75a61..659a9d165198 100644
>> > --- a/kernel/kexec_file.c
>> > +++ b/kernel/kexec_file.c
>> > @@ -222,7 +222,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>> >         loff_t size;
>> >
>> >         ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
>> > -                                      &size, INT_MAX, READING_KEXEC_IMAGE);
>> > +                                      &size, 0, READING_KEXEC_IMAGE);
>> >         if (ret)
>> >                 return ret;
>> >         image->kernel_buf_len = size;
>> > @@ -242,7 +242,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>> >         /* It is possible that there no initramfs is being loaded */
>> >         if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>> >                 ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
>> > -                                              &size, INT_MAX,
>> > +                                              &size, 0,
>> >                                                READING_KEXEC_INITRAMFS);
>> >                 if (ret)
>> >                         goto out;
>> > --
>> > 2.28.0.402.g5ffc5be6b7-goog
>>
>> Can you share some background about this fix? For example why is it
>> needed or what is failing at your end?
>> I think a 2GB initramfs is a good enough size to accommodate while
>> loading it via kexec_file_load(). Eventually the initramfs to be
>> loaded is passed via user-space as a command line argument to the
>> kexec_file_load() syscall, so we should be careful about the file
>> sizes we might be loading here.
>>
>> I am just trying to understand what initramfs size limits you are
>> working with from a kexec_file_load() p-o-v.
>>
>> Thanks,
>> Bhupesh
>>
>
> Hello Bhupesh,
>
>  Sure, and thank you very much for the question. I will do my best to anwer.
>
>  I am experimenting with netbooting larger images of various distros. I am looking for standalone configurations where I would like to have the system booted without dependencies to NFS/CIFS shares and just have 'everything' on ramdisk. In the netboot configuration I'm using, it's a u-root bootloader (https://github.com/u-root/u-root) kexec-ing into this netboot image. The machine HW configuration I have is typically several hundreds of GB RAM with 100Gb+ network interface(s).
>  To sum up: I am netbooting (kexec-ing) from a 'tiny' 32MB linux bootloader image into a huge 2GB+ linux image.
>
>  My problem with the 2GB limit in the current kexec is, that in my opinion it's somehow arbitrary selection and does not have to do with any architectural limitations any more. If a user wants to use a bigger image (and has the necessary memory to load the image) - the kernel should not limit it in my opinion. I was looking at other invocations of kernel_read_file(...) - which this kernel_read_file_from_fd comes down to - and there are also other use cases with no limit specified. I see your point about being specified as a command line argument, but if you let's say you have a system with several terabytes of DDR, what's the point in limiting the user at 2GB? We could increase the limit to 8GB for now (and that would be certainly sufficient for a while) - but then we would possibly have the same discussion in a few years again.
>
>  Does it answer your question?
>
> Thanks, Robi

Hello Bhupesh,

 Sure, and thank you very much for the question. I will do my best to anwer.

 I am experimenting with netbooting larger images of various distros.
I am looking for standalone configurations where I would like to have
the system booted without dependencies to NFS/CIFS shares and just
have 'everything' on ramdisk. In the netboot configuration I'm using,
it's a u-root bootloader (https://github.com/u-root/u-root) kexec-ing
into this netboot image. The machine HW configuration I have is
typically several hundreds of GB RAM with 100Gb+ network interface(s).
 To sum up: I am netbooting (kexec-ing) from a 'tiny' 32MB linux
bootloader image into a huge 2GB+ linux image.

 My problem with the 2GB limit in the current kexec is, that in my
opinion it's somehow arbitrary selection and does not have to do with
any architectural limitations any more. If a user wants to use a
bigger image (and has the necessary memory to load the image) - the
kernel should not limit it in my opinion. I was looking at other
invocations of kernel_read_file(...) - which this
kernel_read_file_from_fd comes down to - and there are also other use
cases with no limit specified. I see your point about being specified
as a command line argument, but if you let's say you have a system
with several terabytes of DDR, what's the point in limiting the user
at 2GB? We could increase the limit to 8GB for now (and that would be
certainly sufficient for a while) - but then we would possibly have
the same discussion in a few years again.

 Does it answer your question?

Thanks, Robi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
