Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgE7b-0005w9-GE
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 07:08:00 +0000
Date: Mon, 31 Mar 2008 16:07:57 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: [PATCH 2/4] extract vmcoreinfo from /proc/vmcore for Xen
In-Reply-To: <9CC892FBA61B9Atakebe_akio@jp.fujitsu.com>
References: <20080331131640.DDCF.ODA@valinux.co.jp>
	<9CC892FBA61B9Atakebe_akio@jp.fujitsu.com>
Message-Id: <20080331155917.DDE1.ODA@valinux.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Akio Takebe <takebe_akio@jp.fujitsu.com>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org

Hi,

On Mon, 31 Mar 2008 15:51:30 +0900
Akio Takebe <takebe_akio@jp.fujitsu.com> wrote:

> Hi, Itsuro
> 
> >--- include/xen/interface/kexec.h.org	2008-03-25 09:08:43.000000000 +0900
> >+++ include/xen/interface/kexec.h	2008-03-25 09:12:02.000000000 +0900
> >@@ -111,6 +111,10 @@
> > #define KEXEC_RANGE_MA_CRASH 0   /* machine address and size of crash area */
> > #define KEXEC_RANGE_MA_XEN   1   /* machine address and size of Xen itself */
> > #define KEXEC_RANGE_MA_CPU   2   /* machine address and size of a CPU note */
> >+#define KEXEC_RANGE_MA_VMCOREINFO   3   /* machine address and size of 
> >vmcoreinfo */
> >+
> >+extern size_t vmcoreinfo_max_size_xen;
> Why don't you use VMCOREINFO_BYTES (4096) instead of vmcoreinfo_max_size_xen?

There is no significant reason now. Just reserve the posibility
to make it variable.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
