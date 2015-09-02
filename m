Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZWxhu-0004s9-Ov
 for kexec@lists.infradead.org; Wed, 02 Sep 2015 02:23:27 +0000
Date: Wed, 2 Sep 2015 11:22:41 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Drop release date from kexec-tools version output
Message-ID: <20150902022241.GH12080@verge.net.au>
References: <20150902012412.GA8022@dhcp-128-42.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150902012412.GA8022@dhcp-128-42.nay.redhat.com>
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
Cc: kexec@lists.infradead.org

On Wed, Sep 02, 2015 at 09:24:12AM +0800, Dave Young wrote:
> kexec --version reports like below:
> kexec-tools 2.0.7 released 05 February 2015
> 
> The date string is generated when one run bootstrap script, thus
> it is more like a build date instead of release date.
> Even for distribution like Fedora it will make more sense if it can
> report something like "kexec-tools 2.0.7-1 released 05 February 2015"
> 
> In case building from git tree, the date cause more confusion.
> So let's remove it from version string unless there is better idea
> to resolve the issue.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
