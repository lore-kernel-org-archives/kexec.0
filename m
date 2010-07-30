Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OeyyD-0000SQ-6G
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 23:26:30 +0000
Message-ID: <4C535F87.5030909@zytor.com>
Date: Fri, 30 Jul 2010 16:25:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: In place kexec
References: <4C51C878.2090102@zytor.com> <20100729191654.GB28704@redhat.com>
	<m1lj8uvzgy.fsf@fess.ebiederm.org>
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<4C525D6A.4000007@zytor.com> <m1aap93pak.fsf@fess.ebiederm.org>
	<4C5300B9.2080507@zytor.com> <m1sk30zuis.fsf@fess.ebiederm.org>
	<20100730225222.GA14545@plapp.qlogic.org>
In-Reply-To: <20100730225222.GA14545@plapp.qlogic.org>
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
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Driver <Linux-Driver@qlogic.com>, Vivek Goyal <vgoyal@redhat.com>

On 07/30/2010 03:52 PM, Andrew Vasquez wrote:
> 
> Looking through all these emails, what's the upshot here?  Is the
> expectation, for all storage drivers to starting to implement some
> 'minimal' level of shutdown with the hardware/firmware during the
> .shutdown callback?
> 

I believe so.  It seems to be a fundamental requirement for kexec to
function.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
