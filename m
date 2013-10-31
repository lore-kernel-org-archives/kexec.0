Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbihV-0005ij-MZ
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 03:13:39 +0000
Message-ID: <5271C981.2050705@zytor.com>
Date: Wed, 30 Oct 2013 20:07:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 3/6] Cleanup efi_enter_virtual_mode function
References: <20131028101011.GF25527@dhcp-16-126.nay.redhat.com>
 <20131028112045.GH4314@pd.tnic>
 <20131028112458.GD29133@dhcp-16-126.nay.redhat.com>
 <20131028145801.GM4314@pd.tnic>
 <20131028151048.GA14984@dhcp-16-126.nay.redhat.com>
 <20131029023203.GB5185@dhcp-16-126.nay.redhat.com>
 <20131029134302.GI10972@pd.tnic>
 <20131030020348.GA4332@dhcp-16-126.nay.redhat.com>
 <20131030104718.GB13290@pd.tnic>
 <20131031020405.GA4377@dhcp-16-126.nay.redhat.com>
 <20131031020714.GB4377@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, vgoyal@redhat.com

On 10/30/2013 07:07 PM, Dave Young wrote:
> On 10/31/13 at 10:04am, Dave Young wrote:
>> On 10/30/13 at 11:47am, Borislav Petkov wrote:
>>> On Wed, Oct 30, 2013 at 10:03:49AM +0800, Dave Young wrote:
>>>> Will try, but please keep the posted patches in mailing list up-to-date,
>>>
>>> Would you like me to send them to you privately?
>>
>> Thanks, do not bother to send me privately I can get it from your git tree.
>>
>> But Frankly I'd like to see them in list instead even with only small fixes
>> beacuse in this way there might be more people to review it carefully.
> 
> There's another shorcoming for keeping new patches in git is that nobody know
> when you push it and when is the proper date to pull from your git. I think
> it's better to use git only for the patches which have already been accepted
> and is waiting for maintainer to pull.
> 

You can use git for your own purposes, still.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
