Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx40.brocade.com ([144.49.195.4])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LX0G1-0005Vl-3y
	for kexec@lists.infradead.org; Tue, 10 Feb 2009 21:35:07 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: should kernel image destination address be picked up by kernel
	itself?
Date: Tue, 10 Feb 2009 13:34:32 -0800
Message-ID: <4C94DE2070B172459E4F1EE14BD2364E02860971@HQ-EXCH-5.corp.brocade.com>
In-Reply-To: <m14oz22767.fsf@fess.ebiederm.org>
References: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com><m14ozb1eom.fsf@fess.ebiederm.org><4C94DE2070B172459E4F1EE14BD2364E027DFC66@HQ-EXCH-5.corp.brocade.com><m1ab93w61r.fsf@fess.ebiederm.org><4C94DE2070B172459E4F1EE14BD2364E027E0B15@HQ-EXCH-5.corp.brocade.com>
	<m14oz22767.fsf@fess.ebiederm.org>
From: "Ming Lei" <mlei@Brocade.COM>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org




>> "Ming Lei" <mlei@Brocade.COM> writes:
>>
>> Hi Eric,
>>
>> Do you know what's this purgatory directory for? I saw it is linked
with
>> kexec in a weird way.

>Yep.  That is the relocatable code that run between one kernel and the
next.

Is there any doc or email thread explain this purgatory and its purpose?

>> Another note for current code base is that there is merged directory
>> arch/powerpc since linux kernel 2.6.23, but kexec-tools still has ppc
>> and ppc64 separated. Is there anyone working on this merged arch?

>Userspace should not be affected by a kernel implementation detail
>like that.

Now linux kernel uses arch/powerpc to have both ppc32 and ppc64 code
together. Should I use arch/ppc in kexec-tools, then it wont work with
kernel powerpc since it uses device tree blob; if I use arch/ppc64 in
kexec-tools, then since I need to use for ppc32, it wont work too. Right
now it is not an immediate problem because we don't have any
ppc32(except these few old ppc32). Howver, there is working in progress
to support kexec/kdump for freescale 85xx(it is 32bit ppc). We may need
to address the problem in kexec-tools.

Thanks,
Ming

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
