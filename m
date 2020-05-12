Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcdn-iport-2.cisco.com ([173.37.86.73])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYZdD-00005l-Hm
 for kexec@lists.infradead.org; Tue, 12 May 2020 18:27:56 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Subject: Re: [REQUEST] makedumpfile: stream compress flat ELF format with libz
Date: Tue, 12 May 2020 18:27:51 +0000
Message-ID: <20200512182749.GP31850@zorba>
References: <20200512172546.GL31850@zorba>
 <CAHD1Q_wJGA+b9hgLhUUt2fBK8aEOchis9EDW4W8JVQ1EreFwqA@mail.gmail.com>
In-Reply-To: <CAHD1Q_wJGA+b9hgLhUUt2fBK8aEOchis9EDW4W8JVQ1EreFwqA@mail.gmail.com>
Content-Language: en-US
Content-ID: <E1FA5D745FE4884CA1D3278F70DC5A66@namprd11.prod.outlook.com>
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

On Tue, May 12, 2020 at 03:14:49PM -0300, Guilherme Piccoli wrote:
> It's a quite interesting feature Daniel, thanks for the effort!
> I'm curious about memory usage - did you somehow measure the
> consumption with your patches vs. the regular kdump compression?

It's not really a memory consumption issue, it's a core size issue. The core
size is much smaller when compressed with gzip. I measured the core size with
different formats and gzip compressed.

Daniel
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
