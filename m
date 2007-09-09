Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUU25-0006uu-Gs
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 17:09:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [discuss] [patch 3/5] Use extended crashkernel command line on
	x86_64
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.951336895@strauss.suse.de>
	<86802c440709091027o32a63d11w629bad87abcc19c2@mail.gmail.com>
	<20070909185257.GA10600@suse.de>
Date: Sun, 09 Sep 2007 15:06:55 -0600
In-Reply-To: <20070909185257.GA10600@suse.de> (Bernhard Walle's message of
	"Sun, 9 Sep 2007 20:52:58 +0200")
Message-ID: <m1ir6jsg40.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, discuss@x86-64.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, Yinghai Lu <yhlu.kernel@gmail.com>

Bernhard Walle <bwalle@suse.de> writes:

> * Yinghai Lu <yhlu.kernel@gmail.com> [2007-09-09 19:27]:
>> >
>> > +#ifdef CONFIG_KEXEC
>> ...
>> 
>> CONFIG_KEXEC or CONFIG_CRASH_DUMP?
>
> Good question. The crashkernel parameter was CONFIG_KEXEC before, and
> I also wondered why, but I didn't change this because maybe there's
> some reason I don't know.
>
> Vivek, do you know why this was CONFIG_KEXEC?

Probably because you use it in the primary kernel you use it.
The option reserves an area of memory for the kernel we switch
to on panic or another kernel crash.

Generally CONFIG_CRASH_DUMP seems to be about the options needed
to read out the crash dump after the fact.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
