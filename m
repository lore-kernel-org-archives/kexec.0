From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 5 May 2022 15:20:18 +0100
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <YnM9w69l5dbE+k15@MiWiFi-R3L-srv>
References: <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
 <YmlphvZVMsGfFksp@arm.com> <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
 <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
 <3fc41a94-4247-40f3-14e7-f11e3001ec33@huawei.com>
 <YmtaiJhwIgP6m2Sk@MiWiFi-R3L-srv>
 <a9c736a0-f2b3-5b8a-94d9-80742ccd2700@huawei.com>
 <23e2dcf4-4e9a-5298-d5d8-8761b0bbbe21@huawei.com>
 <YnGmCwaWkvCrJoU2@arm.com> <YnM9w69l5dbE+k15@MiWiFi-R3L-srv>
Message-ID: <YnPdIvOktZBQYLjg@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, May 05, 2022 at 11:00:19AM +0800, Baoquan He wrote:
> On 05/03/22 at 11:00pm, Catalin Marinas wrote:
> > So, to recap, IIUC you are fine with:
> > 
> > 	crashkernel=Y		- allocate within ZONE_DMA with fallback
> > 				  above with a default in ZONE_DMA (like
> > 				  x86, 256M or swiotlb size)
> 
>         Ack to this one.
> 
> 
> > 	crashkernel=Y,high	- allocate from above ZONE_DMA
> 
>         Not exactly. If there's only ZONE_DMA, crashkernel,high will
>         be reserved in ZONE_DMA, and crashkernel,low will be ignored.
>         Other than this, ack.

Yes, that's fine.

> > 	crashkernel=Y,low	- allocate within ZONE_DMA
> 
>         Ack to this one.
> > 
> > 'crashkernel' overrides the high and low while the latter two can be
> > passed independently.
> 
>         crashkernel=,high can be passed independently, then a crashkernel=,low
>         is needed implicitly. If people don't want crashkernel=,low
>         explicitly, crashkernel=0,low need be specified.

I find this complicating the interface. I don't know the background to
the x86 implementation but we diverge already on arm64 since we talk
about ZONE_DMA rather than 4G limit (though for most platforms these
would be the same).

I guess we could restate the difference between crashkernel= and
crashkernel=,high as the hint to go for allocation above ZONE_DMA first.

>         An independent crashkernel=,low makes no sense. Crashkernel=,low
>         should be paird with crashkernel=,high.

You could argue that crashkernel=,low gives the current crashkernel=
behaviour, i.e. either all within ZONE_DMA or fail to allocate. So it
may have some value on its own.

>         My personal opinion according to the existed senmantics on x86.
>         Otherwise, the guidance of crashkernel= |,high|,low reservation
>         will be complicated to write.

It's more that I find the current semantics unnecessarily confusing. But
even reading the x86_64 text it's not that clear. For example the
default low allocation for crashkernel= and crashkernel=,high is only
mentioned in the crashkernel=,low description.

-- 
Catalin

