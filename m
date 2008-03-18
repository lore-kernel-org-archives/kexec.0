Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JbhvF-00016o-5r
	for kexec@lists.infradead.org; Tue, 18 Mar 2008 19:56:33 +0000
Message-ID: <47E01E6E.2090809@redhat.com>
Date: Tue, 18 Mar 2008 12:56:30 -0700
From: Ben Woodard <woodard@redhat.com>
MIME-Version: 1.0
Subject: Re: force a dump on a hung system?
References: <47DFFB45.3060106@sgi.com> <frovcv$lss$1@ger.gmane.org>
In-Reply-To: <frovcv$lss$1@ger.gmane.org>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

does it have a BMC can you use IPMI to trigger an NMI?

-ben


Bernhard Walle wrote:
> * Jay Lan [2008-03-18 18:26]:
>
>   
>> How do i force a dump on a hung system when
>> 1) it does not respond to the serial console, and
>>     
>
> Also not sysrq? Attach a PS/2 keyboard and sysrq?
>
>   
>> Am i out of luck?
>>     
>
> Looks like you are. :(
>
>
>         Bernhard
>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>   


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
