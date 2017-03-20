Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpwmS-0002Oi-N1
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 12:51:26 +0000
Received: by mail-pf0-f179.google.com with SMTP id o126so65579742pfb.3
 for <kexec@lists.infradead.org>; Mon, 20 Mar 2017 05:51:04 -0700 (PDT)
Subject: Re: [PATCH v33 00/14] add kdump support
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <2d0f8fbf-f815-e773-9a6b-05242eb9abfd@redhat.com>
Date: Mon, 20 Mar 2017 18:12:48 +0530
MIME-Version: 1.0
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
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



On Wednesday 15 March 2017 03:26 PM, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
>
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v6 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
>
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.8 or later) [3]
>
> I tested this patchset on fast model and hikey.
>
> The previous versions were also:
> Tested-by: Pratyush Anand <panand@redhat.com> (v32, mustang and seattle)

You have it for this version as well.

Thanks for the patchset.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
