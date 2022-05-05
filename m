From: Baoquan He <bhe@redhat.com>
Date: Thu, 5 May 2022 19:04:02 +0800
Subject: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <e677f11b-32f9-0c89-9592-b987b00c4353@linux.ibm.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
 <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
 <6f3a6cbb-0ac4-f178-fc17-18f9594da319@linux.ibm.com>
 <YmeBjrChOHsIYG3e@MiWiFi-R3L-srv>
 <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
 <YnNkgfnHlUTky0lt@MiWiFi-R3L-srv>
 <e677f11b-32f9-0c89-9592-b987b00c4353@linux.ibm.com>
Message-ID: <YnOvIuSRZX1cct4Y@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/05/22 at 03:29pm, Sourabh Jain wrote:
> 
> On 05/05/22 11:15, Baoquan He wrote:
> > On 04/28/22 at 10:48am, Sourabh Jain wrote:
> > > Hi Baoquan,
> > > 
> > > On 26/04/22 10:52, Baoquan He wrote:
> > > > On 04/26/22 at 09:36am, Sourabh Jain wrote:
> > > > > On 15/04/22 03:59, Eric DeVolder wrote:
> > ......
> > 
> > > > > > > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > > > > > > +static int crash_memhp_notifier(struct notifier_block *nb,
> > > > > > > > +??? unsigned long val, void *v)
> > > > > > > > +{
> > > > > > > > +??? struct memory_notify *mhp = v;
> > > > > > > > +
> > > > > > > > +??? switch (val) {
> > > > > > > > +??? case MEM_ONLINE:
> > > > > > > > +??????? crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
> > > > > > > We don't differentiate the memory add/remove, cpu add, except of cpu
> > > > > > > remove. Means the hp_action only differentiate cpu remove from the other
> > > > > > > action. Maybe only making two types?
> > > > > > > 
> > > > > > > #define KEXEC_CRASH_HP_REMOVE_CPU?? 0
> > > > > > > #define KEXEC_CRASH_HP_UPDATE_OTHER????? 1
> > > > > > > 
> > > > > > Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and
> > > > > > ADD_MEMORY.
> > > > > > Do you still want to consolidate these?
> > > > > On PowerPC different actions are needed for CPU add and memory add/remove.
> > > > > For CPU add case only FDT is updated whereas for the memory hotplug we will
> > > > > be
> > > > > updating FDT and elfcorehdr.
> > > > I don't understand. For elfcorehdr updating, we only need regenerate it.
> > > > Do you update them different for memory add/remove?
> > > We have different actions for cpu remove, CPU add and memory add/remove
> > > case.
> > > 
> > > CPU remove: no action
> > > CPU add: update flattened device tree (FDT)
> > > memory add/remove: update FDT and regenerate/update elfcorehdr
> > > 
> > > Since memory add/remove action is same we can have common hp_action for
> > > them.
> > For memory hot add/remove, we need rengereate elfcorehdr, and add the
> > new elfcorehdr into fdt. Except of this, FDT need to know the hp_action
> > and the hot added/removed memory region, namely the start and end, e.g
> > [start, end]?
> > 
> > I checked arm64 kexec code, seems we only need to know if mem hotplug
> > event happened, then regenerate elfcorehdr and embed the new elfcorehdr
> > into fdt. Then we don't know pass the [start, end] info into the
> > handler. Please tell if ppc is different or I missed anything.
> 
> Yes we don't need start and end info as such but we expect arch
> handler to have info about which hotplug action is performed.
> It is just that I don't see an significant advantage of consolidation of
> CPU ADD, memory ADD and Memory REMOVE in one hp_action as
> KEXEC_CRASH_HP_UPDATE_OTHER.

I see. I don't oppose all those passed info, just worried the
unnecessary info passed down to the handler.

> 
> > If I am right, I would like the handler interface as Boris has made
> > in his draft patch.
> > 
> > void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
> >                                             unsigned int cpu)
> > 
> > static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> The above template works fine for PowerPC as long we have four different
> hp_action
> to indicate CPU add/remove and memory add/remove.

Cool. Then all things are clear. We can pass the needed hp_action and
cpu number only.

Hi Eric,

The consensus is reached, please proceed when it's convenient.


