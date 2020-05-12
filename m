Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYZiB-000301-M8
 for kexec@lists.infradead.org; Tue, 12 May 2020 18:33:04 +0000
Received: from mail-ed1-f71.google.com ([209.85.208.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1jYZiA-0007Wt-6E
 for kexec@lists.infradead.org; Tue, 12 May 2020 18:33:02 +0000
Received: by mail-ed1-f71.google.com with SMTP id p12so5637371edi.15
 for <kexec@lists.infradead.org>; Tue, 12 May 2020 11:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200512172546.GL31850@zorba>
 <CAHD1Q_wJGA+b9hgLhUUt2fBK8aEOchis9EDW4W8JVQ1EreFwqA@mail.gmail.com>
 <20200512182749.GP31850@zorba>
In-Reply-To: <20200512182749.GP31850@zorba>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Tue, 12 May 2020 15:32:25 -0300
Message-ID: <CAHD1Q_zghTM0ahkc-MLaRktC356YrQX_yg6bGn9pFXuxY3enrA@mail.gmail.com>
Subject: Re: [REQUEST] makedumpfile: stream compress flat ELF format with libz
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
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>

Sure, I understood that. I'm curious though about the memory
consumption of the compression operation, or put in other words: do we
need to increase crashkernel reserved memory if we plan to use your
gzip approach?
It's good to be sure about this, to evaluate the trade-off of core
file size vs. necessary reserved memory.

Thanks!

On Tue, May 12, 2020 at 3:27 PM Daniel Walker (danielwa)
<danielwa@cisco.com> wrote:
>
> On Tue, May 12, 2020 at 03:14:49PM -0300, Guilherme Piccoli wrote:
> > It's a quite interesting feature Daniel, thanks for the effort!
> > I'm curious about memory usage - did you somehow measure the
> > consumption with your patches vs. the regular kdump compression?
>
> It's not really a memory consumption issue, it's a core size issue. The core
> size is much smaller when compressed with gzip. I measured the core size with
> different formats and gzip compressed.
>
> Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
