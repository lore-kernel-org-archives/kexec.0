Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YFzmv-0001UB-Or
 for kexec@lists.infradead.org; Tue, 27 Jan 2015 06:38:14 +0000
Date: Tue, 27 Jan 2015 14:37:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFD] efi assisted kdump
Message-ID: <20150127063742.GE2506@darkstar.redhat.com>
References: <20150124132637.GB2139@darkstar.redhat.com>
 <20150126163941.GD3320@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150126163941.GD3320@codeblueprint.co.uk>
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
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: matt.fleming@intel.com, Kweh Hock Leong <hock.leong.kweh@intel.com>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com

Hi, Matt

Thanks for the feedback.

On 01/26/15 at 04:39pm, Matt Fleming wrote:
> On Sat, 24 Jan, at 09:26:37PM, Dave Young wrote:
> > 
> > There's several things I need to ask for help from EFI gurus to see if it is doable:
> > 
> > * Make sure in case EFI warm reboot the memory of previous kernel can be retained.
>  
> The only way to reserve memory across a reboot is with EFI capsules.

I know your capsules patchset, but I did not look into the details.

Do you means the old memory will be not reliable in case booting without capsules
even for warm reboot?

> 
> > * How to determine if kernel is boot with EFI warm reboot in stub
> 
> The presence of a capsule would indicate whether we were invoked from a
> crash handler.

Ok, another problem is for efi capsule handling, can we do it in efi stub, or I
in a efi application, which stage is the doable?

>  
> > * What is the right way to pass informations from 1st kernel to 2nd kernel.
> >   Is it ok for saving something with efi variables? 
> 
> EFI capsules would the be most natural mechanism, but you could
> conceivably do it with EFI variables (there's an upper limit on the size
> of variable data, though).

Will think about it after I checking the capsule machanisms details.

> 
> > * Other possible problems what I missed
> 
> Support for runtime EFI capsules was rather spotty last time I looked.
> Things may have moved on, but it's definitely something to watch out
> for.
> 
> There have been patches on linux-efi in recent months for making use of
> EFI capsules,
> 
>   https://lkml.kernel.org/r/1412692886-25306-1-git-send-email-matt@console-pimps.org
>   https://lkml.kernel.org/r/1414984030-13859-1-git-send-email-hock.leong.kweh@intel.com
> 
> I could take a look at resubmitting the first series above if that would
> be useful for doing kexec across a reset.

Thanks a lot. I will take a look at how capsules works firstly.
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
