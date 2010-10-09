Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from usindmx01.hds.com ([207.126.252.12])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P4Mul-0001s1-06
	for kexec@lists.infradead.org; Sat, 09 Oct 2010 00:03:51 +0000
From: Seiji Aguchi <seiji.aguchi@hds.com>
Date: Fri, 8 Oct 2010 20:02:58 -0400
Subject: RE: [RFC][PATCH] Fix kexec abort due to IPI from panic().
Message-ID: <5C4C569E8A4B9B42A84A977CF070A35B2C119E5ACE@USINDEVS01.corp.hds.com>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C0979C90E@USINDEVS01.corp.hds.com>
	<m1wrql2sf1.fsf@fess.ebiederm.org>
	<5C4C569E8A4B9B42A84A977CF070A35B2C0DCFFB3E@USINDEVS01.corp.hds.com>
	<m1eicfp1fz.fsf@fess.ebiederm.org>
In-Reply-To: <m1eicfp1fz.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "David.Woodhouse@intel.com" <David.Woodhouse@intel.com>, "jason.wessel@windriver.com" <jason.wessel@windriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "anton@samba.org" <anton@samba.org>, "simon.kagstrom@netinsight.net" <simon.kagstrom@netinsight.net>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "ben@decadent.org.uk" <ben@decadent.org.uk>

Hi Eric

Thank you for your detailed explanation.
I understood historic backdrop of kexec in upstream kernel.
I also understood the reason why you are worried about 
kmsg_dump in kexec path.

The problem is that kmsg_dumper or notifier calls are used by people 
who are unfamiliar with kexec because they use blocking-functions 
such as do_gettimeofday unconsciously.

And I still believe that kmsg_dumper in kexec path is an useful 
A troubleshooting feature.

When kexec on panic fails, it is difficult to investigate the reason 
why kexec fails. It comes from lack of materials for the investigation.

Kernel buffer is helpful for the investigation.
So, I would like to continue the discussion about a way of getting 
kernel buffer in kexec path.

I'll participate in End User Summit and Linux Plumbers Conference.
I'd like to meet with you if you join these conferences. 

Seiji

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
