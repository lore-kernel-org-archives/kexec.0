Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZbpW-0005GB-A4
 for kexec@lists.infradead.org; Tue, 16 Aug 2016 10:42:48 +0000
Date: Tue, 16 Aug 2016 18:42:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: Account crashk_low_res to kexec_crash_size
Message-ID: <20160816104217.GA15921@dhcp-128-65.nay.redhat.com>
References: <1471076770-29426-1-git-send-email-xlpang@redhat.com>
 <20160815071759.GB10435@dhcp-128-65.nay.redhat.com>
 <57B177DA.3030005@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57B177DA.3030005@redhat.com>
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
To: xlpang@redhat.com
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi,

On 08/15/16 at 04:05pm, Xunlei Pang wrote:
> On 2016/08/15 at 15:17, Dave Young wrote:
> > Hi Xunlei,
> >
> > On 08/13/16 at 04:26pm, Xunlei Pang wrote:
> >> "/sys/kernel/kexec_crash_size" only includes crashk_res, it
> >> is fine in most cases, but sometimes we have crashk_low_res.
> >> For example, when "crashkernel=size[KMG],high" combined with
> >> "crashkernel=size[KMG],low" is used for 64-bit x86.
> >>
> >> Let "/sys/kernel/kexec_crash_size" reflect all the reserved
> >> memory including crashk_low_res, this is more understandable
> >> from its naming.
> > Maybe export another file for the kexec_crash_low_size so that
> > we can clearly get how much the low area is.
> 
> I'm fine with it.
> 
> >> Although we can get all the crash memory from "/proc/iomem"
> >> by filtering all "Crash kernel" keyword, it is more convenient
> >> to utilize this file, and the two ways should stay consistent.
> > Shrink low area does not make much sense, one may either use it or
> > shrink it to 0.
> >
> > Actually think more about it, the crashk_low is only for x86,
> > it might be even better to move it to x86 code instead of in
> > common code.
> >
> > Opinion?
> 
> crashk_low is defined in kernel/kexec_core.c, it's an architecture independent definition
> though it's only used by x86 currently, maybe it can be used by others in the future.
> It's why I'm not handling it specifically for x86.

Ok, we can leave with it since it is in common code from the very
beginning but I doubt that any other arches will use it.

> 
> I just tested the original proc interface further, and it can be shrinked to be zero.
> So I guess we can ease the restriction on shrinking the low area as well.
> 
> What do you think?

Ok, agreed.

Thanks
Dave

> 
> Regards,
> Xunlei
> 
> >
> > Thanks
> > Dave
> >> Note that write to "/sys/kernel/kexec_crash_size" is to shrink
> >> the reserved memory, and we want to shrink crashk_res only.
> >> So we add some additional check in crash_shrink_memory() since
> >> crashk_low_res now is involved.
> >>
> >> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> >> ---
> >>  kernel/kexec_core.c | 15 ++++++++++++++-
> >>  1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> index 5616755..d5ae780 100644
> >> --- a/kernel/kexec_core.c
> >> +++ b/kernel/kexec_core.c
> >> @@ -932,6 +932,8 @@ size_t crash_get_memory_size(void)
> >>  	mutex_lock(&kexec_mutex);
> >>  	if (crashk_res.end != crashk_res.start)
> >>  		size = resource_size(&crashk_res);
> >> +	if (crashk_low_res.end != crashk_low_res.start)
> >> +		size += resource_size(&crashk_low_res);
> >>  	mutex_unlock(&kexec_mutex);
> >>  	return size;
> >>  }
> >> @@ -949,7 +951,7 @@ int crash_shrink_memory(unsigned long new_size)
> >>  {
> >>  	int ret = 0;
> >>  	unsigned long start, end;
> >> -	unsigned long old_size;
> >> +	unsigned long low_size, old_size;
> >>  	struct resource *ram_res;
> >>  
> >>  	mutex_lock(&kexec_mutex);
> >> @@ -958,6 +960,17 @@ int crash_shrink_memory(unsigned long new_size)
> >>  		ret = -ENOENT;
> >>  		goto unlock;
> >>  	}
> >> +
> >> +	start = crashk_low_res.start;
> >> +	end = crashk_low_res.end;
> >> +	low_size = (end == 0) ? 0 : end - start + 1;
> >> +	/* Do not shrink crashk_low_res. */
> >> +	if (new_size <= low_size) {
> >> +		ret = -EINVAL;
> >> +		goto unlock;
> >> +	}
> >> +
> >> +	new_size -= low_size;
> >>  	start = crashk_res.start;
> >>  	end = crashk_res.end;
> >>  	old_size = (end == 0) ? 0 : end - start + 1;
> >> -- 
> >> 1.8.3.1
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
