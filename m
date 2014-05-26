Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WokBN-0006vq-I8
 for kexec@lists.infradead.org; Mon, 26 May 2014 01:58:33 +0000
Date: Mon, 26 May 2014 09:58:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86: do not enable efi boot for sgi uv machine
Message-ID: <20140526015801.GB2863@darkstar.nay.redhat.com>
References: <20140523101454.GA8608@darkstar.nay.redhat.com>
 <20140523132834.GB2126@redhat.com>
 <640284398.17653158.1400852828081.JavaMail.zimbra@redhat.com>
 <20140523155411.GC28727@pd.tnic> <20140523161930.GB4212@sgi.com>
 <20140523190210.GA10771@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140523190210.GA10771@sgi.com>
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
To: Alex Thorlton <athorlton@sgi.com>
Cc: Russ Anderson <rja@sgi.com>, matt.fleming@intel.com, kexec@lists.infradead.org, horms@verge.net.au, Borislav Petkov <bp@suse.de>, Vivek Goyal <vgoyal@redhat.com>

On Fri, May 23, 2014 at 02:02:10PM -0500, Alex Thorlton wrote:
> On Fri, May 23, 2014 at 11:19:30AM -0500, Russ Anderson wrote:
> > On Fri, May 23, 2014 at 05:54:11PM +0200, Borislav Petkov wrote:
> > > On Fri, May 23, 2014 at 09:47:08AM -0400, Dave Young wrote:
> > > > Hi,
> > > > 
> > > > Vivek, replying with webmail, sorry for the formatting issue.
> > > > 
> > > > Another way is export the mapping scheme in sysfs. So if kernel boot
> > > > with efi=old_map we can detect it as well. OTOH in future there's probably
> > > > other quirk system.
> > > > 
> > > > So kexec-tools can switch to use old way if kernel use ioremap.
> 
> This sounds like a good approach to use, but I think we should still
> have a way to force it to use the old way if necessary (can't think of a
> use case for that off the top of my head, but I'm sure someone can :)
> 
> I think a sort of hybrid approach between detecting the mapping scheme,
> and having a command-line option would probably be best:
> 
> - Detect which mapping method we used.
> - Default to noefi if the old mapping method was used, default to
>   efi if new mapping was used.

Agree because the efi=old_map

> - Allow users to specify either --efi or --noefi when kexec'ing to
>   override the suggested default, determined above.

I can not think out of such a case, but who knows. I can work on a '--noefi'
patch. 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
