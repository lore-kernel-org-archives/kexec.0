Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]
 helo=smtprelay.hostedemail.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMpwq-0005kg-Av
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 01:55:56 +0000
Message-ID: <1379642127.2021.1.camel@joe-AO722>
Subject: Re: [PATCH v2] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
From: Joe Perches <joe@perches.com>
Date: Thu, 19 Sep 2013 18:55:27 -0700
In-Reply-To: <20130920015047.GA4989@dhcp-16-126.nay.redhat.com>
References: <20130919143815.GA4487@dhcp-16-126.nay.redhat.com>
 <1379602186-13617-1-git-send-email-lkundrak@v3.sk>
 <20130920015047.GA4989@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Fri, 2013-09-20 at 09:50 +0800, Dave Young wrote:
> On 09/19/13 at 04:49pm, Lubomir Rintel wrote:
> > Symbol name changed with the following commit:
> > 62e32ac printk: rename struct log to struct printk_log
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > ---
> 
> Acked-by: Dave Young <dyoung@redhat.com>

It might be nice if there was a reference somewhere in
the linux kernel source tree to whatever it is that this
patch modifies.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
