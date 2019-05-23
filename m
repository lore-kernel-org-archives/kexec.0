Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f67.google.com ([209.85.166.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTlWu-0005ry-QI
 for kexec@lists.infradead.org; Thu, 23 May 2019 11:05:02 +0000
Received: by mail-io1-f67.google.com with SMTP id g84so4510003ioa.1
 for <kexec@lists.infradead.org>; Thu, 23 May 2019 04:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190520061834.32231-1-kasong@redhat.com>
 <20190522053822.GA4472@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190522053822.GA4472@dhcp-128-65.nay.redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Thu, 23 May 2019 19:04:42 +0800
Message-ID: <CACPcB9dM97sFmydswSkpj8nmFHvsWXUhnQJ-8jW2aEc-m7g9qg@mail.gmail.com>
Subject: Re: [PATCH v2] vmcore: Add a kernel cmdline vmcore_device_dump
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
To: Dave Young <dyoung@redhat.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Alexey Dobriyan <adobriyan@gmail.com>

On Wed, May 22, 2019 at 1:38 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 05/20/19 at 02:18pm, Kairui Song wrote:
> > Since commit 2724273e8fd0 ('vmcore: add API to collect hardware dump in
> > second kernel'), drivers is allowed to add device related dump data to
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
> > ---
> >  Update from V1:
> >   - Use bool parameter to turn it on/off instead of letting user give
> >     the size limit. Size of device dump is hard to determine.
> >
> >  Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
> >  fs/proc/vmcore.c                                | 13 +++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 43176340c73d..2d48e39fd080 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5062,6 +5062,21 @@
> >                       decrease the size and leave more room for directly
> >                       mapped kernel RAM.
> >
> > +     vmcore_device_dump=
> > +                     [VMCORE]
>
> It looks better to have above two line merged in one line, also use
> [KNL, KDUMP] will be better.
>
> > +                     Format: {"off" | "on"}
> > +                     If CONFIG_PROC_VMCORE_DEVICE_DUMP is set,
> > +                     this parameter allows enable or disable device dump
> > +                     for vmcore.
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

Good suggestion, I'll update in V3.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
