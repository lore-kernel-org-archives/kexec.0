Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KW2BM-0006Uo-9j
	for kexec@lists.infradead.org; Thu, 21 Aug 2008 04:54:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1218138156.3361.386.camel@amd.troyhebe>
	<20080808014024.GB3911@redhat.com>
	<1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com>
Date: Wed, 20 Aug 2008 21:50:21 -0700
In-Reply-To: <20080819134748.GC18972@redhat.com> (Vivek Goyal's message of
	"Tue, 19 Aug 2008 09:47:48 -0400")
Message-ID: <m1wsib3raq.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Heber, Troy" <troy.heber@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, "Loftin,
	Terry" <terry.loftin@hp.com>, Bob Montgomery <bob.montgomery@hp.com>

Vivek Goyal <vgoyal@redhat.com> writes:

> Hi Bob,
>
> I am CCing this thread to kexec mailing list. It is good to discuss
> the issue there to get the ideas.
>
> I will summarize the discussion so far.
>
> Bob is running into MCA in second kernel in kdump. Reason seems to be
> that second kernel is trying to access the memory area marked as
> GART aperture (by first kernel). Because GART aperture does not appear
> as "reserved" or something else in /proc/iomem (in case kernel has
> overridden the BIOS settings and has reserved a memory area), second
> kernel thinks it is a valid RAM area and tries to dump it and runs into
> issues.
>
> Few options Bob is considering are.
>
> - Update "e820" memory map to mark GART aperture as reserved, which will
>   be reflected in /proc/iomem also. Kexec-tools will not pass reserved
>   area to second kernel and it will not try to dump this area.
>
>
> - Mark GART aperture as "GART aperture" in /proc/iomem and modify
>   kexec-tools to filter out this memroy from memory map passed to second
>   kernel.


We should definitely reserve the resource, and it should definitely
show up in /proc/iomem.

> - Disable cpu side GART access in first kernel so that even if second
>   kernel tries to access it, it does not run into isseus.

This is an interesting one.  When I looked at this years ago I had the
feeling that if we did this we could actually always use a 2G Aperture
at a fixed address, and require going through the gart for all of lowmem.

But that is a little more than we are talking about.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
