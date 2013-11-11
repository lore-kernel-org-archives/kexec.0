Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VfujF-0005uS-Sf
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 16:52:46 +0000
Date: Mon, 11 Nov 2013 11:52:03 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 1/3] x86, apic: Don't count the CPU with BP flag from
 MP table as booting-up CPU
Message-ID: <20131111165202.GD11547@redhat.com>
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022150124.24240.20741.stgit@localhost6.localdomain6>
 <20131108160830.GB13068@redhat.com>
 <5280466E.9090504@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5280466E.9090504@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

On Mon, Nov 11, 2013 at 11:52:30AM +0900, HATAYAMA Daisuke wrote:

[..]
> Looking at my past investigation, kernel/mpparse.c, mm/amdtopology.c and
> platform/visws/visws_quirks.c assumes that boot_cpu_physical_apicid
> has initial apicid of the BSP, not the current actual booting-up cpu.
> 
> These three are called in get_smp_config() below. If either of them is
> called actually, boot_cpu_physical_apicid has the apicid different from
> the current actual booting-up cpu temporarily. But init_apic_mappings()
> soon modifies back the value to the one obtained by read_apic_id().
> 
>         /*
>          * Read APIC and some other early information from ACPI tables.
>          */
>         acpi_boot_init();
>         sfi_init();
>         x86_dtb_init();
> 
>         /*
>          * get boot-time SMP configuration:
>          */
>         if (smp_found_config)
>                 get_smp_config();
> 
>         prefill_possible_map();
> 
>         init_cpu_to_node();
> 
>         init_apic_mappings();
> 
> So, thanks to init_apic_mappings(), the patch set would work without the
> first patch... This is a careless point in this patch set.
> 

If init_apic_mappings(), is making sure that boot_cpu_physical_apicid is
apic id of booting processor, and you don't need first patch of your
series, then I think atleast re-post your patch series without first
patch.  

And then there can be another series which looks into whether we need
two different variables or not and if we do, then a separate variable
bsp_physical_apicid will track the bsp id as reported by BIOS and
boot_cpu_physical_apicid will track apic id of booting cpu. This might
a very big and slow cleanup. So I think blocking the first patch series
behind it might not make much sense.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
