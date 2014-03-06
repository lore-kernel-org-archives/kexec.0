Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLS9S-0005M5-Ks
 for kexec@lists.infradead.org; Thu, 06 Mar 2014 06:51:31 +0000
Message-ID: <53181AC1.2020807@zytor.com>
Date: Wed, 05 Mar 2014 22:50:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
 <20140305053617.GE26240@dhcp-17-89.nay.redhat.com>
 <20140306064756.GB16859@needle.mulix.org>
In-Reply-To: <20140306064756.GB16859@needle.mulix.org>
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
To: Muli Ben-Yehuda <muli@cs.technion.ac.il>, WANG Chao <chaowang@redhat.com>
Cc: discuss@x86-64.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Jon D. Mason" <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On 03/05/2014 10:47 PM, Muli Ben-Yehuda wrote:
> On Wed, Mar 05, 2014 at 01:36:17PM +0800, WANG Chao wrote:
> 
>> Hi, Muli
>>
>> saved_max_pfn is becoming a setback for kexec-tools. Ideally calgary
>> could get rid of saved_max_pfn at all. But If this can't work, how
>> about exporting a calgary tce table size to user space, so that
>> kexec-tools can simply pass calgary=xxx cmdline to 2nd kernel.
> 
> As Jon noted, this code is used to so that the TCE table remains
> consistent between the original and the kexec'd kernel. I see two
> options: either we hard code the TCE table size to the max so that
> this bit of code becomes redundant, or we explicitly pass the original
> table size (or the original max_pfn) to the kexec'd kernel. The first
> option is more appealing, because I don't think anyone is actually
> using the TCE table size -- we mostly added it for debugging the IOMMU
> TCE code at the time -- but since I don't have a Calgary machine
> anymore, I don't have any way to test it. The second option is uglier
> but would be fully backward-compatible and less likely to break
> things. Given that very few people are likely running the latest
> upstream kernel on Calgary/CalIOC2 machines, I'm inclined towards the
> first option.
> 
>> BTW MAINTAINERS file still uses your old email, please update
>> accordingly.
> 
> I think you are the first person to actually look up the Calgary
> maintainers in the last few years :-)
> 

OK, second question... is it time to axe Calgary?

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
