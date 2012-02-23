Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0Tsa-0004RR-KJ
 for kexec@lists.infradead.org; Thu, 23 Feb 2012 08:18:26 +0000
Date: Thu, 23 Feb 2012 17:16:46 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
Message-Id: <20120223171646.18e3dd30.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
References: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
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

On Thu, 23 Feb 2012 10:33:54 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> The following series implements LZO compression support to
> makedumpfile. LZO is as good as in size but by far better in speed
> than ZLIB, readucing down time during generation of crash dump and
> refiltering.
> 
> The RFC discussion was made here:
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
>   3. Do make as follows:
> 
>     $ make USELZO=on
> 
>     Note: In default, no LZO compression support is included.
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
>   - Kumagai-san's evaluation simulating working servers:
>     http://lists.infradead.org/pipermail/kexec/2011-December/005868.html
> 
>   - My evaluation focusing on the worst cases:
>     http://lists.infradead.org/pipermail/kexec/2011-November/005783.html
> 
> LZO Support for crash:
> 
>   I'll post LZO support patch for crash after makedumpfile merges
>   these patches.
> 
> Changelog:
> 
>   v1 => v2:
> 
>     - Add build condition for LZO support. Enable LZO support if
>       specifying USELZO=on to make command.
> 
>     - Avoid LONG_MAX/ULONG_MAX redefinitions.

Thank you for your work.
I will review your patches for v1.4.4.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
