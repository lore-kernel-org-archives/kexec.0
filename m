Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbpkN-0004yf-T0
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 10:45:04 +0000
Date: Thu, 31 Oct 2013 11:44:26 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [patch 3/6] Cleanup efi_enter_virtual_mode function
Message-ID: <20131031104426.GA10544@pd.tnic>
References: <20131028112045.GH4314@pd.tnic>
 <20131028112458.GD29133@dhcp-16-126.nay.redhat.com>
 <20131028145801.GM4314@pd.tnic>
 <20131028151048.GA14984@dhcp-16-126.nay.redhat.com>
 <20131029023203.GB5185@dhcp-16-126.nay.redhat.com>
 <20131029134302.GI10972@pd.tnic>
 <20131030020348.GA4332@dhcp-16-126.nay.redhat.com>
 <20131030104718.GB13290@pd.tnic>
 <20131031020405.GA4377@dhcp-16-126.nay.redhat.com>
 <20131031020714.GB4377@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131031020714.GB4377@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

Dear Mr. Young,

On Thu, Oct 31, 2013 at 10:07:14AM +0800, Dave Young wrote:
> > But Frankly I'd like to see them in list instead even with only small fixes
> > beacuse in this way there might be more people to review it carefully.
> 
> There's another shorcoming for keeping new patches in git is that nobody know
> when you push it and when is the proper date to pull from your git. I think
> it's better to use git only for the patches which have already been accepted
> and is waiting for maintainer to pull.

thank you for teaching me how to do kernel development!

The actual and real reason why I didn't send them yet is because I
didn't want to be that kaffeine-inflated dork who spams the lists every
other day with a new version of his patches.

I am running build smoketests now and will send the latest version of
the patchset later today so don't worry, the world will see them :)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
