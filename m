Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 00/19] arm64 kexec kernel patches v13
References: <cover.1452884156.git.geoff@infradead.org>
 <c7575f853ccc491bb0212e025aab1cc9@NASANEXM01H.na.qualcomm.com>
From: Azriel Samson <asamson@codeaurora.org>
Message-ID: <56D5D763.4030304@codeaurora.org>
Date: Tue, 1 Mar 2016 10:54:43 -0700
MIME-Version: 1.0
In-Reply-To: <c7575f853ccc491bb0212e025aab1cc9@NASANEXM01H.na.qualcomm.com>
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
To: Geoff Levand <geoff@infradead.org>
Cc: 'Mark Rutland' <mark.rutland@arm.com>, marc.zyngier@arm.com, catalin.marinas@arm.com, 'Will Deacon' <will.deacon@arm.com>, 'AKASHI Takahiro' <takahiro.akashi@linaro.org>, james.morse@arm.com, christoffer.dall@linaro.org, virajm@codeaurora.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 01/15/16 at 07:18pm, Geoff Levand wrote:
> This series adds the core support for kexec re-boot and kdump on
> ARM64.This version of the series combines Takahiro's kdump patches
> with my kexec patches. Please consider all patches for inclusion.
>
> I just tested all the endian combinations of kexec LE->LE, LE->BE,
> BE->BE, BE->LE, and both LE an BE kdump, and all work as expected.
>
> To load a second stage kernel and execute a kexec re-boot or to work
> with kdump on ARM64 systems a series of patches to kexec-tools [2],
> which have not yet been merged upstream, are needed.
>
> To examine vmcore (/proc/vmcore), you should use - gdb v7.7 or later
> - crash v7.1.1 or later
>
> [1]
> https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]
> https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
>

We have been using the kexec/kdump patches on ARM64 and would like to 
use them from upstream.

Assuming these are not going to be in Linux-4.5, a rebased set on 
Linux-4.5 would be very useful.

Thank you for your work.
-- 
Thanks,
Azriel Samson
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
