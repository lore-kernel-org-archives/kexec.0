Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdCQb-0001oL-Oa
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 05:42:35 +0000
Date: Thu, 24 Apr 2014 14:42:09 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec-tools] [PATCH] Do not distribute generated files in the
 release tarball
Message-ID: <20140424054209.GI8892@verge.net.au>
References: <1398313256-20388-1-git-send-email-pabs3@bonedaddy.net>
 <20140424043255.GC9469@verge.net.au>
 <1398314768.7980.66.camel@chianamo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398314768.7980.66.camel@chianamo>
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
To: Paul Wise <pabs3@bonedaddy.net>
Cc: kexec@lists.infradead.org

On Thu, Apr 24, 2014 at 12:46:08PM +0800, Paul Wise wrote:
> On Thu, 2014-04-24 at 13:32 +0900, Simon Horman wrote:
> 
> > While I'm not opposed to this off-hand I am curious to know what the
> > motivation for it is.
> 
> Within Debian there has been a renewed focus on finding and removing
> sourceless files and one Debian contributor mentioned kexec/purgatory.c
> on IRC and asked for help finding if source was missing. It was
> concluded that the source was present and this wasn't an issue....

Thanks, an interesting initiative.

> ..but I tend to think that generated files should always be built from
> source and never be present in VCS repositories and only autotools
> generated files should be in tarballs. This ensures that they get built
> as often as possible and bugs with that process are discovered early.

That seems reasonable to me.

Could you add something like that to the changelog and add
a signed-off-by line?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
