Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U50Er-0003Nq-IJ
 for kexec@lists.infradead.org; Mon, 11 Feb 2013 20:44:34 +0000
Date: Mon, 11 Feb 2013 15:44:14 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, oldmem: support mmap on /dev/oldmem
Message-ID: <20130211204414.GA24936@redhat.com>
References: <33710E6CAA200E4583255F4FB666C4E20AC36B01@G01JPEXMBYT03>
 <20130205151256.GB12853@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20AC61B3C@G01JPEXMBYT03>
 <20130207150623.GC6462@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20AC6735D@G01JPEXMBYT03>
 <33710E6CAA200E4583255F4FB666C4E20AC67384@G01JPEXMBYT03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AC67384@G01JPEXMBYT03>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "cpw@sgi.com" <cpw@sgi.com>

On Fri, Feb 08, 2013 at 12:33:49AM +0000, Hatayama, Daisuke wrote:

[..]
> Also, remap_pfn_range is the function exported into kernel modules, so changing the third argument means changing ABI. Introducing a kind of remap_pfn_range_64 is a good idea? if there's someone needing the feature on 32-bit kernel.

I thought kernel does not care about compatibility with out of tree
modules and any user of in-tree module is updated to use new API. I could
be wrong though...

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
