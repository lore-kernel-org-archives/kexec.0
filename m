Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x236.google.com ([2607:f8b0:400e:c03::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a8lHv-0002zT-Sg
 for kexec@lists.infradead.org; Tue, 15 Dec 2015 08:48:52 +0000
Received: by mail-pa0-x236.google.com with SMTP id dm15so1266153pac.3
 for <kexec@lists.infradead.org>; Tue, 15 Dec 2015 00:48:31 -0800 (PST)
Subject: Re: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com> <1449772308.24127.59.camel@infradead.org>
 <20151211163144.GK18828@arm.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <566FD3D6.2040605@linaro.org>
Date: Tue, 15 Dec 2015 17:48:22 +0900
MIME-Version: 1.0
In-Reply-To: <20151211163144.GK18828@arm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, vikrams@codeaurora.org, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, shankerd@codeaurora.org, Christoffer Dall <christoffer.dall@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Will,

On 12/12/2015 01:31 AM, Will Deacon wrote:
> On Thu, Dec 10, 2015 at 10:31:48AM -0800, Geoff Levand wrote:
>> On Thu, 2015-12-03 at 13:58 +0000, Marc Zyngier wrote:
>>> Indeed, this is completely broken (I just reproduced the issue on a
>>> model).
>>
>> There are users out there that want kexec/kdump support.  I think we
>> should remove this patch from the series, replace it with a temporary
>> Kconfig conditional that allows only one of KVM or kexec to be enabled,
>> and merge kexec and kdump support in for 4.5.  This will satisfy users
>> who need kexec but not KVM, like kexec based bootloaders.  Once this
>> KVM hot plug patch is fixed we then merge it, either for 4.5 or 4.6,
>> depending on the timing.
>>
>> I'll prepare and post a v13 series that does the above.
>
> I'm not really keen on merging this based on a "temporary" Kconfig change
> with a promise to have it resolved in the future. Given how long this
> series has been floating around already, I'm not filled with confidence
> at the prospect of waiting for a fixup patch after it's been merged.
>
> Please address the outstanding review comments before reposting.

I'm working hard on addressing Marc's comment on kvm cpu hotplug, and so
can you please review other *main* part of kexec/kdump patches?
Or can I think that 'no comments' is a good sign of your acceptance?

Thanks,
-Takahiro AKASHI


> Will
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
