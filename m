Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S02BG-0005KE-6V
 for kexec@lists.infradead.org; Wed, 22 Feb 2012 02:43:49 +0000
Date: Wed, 22 Feb 2012 11:42:09 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile 0/2] LZO Compression Support
Message-Id: <20120222114209.d22e2e34.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120221.170125.347143815.d.hatayama@jp.fujitsu.com>
References: <20120220090528.30966.59163.stgit@localhost6.localdomain6>
 <20120221165041.5ebd8a15.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120221.170125.347143815.d.hatayama@jp.fujitsu.com>
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

On Tue, 21 Feb 2012 17:01:25 +0900 (   )
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
 
> > Thank you for your patches.
> > 
> > I'll review and merge them into v1.4.4 with making LZO support optional.
> > I'll post the patch to make it optional after v1.4.3 is released.
> > 
> > Please wait for a while.
> > 
> > Thanks
> > Atsushi Kumagai
> > 
> 
> Thanks. But I'm OK if I'll repost the patch after you have decided how
> you change Makefile to support optional building. Or is it more
> effective for you to do them by yourself at the same time?

I wonder if you could repost the patch with implementing my idea.
My idea is that using build option (like "LINKTYPE" at v1.4.2).

 Example)
   1. enable lzo support
     $ make USELZO=on

   2. disable lzo support (default)
     $ make

In future, I would like to use automake but don't worry
about it now.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
