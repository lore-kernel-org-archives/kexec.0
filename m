Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wok6Q-0005Ps-S4
 for kexec@lists.infradead.org; Mon, 26 May 2014 01:53:27 +0000
Date: Mon, 26 May 2014 09:52:56 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86: do not enable efi boot for sgi uv machine
Message-ID: <20140526015255.GA2863@darkstar.nay.redhat.com>
References: <20140523101454.GA8608@darkstar.nay.redhat.com>
 <20140523132834.GB2126@redhat.com>
 <640284398.17653158.1400852828081.JavaMail.zimbra@redhat.com>
 <20140523155427.GF2126@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140523155427.GF2126@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org, Borislav Petkov <bp@suse.de>, matt.fleming@intel.com

On Fri, May 23, 2014 at 11:54:27AM -0400, Vivek Goyal wrote:
> On Fri, May 23, 2014 at 09:47:08AM -0400, Dave Young wrote:
> > Hi,
> > 
> > Vivek, replying with webmail, sorry for the formatting issue.
> > 
> > Another way is export the mapping scheme in sysfs. So if kernel boot
> > with efi=old_map we can detect it as well. OTOH in future there's probably
> > other quirk system.
> > 
> > So kexec-tools can switch to use old way if kernel use ioremap.
> 
> Exporting type of mapping being used in current kernel and automatically
> deciding that whether to boot with efi or noefi sounds reasonable to me.
> I am assuming that once type of mapping got fixed in first kernel boot
> it can't be changed in subsequent kernel boots?

Right, 2nd kernel will continue to use the original mapping because we can
only call the firmware function once to enter virtual mode. 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
