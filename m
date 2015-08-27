Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZUqhc-0006GQ-M5
 for kexec@lists.infradead.org; Thu, 27 Aug 2015 06:30:26 +0000
Date: Thu, 27 Aug 2015 14:29:57 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH RFC] Drop release date from kexec-tools version output
Message-ID: <20150827062956.GD3427@dhcp-129-155.nay.redhat.com>
References: <20150824091005.GA10044@dhcp-16-198.nay.redhat.com>
 <20150824102923.GA21306@dhcppc13.redhat.com>
 <20150825084759.GC20225@dhcp-129-120.nay.redhat.com>
 <20150825104219.GA2948@dhcppc13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150825104219.GA2948@dhcppc13>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 08/25/15 at 04:12pm, Pratyush Anand wrote:
> On 25/08/2015:04:47:59 PM, Dave Young wrote:
> > On 08/24/15 at 03:59pm, Pratyush Anand wrote:
> > > 
> > > May be we can take same approach what kernel build takes. Kernel build does not
> > > add build/release string. It just add date and time like "Mon Aug 10 23:38:23 UTC 2015".
> > > 
> > > $ uname -a
> > > Linux dhcppc13 4.1.5-200.fc22.x86_64 #1 SMP Mon Aug 10 23:38:23 UTC 2015 x86_64
> > > x86_64 x86_64 GNU/Linux
> > > 
> > 
> > Do you means drop "released" string only and keep the date? I'm also fine with
> > it, at lease less confusion to me.
> 
> Yes, exactly.
> 

Pratyush, rethink about it, it is still confused. Considering below case:

git clone kexec-tools;
bootstrap and build, the version and date is the current git version and current date
after some time, git pull, upstream bumps to new version
run make again, build/sbin/kexec --version will still show the old date along with new version

I know one can say we should make distclean and run bootstrap again, but it really worth?

Am I the only person with such feel?

Thanks
dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
