Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTlWs-0005rS-6F
 for kexec@lists.infradead.org; Thu, 23 May 2019 11:05:00 +0000
Received: by mail-it1-f196.google.com with SMTP id j17so7992382itk.0
 for <kexec@lists.infradead.org>; Thu, 23 May 2019 04:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190520061834.32231-1-kasong@redhat.com>
 <0c0fb7af-f386-bde1-46f6-1afa29782243@redhat.com>
In-Reply-To: <0c0fb7af-f386-bde1-46f6-1afa29782243@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Thu, 23 May 2019 19:04:36 +0800
Message-ID: <CACPcB9fWsOHGhyF-b4emTuoTUO4twbG6of=bruBYop4Jf4rzig@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>

On Thu, May 23, 2019 at 2:44 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> On 05/20/2019 11:48 AM, Kairui Song wrote:
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
> >   Update from V1:
> >    - Use bool parameter to turn it on/off instead of letting user give
> >      the size limit. Size of device dump is hard to determine.
> >
> >   Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
> >   fs/proc/vmcore.c                                | 13 +++++++++++++
> >   2 files changed, 28 insertions(+)
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
> > +                     Format: {"off" | "on"}
> > +                     If CONFIG_PROC_VMCORE_DEVICE_DUMP is set,
> > +                     this parameter allows enable or disable device dump
> > +                     for vmcore.
>
> We can add a simpler description here, something like:
>                         Depends on CONFIG_PROC_VMCORE_DEVICE_DUMP
>
> > +                     Device dump allows drivers to append dump data to
> > +                     vmcore so you can collect driver specified debug info.
> > +                     Note that the drivers could append the data without
> > +                     any limit, and the data is stored in memory, this may
> > +                     bring a significant memory stress. If you want to turn
> > +                     on this option, make sure you have reserved enough memory
> > +                     with crashkernel= parameter.
> > +                     default: off
>
> ... and massage the rest of text accordingly.
>
> Better to also modify the help text for 'PROC_VMCORE_DEVICE_DUMP' config
> option defined in 'fs/proc/Kconfig'. Something like:
>
> config PROC_VMCORE_DEVICE_DUMP
>         bool "Device Hardware/Firmware Log Collection"
> <..snip..>
>           If you say Y here, the collected device dumps will be added
>           as ELF notes to /proc/vmcore.
>
>           If this option is selected, device dump collection can still be
> disabled by passing vmcore_device_dump=off to the kernel.
>
> See config INTEL_IOMMU_DEFAULT_ON in 'drivers/iommu/Kconfig' as an example.
>

Good suggestion! I'll update in V3.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
