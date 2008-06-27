Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCBoS-0003mZ-CR
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 11:08:20 +0000
Date: Fri, 27 Jun 2008 13:08:57 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
Message-ID: <20080627130857.6d543a75@halley.suse.de>
In-Reply-To: <20080626222458.GA18981@suse.de>
References: <1214511542-28458-1-git-send-email-bwalle@suse.de>
	<1214511542-28458-2-git-send-email-bwalle@suse.de>
	<20080626222458.GA18981@suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Greg KH <gregkh@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, yhlu.kernel@gmail.com

Hi,

* Greg KH [2008-06-26 15:24]:
>
> On Thu, Jun 26, 2008 at 10:19:01PM +0200, Bernhard Walle wrote:
> > This patch adds /sys/firmware/memmap interface that represents the BIOS
> > (or Firmware) provided memory map. The tree looks like:
> > 
> >     /sys/firmware/memmap/0/start   (hex number)
> >                            end     (hex number)
> >                            type    (string)
> >     ...                 /1/start
> >                            end
> >                            type
> 
> Please provide new entries in Documentation/ABI/ for these new sysfs
> files with all of this information.

Yes, I planned that but wanted to get feedback first. It's in the next
resend.

> > +/*
> > + * Firmware memory map entries
> > + */
> > +LIST_HEAD(map_entries);
> 
> Should this be static?

Yes, thanks.

> > +int firmware_map_add(resource_size_t start, resource_size_t end,
> > +		     const char *type)
> > +{
> > +	struct firmware_map_entry *entry;
> > +
> > +	entry = kmalloc(sizeof(struct firmware_map_entry), GFP_ATOMIC);
> > +	WARN_ON(!entry);
> > +	if (!entry)
> > +		return -ENOMEM;
> > +
> > +	return firmware_map_add_entry(start, end, type, entry);
> 
> Where is the kobject initialized properly?
> 
> Ah, later on, that's scary...

Ok, I moved initialisation to firmware_map_add_entry() and add it later
with kobject_add().

> > +static struct kobj_type memmap_ktype = {
> > +	.sysfs_ops	= &memmap_attr_ops,
> > +	.default_attrs	= def_attrs,
> > +};
> 
> Do you really need your own kobj_type here?  What you want is just a
> directory, and some attributes assigned to the kobject, can't you use
> the default kobject attributes for them?
> 
> I'm not saying this is incorrect, it looks implemented properly, just
> curious.

Well, since there are more than one directory with the same attributes,
isn't using kobj_type easier here?

> > +static int __init memmap_init(void)
> > +{
> > +	int i = 0;
> > +	struct firmware_map_entry *entry;
> > +	struct kset *memmap_kset;
> > +
> > +	memmap_kset = kset_create_and_add("memmap", NULL, firmware_kobj);
> > +	WARN_ON(!memmap_kset);
> > +	if (!memmap_kset)
> > +		return -ENOMEM;
> > +
> > +	list_for_each_entry(entry, &map_entries, list) {
> 
> So the list is supposed to be set up before this function is called?  Is
> that because of early boot issues?
> 
> You should document this somehow.

Yes, added a comment to firmware_map_add_early(), firmware_map_add()
and before memmap_init().

> > +/*
> > + * Firmware map entry. Because firmware memory maps are flat and not
> > + * hierarchical, it's ok to organise them in a linked list. No parent
> > + * information is necessary as for the resource tree.
> > + */
> > +struct firmware_map_entry {
> > +	resource_size_t		start;	/* start of the memory range */
> > +	resource_size_t		end;	/* end of the memory range (incl.) */
> > +	const char		*type;	/* type of the memory range */
> > +	struct list_head	list;	/* entry for the linked list */
> > +	struct kobject		kobj;   /* kobject for each entry */
> > +};
> 
> Does this really need to be in the .h file?

No, that was because I modified the API afterwards. Thanks for spotting
that.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
