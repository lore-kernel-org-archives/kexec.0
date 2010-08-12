Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OjLZT-0005c2-9H
	for kexec@lists.infradead.org; Thu, 12 Aug 2010 00:23:00 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20100811194734.GD23317@hmsreliant.think-freely.org>
	<4C6301C2.5020808@zytor.com> <m1zkwsn7h0.fsf@fess.ebiederm.org>
	<4C631DF0.2040908@zytor.com>
Date: Wed, 11 Aug 2010 17:22:49 -0700
In-Reply-To: <4C631DF0.2040908@zytor.com> (H. Peter Anvin's message of "Wed,
	11 Aug 2010 15:02:24 -0700")
Message-ID: <m17hjwllwm.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Question regardin intel64 arch and page table setup
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
Cc: kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 08/11/2010 02:51 PM, Eric W. Biederman wrote:
>> 
>> 3) I would start just getting the normal kexec case to work.
>>    The 64bit kernel does support starting at the 64bit entry point,
>>    but I don't think it has been tested if loaded above 4G.
>> 
>
> I can guarantee that it hasn't; I looked at that code not all that long
> ago and it's shock-full of 32- and 39-bit assumptions.

Ugh.  I thought I had purged the 32bit assumptions. I guess it has been
a while.  39-bit assumptions are forgivable, the architecture didn't
support more than 40bit physical addresses when it was written.

I wonder if this is a problem for SGI.  I remember on the ia64 NUMA
machines only node 0 had memory below 4GiB and so if you booted without
node 0 you had no memory below 4GiB.  I wonder if this restriction has
carried over to the x86_64 descendants of the Altix.

What is definitely true (unless someone has added an extension since last
I looked ) is that on a normal x86 smp architecture you can't start
additional processors without memory in the low 1MiB because that is all
you can specify in the startup ipi.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
