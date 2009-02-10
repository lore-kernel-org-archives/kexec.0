Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LWl9M-0007LK-85
	for kexec@lists.infradead.org; Tue, 10 Feb 2009 05:27:14 +0000
References: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com>
	<m14ozb1eom.fsf@fess.ebiederm.org>
	<4C94DE2070B172459E4F1EE14BD2364E027DFC66@HQ-EXCH-5.corp.brocade.com>
	<m1ab93w61r.fsf@fess.ebiederm.org>
	<4C94DE2070B172459E4F1EE14BD2364E027E0B15@HQ-EXCH-5.corp.brocade.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 09 Feb 2009 21:27:12 -0800
In-Reply-To: <4C94DE2070B172459E4F1EE14BD2364E027E0B15@HQ-EXCH-5.corp.brocade.com>
	(Ming Lei's message of "Mon\, 9 Feb 2009 17\:08\:36 -0800")
Message-ID: <m14oz22767.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: should kernel image destination address be picked up by kernel
	itself?
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
To: Ming Lei <mlei@Brocade.COM>
Cc: kexec@lists.infradead.org

"Ming Lei" <mlei@Brocade.COM> writes:

> Hi Eric,
>
> Do you know what's this purgatory directory for? I saw it is linked with
> kexec in a weird way.

Yep.  That is the relocatable code that run between one kernel and the next.

> Another note for current code base is that there is merged directory
> arch/powerpc since linux kernel 2.6.23, but kexec-tools still has ppc
> and ppc64 separated. Is there anyone working on this merged arch?

Userspace should not be affected by a kernel implementation detail
like that.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
