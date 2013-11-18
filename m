Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViHQA-0002d5-TO
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 05:30:52 +0000
Date: Mon, 18 Nov 2013 13:29:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 1/3 v2] Add function get_bootparam
Message-ID: <20131118052949.GA14532@dhcp-16-126.nay.redhat.com>
References: <1384219658.1847.84.camel@misato.fc.hp.com>
 <52819E71.70201@zytor.com> <20131112075831.GA6213@kroah.com>
 <20131112080854.GD6999@dhcp-16-126.nay.redhat.com>
 <20131112083012.GB7708@kroah.com> <5281F6D5.4090700@zytor.com>
 <20131112095114.GA20100@kroah.com>
 <20131113005032.GB5069@dhcp-16-126.nay.redhat.com>
 <20131118022234.GD4025@dhcp-16-126.nay.redhat.com>
 <52898982.3020200@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52898982.3020200@zytor.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Greg KH <greg@kroah.com>, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

On 11/17/13 at 07:29pm, H. Peter Anvin wrote:
> On 11/17/2013 06:22 PM, Dave Young wrote:
> > On 11/13/13 at 08:50am, Dave Young wrote:
> >> On 11/12/13 at 06:51pm, Greg KH wrote:
> >>> On Tue, Nov 12, 2013 at 01:37:25AM -0800, H. Peter Anvin wrote:
> >>>> On 11/12/2013 12:30 AM, Greg KH wrote:
> >>>>>
> >>>>> And these binary data blobs are a "standard" somewhere, and will not
> >>>>> change per kernel version change?
> >>>>>
> >>>>> If so, that structure is fine with me.
> >>>>>
> >>>>
> >>>> Correct.  The structure is documented in Documentation/x86/boot.txt, and
> >>>> has been largely invariant (but extended) since the beginning of Linux.
> >>>>  It has sometimes taken some serious work to keep it that way.
> >>>
> >>> Ok, then use the binary sysfs file interface for these blobs, and
> >>> everyone will be happy.
> >>
> >> Since we got an agreement I will move them to sysfs in next version.
> > 
> > I have created one patch for the sysfs part this weekend, bug I'm hesitating to
> > remove the debugfs part because currently there's already user, I tend to
> > keep them in debugfs for now.
> > 
> > What do you think, Peter?
> > 
> 
> Yes, it makes sense to keep them for compatibility, at least for now.
> What is the specific user that already exists?

kexec-tools is using it to setup hardware_subarch..

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
