Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTBOR-0003Fc-Sc
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 17:16:17 +0000
Received: by mail-pf0-f169.google.com with SMTP id x72so34540207pfd.2
 for <kexec@lists.infradead.org>; Fri, 29 Jul 2016 10:15:55 -0700 (PDT)
Date: Fri, 29 Jul 2016 22:45:52 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v2 4/4] arm64: Add support for binary image files
Message-ID: <20160729171552.GB478@localhost.localdomain>
References: <cover.1469559530.git.geoff@infradead.org>
 <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
 <20160728040125.GA27150@localhost.localdomain>
 <1469729083.16559.26.camel@infradead.org>
 <20160729033514.GC27150@localhost.localdomain>
 <1469811760.16559.33.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469811760.16559.33.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 29/07/2016:10:02:40 AM, Geoff Levand wrote:
> On Fri, 2016-07-29 at 09:05 +0530, Pratyush Anand wrote:
> 
> > See kexec/crashdump-elf.c:FUNC()
> > We have:
> > 223                 phdr->p_vaddr = phys_to_virt(elf_info, mstart);
> > 
> 
> These patches don't support kdump.

OK, so you suggest that I should keep this patch as it is and add --page-offset
in corresponding kdump patch. I can do that, no issue.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
