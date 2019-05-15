Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQnsR-0003FO-9l
 for kexec@lists.infradead.org; Wed, 15 May 2019 06:59:01 +0000
Date: Wed, 15 May 2019 08:58:43 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190515065843.GA24212@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On Wed, May 15, 2019 at 05:17:19AM +0000, Junichi Nomura wrote:
> Hi Kairui,
> 
> On 5/13/19 5:02 PM, Baoquan He wrote:
> > On 05/13/19 at 09:50am, Borislav Petkov wrote:
> >> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> >> So we're going to try it again this cycle and if there's no fallout, it
> >> will go upstream. If not, it will have to be fixed. The usual thing.
> >>
> >> And I don't care if Kairui's patch fixes this one problem - judging by
> >> the fragility of this whole thing, it should be hammered on one more
> >> cycle on as many boxes as possible to make sure there's no other SNAFUs.
> >>
> >> So go test it on more machines instead. I've pushed it here:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window
> > 
> > Pingfan has got a machine to reproduce the kexec breakage issue, and
> > applying these two patches fix it. He planned to paste the test result.
> > I will ask him to try this branch if he has time, or I can get his
> > machine to test.
> > 
> > Junichi, also have a try on Boris's branch in NEC's test environment?
> 
> while the patch set works on most of the machines I'm testing around,
> I found kexec(1) fails to load kernel on a few machines if this patch
> is applied.  Those machines don't have IORES_DESC_ACPI_TABLES region
> and have ACPI tables in IORES_DESC_ACPI_NV_STORAGE region instead.

Why? What kind of machines are those?

Why are the ACPI tables in NV storage?

Looking at crash_setup_memmap_entries(), it already maps that type so I
guess this is needed.

+ Rafael and leaving in the rest for reference.

 
> So I think map_acpi_tables() should try to map both regions.  I tried
> following change in addition and it worked.
> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
> 
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 3c77bdf..3837c4a 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -56,12 +56,22 @@ static int mem_region_callback(struct resource *res, void *arg)
>  {
>  	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>  	struct init_pgtable_data data;
> +	int ret;
>  
>  	data.info = info;
>  	data.level4p = level4p;
>  	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> -	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> -				   &data, mem_region_callback);
> +	ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> +				  &data, mem_region_callback);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
> +				  &data, mem_region_callback);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	return 0;
>  }
>  #else
>  static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
