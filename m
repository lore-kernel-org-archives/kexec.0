Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 30 Jul 2010 19:50:19 +0100 (BST)
From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: In place kexec
In-Reply-To: <20100730183446.GC3332@redhat.com>
Message-ID: <alpine.LFD.2.00.1007301948420.13729@dwoodhou-mobl2.ger.corp.intel.com>
References: <4C51BFA5.60507@zytor.com> <m1k4oe88n9.fsf@fess.ebiederm.org>
	<4C51C878.2090102@zytor.com> <20100729191654.GB28704@redhat.com>
	<m1lj8uvzgy.fsf@fess.ebiederm.org>
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<1280508817.28006.0.camel@macbook.infradead.org>
	<m1vd7w3k5l.fsf@fess.ebiederm.org>
	<20100730183446.GC3332@redhat.com>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-driver@qlogic.com, Andrew Vasquez <andrew.vasquez@qlogic.com>

On Fri, 30 Jul 2010, Vivek Goyal wrote:

> On Fri, Jul 30, 2010 at 11:21:42AM -0700, Eric W. Biederman wrote:
>> David Woodhouse <dwmw2@infradead.org> writes:
>>
>>> On Thu, 2010-07-29 at 21:41 -0700, Eric W. Biederman wrote:
>>>> There isn't a bus master shut off at the core level.
>>>
>>> Effectively, there is if you have an IOMMU.
>>
>> Depends on the IOMMU.  There are several dinky IOMMUs that when you
>> shut them off DMA simply goes around them, and is not stopped.
>
> I think last time we were discussing this for AMD IOMMU where if you
> disable IOMMU, it just kind of become pass through with 1:1 mapping of
> addresses.

Yeah, don't do that. The IOMMU should be *on*, but without any active 
mappings set up. Which is exactly how Linux will set it up at boot.

-- 
dwmw2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
