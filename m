Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OezBd-00044K-Kx
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 23:40:24 +0000
Subject: Re: In place kexec
References: <4C51C878.2090102@zytor.com> <20100729191654.GB28704@redhat.com>
	<m1lj8uvzgy.fsf@fess.ebiederm.org>
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<4C525D6A.4000007@zytor.com> <m1aap93pak.fsf@fess.ebiederm.org>
	<4C5300B9.2080507@zytor.com> <m1sk30zuis.fsf@fess.ebiederm.org>
	<20100730225222.GA14545@plapp.qlogic.org> <4C535F87.5030909@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 30 Jul 2010 16:40:13 -0700
In-Reply-To: <4C535F87.5030909@zytor.com> (H. Peter Anvin's message of "Fri\,
	30 Jul 2010 16\:25\:59 -0700")
Message-ID: <m162zwv8rm.fsf@fess.ebiederm.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Andrew Vasquez <andrew.vasquez@qlogic.com>, Linux Driver <Linux-Driver@qlogic.com>, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 07/30/2010 03:52 PM, Andrew Vasquez wrote:
>> 
>> Looking through all these emails, what's the upshot here?  Is the
>> expectation, for all storage drivers to starting to implement some
>> 'minimal' level of shutdown with the hardware/firmware during the
>> .shutdown callback?
>> 
>
> I believe so.  It seems to be a fundamental requirement for kexec to
> function.

Yes.  Implementing a .shutdown method the solution we have, and the
requirement has been stable for several years.  I did a quick grep
through drivers scsi and a lot of the storage drivers already
implement the .shutdown method.

Beyond not leaving DMAs running which can foul up kexec there is also
the need to ensure any drive caches are flushed on reboot.  I know
ide/sata drivers have been handling this case in ide_gd_shutdown for a
long time to ensure the drives write-back caches are flushed.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
