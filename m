Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out.google.com ([216.239.45.13])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IYQy7-0008AC-OF
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 14:41:47 -0400
Date: Thu, 20 Sep 2007 11:40:41 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 5/4] [-mm patch] Rename macros returning the size.
In-Reply-To: <alpine.LFD.0.999.0709201746090.17093@enigma.security.iitk.ac.in>
Message-ID: <alpine.DEB.0.9999.0709201139000.14644@chino.kir.corp.google.com>
References: <46E9F6A9.8060500@mxs.nes.nec.co.jp>
	<46E9F942.5070007@mxs.nes.nec.co.jp>
	<20070914190350.011cdadb.akpm@linux-foundation.org>
	<46F204FD.6040303@mxs.nes.nec.co.jp>
	<46F2056E.6080601@mxs.nes.nec.co.jp>
	<alpine.LFD.0.999.0709201746090.17093@enigma.security.iitk.ac.in>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Satyam Sharma <satyam@infradead.org>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Adrian Bunk <bunk@kernel.org>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 20 Sep 2007, Satyam Sharma wrote:

> > [PATCH 5/4] [-mm patch] Rename macros returning the size.
> >  The #define SIZE() should be renamed STRUCT_SIZE() since it's always 
> >  returning the size of the struct with a given name.  This would allow 
> >  TYPEDEF_SIZE() to simply become SIZE() since it need not be used 
> >  exclusively for typedefs. This idea is David Rientjes's.
> >  http://www.ussg.iu.edu/hypermail/linux/kernel/0709.1/1964.html
> > 
> > Thanks
> > Ken'ichi Ohmichi
> > 
> > ---
> > Signed-off-by: David Rientjes <rientjes@google.com>
> 
> Hmm, I think adding a s-o-b line for David here isn't quite correct.
> When someone reviews a patch and gives a suggestion, you only need to
> copy him on the next iteration (and he may ack it or whatever, if he
> wants) -- but adding a s-o-b line like that ends up (incorrectly)
> denoting that he came between the author-to-git-commit chain ...
> 

Feel free to add

	Acked-by: David Rientjes <rientjes@google.com>

since I've reviewed the patch and agree with it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
