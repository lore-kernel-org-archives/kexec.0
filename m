Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WI9OU-0003G3-RI
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 04:13:24 +0000
Date: Tue, 25 Feb 2014 12:12:55 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: More frequent kexec-tools releases
Message-ID: <20140225041255.GA32292@dhcp-17-89.nay.redhat.com>
References: <20140131052304.GC25099@verge.net.au>
 <20140131143047.GA10594@redhat.com>
 <20140204083151.GE30621@verge.net.au>
 <20140204124148.GH17028@verge.net.au>
 <52F18FFA.5060103@cn.fujitsu.com>
 <20140205064906.GB29499@verge.net.au>
 <20140205132015.GA6042@redhat.com>
 <20140206015513.GX5125@verge.net.au>
 <20140206142332.GA3674@redhat.com>
 <20140206235851.GB19799@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140206235851.GB19799@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On 02/07/14 at 08:58am, Simon Horman wrote:
> On Thu, Feb 06, 2014 at 09:23:32AM -0500, Vivek Goyal wrote:
> > On Thu, Feb 06, 2014 at 10:55:13AM +0900, Simon Horman wrote:
> > 
> > [..]
> > > > Thanks Simon. I did git pull but I don't see new tag in my tree. Not sure
> > > > why. 
> > > 
> > > Could you try again? I messed up the push.
> > 
> > It works now. Thanks.
> 
> It seems that a few bugs showed up in 2.0.5, fixes for which
> are now in the git repository. I am thinking it would be a good
> idea to release these as 2.0.6 unless people would rather that I held off.

As you mentioned, I found 2.0.5 doesn't build on i386. I consider these
are major bugs, which deserves a hot fix release as 2.0.6. What do you
think?

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
