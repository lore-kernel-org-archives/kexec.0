Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ILvYj-0000IR-Eh
	for kexec@lists.infradead.org; Fri, 17 Aug 2007 02:44:09 -0400
Subject: Re: makedumpfile-1.1.5: Xen support
In-reply-to: <20070814082614.DC30.ODA@valinux.co.jp>
Message-Id: <20070817154401oomichi@mail.jp.nec.com>
References: <20070814082614.DC30.ODA@valinux.co.jp>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 17 Aug 2007 15:44:01 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Itsuro ODA <oda@valinux.co.jp>
Cc: kexec@lists.infradead.org


Hi ODA-san,

2007/08/14 08:27:17 +0900, Itsuro ODA <oda@valinux.co.jp> wrote:
>Hi,
>
>> Hmm, adding to skip zero-filled pages is easy but I wonder
>> how effective it is ...
>
>I found it is sometimes effective.
>
>The attached patch enables the "-d" option with --xen-syms.
>Note that only the level 1 (skip zero-filled pages) is supported.
>
>ex. # makedumpfile -E -d 1 --xen-syms xen-syms.debug vmcore output

Thank you for a good patch.
I will release a new version with your patch.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
