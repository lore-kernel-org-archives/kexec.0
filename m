Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZUBgg-00084h-VE
 for kexec@lists.infradead.org; Tue, 25 Aug 2015 10:42:43 +0000
Date: Tue, 25 Aug 2015 16:12:19 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH RFC] Drop release date from kexec-tools version output
Message-ID: <20150825104219.GA2948@dhcppc13>
References: <20150824091005.GA10044@dhcp-16-198.nay.redhat.com>
 <20150824102923.GA21306@dhcppc13.redhat.com>
 <20150825084759.GC20225@dhcp-129-120.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150825084759.GC20225@dhcp-129-120.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 25/08/2015:04:47:59 PM, Dave Young wrote:
> On 08/24/15 at 03:59pm, Pratyush Anand wrote:
> > 
> > May be we can take same approach what kernel build takes. Kernel build does not
> > add build/release string. It just add date and time like "Mon Aug 10 23:38:23 UTC 2015".
> > 
> > $ uname -a
> > Linux dhcppc13 4.1.5-200.fc22.x86_64 #1 SMP Mon Aug 10 23:38:23 UTC 2015 x86_64
> > x86_64 x86_64 GNU/Linux
> > 
> 
> Do you means drop "released" string only and keep the date? I'm also fine with
> it, at lease less confusion to me.

Yes, exactly.

Thanks

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
