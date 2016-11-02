Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1s1b-0005w8-AL
 for kexec@lists.infradead.org; Wed, 02 Nov 2016 09:40:04 +0000
Received: by mail-qk0-f169.google.com with SMTP id q130so11209537qke.1
 for <kexec@lists.infradead.org>; Wed, 02 Nov 2016 02:39:42 -0700 (PDT)
Subject: Re: [PATCH v27 0/9] arm64: add kdump support
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <e9d49b0b-f4e6-13af-f963-5e42191cb24e@redhat.com>
Date: Wed, 2 Nov 2016 15:09:35 +0530
MIME-Version: 1.0
In-Reply-To: <20161102044959.11954-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org



On Wednesday 02 November 2016 10:19 AM, AKASHI Takahiro wrote:
>     v27-specific note: In this version, the change made in v26 was reverted
>     because I've got a comment that /reserved-memory DT property should
>     not be used on UEFI/ACPI systems, even though it is workable under
>     the current implementation. I've also confirmed that Rob doesn't argue
>     any more against using "linux,usable-memory-range".
>     So v27 is essentially the same as v25.
>
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v4 [2].
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.6 or later) [3]

Tested with mustang and seattle.
Tested-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
