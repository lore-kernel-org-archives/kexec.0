Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cbKys-0008Ki-LH
 for kexec@lists.infradead.org; Wed, 08 Feb 2017 05:39:52 +0000
Received: by mail-pf0-f172.google.com with SMTP id y143so39325266pfb.0
 for <kexec@lists.infradead.org>; Tue, 07 Feb 2017 21:39:29 -0800 (PST)
Subject: Re: [PATCH v32 00/13] arm64: add kdump support
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <d3759cc9-01d8-814c-e76e-e035eac6bb8b@redhat.com>
Date: Wed, 8 Feb 2017 11:09:23 +0530
MIME-Version: 1.0
In-Reply-To: <20170207080601.5816-1-takahiro.akashi@linaro.org>
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



On Tuesday 07 February 2017 01:36 PM, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v5 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.8 or later, i.e. master for now) [3]
>
> I tested this patchset on fast model and hikey.
> (under various configurations, in particular 4KB-page/39,48-bits, 64KB-page/42
> -bits with hibernate)
>
> The previous versions were also:
> Tested-by: Pratyush Anand <panand@redhat.com> (v29, mustang and seattle)

..and you have my Tested-by for this series as well. They work fine with 
both the above platform.

Although we are very close, still it could be great if these patches can 
make into v4.11.

Thanks a lot Akashi for the quick v32.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
