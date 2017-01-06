Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cPME4-0005SG-1j
 for kexec@lists.infradead.org; Fri, 06 Jan 2017 04:34:02 +0000
Received: by mail-pg0-x22a.google.com with SMTP id f188so247614313pgc.3
 for <kexec@lists.infradead.org>; Thu, 05 Jan 2017 20:33:39 -0800 (PST)
Date: Fri, 6 Jan 2017 13:34:27 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v29 0/9] arm64: add kdump support
Message-ID: <20170106043426.GB20972@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <610620b2-d77d-0684-144f-0f76d0cdbb5e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <610620b2-d77d-0684-144f-0f76d0cdbb5e@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 06, 2017 at 08:56:30AM +0530, Pratyush Anand wrote:
> 
> 
> On Wednesday 28 December 2016 10:03 AM, AKASHI Takahiro wrote:
> >This patch series adds kdump support on arm64.
> >
> >To load a crash-dump kernel to the systems, a series of patches to
> >kexec-tools[1] are also needed. Please use the latest one, v4 [2].
> >For your convinience, you can pick them up from:
> >   https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
> >   https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
> >
> >To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> >  - crash utility (v7.1.7 or later) [3]
> >    (As of today, the very latest tree cannot handle a core image correctly
> >     due to the commit 7fd8329ba502 ("taint/module: Clean up global and module
> >     taint flags handling")
> >
> >
> >The previous version, v27, was also:
> >Tested-by: Pratyush Anand <panand@redhat.com> (mustang and seattle)
> 
> You have my "Tested-by" for this version as well :-). Patches works great
> after applying them over v4.10-rc2.

Great thanks, again.

> I used crash-utility from below where there are few patches queued for
> crash-7.1.8
> https://github.com/crash-utility/crash

Yes, we need some patch for v4.10 kernel.

-Takahiro AKASHI

> ~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
