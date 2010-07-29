Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OeZNM-00020n-5i
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 20:06:45 +0000
Message-ID: <4C51DF3A.4070207@zytor.com>
Date: Thu, 29 Jul 2010 13:06:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com>
	<m1y6cvtgd0.fsf@fess.ebiederm.org>	<20100729134343.GA31490@shamino.rdu.redhat.com>	<4C519853.2040206@zytor.com>	<20100729150640.GF31490@shamino.rdu.redhat.com>	<4C51BFA5.60507@zytor.com>
	<m1k4oe88n9.fsf@fess.ebiederm.org>	<4C51C878.2090102@zytor.com>
	<20100729191654.GB28704@redhat.com>
	<m1lj8uvzgy.fsf@fess.ebiederm.org>
In-Reply-To: <m1lj8uvzgy.fsf@fess.ebiederm.org>
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
Cc: Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-driver@qlogic.com, Vivek Goyal <vgoyal@redhat.com>

On 07/29/2010 12:51 PM, Eric W. Biederman wrote:
>>
>> kernel_kexec()
>>    kernel_restart_prepare()
>> 	device_shutdown()
>>
>> I would suspect it to be a qla2xxx driver problem that it did not shut
>> down the device properly.
> 
> And device_shutdown calls every drivers .shutdown method.
> 
> Things like this are always a driver problem.
> 

Anyone from Qlogic who can comment/confirm/deny/investigage?

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
