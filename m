Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VblaQ-00083k-Co
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 06:18:31 +0000
Date: Thu, 31 Oct 2013 14:18:01 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v2] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
Message-ID: <20131031061801.GC7611@dhcp16-109.nay.redhat.com>
References: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
 <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
 <20131030031253.GD20932@dhcp16-109.nay.redhat.com>
 <1383152798.31813.2.camel@odvarok>
 <20131031053808.GA7611@dhcp16-109.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131031053808.GA7611@dhcp16-109.nay.redhat.com>
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
To: Lubomir Rintel <lkundrak@v3.sk>, Simon Horman <horms@verge.net.au>
Cc: Joe Perches <joe@perches.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On 10/31/13 at 01:38pm, WANG Chao wrote:
> On 10/30/13 at 06:06pm, Lubomir Rintel wrote:
> > Hi,
> > 
> > On Wed, 2013-10-30 at 11:12 +0800, WANG Chao wrote:
> > > On 09/19/13 at 04:49pm, Lubomir Rintel wrote:
> > > > Symbol name changed with the following commit:
> > > > 62e32ac printk: rename struct log to struct printk_log
> > ...
> > > vmcore-dmesg is really broken here since 3.11 kernel is released. Are
> > > you going to send an update v3 to address the comments to v2 from Vivek,
> > > Joe and Dave
> > 
> > I'm not really sure. I thought the suggestions were concerning the Linux
> > kernel tree, not kexec-tools tree. I might be wrong though, but I'd need
> > the suggestions to be a bit more specific for me to understand.
> 
> That wouldn't be your concern any more.

Hi, Lubomir,

I'm sorry. I was told that this phrase is not friendly and nearly rude.
By that I realy mean I think your patch has no problem and you don't
need to concern what I brought up in my first email.

I'm not a native speaker and that was not my intention. I should have
choosed my words more carefully. Sorry again.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
