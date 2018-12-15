Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXz9V-0001Co-Fx
 for kexec@lists.infradead.org; Sat, 15 Dec 2018 01:54:03 +0000
Received: by mail-qt1-x843.google.com with SMTP id k12so8333998qtf.7
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2018 17:53:50 -0800 (PST)
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
 <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
Date: Fri, 14 Dec 2018 20:53:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
Content-Language: en-US
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 12/14/18 2:23 AM, Ard Biesheuvel wrote:
> On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
>> Also tried to move the local TLB flush part around a bit inside
>> __cpu_setup(), although it did complete kdump some times, it did trigger
>> "Synchronous Exception" in EFI after a cold-reboot fairly often that
>> seems no way to recover remotely without reinstalling the OS.
> 
> This doesn't make any sense to me. If the system gets into a weird
> state out of cold reboot, how could this code be the culprit? Please
> check your firmware, and try to reproduce the issue on a system that
> doesn't have such defects.
> 

I'll continue investigating those "Synchronous Exception" although it is kind of
hard due to I don't have any source code of the firmware to confirm it is buggy
or not.

I did manage to reproduce this kdump issue on around 5 of those server running a
fairly recent version of the firmware (07/01/2018). I don't have access to other
large CPU machines.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
