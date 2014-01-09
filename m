Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1IPq-00026m-5G
 for kexec@lists.infradead.org; Thu, 09 Jan 2014 16:25:06 +0000
Date: Thu, 9 Jan 2014 11:24:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
Message-ID: <20140109162427.GF25897@redhat.com>
References: <52CD6E33.400@redhat.com> <20140108155829.GC13649@redhat.com>
 <8500545.JVNPnKcyD1@vostro.rjw.lan>
 <1389226308.1792.39.camel@misato.fc.hp.com>
 <20140109145035.GB25897@redhat.com>
 <1389283439.1792.66.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389283439.1792.66.camel@misato.fc.hp.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Baoquan <bhe@redhat.com>, kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com, linux-acpi@vger.kernel.org, zhangyanfei@cn.fujitsu.com, dyoung@redhat.com

On Thu, Jan 09, 2014 at 09:03:59AM -0700, Toshi Kani wrote:

[..]
> > > > > So basically acpi thinks that some memory block is a hot plug memory
> > > > > and tries to add it. And that consumes lots of memory and we don't have
> > > > > that memory in second kernel.
> > > > 
> > > > That's not exactly the case.  What seems to happen is that there is an ACPI
> > > > memory object in the ACPI namespace and the ACPI memory hotplug driver
> > > > attempts to bind to it.  That driver attempts to find removable memory blocks
> > > > associated with that object and to add them to the memory map.
> > > > 
> > > > Why don't you simply append acpi=off to the kexec command line?  That should
> > > > make the problem go away.
> > > 
> > > Yes, that should work, but Baoquan's approach makes sense to me.  When
> > > memmap=exactmap is specified, the kernel should ignore any memory
> > > information from the firmware.
> > 
> > memmap=exactmap is only for E820 map. It does not say that later memory
> > can not be hotplugged. So to me specifying exactmap does not imply that
> > memory hotplugging is disabled.
> 
> There are multiple ways to describe memory range info in the firmware;
> e820, EFI memory descriptor table, and ACPI memory device objects.  They
> basically provide the same info.

So ACPI memory device objects contain all the memory ranges as exported
in E820?

> 
> This problem happens when the firmware implements ACPI memory device
> objects, which are necessary to support memory hotplug, but do not mean
> that the system always supports hotplug when they exist.  They are
> optional objects that firmware vendors may choose to implement.

This is confusing. So even if memory hotplug is not supported, ACPI memory
device objects might be present. What's the purpose? How do they help.

If they represent same info as firmware provided using a BIOS call early
(E820 map), then how does system later avoid adding same memory ranges.

IOW, in terms of design, what's the objective. Why to create this
additional path of getting memory information.

> 
> While the exactmap option does not imply that memory hotplug is
> disabled,

But Bao's approach will disable memory hotplug on exactmap.

> it does require that the kernel only consumes user-supplied
> memory range information.  Hence, Baoquan's approach makes sense to me.

I am fine with this as long as memmap=exactmap is not the only way to
disable memory hotplug. I need another way too so that users who are
not using exactmap can still disable memory hotplug.

> 
> > IMO, it makes sense to have a separate knob to disable memory hotplug
> > behavior.
> 
> Regular users do not know if their systems implement ACPI memory device
> objects or not.  So, asking users to specify a separate option when
> their systems implement ACPI memory objects is tricky, IMO.

They can always specify no_memory_hotplug, irrespective of the fact that
kernel supports memory hotplug or not.

Anyway, I don't mind if one implicitly disables memory hotplug if
memmap=exactmap or mem=X is specified. It is just a matter of figuring
how what should be a more intutive behavior from user's point of view.

But I do want a separate path to disable memory hotplug so that even 
if I am not using memmap=exactmap or mem=X, I should be able to disable
memory hotplug.
 
> 
> > Also from kdump point of view, I don't want to rely on exactmap as in 
> > new implementation I am planning to move away from exactmap. I will
> > pass new memory map in bootparams and stop passing it on command line.
> 
> I think we still need a flag that indicates the kernel can only consume
> the new memory map in bootparams, and cannot to obtain from the
> firmware.

I think creating a new command line option is simpler as compared to
creating a new flag in bootparam which in turn disables memory hotplug.
More users can use that option. For example, if for some reason hotplug
code is crashing, one can just disable it on command line as work around
and move on.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
