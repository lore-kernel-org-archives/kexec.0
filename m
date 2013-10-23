Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZ0kQ-0001jh-LN
 for kexec@lists.infradead.org; Wed, 23 Oct 2013 15:53:27 +0000
Date: Wed, 23 Oct 2013 11:51:27 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
Message-ID: <20131023155127.GA17437@redhat.com>
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com>
 <526712B2.7070108@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <526712B2.7070108@jp.fujitsu.com>
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
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jerry.hoemann@hp.com, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

On Wed, Oct 23, 2013 at 09:05:06AM +0900, HATAYAMA Daisuke wrote:

[..]
> >Do you literally mean a human at each boot will have to configure
> >the kdump configuration files for passing disable_cpu_apic?
> >Or do you envision the setting of disable_cpu_apic being put into
> >the kdump initialization scripts?
> >
> >thanks
> >
> >Jerry
> 
> Nearer to the former case, but this is not what a human should do. It's
> a cumbersome task. I think, on fedora/RHEL system for example, kdump
> service should check at each boot automatically.

Hi Hatayama,

So what information should I look for to prepare disable_cpu_apic=X in
kdump script?

Is BSP processor info exported to user space somewhere? Or assuming that
processor 0 is BSP and corresponding apicid should be disabled in kdump
kernel is good enough?

I am looking at /proc/cpuinfo and following 3 fields seem interesting.

processor: 0
apicid		: 0
initial apicid	: 0

What's the difference between apicid and "initial apicid". I guess
initial apicid reflects the apicid number as set by firmware and then
kernel can overwrite it and new number would be reflected in "apicid"?

If that's the case, then I guess we should be looking at "apicid" of
processor "0" and set that in disable_cpu_apic? Because that's the
number kdump kernel  boot should see in apic upon boot.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
