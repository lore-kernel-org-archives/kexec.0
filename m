Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WnTP4-0007jR-N9
 for kexec@lists.infradead.org; Thu, 22 May 2014 13:51:27 +0000
Date: Thu, 22 May 2014 09:51:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
Message-ID: <20140522135101.GD13647@redhat.com>
References: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
 <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
 <20131030031253.GD20932@dhcp16-109.nay.redhat.com>
 <1383152798.31813.2.camel@odvarok>
 <20131031053808.GA7611@dhcp16-109.nay.redhat.com>
 <20131031062026.GX1603@verge.net.au> <52728878.2080302@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52728878.2080302@linaro.org>
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
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: kexec@lists.infradead.org, Lubomir Rintel <lkundrak@v3.sk>, Simon Horman <horms@verge.net.au>, Joe Perches <joe@perches.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Thu, Oct 31, 2013 at 09:42:32AM -0700, Taras Kondratiuk wrote:

[..]

This patch has not gone it for quite some time and vmcore-dmesg continues
to fail for me with upstream kernels. So it is time to do something
about it.

> I have concerns about this patch.
> There were a lot of hardcoded lenght values in the original code.

One can easily fix that by using strlen().

> Now there are twice as much and we need to keep adding hardcoded
> values if any additional parameter should be read of renamed.
> 
> Please eveluate this patch [1]. It should remove both:
> hardcoded values and duplicated reading for two buffer names.

I don't like excessive usage of macros. And in your patch you are
using nested marcros.

While it might make look code smaller, readability of code becomes
a problem. 

So I personally like simpler approach. And please use strlen() for
fixing the hardcoding of length issue.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
