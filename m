Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfR6Z-0001zx-T0
 for kexec@lists.infradead.org; Fri, 04 Jan 2019 15:09:49 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x04F9BF1142753
 for <kexec@lists.infradead.org>; Fri, 4 Jan 2019 10:09:45 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pt6yerwtt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 04 Jan 2019 10:09:44 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <rppt@linux.ibm.com>;
 Fri, 4 Jan 2019 15:09:41 -0000
Date: Fri, 4 Jan 2019 17:09:29 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of
 bottom-up after parsing hotplug attr
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-2-git-send-email-kernelfans@gmail.com>
 <20181231084018.GA28478@rapoport-lnx>
 <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
 <20190102092749.GA22664@rapoport-lnx>
 <20190102101804.GD1990@MiWiFi-R3L-srv>
 <20190102170537.GA3591@rapoport-lnx>
 <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
Message-Id: <20190104150929.GA32252@rapoport-lnx>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, kexec@lists.infradead.org, Stefan Agner <stefan@agner.ch>, Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, Dave Young <dyoung@redhat.com>, Daniel Vacek <neelx@redhat.com>, vgoyal@redhat.com, Len Brown <lenb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Pingfan Liu <kernelfans@gmail.com>, yinghai@kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mathieu Malaterre <malat@debian.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jan 03, 2019 at 10:47:06AM -0800, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 02, 2019 at 07:05:38PM +0200, Mike Rapoport wrote:
> > I agree that currently the bottom-up allocation after the kernel text has
> > issues with KASLR. But this issues are not necessarily related to the
> > memory hotplug. Even with a single memory node, a bottom-up allocation will
> > fail if KASLR would put the kernel near the end of node0.
> > 
> > What I am trying to understand is whether there is a fundamental reason to
> > prevent allocations from [0, kernel_start)?
> > 
> > Maybe Tejun can recall why he suggested to start bottom-up allocations from
> > kernel_end.
> 
> That's from 79442ed189ac ("mm/memblock.c: introduce bottom-up
> allocation mode").  I wasn't involved in that patch, so no idea why
> the restrictions were added, but FWIW it doesn't seem necessary to me.

I should have added the reference [1] at the first place :)
Thanks!

[1] https://lore.kernel.org/lkml/20130904192215.GG26609@mtj.dyndns.org/
 
> Thanks.
> 
> -- 
> tejun
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
