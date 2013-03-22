Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UJ9Oi-0000Rr-TL
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 21:21:13 +0000
Date: Fri, 22 Mar 2013 17:21:04 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, x86: Process multiple Crash kernel in /proc/iomem
Message-ID: <20130322212104.GI4544@redhat.com>
References: <20130320163131.GE2273@redhat.com>
 <1363807494-25127-1-git-send-email-yinghai@kernel.org>
 <20130322175925.GA10004@redhat.com>
 <CAE9FiQXZP0zbGA=nTg6bHG29sJJRvzNHHbBi1WUsO60cksSUSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQXZP0zbGA=nTg6bHG29sJJRvzNHHbBi1WUsO60cksSUSQ@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Mar 22, 2013 at 01:52:26PM -0700, Yinghai Lu wrote:
> On Fri, Mar 22, 2013 at 10:59 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > I get following error while loading kernel.
> >
> > parse_iomem_single failed.
> > Could not get memory layout
> >
> > I think you need to handle parse_iomem_single("Crash Kernel") in
> > kexec-x86-common.c. It assumes that there is a single contiguous
> > reserved region of memory and set mem_min and mem_max based on
> > that. But that will not work when there are multiple "Crash Kernel"
> > entries.
> >
> > In case of kexec_on_panic, we seem to have all the memory ranges in
> > info->memory_ranges[]. I guess we don't need that. We just need ranges
> > which are reserved for crash kernel and marked by "Crash Kernel". In
> > that case we will be able to handle multiple "Crash Kernel" ranges.
> 
> but we still like to put kernel and initrd high, and leave low range
> for swiotlb.
> could just find mem_min and mem_max for largest and last one.

Yes, but I guess that should not be hard coded here. It is during load
phase we should enforce where we want to load all the segments.

It will work though for our current usage. May be later we can improve
it further. Where loader sees all the memory ranges (low and high) and
we choose appropriate segment.

BTW, I had a query about loading 64bit entry point bzImage. In 32bit
bzImage entry point logic, we used to load bzImage at the beginning
of memory hole and initrd at the end of memory hole. So that bzImage
and initramfs are as far as possible and initramfs decompression does
not overwrite anything or for that matter setting bss are does not
spill over into initramfs.

In new code, It looks like we seem to be loading kernel towards the end
of the hole.

       addr = add_buffer(info, kernel + kern16_size, k_size,
                          size, align, 0x100000, -1, -1);

IIUC, this has potential that new kernel can overwrite some of the old
kernel's data structure while setting up bss. Shouldn't we do it 32bit
entry code way where bzImage is loaded towards the beginning of hole and
initramfs is loaded towards the end of the hole.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
