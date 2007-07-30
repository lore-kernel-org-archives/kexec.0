Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IFdc5-0000s2-61
	for kexec@lists.infradead.org; Mon, 30 Jul 2007 18:21:19 -0400
Date: Tue, 31 Jul 2007 07:19:48 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: makedumpfile-1.1.5: Xen support
In-Reply-To: <46ADDF9D.4060704@redhat.com>
References: <1181.219.4.192.46.1185620025.risu@secure.valinux.co.jp>
	<46ADDF9D.4060704@redhat.com>
Message-Id: <20070731071034.DBA9.ODA@valinux.co.jp>
MIME-Version: 1.0
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org

Hi,

> Is the "-d" dump_level option completely ignored, or can it
> (without vmlinux awareness) recognize and skip zero-filled
> pages?

Yes, "-d" is ignored.

Hmm, adding to skip zero-filled pages is easy but I wonder
how effective it is ...

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
