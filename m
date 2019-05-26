Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hUy97-0003zQ-VB
 for kexec@lists.infradead.org; Sun, 26 May 2019 18:45:27 +0000
Received: by mail-lj1-f193.google.com with SMTP id 14so12785178ljj.5
 for <kexec@lists.infradead.org>; Sun, 26 May 2019 11:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190524062922.26399-1-kasong@redhat.com>
 <20190524125456.GA3342@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190524125456.GA3342@dhcp-128-65.nay.redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 27 May 2019 00:15:11 +0530
Message-ID: <CACi5LpNue+9GVafB-aYxhTNRWf6jbRk9O6Vq8BCQO3EHWrNnrw@mail.gmail.com>
Subject: Re: [PATCH v3] vmcore: Add a kernel parameter vmcore_device_dump
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
To: Kairui Song <kasong@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>

On Fri, May 24, 2019 at 6:25 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 05/24/19 at 02:29pm, Kairui Song wrote:
> > Since commit 2724273e8fd0 ("vmcore: add API to collect hardware dump in
> > second kernel"), drivers is allowed to add device related dump data to
> > vmcore as they want by using the device dump API. This have a potential
> > issue, the data is stored in memory, drivers may append too much data
> > and use too much memory. The vmcore is typically used in a kdump kernel
> > which runs in a pre-reserved small chunk of memory. So as a result it
> > will make kdump unusable at all due to OOM issues.
> >
> > So introduce new vmcore_device_dump= kernel parameter, and disable
> > device dump by default. User can enable it only if device dump data is
> > required for debugging, and have the chance to increase the kdump
> > reserved memory accordingly before device dump fails kdump.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> >
> > ---
> >
> >  Update from V2:
> >   - Improve related docs
> >
> >  Update from V1:
> >   - Use bool parameter to turn it on/off instead of letting user give
> >     the size limit. Size of device dump is hard to determine.
> >
> >  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
> >  fs/proc/Kconfig                                 |  6 ++++--
> >  fs/proc/vmcore.c                                | 13 +++++++++++++
> >  3 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 138f6664b2e2..3706ad9e1d97 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5078,6 +5078,20 @@
> >                       decrease the size and leave more room for directly
> >                       mapped kernel RAM.
> >
> > +     vmcore_device_dump=     [KNL,KDUMP]
> > +                     Format: {"off" | "on"}
> > +                     Depends on CONFIG_PROC_VMCORE_DEVICE_DUMP.
> > +                     This parameter allows enable or disable device dump
> > +                     for vmcore on kernel start-up.
> > +                     Device dump allows drivers to append dump data to
> > +                     vmcore so you can collect driver specified debug info.
> > +                     Note that the drivers could append the data without
> > +                     any limit, and the data is stored in memory, this may
> > +                     bring a significant memory stress. If you want to turn
> > +                     on this option, make sure you have reserved enough memory
> > +                     with crashkernel= parameter.
> > +                     default: off
> > +
> >       vmcp_cma=nn[MG] [KNL,S390]
> >                       Sets the memory size reserved for contiguous memory
> >                       allocations for the vmcp device driver.
> > diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> > index 817c02b13b1d..1a7a38976bb0 100644
> > --- a/fs/proc/Kconfig
> > +++ b/fs/proc/Kconfig
> > @@ -56,8 +56,10 @@ config PROC_VMCORE_DEVICE_DUMP
> >         recovery kernel's initramfs to collect its underlying device
> >         snapshot.
> >
> > -       If you say Y here, the collected device dumps will be added
> > -       as ELF notes to /proc/vmcore.
> > +       If you say Y here, a new kernel parameter 'vmcore_device_dump'
> > +       will be available. You can then enable device dump by passing
>
> "a new kernel parameter 'vmcore_device_dump' will be available" is not
> necessary, "new" is a not a clear word.  I suggest to remove this
> sentence.
>
> s/You can then/You can

I agree with Dave. We are just trying to say here that even if
CONFIG_PROC_VMCORE_DEVICE_DUMP is set to Y, one can still disable the
device dump feature by passing parameter 'vmcore_device_dump=off' to
the kernel.

May be you can use the wording I mentioned in the v2 patch review,
which tried to convey a similar meaning.

With the change addressed:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh


> Otherwise:
>
> Acked-by: Dave Young <dyoung@redhat.com>
>
>
> > +       'vmcore_device_dump=on' to kernel, the collected device dumps
> > +       will be added as ELF notes to /proc/vmcore.
> >
> >  config PROC_SYSCTL
> >       bool "Sysctl support (/proc/sys)" if EXPERT
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 3fe90443c1bb..d1b608b0efad 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -53,6 +53,8 @@ static struct proc_dir_entry *proc_vmcore;
> >  /* Device Dump list and mutex to synchronize access to list */
> >  static LIST_HEAD(vmcoredd_list);
> >  static DEFINE_MUTEX(vmcoredd_mutex);
> > +
> > +static bool vmcoredd_enabled;
> >  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >  /* Device Dump Size */
> > @@ -1451,6 +1453,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       size_t data_size;
> >       int ret;
> >
> > +     if (!vmcoredd_enabled) {
> > +             pr_err_once("Device dump is disabled\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (!data || !strlen(data->dump_name) ||
> >           !data->vmcoredd_callback || !data->size)
> >               return -EINVAL;
> > @@ -1502,6 +1509,12 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(vmcore_add_device_dump);
> > +
> > +static int __init vmcoredd_parse_cmdline(char *arg)
> > +{
> > +     return kstrtobool(arg, &vmcoredd_enabled);
> > +}
> > +__setup("vmcore_device_dump=", vmcoredd_parse_cmdline);
> >  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> >
> >  /* Free all dumps in vmcore device dump list */
> > --
> > 2.21.0
> >
>
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
