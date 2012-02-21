Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzkWH-0003bq-V0
 for kexec@lists.infradead.org; Tue, 21 Feb 2012 07:52:21 +0000
Date: Tue, 21 Feb 2012 16:50:41 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile 0/2] LZO Compression Support
Message-Id: <20120221165041.5ebd8a15.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120220090528.30966.59163.stgit@localhost6.localdomain6>
References: <20120220090528.30966.59163.stgit@localhost6.localdomain6>
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

On Mon, 20 Feb 2012 18:10:00 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> The following series implements LZO compression support to
> makedumpfile. LZO is as good as in size but by far better in speed
> than ZLIB, readucing down time during generation of crash dump and
> refiltering.
> 
> The RFC discussion:
> 
>   http://lists.infradead.org/pipermail/kexec/2011-November/005783.html
>   http://lists.infradead.org/pipermail/kexec/2011-December/005868.html
> 
> How to build:
> 
>   1. Get lzo libraries: lzo, lzo-devel and lzo-minilzo from either of
>   the following:
> 
>     1) Original author's website:
>        http://www.oberhumer.com/opensource/lzo/
> 
>     2) yum framework on fedora. Older releases don't have the packages.
> 
>   2. Apply the patch set to makedumpfile v1.4.2.
> 
>   3. Do make.
> 
> How to use:
> 
>   Introduce new -l option. If a user specify this, makedumpfile
>   generates dumpfile compressed by pages with lzo compression.
> 
>   Example)
>   $ makedumpfile -l vmcore dumpfile
> 
> Performance evaluation:
> 
>   - Kumagai-san's evaluation simulating actually working servers:
>     http://lists.infradead.org/pipermail/kexec/2011-December/005868.html
> 
>   - My evaluation focusing on the worst cases:
>     http://lists.infradead.org/pipermail/kexec/2011-November/005783.html
> 
> LZO Support for crash:
> 
>   I'll post LZO support patch for crash after makedumpfile merges
>   these patches.

Thank you for your patches.

I'll review and merge them into v1.4.4 with making LZO support optional.
I'll post the patch to make it optional after v1.4.3 is released.

Please wait for a while.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
