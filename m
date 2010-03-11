Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NpdrU-0002Du-KB
	for kexec@lists.infradead.org; Thu, 11 Mar 2010 08:35:24 +0000
Subject: Re: [PATCH 0/3] Getting biarch support
References: <m1k4tjb7d1.fsf@fess.ebiederm.org>
	<20100311092240.21222nl5qlr5mou8@webmail.df.eu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 11 Mar 2010 00:35:14 -0800
In-Reply-To: <20100311092240.21222nl5qlr5mou8@webmail.df.eu> (Bernhard Walle's
	message of "Thu\, 11 Mar 2010 09\:22\:40 +0100")
Message-ID: <m1ociv9ry5.fsf@fess.ebiederm.org>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

Bernhard Walle <bernhard@bwalle.de> writes:

> Zitat von "Eric W. Biederman" <ebiederm@xmission.com>:
>
>>
>> It looks like no one ever tested taking a crashdump
>> from a 64bit kernel with a 32bit userspace on x86,
>> and we have a reuse-cmdline regression fixes follow.
>
> I didn't even know that it is supposed to work...

The x86 biarch tends to be an after thought.  But we
have to do the hard work for all of the architectures
where the optimal configuration is 32bit userspace with
a 64bit kernel.  So we might as well have it work on
x86 so we can test the code without need an exotic
architecture.

In my case it was purely code size savings on an embedded
setup that got me using, and thus fixing it.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
