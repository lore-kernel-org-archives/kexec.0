Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUyKF-0007kf-Hl
 for kexec@lists.infradead.org; Fri, 19 Sep 2014 13:34:16 +0000
Date: Fri, 19 Sep 2014 09:33:53 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] autokdump - automated kdump testsuite
Message-ID: <20140919133353.GD2190@redhat.com>
References: <145412866.25258463.1411119061796.JavaMail.zimbra@redhat.com>
 <293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
 <20140919132236.GB2190@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140919132236.GB2190@redhat.com>
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, crash-utility <crash-utility@redhat.com>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kexec kdump redhat mailing list <kexec-kdump-list@redhat.com>

On Fri, Sep 19, 2014 at 09:22:36AM -0400, Vivek Goyal wrote:
> On Fri, Sep 19, 2014 at 05:52:25AM -0400, CAI Qian wrote:
> > I plan to release an automated kdump testsuite that will be
> 
> So will this be a standalone test suit? Can it be merged with
> something already existing say, LTP.

Also how about calling it just kdumptest. autokdump feels more
like as if there have been improvements to kdump mechanism and
there is improved method named "autokdump".

kdumptest is more intuitive and it being "auto" is more or less
implied.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
