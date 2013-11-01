Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vc3O5-0006Y5-Ci
 for kexec@lists.infradead.org; Fri, 01 Nov 2013 01:18:57 +0000
Date: Fri, 1 Nov 2013 09:18:25 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 3/6] Cleanup efi_enter_virtual_mode function
Message-ID: <20131101011825.GB4378@dhcp-16-126.nay.redhat.com>
References: <20131028112458.GD29133@dhcp-16-126.nay.redhat.com>
 <20131028145801.GM4314@pd.tnic>
 <20131028151048.GA14984@dhcp-16-126.nay.redhat.com>
 <20131029023203.GB5185@dhcp-16-126.nay.redhat.com>
 <20131029134302.GI10972@pd.tnic>
 <20131030020348.GA4332@dhcp-16-126.nay.redhat.com>
 <20131030104718.GB13290@pd.tnic>
 <20131031020405.GA4377@dhcp-16-126.nay.redhat.com>
 <20131031020714.GB4377@dhcp-16-126.nay.redhat.com>
 <20131031104426.GA10544@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131031104426.GA10544@pd.tnic>
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
To: Borislav Petkov <bp@suse.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 10/31/13 at 11:44am, Borislav Petkov wrote:
> Dear Mr. Young,
> 
> On Thu, Oct 31, 2013 at 10:07:14AM +0800, Dave Young wrote:
> > > But Frankly I'd like to see them in list instead even with only small fixes
> > > beacuse in this way there might be more people to review it carefully.
> > 
> > There's another shorcoming for keeping new patches in git is that nobody know
> > when you push it and when is the proper date to pull from your git. I think
> > it's better to use git only for the patches which have already been accepted
> > and is waiting for maintainer to pull.
> 
> thank you for teaching me how to do kernel development!
> 
> The actual and real reason why I didn't send them yet is because I
> didn't want to be that kaffeine-inflated dork who spams the lists every
> other day with a new version of his patches.

I need remind myself about careless patch, I used to do that before :(

> 
> I am running build smoketests now and will send the latest version of
> the patchset later today so don't worry, the world will see them :)

Great, thank you. BTW, I have managed to test original patch set on a
Macboot Air of my friend with usb boot, it works ok.

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
