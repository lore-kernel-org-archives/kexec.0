Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from borg.tf-network.de ([62.75.218.204])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XSTDD-0006ER-04
 for kexec@lists.infradead.org; Fri, 12 Sep 2014 15:56:39 +0000
Message-ID: <5413179C.8020902@whissi.de>
Date: Fri, 12 Sep 2014 17:56:12 +0200
From: "Thomas D." <whissi@whissi.de>
MIME-Version: 1.0
Subject: Re: [Patch v3 1/2] kaslr: check if kernel location is changed
References: <1410502832-3573-1-git-send-email-bhe@redhat.com>
 <20140912152244.GA2781@dhcp-16-105.nay.redhat.com>
 <20140912153308.GB4408@redhat.com>
In-Reply-To: <20140912153308.GB4408@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>, "keescook@chromium.org" <keescook@chromium.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

Hi,

Vivek Goyal wrote:
> You had reported kexec issues with CONFIG_RANDOMIZE_BASE=y. Does this
> patch resolve the issue for you?

Yup! Tested against kernel-3.16.2.


-Thomas


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
