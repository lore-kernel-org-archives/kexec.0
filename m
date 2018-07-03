Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faMiR-00068u-M4
 for kexec@lists.infradead.org; Tue, 03 Jul 2018 14:55:41 +0000
Date: Tue, 3 Jul 2018 22:55:03 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Message-ID: <20180703145503.GA1225@MiWiFi-R3L-srv>
References: <20180612032831.29747-1-bhe@redhat.com>
 <20180612032831.29747-2-bhe@redhat.com>
 <CAHp75Vd6v4+RTq-5uw_BJpT6=w2KGjTfU+rEst6+8igs2cyntw@mail.gmail.com>
 <20180612093812.GC1820@MiWiFi-R3L-srv>
 <CAHp75Vf_kBLkE6v=JyOdfNoWktWEfKs7JzRP1XEc4TeuT5xqfw@mail.gmail.com>
 <CAHp75Vdaqj+n=F7wSB9PFGpf9Ok2XZzKcq_H0DzmtjmN-4UUfw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHp75Vdaqj+n=F7wSB9PFGpf9Ok2XZzKcq_H0DzmtjmN-4UUfw@mail.gmail.com>
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
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, brijesh.singh@amd.com, devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, richard.weiyang@gmail.com, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, baiyaowei@cmss.chinamobile.com, KY Srinivasan <kys@microsoft.com>, Frank Rowand <frowand.list@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org, Michael Ellerman <mpe@ellerman.id.au>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input <linux-input@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>, Borislav Petkov <bp@suse.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Haiyang Zhang <haiyangz@microsoft.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Josh Triplett <josh@joshtriplett.org>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Biederman <ebiederm@xmission.com>, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, kbuild test robot <fengguang.wu@intel.com>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>

Hi Andy,

On 06/12/18 at 05:24pm, Andy Shevchenko wrote:
> On Tue, Jun 12, 2018 at 5:20 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >> Hmm, I just copied it from arch/powerpc/kernel/pci-common.c. The
> >> function interface expects an integer returned value, not sure what a
> >> real error codes look like, could you give more hints? Will change
> >> accordingly.
> >
> > I briefly looked at the code and error codes we have, so, my proposal
> > is one of the following
> 
> >  - use -ECANCELED (not the best choice for first occurrence here,
> > though I can't find better)
> 
> Actually -ENOTSUPP might suit the first case (although the actual
> would be something like -EOVERLAP, which we don't have)

Sorry for late reply, and many thanks for your great suggestion.

I am fine to use -ENOTSUPP as the first returned value, and -ECANCELED
for the 2nd one. Or define an enum as you suggested inside the function
or in header file.

Or use -EBUSY for the first case because existing resource is
overlapping but not fully contained by 'res'; and -EINVAL for
the 2nd case since didn't find any one resources which is contained by
'res', means we passed in a invalid resource. 

All is fine to me, I can repost with each of them.

Thanks
Baoquan

> 
> >  - use positive integers (or enum), like
> >   #define RES_REPARENTED 0
> >   #define RES_OVERLAPPED 1
> >   #define RES_NOCONFLICT 2
> >
> >
> >>> > +               if (firstpp == NULL)
> >>> > +                       firstpp = pp;
> >>> > +       }
> >>>
> >>> > +       if (firstpp == NULL)
> >>> > +               return -1;      /* didn't find any conflicting entries? */
> >>>
> >>> Ditto.
> >
> > Ditto.
> >
> >>>
> >>> > +}
> >>> > +EXPORT_SYMBOL(reparent_resources);
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
