Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hRBbj-0003C3-8q
 for kexec@lists.infradead.org; Thu, 16 May 2019 08:19:20 +0000
Received: by mail-it1-f193.google.com with SMTP id e184so4800026ite.1
 for <kexec@lists.infradead.org>; Thu, 16 May 2019 01:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190510102051.25647-1-kasong@redhat.com>
 <4f453ec6-67a6-2c8f-2aab-acb54ae55645@redhat.com>
In-Reply-To: <4f453ec6-67a6-2c8f-2aab-acb54ae55645@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Thu, 16 May 2019 16:19:06 +0800
Message-ID: <CACPcB9d-h75MEMrjREe7sMvjRqvxBhGxaeR3_k7An2-BDsDy4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] vmcore: Add a kernel cmdline device_dump_limit
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "David S . Miller" <davem@davemloft.net>, Ganesh Goudar <ganeshgr@chelsio.com>

On Fri, May 10, 2019 at 7:17 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Kairui,
>
> Thanks for the patch. Please see my comments in-line:
>
> On 05/10/2019 03:50 PM, Kairui Song wrote:
> > Device dump allow drivers to add device related dump data to vmcore as
> > they want. This have a potential issue, the data is stored in memory,
> > drivers may append too much data and use too much memory. The vmcore is
> > typically used in a kdump kernel which runs in a pre-reserved small
> > chunk of memory. So as a result it will make kdump unusable at all due
> > to OOM issues.
> >
> > So introduce new device_dump_limit= kernel parameter, and set the
> > default limit to 0, so device dump is not enabled unless user specify
> > the accetable maxiam
>
>        ^^^^ acceptable maximum

Will fix this typo.

>
> > memory usage for device dump data. In this way user
> > will also have the chance to adjust the kdump reserved memory
> > accordingly.
>
> Hmmm., this doesn't give much confidence with the
> PROC_VMCORE_DEVICE_DUMP feature in its current shape. Rather shouldn't
> we be enabling config PROC_VMCORE_DEVICE_DUMP only under EXPERT mode for
> now, considering that this feature needs further thrashing and testing
> with real setups including platforms where drivers append large amounts
> of data to vmcore:

I think no need to move it to expert mode, just leave it disabled by
default should be better, that should be enough to make sure driver
won't append that much memory and cause OOM, while it could still be
enabled without changing the kernel, so this feature won't bring extra
risk, and could be enabled anytime easily.

>
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 817c02b13b1d..c47a12cf7fc0 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -45,7 +45,7 @@ config PROC_VMCORE
>           Exports the dump image of crashed kernel in ELF format.
>
>   config PROC_VMCORE_DEVICE_DUMP
> -       bool "Device Hardware/Firmware Log Collection"
> +       bool "Device Hardware/Firmware Log Collection" if EXPERT
>          depends on PROC_VMCORE
>          default n
>          help
> @@ -59,6 +59,12 @@ config PROC_VMCORE_DEVICE_DUMP
>            If you say Y here, the collected device dumps will be added
>            as ELF notes to /proc/vmcore.
>
> +         Considering that there can be device drivers which append
> +         large amounts of data to vmcore, you should say N here unless
> +         you are reserving a large chunk of memory for crashdump
> +         kernel, because otherwise the crashdump kernel might become
> +         unusable due to OOM issues.
> +
>
> May be you can add a 'Fixes:' tag here.

Problem is previous commit seems not broken, just bring extra memory
stress. Is "Fixes:" tag suitable for this commit?

>
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >   fs/proc/vmcore.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 3fe90443c1bb..e28695ef2439 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
> >   /* Device Dump list and mutex to synchronize access to list */
> >   static LIST_HEAD(vmcoredd_list);
> >   static DEFINE_MUTEX(vmcoredd_mutex);
> > +
> > +/* Device Dump Limit */
> > +static size_t vmcoredd_limit;
> >   #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >   /* Device Dump Size */
> > @@ -1465,6 +1468,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
> >                           PAGE_SIZE);
> >
> > +     if (vmcoredd_orig_sz + data_size >= vmcoredd_limit) {
> > +             ret = -ENOMEM;
>
> Should we be adding a WARN() here to let the user know that the device
> dump data will not be available in vmcore?

Yes, that could be very helpful. How about pr_err_once? WARN is too
noise, just give a hint to the user that device dump is disabled
should be enough, so user will know why device dump data is not
present and will just enable it.

>
> > +             goto out_err;
> > +     }
> > +
> >       /* Allocate buffer for driver's to write their dumps */
> >       buf = vmcore_alloc_buf(data_size);
> >       if (!buf) {
> > @@ -1502,6 +1510,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       return ret;
> >   }
> >   EXPORT_SYMBOL(vmcore_add_device_dump);
> > +
> > +static int __init parse_vmcoredd_limit(char *arg)
> > +{
> > +     char *end;
> > +
> > +     if (!arg)
> > +             return -EINVAL;
> > +     vmcoredd_limit = memparse(arg, &end);
> > +     return end > arg ? 0 : -EINVAL;
> > +
> > +}
> > +__setup("device_dump_limit=", parse_vmcoredd_limit);
>
> We should be adding this boot argument and its description to
> 'Documentation/admin-guide/kernel-parameters.txt'

Good suggestion, will update the document.

>
> >   #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >   /* Free all dumps in vmcore device dump list */
> >
>
> Thanks,
> Bhupesh

Thanks for the review!



--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
