Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1dy0-0003wn-LM
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 15:25:49 +0000
Message-ID: <1389367167.1792.148.camel@misato.fc.hp.com>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
From: Toshi Kani <toshi.kani@hp.com>
Date: Fri, 10 Jan 2014 08:19:27 -0700
In-Reply-To: <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
References: <20140109145035.GB25897@redhat.com>
 <1389283439.1792.66.camel@misato.fc.hp.com>
 <20140109162427.GF25897@redhat.com>
 <1389288265.1792.108.camel@misato.fc.hp.com>
 <20140109182310.GG25897@redhat.com>
 <1389292470.1792.109.camel@misato.fc.hp.com>
 <20140109212705.GC12111@redhat.com>
 <1389304583.1792.139.camel@misato.fc.hp.com>
 <20140110071124.GA6464@dhcp-16-105.nay.redhat.com>
 <52CFAA20.2010109@jp.fujitsu.com>
 <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
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
To: Baoquan <bhe@redhat.com>
Cc: kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com, linux-acpi@vger.kernel.org, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, zhangyanfei@cn.fujitsu.com, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Fri, 2014-01-10 at 17:14 +0800, Baoquan wrote:
 :
> > 
> > >Otherwise, any hotplug memory which is not reserved for 2nd kernel can
> > >be parsed and need be added as hotplug memory, and add them into movable
> > >zone.
> > 
> > wrong.
> > The memory is allocated as normal zone and it is offline.

This is "logical" offline, which means that the memory is accessible,
but the 1st kernel does not use it.

> Hi,
> 
> Thanks for answering.
> 
> I am confused. Now the fact is in 1st kernel memory is reserved for
> crashkernel and passed to 2nd kernel by exactmap. Then in 2nd kernel,
> reserved memory regions are added into e820.

Right.  And this memory is accessible.  

>  Later hotplug memory still
> trigger add_memory, and cause bug I reported.

This is because the 2nd kernel gets all memory ranges from ACPI without
your change.  This is bad, not only it causes the panic you reported but
also it can overwrite the 1st kernel's memory.

Thanks,
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
