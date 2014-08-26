Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMACf-0002rZ-De
 for kexec@lists.infradead.org; Tue, 26 Aug 2014 06:26:01 +0000
Date: Tue, 26 Aug 2014 08:25:34 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [Patch v3 7/7] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140826082534.5b070f7d@hananiah.suse.cz>
In-Reply-To: <20140826032247.GA6230@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-8-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246623@BPXM01GP.gisp.nec.co.jp>
 <20140821103126.GA6517@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9724F9CA@BPXM01GP.gisp.nec.co.jp>
 <20140826032247.GA6230@dhcp-16-105.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Tue, 26 Aug 2014 11:22:47 +0800
"bhe@redhat.com" <bhe@redhat.com> wrote:

>[...]
> Here it use lseek to position, then try to read, and then reading failed
> and raised a SIGKILL.
> 
> lseek(3, 8799381360640, SEEK_SET)       = 8799381360640
> read(3,  <unfinished ...>
> +++ killed by SIGKILL +++
> Killed

This smells like killed by OOM Killer. Can you check the kernel log if
there's anything?

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
