Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVAXT-0003sL-DR
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 04:45:49 +0000
Received: by mail-pf0-x231.google.com with SMTP id x72so83728268pfd.2
 for <kexec@lists.infradead.org>; Wed, 03 Aug 2016 21:45:25 -0700 (PDT)
Date: Thu, 4 Aug 2016 13:51:05 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 4/4] arm64: Add support for binary image files
Message-ID: <20160804045104.GJ7995@linaro.org>
References: <cover.1469559530.git.geoff@infradead.org>
 <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
 <20160728040125.GA27150@localhost.localdomain>
 <1469729083.16559.26.camel@infradead.org>
 <20160729033514.GC27150@localhost.localdomain>
 <1469811760.16559.33.camel@infradead.org>
 <20160729171552.GB478@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160729171552.GB478@localhost.localdomain>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Pratyush,

On Fri, Jul 29, 2016 at 10:45:52PM +0530, Pratyush Anand wrote:
> Hi Geoff,
> 
> On 29/07/2016:10:02:40 AM, Geoff Levand wrote:
> > On Fri, 2016-07-29 at 09:05 +0530, Pratyush Anand wrote:
> > 
> > > See kexec/crashdump-elf.c:FUNC()
> > > We have:
> > > 223                 phdr->p_vaddr = phys_to_virt(elf_info, mstart);
> > > 
> > 
> > These patches don't support kdump.
> 
> OK, so you suggest that I should keep this patch as it is and add --page-offset
> in corresponding kdump patch. I can do that, no issue.

I will add necessary hunks from your old patch when I submit
a next version of patches for arm64, probably next Monday.

I hope that you don't mind.

Thanks,
-Takahiro AKASHI

> ~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
