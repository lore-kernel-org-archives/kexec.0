Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1469812795.16559.42.camel@infradead.org>
Subject: Re: [PATCH v2 4/4] arm64: Add support for binary image files
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 29 Jul 2016 10:19:55 -0700
In-Reply-To: <20160729171552.GB478@localhost.localdomain>
References: <cover.1469559530.git.geoff@infradead.org>
 <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
 <20160728040125.GA27150@localhost.localdomain>
 <1469729083.16559.26.camel@infradead.org>
 <20160729033514.GC27150@localhost.localdomain>
 <1469811760.16559.33.camel@infradead.org>
 <20160729171552.GB478@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, 2016-07-29 at 22:45 +0530, Pratyush Anand wrote:
> Hi Geoff,
> 
> On 29/07/2016:10:02:40 AM, Geoff Levand wrote:
> > On Fri, 2016-07-29 at 09:05 +0530, Pratyush Anand wrote:
> > 
> > > See kexec/crashdump-elf.c:FUNC()
> > > We have:
> > > 223                 phdr->p_vaddr = phys_to_virt(elf_info,
> > > mstart);
> > > 
> > 
> > These patches don't support kdump.
> 
> OK, so you suggest that I should keep this patch as it is and add -
> -page-offset
> in corresponding kdump patch. I can do that, no issue.

Yes, this is an issue related to kdump, so let's discuss it in that
context.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
