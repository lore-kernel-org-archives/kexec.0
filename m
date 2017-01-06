Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cPLBI-0006Xz-OX
 for kexec@lists.infradead.org; Fri, 06 Jan 2017 03:27:06 +0000
Received: by mail-pf0-f172.google.com with SMTP id f144so1307618pfa.2
 for <kexec@lists.infradead.org>; Thu, 05 Jan 2017 19:26:42 -0800 (PST)
Subject: Re: [PATCH v29 0/9] arm64: add kdump support
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <610620b2-d77d-0684-144f-0f76d0cdbb5e@redhat.com>
Date: Fri, 6 Jan 2017 08:56:30 +0530
MIME-Version: 1.0
In-Reply-To: <20161228043347.27358-1-takahiro.akashi@linaro.org>
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



On Wednesday 28 December 2016 10:03 AM, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v4 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.7 or later) [3]
>     (As of today, the very latest tree cannot handle a core image correctly
>      due to the commit 7fd8329ba502 ("taint/module: Clean up global and module
>      taint flags handling")
>
>
> The previous version, v27, was also:
> Tested-by: Pratyush Anand <panand@redhat.com> (mustang and seattle)

You have my "Tested-by" for this version as well :-). Patches works 
great after applying them over v4.10-rc2.

I used crash-utility from below where there are few patches queued for 
crash-7.1.8
https://github.com/crash-utility/crash

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
