Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZDpU-0005jg-1L
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 05:51:32 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com>
 <526712B2.7070108@jp.fujitsu.com> <20131023155127.GA17437@redhat.com>
Date: Wed, 23 Oct 2013 22:50:13 -0700
In-Reply-To: <20131023155127.GA17437@redhat.com> (Vivek Goyal's message of
 "Wed, 23 Oct 2013 11:51:27 -0400")
Message-ID: <871u3bcj56.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic,
 kexec: Add disable_cpu_apic kernel parameter
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, jerry.hoemann@hp.com, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, bp@alien8.de, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

Vivek Goyal <vgoyal@redhat.com> writes:

> Hi Hatayama,
>
> So what information should I look for to prepare disable_cpu_apic=X in
> kdump script?
>
> Is BSP processor info exported to user space somewhere? Or assuming that
> processor 0 is BSP and corresponding apicid should be disabled in kdump
> kernel is good enough?

On x86 assuming that processor 0 is BSP should be good enough.  Unless
we starting getting SMP BIOSen playing games with us.

> I am looking at /proc/cpuinfo and following 3 fields seem interesting.
>
> processor: 0
> apicid		: 0
> initial apicid	: 0
>
> What's the difference between apicid and "initial apicid". I guess
> initial apicid reflects the apicid number as set by firmware and then
> kernel can overwrite it and new number would be reflected in "apicid"?

Last I was current initial apicid is the apic id the hardware chooses
and it tells you something about the topology of the processors in the
system.

The apicid is programmed by the BIOS so that the BSP can have apicid 0,
and apicid's can be contiguous etc.  In principle any piece of software
can program apicids but there is no advantage.

> If that's the case, then I guess we should be looking at "apicid" of
> processor "0" and set that in disable_cpu_apic? Because that's the
> number kdump kernel  boot should see in apic upon boot.

Restricting this to x86 and not Voyager that is correct.  Linux cpu 0
is the processor we booted up on as is apparent lots of things special
case the bootstrap processor so using a cpu hotplug remove to make it go
away is silly.  Still to handle cazy cpu hotplug I would recomend to
simply force a single cpu if you can't find cpu 0.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
