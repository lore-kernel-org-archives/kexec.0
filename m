Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TgzOc-0007H5-5D
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 14:59:23 +0000
Date: Fri, 7 Dec 2012 09:59:09 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 0/8] remove vm_struct list management
Message-ID: <20121207145909.GA4928@redhat.com>
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
 <20121206145020.93fd7128.akpm@linux-foundation.org>
 <CAAmzW4N-=uXBdgjbkdL=aNVtKvvXZs-6BNgpDzi7CLkeo0-jBg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAmzW4N-=uXBdgjbkdL=aNVtKvvXZs-6BNgpDzi7CLkeo0-jBg@mail.gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: JoonSoo Kim <js1304@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Dave Anderson <anderson@redhat.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

On Fri, Dec 07, 2012 at 10:16:55PM +0900, JoonSoo Kim wrote:
> 2012/12/7 Andrew Morton <akpm@linux-foundation.org>:
> > On Fri,  7 Dec 2012 01:09:27 +0900
> > Joonsoo Kim <js1304@gmail.com> wrote:
> >
> >> I'm not sure that "7/8: makes vmlist only for kexec" is fine.
> >> Because it is related to userspace program.
> >> As far as I know, makedumpfile use kexec's output information and it only
> >> need first address of vmalloc layer. So my implementation reflect this
> >> fact, but I'm not sure. And now, I don't fully test this patchset.
> >> Basic operation work well, but I don't test kexec. So I send this
> >> patchset with 'RFC'.
> >
> > Yes, this is irritating.  Perhaps Vivek or one of the other kexec
> > people could take a look at this please - if would obviously be much
> > better if we can avoid merging [patch 7/8] at all.
> 
> I'm not sure, but I almost sure that [patch 7/8] have no problem.
> In kexec.c, they write an address of vmlist and offset of vm_struct's
> address field.
> It imply that user for this information doesn't have any other
> information about vm_struct,
> and they can't use other field of vm_struct. They can use *only* address field.
> So, remaining just one vm_struct for vmlist which represent first area
> of vmalloc layer
> may be safe.

I browsed through makedumpfile source quickly. So yes it does look like
that we look at first vmlist element ->addr field to figure out where
vmalloc area is starting.

Can we get the same information from this rb-tree of vmap_area? Is
->va_start field communication same information as vmlist was
communicating? What's the difference between vmap_area_root and vmlist.

So without knowing details of both the data structures, I think if vmlist
is going away, then user space tools should be able to traverse vmap_area_root
rb tree. I am assuming it is sorted using ->addr field and we should be
able to get vmalloc area start from there. It will just be a matter of
exporting right fields to user space (instead of vmlist).

CCing Atsushi Kumagai and Dave Anderson. Atsushi-san is the one who
maintains makedumpfile. Dave Anderson maintains "crash" and looks like
it already has the capability to traverse through vmap_area_root
rb-tree.

So please let us know if left most element of vmap_area_root rb-tree will
give us start of vmalloc area or not?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
