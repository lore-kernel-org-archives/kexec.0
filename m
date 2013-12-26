Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vw0Vi-0002f5-BR
 for kexec@lists.infradead.org; Thu, 26 Dec 2013 02:17:19 +0000
Date: Thu, 26 Dec 2013 10:17:06 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: split efi systab in sysfs
Message-ID: <20131226021705.GC3750@dhcp-16-126.nay.redhat.com>
References: <20131226015308.GA3750@dhcp-16-126.nay.redhat.com>
 <52BB8C8F.1020606@zytor.com>
 <20131226021238.GB3750@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131226021238.GB3750@dhcp-16-126.nay.redhat.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: matt@console-pimps.org, linux-efi@vger.kernel.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au

CCing Simon and kexec list

On 12/26/13 at 10:12am, Dave Young wrote:
> On 12/25/13 at 05:55pm, H. Peter Anvin wrote:
> > On 12/25/2013 05:53 PM, Dave Young wrote:
> > > Hi, Matt and Peter
> > > 
> > > Currently /sys/firmware/efi/systab contains multi-lines for efi systab
> > > entries. As previous discussion with Greg, this is not a good in sysfs.
> > > I wonder if there's other users for this file except kexec-tools.
> > > 
> > > If kexec-tools is the only user, maybe I can split it as several files.
> > > In kexec-tools just use /sys/firmware/efi/"$entry_name" and if $entry_name
> > > does not exist then switch to old systab file. 
> > > 
> > 
> > Yes, the sysfs standard is "one entry per datum".  I have no idea about
> > who the user(s) might be, though.
> 
> Even the only known user kexec-tools, for new kernel + old kexec-tools we
> have no way to support, maybe this systab should be kept forever...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
