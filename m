Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr1bu-0006S6-Ch
 for kexec@lists.infradead.org; Tue, 05 Feb 2019 14:22:07 +0000
Date: Tue, 5 Feb 2019 15:21:57 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory: Use standalond CFLAGS
Message-ID: <20190205142147.naqs2gw5en77x5nu@verge.net.au>
References: <20190128105040.30520-1-kasong@redhat.com>
 <20190128105844.zx4bmpkovlzs2wsx@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128105844.zx4bmpkovlzs2wsx@verge.net.au>
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
To: Kairui Song <kasong@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

On Mon, Jan 28, 2019 at 11:58:44AM +0100, Simon Horman wrote:
> On Mon, Jan 28, 2019 at 06:50:40PM +0800, Kairui Song wrote:
> > There has been a lot of workarounds for purgatory disabling many
> > specified CFLAGS that will break purgatory. It will be better to not
> > let the CFLAGS used to compile purgatory honor the CFLAGS from
> > environment variables. So we will have stable CFLAGS for purgatory.
> > 
> > If anyone still wants to change purgatory CFLAGS, PURGATORY_EXTRA_CFLAGS
> > is still honored.
> 
> Thanks, this seems reasonable to me.
> But I'd like to wait to see if there is feedback from others before applying.

Thanks again, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
