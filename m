Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x22f.google.com ([2607:f8b0:4001:c03::22f])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UJ8wv-0006XW-Cc
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 20:52:30 +0000
Received: by mail-ie0-f175.google.com with SMTP id c12so5302341ieb.20
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 13:52:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130322175925.GA10004@redhat.com>
References: <20130320163131.GE2273@redhat.com>
 <1363807494-25127-1-git-send-email-yinghai@kernel.org>
 <20130322175925.GA10004@redhat.com>
Date: Fri, 22 Mar 2013 13:52:26 -0700
Message-ID: <CAE9FiQXZP0zbGA=nTg6bHG29sJJRvzNHHbBi1WUsO60cksSUSQ@mail.gmail.com>
Subject: Re: [PATCH] kdump, x86: Process multiple Crash kernel in /proc/iomem
From: Yinghai Lu <yinghai@kernel.org>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Mar 22, 2013 at 10:59 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> I get following error while loading kernel.
>
> parse_iomem_single failed.
> Could not get memory layout
>
> I think you need to handle parse_iomem_single("Crash Kernel") in
> kexec-x86-common.c. It assumes that there is a single contiguous
> reserved region of memory and set mem_min and mem_max based on
> that. But that will not work when there are multiple "Crash Kernel"
> entries.
>
> In case of kexec_on_panic, we seem to have all the memory ranges in
> info->memory_ranges[]. I guess we don't need that. We just need ranges
> which are reserved for crash kernel and marked by "Crash Kernel". In
> that case we will be able to handle multiple "Crash Kernel" ranges.

but we still like to put kernel and initrd high, and leave low range
for swiotlb.
could just find mem_min and mem_max for largest and last one.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
