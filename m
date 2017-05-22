Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dCgrM-0007Bo-V9
 for kexec@lists.infradead.org; Mon, 22 May 2017 06:30:31 +0000
Received: by mail-pf0-f176.google.com with SMTP id n23so72327215pfb.2
 for <kexec@lists.infradead.org>; Sun, 21 May 2017 23:30:08 -0700 (PDT)
Subject: Re: [PATCH v7 00/10] (kexec-tools) arm64: add kdump support
References: <20170517055150.12601-1-takahiro.akashi@linaro.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <089fe15a-ef8d-a325-59cb-f25ecf678deb@redhat.com>
Date: Mon, 22 May 2017 11:52:25 +0530
MIME-Version: 1.0
In-Reply-To: <20170517055150.12601-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, horms@verge.net.au
Cc: geoff@infradead.org, kexec@lists.infradead.org

Hi Akashi,

On Wednesday 17 May 2017 11:21 AM, AKASHI Takahiro wrote:
> My kernel patches of kdump support on arm64 were merged in v4.12-rc1.
>
> This patchset is synced with them and provides necessary changes for
> kexec-tools. It can be applied on top of kexec-tools master branch.
>
> Patch #1 to #4 are preparatory patches for succeeding patches,
> #5 to #9 are main part of kdump implementation for vmlinux support
> and #10 is for Image support.
>
> Changes for v7:
>  - rebased on the latest master
>  - fix incorrect return values on error (patch #4)
>  - implement get_crash_kernel_load_range() (patch #5)
>  - rename some variables/functions for better readability (patch #5/#9)
>  - add/revise comments
>


Thanks for the v7 updates. I tested this version as well, and it worked!!
Tested-by: Pratyush Anand <panand@redhat.com>


I will be sending v2 of D-cache enabling patches(for faster purgatory sha 
verification) once these patches are merged. If some one would like to test 
those patches in advance, it will be more than welcome. Patches lie in my 
github devel branch.

https://github.com/pratyushanand/kexec-tools.git : devel

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
