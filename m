Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBmcy-0000tX-SG
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 08:14:49 +0000
Date: Thu, 26 Jun 2008 10:15:26 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
Message-ID: <20080626101526.780af0c0@halley.suse.de>
In-Reply-To: <20080625224301.GE32344@redhat.com>
References: <1214423826-12628-1-git-send-email-bwalle@suse.de>
	<1214423826-12628-2-git-send-email-bwalle@suse.de>
	<20080625224301.GE32344@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com

* Vivek Goyal [2008-06-25 18:43]:
>
> Thanks for the patch. Couple of thoughts.
> 
> Do we really need another CONFIG option (CONFIG_FIRMWARE_MEMMAP)? To,
> me this does not seem to be a big chunk of code at the same time I am
> assuming that most of the people will use it (because of kexec). So
> probably, it might not make lot of sense to put additional CONFIG option.

Agreed.

> [..]
> > +#include <linux/string.h>
> > +#include <linux/firmware-map.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/bootmem.h>
> > +
> > +/*
> > + * String representation of enum firmware_map_type from
> > + * <linux/firmware-map.h>.
> > + */
> > +const char *type_to_string_map[] = {
> > +	"RAM",				/* MAP_RAM */
> > +	"Reserved",			/* MAP_RESERVED */
> > +	"ACPI Tables",			/* MAP_ACPI */
> > +	"Non-volatile Storage",		/* MAP_NVS */
> > +};
> > +
> 
> How about leaving the decision of memory type on arch dependent code? How
> about letting arch code pass you an string while adding entry and that
> string will contain the type of memory. The way request_resource() is
> implemented. 

Also agreed, see the resent patch.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
