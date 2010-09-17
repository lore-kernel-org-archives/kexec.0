Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usindmx04.hds.com ([207.126.252.15])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OwcZK-0001f8-1G
	for kexec@lists.infradead.org; Fri, 17 Sep 2010 15:09:42 +0000
From: Seiji Aguchi <seiji.aguchi@hds.com>
Date: Fri, 17 Sep 2010 11:08:48 -0400
Subject: RE: [PATCH] Fix kexec abort due to IPI from panic().
Message-ID: <5C4C569E8A4B9B42A84A977CF070A35B2C09821A9E@USINDEVS01.corp.hds.com>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C0979C90E@USINDEVS01.corp.hds.com>
	<m1wrql2sf1.fsf@fess.ebiederm.org>
In-Reply-To: <m1wrql2sf1.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "simon.kagstrom@netinsight.net" <simon.kagstrom@netinsight.net>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

Hi Eric,

Thank you for your quick response!

>Disabling interrupts is fine,

Thanks!

>However that call to kmsg_dump(KMSG_DUMP_KEXEC) is a bug as it introduces locks 
>into a path that should not be taking locks.

I'd like to find a way that kexec coexists with kmsg_dump(KMSG_DUMP_KEXEC) because 
kmsg_dump is a useful troubleshooting feature as well.

So, I will improve kmsg_dump(KMSG_DUMP_KEXEC) if there are some bugs.
Could you please let me know your concern?
It is helpful for me if you have an example scenario kexec fails.

>Nothing in the crash_kexec path should even have the option of blocking.

Do you mean I need to change kmsg_dump(KMSG_DUMP_KEXEC) to lockless?

Seiji

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
