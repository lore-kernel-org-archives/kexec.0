Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMvKZ-0001af-LL
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 07:40:49 +0000
Date: Fri, 20 Sep 2013 15:40:14 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
Message-ID: <20130920074014.GB21922@dhcp-16-126.nay.redhat.com>
References: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
 <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
 <20130920015047.GA4989@dhcp-16-126.nay.redhat.com>
 <1379642127.2021.1.camel@joe-AO722>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379642127.2021.1.camel@joe-AO722>
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
To: Joe Perches <joe@perches.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On 09/19/13 at 06:55pm, Joe Perches wrote:
> On Fri, 2013-09-20 at 09:50 +0800, Dave Young wrote:
> > On 09/19/13 at 04:49pm, Lubomir Rintel wrote:
> > > Symbol name changed with the following commit:
> > > 62e32ac printk: rename struct log to struct printk_log
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Joe Perches <joe@perches.com>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > ---
> > 
> > Acked-by: Dave Young <dyoung@redhat.com>
> 
> It might be nice if there was a reference somewhere in
> the linux kernel source tree to whatever it is that this
> patch modifies.
> 

Agree with you, it will be better to add the info in comment. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
