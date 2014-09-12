Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XSTGc-0007Pp-TP
 for kexec@lists.infradead.org; Fri, 12 Sep 2014 16:00:11 +0000
Date: Fri, 12 Sep 2014 11:59:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch v3 1/2] kaslr: check if kernel location is changed
Message-ID: <20140912155940.GD32421@redhat.com>
References: <1410502832-3573-1-git-send-email-bhe@redhat.com>
 <20140912152244.GA2781@dhcp-16-105.nay.redhat.com>
 <20140912153308.GB4408@redhat.com> <5413179C.8020902@whissi.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5413179C.8020902@whissi.de>
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
To: "Thomas D." <whissi@whissi.de>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>, "keescook@chromium.org" <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On Fri, Sep 12, 2014 at 05:56:12PM +0200, Thomas D. wrote:
> Hi,
> 
> Vivek Goyal wrote:
> > You had reported kexec issues with CONFIG_RANDOMIZE_BASE=y. Does this
> > patch resolve the issue for you?
> 
> Yup! Tested against kernel-3.16.2.

Thanks. Given this patch is small and should not break anything else, I
think it might make sense to send it to stable too.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
