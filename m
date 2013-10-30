Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbL96-0006CI-5s
 for kexec@lists.infradead.org; Wed, 30 Oct 2013 02:04:33 +0000
Date: Wed, 30 Oct 2013 10:03:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 3/6] Cleanup efi_enter_virtual_mode function
Message-ID: <20131030020348.GA4332@dhcp-16-126.nay.redhat.com>
References: <20131028094049.GC25527@dhcp-16-126.nay.redhat.com>
 <20131028095117.GD25527@dhcp-16-126.nay.redhat.com>
 <20131028100402.GC4314@pd.tnic>
 <20131028101011.GF25527@dhcp-16-126.nay.redhat.com>
 <20131028112045.GH4314@pd.tnic>
 <20131028112458.GD29133@dhcp-16-126.nay.redhat.com>
 <20131028145801.GM4314@pd.tnic>
 <20131028151048.GA14984@dhcp-16-126.nay.redhat.com>
 <20131029023203.GB5185@dhcp-16-126.nay.redhat.com>
 <20131029134302.GI10972@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131029134302.GI10972@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 10/29/13 at 02:43pm, Borislav Petkov wrote:
> On Tue, Oct 29, 2013 at 10:32:03AM +0800, Dave Young wrote:
> > I remember I tried your efi branch, but the code is different from
> > what you sent to list, thus I turned to use the mbox patches.
> 
> Yeah, please use the #efi branch as I keep refreshing it with the newest
> changes. They're hopefully not serious changes but minor stuff here and
> there so basing stuff ontop should be ok.

Will try, but please keep the posted patches in mailing list up-to-date,
I'm an old-fashioned person, do not tend to depend on git.

Thanks in advance.
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
