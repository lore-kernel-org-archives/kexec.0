Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YdXp6-0004iL-J4
 for kexec@lists.infradead.org; Thu, 02 Apr 2015 05:37:49 +0000
Received: by padcy3 with SMTP id cy3so73837715pad.3
 for <kexec@lists.infradead.org>; Wed, 01 Apr 2015 22:37:27 -0700 (PDT)
Message-ID: <551CD58E.60807@linaro.org>
Date: Thu, 02 Apr 2015 14:37:18 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] arm64: add kdump support
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <551C1537.2030009@redhat.com> <551C7EF5.9030806@linaro.org>
 <551CCC67.1040607@redhat.com>
In-Reply-To: <551CCC67.1040607@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, catalin.marinas@arm.com, will.deacon@arm.com, vgoyal@redhat.com, hbabus@us.ibm.com
Cc: linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, linux-arm-kernel@lists.infradead.org

Pratyush,

On 04/02/2015 01:58 PM, Pratyush Anand wrote:
>
>
> On Thursday 02 April 2015 04:57 AM, AKASHI Takahiro wrote:
>> Please try my latest kexec-tools in my linaro repo (branch name is
>> kdump/v0.11)
>> and let me know the result.
>
> Thanks a lot.. Just fetched your repo and found v.0.11.
>
> With this crash kernel loaded successfully, if I do not use initrd.
>
> With following I still see Overlapping memory segments
>
> kexec -p  /home/panand/work/kernel/bsa2_kdump/vmlinux --initrd=/boot/initramfs-3.19.0.bz1198945+.img --append="$( cat
> /proc/cmdline ) maxcpus=1 mem=64M reset_devices"

How big is your initrd?
If it is good small, please tell me segments info, or messages from add_segment_phys_virt()
for all the segments.

FYI,
my latest kexec-tools, ie. v0.11, automatically appends "mem=".

Thanks,
-Takahiro AKASHI

> ~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
