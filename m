Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lXfEV-004eAW-3K
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 07:19:13 +0000
Date: Sat, 17 Apr 2021 09:19:05 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1] arm: do not copy magic 4 bytes of appended DTB in
 zImage
Message-ID: <20210417071905.GB2573@vergenet.net>
References: <20210408200644.19724-1-egorenar-dev@posteo.net>
 <20210412103853.GA28946@vergenet.net> <874kgb3fq8.fsf@posteo.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874kgb3fq8.fsf@posteo.net>
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
To: Alexander Egorenkov <egorenar@posteo.net>
Cc: Alexander Egorenkov <egorenar-dev@posteo.net>, rmk@armlinux.org.uk, kexec@lists.infradead.org

On Mon, Apr 12, 2021 at 01:27:27PM +0200, Alexander Egorenkov wrote:
> Simon Horman <horms@verge.net.au> writes:
> 
> > On Thu, Apr 08, 2021 at 10:06:44PM +0200, Alexander Egorenkov wrote:
> >> If the passed zImage happens to have a DTB appended, then the magic 4 bytes
> >> of the DTB are copied together with the kernel image. This leads to
> >> failed kexec boots because the decompressor finds the aforementioned
> >> DTB magic and falsely tries to replace the DTB passed in the register r2
> >> with the non-existent appended one.
> >> 
> >> Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>
> >
> > Hi,
> >
> > I also see that, on line 558 len is further expanded as follows:
> >
> >         /*
> >          * The zImage length does not include its stack (4k) or its
> >          * malloc space (64k).  Include this.
> >          */
> >         len += 0x11000;
> >
> > Is it intentional that this patch also excludes this extra length
> > from the DTB? Or am I missing something?
> >
> 
> Hi,
> 
> if i understood it right, then len expresses not the length of the
> kernel image in the zImage but the length of the kernel memory segment
> into which the kernel image is being loaded. And on this line of code
> it is adjusted to account for stack and heap, i think.

Thanks, I think that answers my question.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
