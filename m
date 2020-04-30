Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410040.outbound.protection.outlook.com
 ([40.107.141.40] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUBPG-00042P-KW
 for kexec@lists.infradead.org; Thu, 30 Apr 2020 15:47:24 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [RFC PATCH 0/1] support lockless printk ringbuffer
Date: Thu, 30 Apr 2020 15:47:14 +0000
Message-ID: <OSBPR01MB1991C1B07AC410A74CF7BBC0DDAA0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200429213256.3691-1-john.ogness@linutronix.de>
In-Reply-To: <20200429213256.3691-1-john.ogness@linutronix.de>
Content-Language: en-US
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
To: John Ogness <john.ogness@linutronix.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Dave Anderson <anderson@redhat.com>, "crash-utility@redhat.com" <crash-utility@redhat.com>

Hi John,

> -----Original Message-----
> Hi Kazu,
> 
> Here is a patch adding full support for the new lockless printk
> ringbuffer as it is currently being proposed. Note that the latest
> version has not yet been submitted to LKML. I was waiting until I
> finished tests with crash(8) and makedumpfile(8).
> 
> The new ringbuffer will export all the necessary symbols, sizes,
> and offsets in VMCOREINFO.
> 
> Note that I created a separate printk.c for the iteration logic.

That's good.

> 
> Also note that I modified dwarf_info.c to support resolving
> typedefs of typedefs. This was necessary in order to support
> atomic_long_t and its "counter" member.

OK, I see.

> 
> I don't expect you to take the patch as-is, but I hope it can
> provide some positive ground work for moving forward.

OK.  It looks already well-considered.
Thank you very much for the patch!

Kazu

> 
> John Ogness (1):
>   printk: add support for lockless ringbuffer
> 
>  Makefile       |   2 +-
>  dwarf_info.c   |  36 +++++++++-
>  makedumpfile.c | 101 ++++++++++++++++++++++++++--
>  makedumpfile.h |  25 +++++++
>  printk.c       | 177 +++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 333 insertions(+), 8 deletions(-)
>  create mode 100644 printk.c
> 
> --
> 2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
