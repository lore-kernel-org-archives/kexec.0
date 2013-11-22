Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjg2B-0003es-8e
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 01:59:51 +0000
Date: Thu, 21 Nov 2013 20:59:10 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 2/3] x86, apic: Add disable_cpu_apicid kernel parameter
Message-ID: <20131122015910.GB31921@redhat.com>
References: <20131121015951.2748.47826.stgit@localhost6.localdomain6>
 <20131121020044.2748.70221.stgit@localhost6.localdomain6>
 <20131121213300.GR16208@redhat.com>
 <528EA874.9010609@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <528EA874.9010609@jp.fujitsu.com>
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

On Fri, Nov 22, 2013 at 09:42:28AM +0900, HATAYAMA Daisuke wrote:
> (2013/11/22 6:33), Vivek Goyal wrote:
> >On Thu, Nov 21, 2013 at 11:00:44AM +0900, HATAYAMA Daisuke wrote:
> >
> >[..]
> >>@@ -2122,6 +2129,19 @@ void generic_processor_info(int apicid, int version)
> >>  	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
> >>  				phys_cpu_present_map);
> >>
> >>+	if (disabled_cpu_apicid != BAD_APICID &&
> >>+	    disabled_cpu_apicid != boot_cpu_physical_apicid &&
> >
> >Hi Hatayama,
> >
> >So we are comparing disabled_cpu_apicid with boot_cpu_physical_apicid
> >to make sure that one can not disable the cpu we are booting on. Can
> >we just read the apic id of booting cpu in local variable and compare
> >against that?
> >
> >Something like as follows.
> >
> >	if (disabled_cpu_apicid != BAD_APICID &&
> >	    disabled_cpu_apicid == apicid &&
> >	    disabled_cpu_apicid != read_apic_id()) {
> >		/* Disable cpu */	
> >	}
> >
> >If above works, you will not need first patch in the series?
> >
> 
> Yes, I came up with the idea, too. But doing this means we leave two different
> ways boot_cpu_physical_apicid is used at boot, which seemed incomplete as a
> patch. Also, then we could even lost the reason why boot_cpu_physical_apicid
> exists.
> 
> But, it's true that the 1st patch causes one more reviewing point. I'll
> remove it and fix the 2nd patch just as you suggested here.

I would say that do the boot_cpu_physical_id related cleanup in a separate
series. If we keep this patch really simple without fear of breaking
anything else, acking and committing the patch becomes easier.

Feel free to post boot cpu related cleanup in a separate series.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
