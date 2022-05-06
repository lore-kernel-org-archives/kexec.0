From: Baoquan He <bhe@redhat.com>
Date: Fri, 6 May 2022 19:39:36 +0800
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <YnPdIvOktZBQYLjg@arm.com>
References: <YmlphvZVMsGfFksp@arm.com> <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
 <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
 <3fc41a94-4247-40f3-14e7-f11e3001ec33@huawei.com>
 <YmtaiJhwIgP6m2Sk@MiWiFi-R3L-srv>
 <a9c736a0-f2b3-5b8a-94d9-80742ccd2700@huawei.com>
 <23e2dcf4-4e9a-5298-d5d8-8761b0bbbe21@huawei.com>
 <YnGmCwaWkvCrJoU2@arm.com> <YnM9w69l5dbE+k15@MiWiFi-R3L-srv>
 <YnPdIvOktZBQYLjg@arm.com>
Message-ID: <YnUI+PagSCZ/DnkL@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/05/22 at 03:20pm, Catalin Marinas wrote:
> On Thu, May 05, 2022 at 11:00:19AM +0800, Baoquan He wrote:
> > On 05/03/22 at 11:00pm, Catalin Marinas wrote:
> > > So, to recap, IIUC you are fine with:
> > > 
> > > 	crashkernel=Y		- allocate within ZONE_DMA with fallback
> > > 				  above with a default in ZONE_DMA (like
> > > 				  x86, 256M or swiotlb size)
> > 
> >         Ack to this one.
> > 
> > 
> > > 	crashkernel=Y,high	- allocate from above ZONE_DMA
> > 
> >         Not exactly. If there's only ZONE_DMA, crashkernel,high will
> >         be reserved in ZONE_DMA, and crashkernel,low will be ignored.
> >         Other than this, ack.
> 
> Yes, that's fine.
> 
> > > 	crashkernel=Y,low	- allocate within ZONE_DMA
> > 
> >         Ack to this one.
> > > 
> > > 'crashkernel' overrides the high and low while the latter two can be
> > > passed independently.
> > 
> >         crashkernel=,high can be passed independently, then a crashkernel=,low
> >         is needed implicitly. If people don't want crashkernel=,low
> >         explicitly, crashkernel=0,low need be specified.
> 
> I find this complicating the interface. I don't know the background to
> the x86 implementation but we diverge already on arm64 since we talk
> about ZONE_DMA rather than 4G limit (though for most platforms these
> would be the same).
> 
> I guess we could restate the difference between crashkernel= and
> crashkernel=,high as the hint to go for allocation above ZONE_DMA first.

Yes, rethinking about this, we can make a straightforward and simpler
crashkernel=,high|,low on arm64, namely asking for user to clearly
specify them.

During maintenance of crashkernel= parameter in our distros, we found
crashkernel=xM is used mostly since most of systems can be satisfied
with 256M or a little more for kdump. While on some big end servers,
1G or more crashkernel memory is needed. In this case, crashkernel=,high
is taken. We don't want to reserve so much low memory during system
running while just waiting in case rare crash happened. crashkernel=,high
is rarely used, so making it simple and not so flexible is not so bad.
We can improve it later with justification.

> 
> >         An independent crashkernel=,low makes no sense. Crashkernel=,low
> >         should be paird with crashkernel=,high.
> 
> You could argue that crashkernel=,low gives the current crashkernel=
> behaviour, i.e. either all within ZONE_DMA or fail to allocate. So it
> may have some value on its own.

Yes, crashkernel=,low has the same behaviour as the current crashkernel=
if we decide not to add fallback mechanism to it. The purpose of
crahskernel=,low is to assist crashkernel=,high to get kdump kernel
boot up with satisfing DMA allocation. While allowing independent
crashkernel=,low will add it another mission, limiting crashkernel only
reserved in low memory. Up to now, we don't see the need for that.

> 
> >         My personal opinion according to the existed senmantics on x86.
> >         Otherwise, the guidance of crashkernel= |,high|,low reservation
> >         will be complicated to write.
> 
> It's more that I find the current semantics unnecessarily confusing. But
> even reading the x86_64 text it's not that clear. For example the
> default low allocation for crashkernel= and crashkernel=,high is only
> mentioned in the crashkernel=,low description.

Yeah, we can improve those document if insufficiency is found.

By the way, with my observation, crashkernel= with fallback meet
99% of our needs. If people really need more than 512M memory or more,
then please consider crashkernel=,high. Basically on servers, low memory
is limited, while high memory is very big.

So I agree with you that we can make it step by step, firstly adding
basic crashkernel=,high and ,low support. We can add those complicated
cases later. 


