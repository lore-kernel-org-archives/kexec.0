Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBXSG-0000QA-A6
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 16:02:44 +0000
Date: Wed, 25 Jun 2008 18:03:19 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 3/3] Limit E820 map when a user-defined memory map is
	specified
Message-ID: <20080625180319.122819ea@halley.suse.de>
In-Reply-To: <86802c440806250901n68278ab1ma1add38c165122af@mail.gmail.com>
References: <1214395342-20375-1-git-send-email-bwalle@suse.de>
	<1214395342-20375-4-git-send-email-bwalle@suse.de>
	<86802c440806250901n68278ab1ma1add38c165122af@mail.gmail.com>
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
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* Yinghai Lu [2008-06-25 09:01]:
> On Wed, Jun 25, 2008 at 5:02 AM, Bernhard Walle <bwalle@suse.de> wrote:
> >  }
> >  early_param("mem", parse_memopt);
> > @@ -1023,6 +1025,7 @@ static int __init parse_memmap_opt(char *p)
> >                e820_add_region(start_at, mem_size, E820_RESERVED);
> >        } else {
> >                end_user_pfn = (mem_size >> PAGE_SHIFT);
> > +               e820_update_range(mem_size, ULLONG_MAX, E820_RAM, E820_RESERVED);
> >        }
> >        return *p == '\0' ? 0 : -EINVAL;
> >  }
> > --
> 
> only this one is needed now. but please change ULLONG_MAX to
> ULLONG_MAX - mem_size

Why can't we add that check at the beginning of e820_update_range() as
you suggested?


Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
