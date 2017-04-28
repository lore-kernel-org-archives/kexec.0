Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3yNm-00019x-MX
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 05:23:56 +0000
Date: Fri, 28 Apr 2017 13:23:26 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: allocate buffer in top-down, if specified,
 correctly
Message-ID: <20170428052326.GC3600@dhcp-128-65.nay.redhat.com>
References: <20170426082209.12127-1-takahiro.akashi@linaro.org>
 <1605356.Vp6YPvtjly@morokweng> <20170428005135.GA3963@fireball>
 <20170428051950.GB3600@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170428051950.GB3600@dhcp-128-65.nay.redhat.com>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, vgoyal@redhat.com, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Correct Vivek's email address
On 04/28/17 at 01:19pm, Dave Young wrote:
> Vivek, can you help to give some comments about the locate hole isssue
> in kexec_file?
> 
> On 04/28/17 at 09:51am, AKASHI Takahiro wrote:
> > Thiago,
> > 
> > Thank you for the comment.
> > 
> > On Thu, Apr 27, 2017 at 07:00:04PM -0300, Thiago Jung Bauermann wrote:
> > > Hello,
> > > 
> > > Am Mittwoch, 26. April 2017, 17:22:09 BRT schrieb AKASHI Takahiro:
> > > > The current kexec_locate_mem_hole(kbuf.top_down == 1) stops searching at
> > > > the first memory region that has enough space for requested size even if
> > > > some of higher regions may also have.
> > > 
> > > kexec_locate_mem_hole expects arch_kexec_walk_mem to walk memory from top to 
> > > bottom if top_down is true. That is what powerpc's version does.
> > 
> > Ah, I haven't noticed that, but x86 doesn't have arch_kexec_walk_mem and
> > how can it work for x86?
> > 
> > > Isn't it possible to walk resources from top to bottom?
> > 
> > Yes, it will be, but it seems to me that such a behavior is not intuitive
> > and even confusing if it doesn't come with explicit explanation.
> 
> Thing need to make clear is why do we need the change, it might be a
> problem for crashkernel=xM,low since that is for softiotlb in case
> crashkernel=xM,high being used, otherwise seems current code is fine.
>  
> Need seeking for old memory from Vivek to confirm.
> > 
> > > > This behavior is not consistent with locate_hole(hole_end == -1) function
> > > > of kexec-tools.
> > > > 
> > > > This patch fixes the bug, going though all the memory regions anyway.
> > > 
> > > This patch would break powerpc, because at the end of the memory walk kbuf 
> > > would have the lowest memory hole.
> > > 
> > > If it's not possible to walk resources in reverse order, then this patch needs 
> > > to change powerpc to always walk memory from bottom to top.
> > 
> > So I would like to hear from x86 guys.
> > 
> > Thanks
> > -Takahiro AKASHI
> > 
> > > -- 
> > > Thiago Jung Bauermann
> > > IBM Linux Technology Center
> > > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
