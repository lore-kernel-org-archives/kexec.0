Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vg24v-0006Hv-Do
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 00:43:38 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id ADDE83EE1DE
 for <kexec@lists.infradead.org>; Tue, 12 Nov 2013 09:43:11 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9CCBC45DE69
 for <kexec@lists.infradead.org>; Tue, 12 Nov 2013 09:43:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 78A0845DE53
 for <kexec@lists.infradead.org>; Tue, 12 Nov 2013 09:43:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F9C8E08009
 for <kexec@lists.infradead.org>; Tue, 12 Nov 2013 09:43:11 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E4726E08004
 for <kexec@lists.infradead.org>; Tue, 12 Nov 2013 09:43:10 +0900 (JST)
Message-ID: <52817916.9030104@jp.fujitsu.com>
Date: Tue, 12 Nov 2013 09:40:54 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] x86, apic: Don't count the CPU with BP flag from
 MP table as booting-up CPU
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022150124.24240.20741.stgit@localhost6.localdomain6>
 <20131108160830.GB13068@redhat.com> <5280466E.9090504@jp.fujitsu.com>
 <20131111165202.GD11547@redhat.com>
In-Reply-To: <20131111165202.GD11547@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/11/12 1:52), Vivek Goyal wrote:
> On Mon, Nov 11, 2013 at 11:52:30AM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>> Looking at my past investigation, kernel/mpparse.c, mm/amdtopology.c and
>> platform/visws/visws_quirks.c assumes that boot_cpu_physical_apicid
>> has initial apicid of the BSP, not the current actual booting-up cpu.
>>
>> These three are called in get_smp_config() below. If either of them is
>> called actually, boot_cpu_physical_apicid has the apicid different from
>> the current actual booting-up cpu temporarily. But init_apic_mappings()
>> soon modifies back the value to the one obtained by read_apic_id().
>>
>>          /*
>>           * Read APIC and some other early information from ACPI tables.
>>           */
>>          acpi_boot_init();
>>          sfi_init();
>>          x86_dtb_init();
>>
>>          /*
>>           * get boot-time SMP configuration:
>>           */
>>          if (smp_found_config)
>>                  get_smp_config();
>>
>>          prefill_possible_map();
>>
>>          init_cpu_to_node();
>>
>>          init_apic_mappings();
>>
>> So, thanks to init_apic_mappings(), the patch set would work without the
>> first patch... This is a careless point in this patch set.
>>
>
> If init_apic_mappings(), is making sure that boot_cpu_physical_apicid is
> apic id of booting processor, and you don't need first patch of your
> series, then I think atleast re-post your patch series without first
> patch.
>

Yes, I'll repost soon.

> And then there can be another series which looks into whether we need
> two different variables or not and if we do, then a separate variable
> bsp_physical_apicid will track the bsp id as reported by BIOS and
> boot_cpu_physical_apicid will track apic id of booting cpu. This might
> a very big and slow cleanup. So I think blocking the first patch series
> behind it might not make much sense.
>

Yes, the current handling of boot_cpu_physical_apicid looks strange and
should be cleaned up, but the cleaning up needs reviewing together with
the maintainers for the corresponding part; in particular, it can be
lengthy for the reviewing on amdtopology.c. I leave this as another
work for the time being.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
