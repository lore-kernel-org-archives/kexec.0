From: Baoquan He <bhe@redhat.com>
Date: Sat, 7 May 2022 10:36:06 +0800
Subject: [PATCH v24 5/6] of: Support more than one crash kernel regions
 for kexec -s
In-Reply-To: <55e201f1-f136-607c-78f8-eb4ec481909e@huawei.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-6-thunder.leizhen@huawei.com>
 <20220506231737.GD122876@MiWiFi-R3L-srv>
 <55e201f1-f136-607c-78f8-eb4ec481909e@huawei.com>
Message-ID: <YnXbFv0crHQDoGqM@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/07/22 at 09:42am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/7 7:17, Baoquan He wrote:
> > On 05/06/22 at 07:44pm, Zhen Lei wrote:
> >> When "crashkernel=X,high" is used, there may be two crash regions:
> >> high=crashk_res and low=crashk_low_res. But now the syscall
> >> kexec_file_load() only add crashk_res into "linux,usable-memory-range",
> >> this may cause the second kernel to have no available dma memory.
> >>
> >> Fix it like kexec tool do for option -c, add both 'high' and 'low' regions
> >               ~~~~~~~~~~~~ 
> >               kexec-tools does
> 
> OK, I will update it. Thanks.

Let's wait and see how Catalin considers. He may pick these with
minor fix directly or your v25.

> 
> > 
> > Other than this, LGTM, > > > > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> >> into the dtb.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  drivers/of/kexec.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> >> index b9bd1cff179388c..8d374cc552be5f2 100644
> >> --- a/drivers/of/kexec.c
> >> +++ b/drivers/of/kexec.c
> >> @@ -386,6 +386,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> >>  				crashk_res.end - crashk_res.start + 1);
> >>  		if (ret)
> >>  			goto out;
> >> +
> >> +		if (crashk_low_res.end) {
> >> +			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> >> +					"linux,usable-memory-range",
> >> +					crashk_low_res.start,
> >> +					crashk_low_res.end - crashk_low_res.start + 1);
> >> +			if (ret)
> >> +				goto out;
> >> +		}
> >>  	}
> >>  
> >>  	/* add bootargs */
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 


