Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SClKu-0000FR-Fn
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 05:22:23 +0000
Date: Wed, 28 Mar 2012 14:18:09 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
Message-Id: <20120328141809.fac2af86.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120323.172608.488340508.d.hatayama@jp.fujitsu.com>
References: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
 <20120323163303.dee3795c.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120323.172608.488340508.d.hatayama@jp.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Hello Hatayama-san,

On Fri, 23 Mar 2012 17:26:08 +0900 (   )
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
 
> BTW, I have a question about future build option of LZO library. You
> said previously you're going to introduce autotools. Then, do you
> consider default enable if LZO library is present on the environment?

I'm afraid I decide not to introduce autotools for the following reasons.

First, because autotools cannot know whether LZO library is prepared in
2nd kernel environment, it cannot decide whether it should link LZO library
dynamically even if LINKTYPE=dynamic is specified.

Second, if autotools behaves differently depending on LINKTYPE, it is difficult
for users to understand.

So, I think that current method is simpler and better than autotools.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
