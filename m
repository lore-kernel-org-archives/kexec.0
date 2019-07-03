Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hiaBX-00086J-8C
 for kexec@lists.infradead.org; Wed, 03 Jul 2019 08:00:12 +0000
Date: Wed, 3 Jul 2019 10:00:07 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] x86: Support multiboot2 images
Message-ID: <20190703080007.aygcila3hdvnhjxb@verge.net.au>
References: <1561630363-6342-1-git-send-email-vrd@amazon.de>
 <1561630363-6342-2-git-send-email-vrd@amazon.de>
 <20190702110944.mcugf6krueakfpam@verge.net.au>
 <a8142dc999983b6fcd8c21314a1c082216226c92.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8142dc999983b6fcd8c21314a1c082216226c92.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: Varad Gautam <vrd@amazon.de>, Amit Shah <aams@amazon.de>, kexec@lists.infradead.org

On Tue, Jul 02, 2019 at 02:29:56PM +0100, David Woodhouse wrote:
> On Tue, 2019-07-02 at 13:09 +0200, Simon Horman wrote:
> > > diff --git a/include/x86/multiboot2.h b/include/x86/multiboot2.h
> > > new file mode 100644
> > > index 0000000..5693923
> > > --- /dev/null
> > > +++ b/include/x86/multiboot2.h
> > > @@ -0,0 +1,416 @@
> > > +/*  multiboot2.h - Multiboot 2 header file.  */
> > > +/*  Copyright (C) 1999,2003,2007,2008,2009,2010  Free Software Foundation, Inc.
> > > + *
> > > + *  Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + *  of this software and associated documentation files (the "Software"), to
> > > + *  deal in the Software without restriction, including without limitation the
> > > + *  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
> > > + *  sell copies of the Software, and to permit persons to whom the Software is
> > > + *  furnished to do so, subject to the following conditions:
> > > + *
> > > + *  The above copyright notice and this permission notice shall be included in
> > > + *  all copies or substantial portions of the Software.
> > > + *
> > > + *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL ANY
> > > + *  DEVELOPER OR DISTRIBUTOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > > + *  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
> > > + *  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> > > + */
> > 
> > As per my comment on your previous posting of this patch:
> > 
> > multiboot2.h does not appear to be licenced as GPLv2.
> > This seems incompatible with inclusion in kexec-tools.
> > Can we discuss this?
> 
> Er... why do you say that isn't GPL-compatible? It's just a standard
> MIT licence, isn't it?

Thanks David,

this is kind of what I meant by discuss.

Taking a look over the FSF site this morning I agree that:
a) this is the MIT license; and
b) it is compatible with GPLv2

With that in mind I have no objections to this series and
have applied it for inclusion in kexec v2.0.20.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
