Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uv7pN-0000gA-BT
 for kexec@lists.infradead.org; Fri, 05 Jul 2013 15:21:42 +0000
Date: Fri, 5 Jul 2013 11:21:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Not booting BSP in kdump kernel (Was: Re: 32TB kdump)
Message-ID: <20130705152115.GD10152@redhat.com>
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com>
 <51D0D399.1070501@jp.fujitsu.com>
 <20130701160635.GB9840@redhat.com>
 <51D3D15D.5090600@jp.fujitsu.com>
 <20130703130324.GA1460@redhat.com>
 <51D4D802.3050503@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D4D802.3050503@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Jul 04, 2013 at 11:03:46AM +0900, HATAYAMA Daisuke wrote:

[..]
> >It took around 400 seconds to capture compressed dump on disk and out of
> >that 326 seconds were consumed by compression only. Around 80% of total
> >dump time in this case was attributed to compression.
> >
> >So this sounds like the next big fish to go after. Using lzo and
> >snappy might help a bit. But I think bringing up more cpus in second
> >kernel should help too.
> >
> >What's the status of your patches to bring up multiple cpus in kdump
> >kernel. Are you planning to push these upstream?
> >
> 
> My next patch is the same as in diff:
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/1210.2/00014.html
> 
> Now there's need to compare the idea with Eric's suggestion that unsets BSP flag from boot cpu
> at the boot time of 1st kernel, which is very simpler than the idea of mine. However,
> HPA pointed out that the Eric's idea could affect some sort of firmware.
> I'm investigating that now.
> 
> Candidates I've found so far is ACPI firmware. ACPI specification describes that in FADT part,
> SMI_CMD and other SMI releated commands need to be called on boot processor, i.e. cpu with BSP
> flag; See Table 5-34 in ACPI spec 5.0. I associate this to restriction of cpu hotplug that boot
> processor cannot be physically removed. Also, there's comment in __acpi_os_execute():
> 
>         /*
>          * On some machines, a software-initiated SMI causes corruption unless
>          * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
>          * typically it's done in GPE-related methods that are run via
>          * workqueues, so we can avoid the known corruption cases by always
>          * queueing on CPU 0.
>          */
>         ret = queue_work_on(0, queue, &dpc->work);
> 
> But I don't know whether the SMI requires even BSP flag set or not. I need suggestion from
> experts around this field.
> 
> I'll post the patch next week and send cc to some experts in order to fill the patch
> description with concrete description about what kind of firmware is affected by unsetting
> BSP flag.

Ok. BTW, did clearing BSP flag work for you experimentally? Hpa mentioned
that it did not for Fenghua.

To me looking into ACPI/MP tables to figure out which is BSP and not
bringing up that cpu sounds simple and one does not have to worry
about dealing with side affects of clearing BSP bit, if any.

CCing Eric to figure out if he is particular about clearing BSP bit
solution or is willing to accept the solution of booting N-1 cpus
in kdump kernel by not bringing up BSP.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
