Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from alln-iport-8.cisco.com ([173.37.142.95])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYa55-0002Je-QB
 for kexec@lists.infradead.org; Tue, 12 May 2020 18:56:45 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Subject: Re: [REQUEST] makedumpfile: stream compress flat ELF format with libz
Date: Tue, 12 May 2020 18:56:33 +0000
Message-ID: <20200512185632.GQ31850@zorba>
References: <20200512172546.GL31850@zorba>
 <CAHD1Q_wJGA+b9hgLhUUt2fBK8aEOchis9EDW4W8JVQ1EreFwqA@mail.gmail.com>
 <20200512182749.GP31850@zorba>
 <CAHD1Q_zghTM0ahkc-MLaRktC356YrQX_yg6bGn9pFXuxY3enrA@mail.gmail.com>
In-Reply-To: <CAHD1Q_zghTM0ahkc-MLaRktC356YrQX_yg6bGn9pFXuxY3enrA@mail.gmail.com>
Content-Language: en-US
Content-ID: <0670214BBEC9E54E853EC3921ADF7077@namprd11.prod.outlook.com>
MIME-Version: 1.0
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
To: Guilherme Piccoli <gpiccoli@canonical.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>

On Tue, May 12, 2020 at 03:32:25PM -0300, Guilherme Piccoli wrote:
> Sure, I understood that. I'm curious though about the memory
> consumption of the compression operation, or put in other words: do we
> need to increase crashkernel reserved memory if we plan to use your
> gzip approach?
> It's good to be sure about this, to evaluate the trade-off of core
> file size vs. necessary reserved memory.

I'm not sure. I didn't measure this, but from my experience makedumpfile uses
more memory during dumping than gzip uses for compression. If our dump kernels
run out of memory it's usually something inside makedumpfile when it's removing
pages or something along those lines.

Daniel
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
