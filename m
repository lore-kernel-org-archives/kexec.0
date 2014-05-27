Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpR4U-0004gf-4y
 for kexec@lists.infradead.org; Tue, 27 May 2014 23:46:19 +0000
Date: Wed, 28 May 2014 08:45:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: Handle struct log to struct printk_log
 renaming
Message-ID: <20140527234553.GC7374@verge.net.au>
References: <20140522144314.GE13647@redhat.com>
 <20140526065421.GB13010@verge.net.au>
 <20140527131342.GD10994@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140527131342.GD10994@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Taras Kondratiuk <taras.kondratiuk@linaro.org>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>, Lubomir Rintel <lkundrak@v3.sk>

On Tue, May 27, 2014 at 09:13:42AM -0400, Vivek Goyal wrote:
> On Mon, May 26, 2014 at 03:54:22PM +0900, Simon Horman wrote:
> > On Thu, May 22, 2014 at 10:43:14AM -0400, Vivek Goyal wrote:
> > > vmcore-dmesg has been failing for me for quite some time as struct log
> > > was renamed to struct printk_log.
> > > 
> > > 62e32ac printk: rename struct log to struct printk_log
> > > 
> > > This patch has been sitting in mailing list for quite some time. It
> > > is time to repost the patch.
> > > 
> > > I took original patch of Lubomir and modified a bit to take care of
> > > concern of hardcoded string length.
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > > 
> > > Changes for v2:
> > >   * Clarified printk_log vs. log in some comments.
> > 
> > Thanks, applied.
> 
> Thanks Simon. "git pull" did not result in anything. Have you pushed it
> out yet?

Sorry about that, I have pushed it now.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
