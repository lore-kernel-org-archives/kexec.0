Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bUGvZ-0002kj-Tl
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 17:22:59 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1470033660.7811.99.camel@localhost>
Date: Mon, 01 Aug 2016 12:09:18 -0500
In-Reply-To: <1470033660.7811.99.camel@localhost> (Jiangang Wei's message of
 "Mon, 1 Aug 2016 06:44:03 +0000")
Message-ID: <87twf4xvpd.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] Fix dump-capture kernel hangs with notsc
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "xpang@redhat.com" <xpang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "kernel@kyup.com" <kernel@kyup.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

"Wei, Jiangang" <weijg.fnst@cn.fujitsu.com> writes:

> Ping ...
> May I ask for some community attention to this series?
> I purpose is fixing  the dump-capture kernel hangs in
> calibrate_delay_converge() while specifying notsc.

Did you not see my reply to patch 3/3?

The short version of my feedback is that you seem to be fixing a case
that should not exist.  So the good fix is to skip completely past
virtual wire mode and into full apic mode as soon as possible.

For a subset of cases the code already supports that.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
